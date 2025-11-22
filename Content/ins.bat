@echo off
chcp 65001
cd /d %~dp0
echo.
echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo X                          X
echo X    会清除全部现存模组    X
echo X                          X
echo X  会覆盖部分现有配置文件  X
echo X                          X
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
echo XXXX 关闭窗口可取消操作 XXXX
echo.
echo        按任意键  继续
pause >nul
cls
echo.
echo.
echo XXXX 正在备份模组文件夹 XXXX
echo.
rd /S /Q %AppData%\.minecraft\modsbk
md %AppData%\.minecraft\modsbk
xcopy %AppData%\.minecraft\mods\* %AppData%\.minecraft\modsbk\ /Y /F
echo.
echo.
echo.
echo XXXX 准备复制模组文件夹 XXXX
timeout /t ２ /nobreak >nul
rd /S /Q %AppData%\.minecraft\mods
md %AppData%\.minecraft\mods
xcopy .\.minecraft %AppData%\.minecraft\ /S /Y /F
echo.
echo.
echo XXXX       已完成       XXXX
echo.
echo      按任意键　关闭窗口
pause >nul
