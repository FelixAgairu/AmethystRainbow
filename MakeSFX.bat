@echo off
setlocal enabledelayedexpansion

:: Define paths
set "WinRARPath=C:\Program Files\WinRAR\WinRAR.exe"
set "AutoitPath=C:\Program Files (x86)\AutoIt3"

:: Check if directories exist
if not exist "%WinRARPath%" (
    echo Error: Directory "%WinRARPath%" does not exist.
    exit /b 1
)
if not exist "%AutoitPath%" (
    echo Error: Directory "%AutoitPath%" does not exist.
    exit /b 1
)

:: Define base files
set "BaseName=AmethystRainbow"
set "IncrementFile=.Make\increment.txt"
set "OutputdirFile=.Make\outputdir.txt"

set "AssetsdirFile=.Make\assetsdir.txt"

:: Read the client dir from the file
if not exist "%AssetsdirFile%" echo "" > "%AssetsdirFile%"
set /p Assetsdir=<"%AssetsdirFile%"

:: Read the current output dir from the file
if not exist "%OutputdirFile%" echo ".\" > "%OutputdirFile%"
set /p Outputdir=<"%OutputdirFile%"

:: Read the current increment number from the file
if not exist "%IncrementFile%" echo 0 > "%IncrementFile%"
set /p Increment=<"%IncrementFile%"

:: Increment the number
set /a Increment+=1

:: Update the increment number in the config
echo {"projectID":0,"modpackName":"Amethyst🌈","modpackVersion":"V%Increment%","useMetadata":false} > "Content\.minecraft\config\bcc.json"

:: Format the new archive name
set "ArchiveName=%Outputdir%\%BaseName%V%Increment%.exe"

:: Compile client.au3 to client.exe
"%AutoitPath%\Aut2Exe\Aut2exe_x64.exe" /in client.au3 /icon .Make\client.ico /productname %BaseName% /fileversion %Increment%
if errorlevel 1 (
    echo Error: AutoIt compilation failed.
    exit /b 1
)

:: Create the new archive
"%WinRARPath%" a -r -ep1 "%ArchiveName%" * -x@.Make\exclude.txt -z.Make\comment.txt -sfx -iicon.Make\client.ico -iimg.Make\client.png
"%WinRARPath%" a -r -ep1 -apContent\.minecraft "%ArchiveName%" "%Assetsdir%\*" -x@.Make\exclude2.txt

:: Add hash sum to the archive
for /f "tokens=*" %%i in ('powershell -Command "(Get-FileHash -Path \"%ArchiveName%\").Hash"') do set "fileHash=%%i"
set "filePathNoExt=%ArchiveName:~0,-4%"
echo %fileHash% > "%filePathNoExt%.exe.SHA256"

:: Save the new increment number back to the file
echo %Increment% > "%IncrementFile%"

:: Clean up
del client.exe

:: Explorer
start "" "%Outputdir%"

endlocal
