cd /d "%~dp0"
msiexec /i "ZeroTierOne.msi" /passive
ping 127.0.0.1 -n 3 > null
sc stop ZeroTierOneService
ping 127.0.0.1 -n 5 > null
xcopy .\planet %ProgramData%\ZeroTier\One /Y
ping 127.0.0.1 -n 5 > null
sc start ZeroTierOneService
ping 127.0.0.1 -n 10 > null
%ProgramData%\ZeroTier\One\zerotier-one_x64.exe -q join bb267aa8a0cf640f
REM netsh advfirewall firewall add rule name="Minecraft A Server IO TCP" dir=in protocol=tcp localport=25565 remoteport=25565 action=allow
REM netsh advfirewall firewall add rule name="Minecraft A Server IO TCP" dir=out protocol=tcp localport=25565 remoteport=25565 action=allow
REM netsh advfirewall firewall add rule name="Minecraft A Server IO UDP" dir=in protocol=udp localport=25565 remoteport=25565 action=allow
REM netsh advfirewall firewall add rule name="Minecraft A Server IO UDP" dir=out protocol=udp localport=25565 remoteport=25565 action=allow
ping 127.0.0.1 -n 10 > null
