param (
	[Parameter(Mandatory = $false)]
    [int]$NotUse?ToGetHelp,
	
	[Parameter(Mandatory = $false)]
    [int]$i,		# Set increment value
	
	[Parameter(Mandatory = $false)]
    [string]$o,		# Set output directory
	
	[switch]$s,	# Sign the exe
	[switch]$ni,	# No increment (And use value loaded from file)
	
	[Alias("?", "Show-Help", "Get-Help", "ShowHelp", "GetHelp", "help")]
	[switch]$h		# Get help
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Set-Location -Path $PSScriptRoot

function Show-Help {
	Write-Host ""
    Write-Host "Usage: .\MakeSFX.ps1 [-i <increment>] [-ni] [-s] [-o <directory>] [-h]"
	Write-Host ""
    Write-Host "Parameters:"
    Write-Host "  -i   Set the increment value"
    Write-Host "  -ni  No increment (And use value loaded from file)"
    Write-Host "  -s   Sign the .exe include client.exe and SFX exe file"
    Write-Host "  -o   Set output directory"
    Write-Host "  -h   (-? -Show-Help -GetHelp etc.)"
    Write-Host "       Display this help message"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  Set increment to '123':"
    Write-Host "    .\MakeSFX.ps1 -i 123"
    Write-Host "  No increment and sign the EXEs:"
    Write-Host "    .\MakeSFX.ps1 -ni -s"
    Write-Host "  Set output path to 'C:\out':"
    Write-Host "    .\MakeSFX.ps1 -o 'C:\out'"
    Write-Host ""
    Write-Host "  Full usage hits:"
    Write-Host "    .\MakeSFX.ps1 -i 123 -ni -s -o 'C:\out'"
    Write-Host ""
    exit
}

if ($h) {
    Show-Help
    exit
}



# Define paths
$WinRARPath = "C:\Program Files\WinRAR\WinRAR.exe"
$AutoitPath = "C:\Program Files (x86)\AutoIt3"
$BaseName = "AmethystRainbow"
$ClientContentDirFile = ".Make\clientcontent.txt"
$OutputDirFile = ".Make\outputdir.txt"
$IncrementFile = ".Make\increment.txt"
$CertificateDirFile = ".Make\certificatefile.txt"

# Check if directories exist
if (!(Test-Path $WinRARPath)) {
    Write-Error "Error: WinRAR not found at '$WinRARPath'"
    exit 1
}
if (!(Test-Path $AutoitPath)) {
    Write-Error "Error: AutoIt not found at '$AutoitPath'"
    exit 1
}

# Ensure config files exist
if (!(Test-Path $ClientContentDirFile))	{ "" 	| Out-File $ClientContentDirFile -Encoding UTF8 }
if (-not $o) {				#PARAM $o Set output directory
	if (!(Test-Path $OutputDirFile))			{ ".\"	| Out-File $OutputDirFile -Encoding UTF8 }
}
if (!(Test-Path $IncrementFile))			{ "0"	| Out-File $IncrementFile -Encoding UTF8 }
if ($s) {					#PARAM $s Sign the exe
	if (!(Test-Path $CertificateDirFile))				{ exit 2 }
}

# Read/Set values
$ClientContentDir = (Get-Content $ClientContentDirFile -Raw).Trim() -replace "`r|`n", ""
$ClientContentDir = Resolve-Path $ClientContentDir

if ($o) {				#PARAM $o Set output directory
	$OutputDir = ($o).Trim() -replace "`r|`n", ""
}
else {
	$OutputDir = (Get-Content $OutputDirFile -Raw).Trim() -replace "`r|`n", ""
}
$OutputDir = Resolve-Path $OutputDir

# Make increment
if ($i) {					#PARAM $i Set increment value
	[int]$Increment = $i
}
else {
	[int]$Increment = Get-Content $IncrementFile -Raw
	if (-not $ni) {		#PARAM $ni No increment
		$Increment++
	}
}

if ($s) {					#PARAM $s Sign the exe
	$CertificateDir = (Get-Content $CertificateDirFile -Raw).Trim() -replace "`r|`n", ""
	$CertificateDir = Resolve-Path $CertificateDir
}

# Update config
@"
{"projectID":0,"modpackName":"Amethyst🌈","modpackVersion":"V$Increment","useMetadata":false}
"@ | Set-Content "Content\.minecraft\config\bcc.json" -Encoding UTF8

# Format archive name
$ArchiveFile = "$BaseName" + "V$Increment.exe"
$ArchiveName = Join-Path $OutputDir $ArchiveFile

# Compile AutoIt script
$AutoItExe = Join-Path $AutoitPath "Aut2Exe\Aut2exe_x64.exe"
$AutoItArgs = "/in client.au3 /icon .Make\client.ico /productname $BaseName /fileversion $Increment"
$compile = Start-Process -FilePath $AutoItExe -ArgumentList $AutoItArgs -Wait -PassThru
if ($compile.ExitCode -ne 0) {
    Write-Error "Error: AutoIt compilation failed."
    exit 1
}
if ($s) {					#PARAM $s Sign the exe
	Write-Host "Type your PFX password"
	Set-AuthenticodeSignature -FilePath "client.exe" -Certificate (Get-PfxCertificate -FilePath "$CertificateDir") -TimestampServer "http://timestamp.digicert.com" -Force
}

# Setup archive
Start-Process -FilePath $WinRARPath -ArgumentList @(
    'a',                        # Add to archive
    '-r',                       # Recurse subdirectories
    '-ep1',                     # Exclude base paths
    $ArchiveName,              # Output archive path
    '*',                        # Include all files
    '-x@.Make\exclude.txt',     # Exclude list
    '-z.Make\comment.txt',      # Comment file
    '-sfx',                     # Create SFX archive
    '-iicon.Make\client.ico',   # Icon for SFX
    '-iimg.Make\client.png'     # SFX image
) -NoNewWindow -Wait
# Add client files to archive
Start-Process -FilePath $WinRARPath -ArgumentList @(
    'a',						# Add to archive
    '-r',						# Recurse subdirectories
    '-ep1',             		# Exclude base paths
    '-apContent\.minecraft',	# Set archive path prefix
    $ArchiveName,				# Output archive path
    "$ClientContentDir\*",		# Input files
    '-x@.Make\exclude2.txt'		# Exclude list
) -NoNewWindow -Wait

# Sign the container
if ($s) {					#PARAM $s Sign the exe
	Write-Host "Type your PFX password"
	Set-AuthenticodeSignature -FilePath "$ArchiveName" -Certificate (Get-PfxCertificate -FilePath "$CertificateDir") -TimestampServer "http://timestamp.digicert.com" -Force
}

# Add hash sum
$fileHash = (Get-FileHash -Path $ArchiveName -Algorithm SHA256).Hash
$filePathNoExt = $ArchiveName -replace '\.exe$', ''
$fileHash | Out-File "$filePathNoExt.exe.SHA256" -Encoding ASCII

# Save increment
"$Increment" | Set-Content $IncrementFile -Encoding UTF8

# Clean up
Remove-Item "client.exe" -ErrorAction SilentlyContinue

# Launch Explorer
Start-Process $Outputdir
