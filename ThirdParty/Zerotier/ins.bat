cd /d "%~dp0"
msiexec /i "ZeroTierOne.msi" /passive
sc stop ZeroTierOneService
xcopy .\planet %ProgramData%\ZeroTier\One /Y
sc start ZeroTierOneService
%ProgramData%\ZeroTier\One\zerotier-one_x64.exe -q join bb267aa8a0cf640f
REM netsh advfirewall firewall add rule name="Minecraft A Server IO" dir=in protocol=tcp localport=25565 remoteport=25565 action=allow
REM netsh advfirewall firewall add rule name="Minecraft A Server IO" dir=out protocol=tcp localport=25565 remoteport=25565 action=allow
pause
