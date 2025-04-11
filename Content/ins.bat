@echo off
chcp 65001
cd /d %~dp0
echo 会清除所有现存的mod模组
echo 会覆盖部分现有配置文件
echo.
echo 现在关闭窗口可取消操作
pause
rd /S /Q %AppData%\.minecraft\modsbk
md %AppData%\.minecraft\modsbk
xcopy %AppData%\.minecraft\mods\* %AppData%\.minecraft\modsbk\ /Y /F
rd /S /Q %AppData%\.minecraft\mods
md %AppData%\.minecraft\mods
xcopy .\.minecraft %AppData%\.minecraft\ /S /Y /F
pause
