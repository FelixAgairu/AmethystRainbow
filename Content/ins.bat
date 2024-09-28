@echo off
chcp 65001
cd /d %~dp0
echo 会清除所有现存的mod模组
echo 会覆盖部分现有配置文件
echo.
echo 现在关闭窗口可取消操作
pause
md %AppData%\.minecraft\modsbk
copy %AppData%\.minecraft\mods\AmbientSounds* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\BetterControls* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\BetterF3* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\BetterPingDisplay* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\BetterThirdPerson* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\cat_jam* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\chat_heads* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\cicada-lib* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\dynamic-fps* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\eg-inventory-blur* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\emi* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\emi_enchanting* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\emoji-type* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\enhancedblockentities* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\firstperson* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\infinite-music* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\inventive_inventory* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\jei* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\justenoughbreeding* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\lightweight-inventory-sorting* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\moderate-loading-screen* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\music_control* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\MusicNotification* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\Notes* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\now-playing* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\nvidium* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\physics-mod* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\PickUpNotifier* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\RoughlyEnoughItems* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\skinlayers3d* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\soundcontroller* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\spark* %AppData%\.minecraft\modsbk\ /Y
copy %AppData%\.minecraft\mods\symbol-chat* %AppData%\.minecraft\modsbk\ /Y
rd /S /Q %AppData%\.minecraft\mods
md %AppData%\.minecraft\mods
xcopy %AppData%\.minecraft\modsbk\* %AppData%\.minecraft\mods\ /Y /F
xcopy .\.minecraft %AppData%\.minecraft\ /S /Y /F
rd /S /Q %AppData%\.minecraft\modsbk
pause
