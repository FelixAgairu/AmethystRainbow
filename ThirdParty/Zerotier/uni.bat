@echo off
chcp 65001
echo 需要管理员权限（右键管理员权限运行）
pause
cd /D "%~dp0"
%ProgramData%\ZeroTier\One\zerotier-one_x64.exe -q leave bb267aa8a0cf640f
sc stop ZeroTierOneService
msiexec /x "ZeroTierOne.msi" /passive

REM netsh advfirewall firewall remove rule name="Minecraft A Server IO" dir=in protocol=tcp localport=25565 remoteport=25565 action=allow
REM netsh advfirewall firewall remove rule name="Minecraft A Server IO" dir=out protocol=tcp localport=25565 remoteport=25565 action=allow
pause
