#include <Constants.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

DllCall("user32.dll", "bool", "SetProcessDPIAware")
#RequireAdmin
Opt("GUIOnEventMode", 1)

Global $win_tips, $win_main

Global $id_But_Yes, $id_But_Exit, $id_But_Close, $id_But_End, $id_But_Stop
Global $id_But_First, $id_But_Update, $id_But_Uninstall
Global $id_But_Link, $id_But_Zt, $id_But_Ts, $id_But_Loader, $id_But_Mods, $id_But_UnZt
Global $id_But_Back

; AdlibRegister("_StartA")
; ShowSelectableText()
_StartA()

Exit

Func SetFonts($ctrl_ID)
	GUICtrlSetFont($ctrl_ID, 14, 500, 0, "Microsoft YaHei")
EndFunc

Func ShowSelectableText()
	Local $title = "安装器介绍"
	Local $text = "点击【继续】按钮继续"&@crlf&""&@crlf&"下载官方Java版："&@crlf&"  将打开浏览器下载“国际版”启动器安装包（官网）"&@crlf&"   https://aka.ms/minecraftClientWindows"&@crlf&"安装Zerotier："&@crlf&"  安装虚拟局域网用于联机"&@crlf&"安装Fabric："&@crlf&"  安装模组加载器（Mod Loader）"&@crlf&"  安装模组加载器前应关闭官方启动器"&@crlf&"安装客户端文件："&@crlf&"  使用Batch脚本复制所需模组及配置文件"&@crlf&"  因为部分模组不支持配置文件同步"&@crlf&""&@crlf&"关于更新："&@crlf&"一般只需更新Fabric和客户端文件，不需要更新Zerotier"&@crlf&""&@crlf&"官方默认分配 2 GB 内存（-Xmx2G）会造成游戏闪退"&@crlf&"建议的完整 JVM 参数位于最下方"&@crlf&"-Xms6G -Xmx6G -XX:+UseZGC -XX:+ZGenerational"&@crlf&"可复制上方内容，替换原有启动参数"&@crlf&"启动失败可尝试降低内存分配大小，例如："&@crlf&"-Xms5G -Xmx5G -XX:+UseZGC -XX:+ZGenerational"&@crlf&""&@crlf&"服务器 IP 地址："&@crlf&"10.245.54.52:25565"&@crlf&"或 mDNS 主机名称："&@crlf&"gameforce1.local:25565"
    $win_tips = GUICreate($title, 490, 680, -1, -1, $GUI_SS_DEFAULT_GUI - $WS_MINIMIZEBOX)
    Local $edit = GUICtrlCreateEdit($text, -1, -1, 492, 682, $ES_MULTILINE  + $ES_READONLY + $WS_TABSTOP)
	SetFonts($edit)
	GUISetOnEvent($GUI_EVENT_CLOSE, "CloseSelectableText")
	
    GUISetState(@SW_SHOW, $win_tips)
EndFunc

Func CloseSelectableText()
	GUISetState(@SW_HIDE, $win_tips)
	GUIDelete($win_tips)
EndFunc

Func _StartA()
	ShowSelectableText()
	
	$win_main = GUICreate("Amethyst 🏳️‍🌈", 180, 260, -1, -1, $GUI_SS_DEFAULT_GUI - $WS_MINIMIZEBOX)
	GUISetIcon(".\ico.ico", 0)
	GUISetOnEvent($GUI_EVENT_CLOSE, "OnExit")
	
	
	$id_But_Exit = GUICtrlCreateButton("退出", 10, 10, 160, 40)
	SetFonts($id_But_Exit)
	GUICtrlSetOnEvent($id_But_Exit, "OnExit")
	
	$id_But_Close = GUICtrlCreateButton("关闭", 10, 60, 160, 40)
	SetFonts($id_But_Close)
	GUICtrlSetOnEvent($id_But_Close, "OnExit")
	
	$id_But_Yes = GUICtrlCreateButton("【继续】", 10, 110, 160, 40)
	SetFonts($id_But_Yes)
	GUICtrlSetOnEvent($id_But_Yes, "InstPreMenu")
	
	$id_But_End = GUICtrlCreateButton("结束", 10, 160, 160, 40)
	SetFonts($id_But_End)
	GUICtrlSetOnEvent($id_But_End, "OnExit")
	
	$id_But_Stop = GUICtrlCreateButton("停止", 10, 210, 160, 40)
	SetFonts($id_But_Stop)
	GUICtrlSetOnEvent($id_But_Stop, "OnExit")
	
	GUISetState(@SW_SHOW)
	
	While 1
		Sleep(1000)
	WEnd
EndFunc

Func InstPreMenu()
	GUISwitch($win_main)
	GUICtrlDelete($id_But_Exit)
	GUICtrlDelete($id_But_Close)
	GUICtrlDelete($id_But_Yes)
	GUICtrlDelete($id_But_End)
	GUICtrlDelete($id_But_Stop)
	
	GUICtrlDelete($id_But_Back)
	
	GUICtrlDelete($id_But_Link)
	GUICtrlDelete($id_But_Zt)
	GUICtrlDelete($id_But_Loader)
	GUICtrlDelete($id_But_Mods)
	
	$id_But_First = GUICtrlCreateButton("首次安装", 10, 10, 160, 40)
	SetFonts($id_But_First)
	GUICtrlSetOnEvent($id_But_First, "InstFristMenu")

	$id_But_Update = GUICtrlCreateButton("更新", 10, 60, 160, 40)
	SetFonts($id_But_Update)
	GUICtrlSetOnEvent($id_But_Update, "InstUpdateMenu")
	
	$id_But_Uninstall = GUICtrlCreateButton("卸载", 10, 210, 160, 40)
	SetFonts($id_But_Uninstall)
	GUICtrlSetOnEvent($id_But_Uninstall, "UninstallMenu")
	
	
EndFunc


Func InstFristMenu()
	GUISwitch($win_main)
	GUICtrlDelete($id_But_First)
	GUICtrlDelete($id_But_Update)
	GUICtrlDelete($id_But_Uninstall)
	
	$id_But_Back = GUICtrlCreateButton("返回", 10, 10, 160, 40)
	SetFonts($id_But_Back)
	GUICtrlSetOnEvent($id_But_Back, "InstPreMenu")
	
	$id_But_Link = GUICtrlCreateButton("下载官方Java版", 10, 60, 160, 40)
	SetFonts($id_But_Link)
	GUICtrlSetOnEvent($id_But_Link, "OpenMcLink")
	
	$id_But_Zt = GUICtrlCreateButton("安装Zerotier", 10, 110, 160, 40)
	SetFonts($id_But_Zt)
	GUICtrlSetOnEvent($id_But_Zt, "InstZerotier")
	
	; $id_But_Ts = GUICtrlCreateButton("安装Tailscale", 10, 110, 160, 40)
	; SetFonts($id_But_Ts)
	; GUICtrlSetOnEvent($id_But_Ts, "InstTailscale")
	
	$id_But_Loader = GUICtrlCreateButton("安装Fabric", 10, 160, 160, 40)
	SetFonts($id_But_Loader)
	GUICtrlSetOnEvent($id_But_Loader, "InstLoader")
	
	$id_But_Mods = GUICtrlCreateButton("安装客户端文件", 10, 210, 160, 40)
	SetFonts($id_But_Mods)
	GUICtrlSetOnEvent($id_But_Mods, "InstMods")
	
	
EndFunc

Func InstUpdateMenu()
	GUISwitch($win_main)
	GUICtrlDelete($id_But_First)
	GUICtrlDelete($id_But_Update)
	GUICtrlDelete($id_But_Uninstall)
	
	$id_But_Mods = GUICtrlCreateButton("更新客户端文件", 10, 10, 160, 40)
	SetFonts($id_But_Mods)
	GUICtrlSetOnEvent($id_But_Mods, "InstMods")
	
	$id_But_Back = GUICtrlCreateButton("返回", 10, 60, 160, 40)
	SetFonts($id_But_Back)
	GUICtrlSetOnEvent($id_But_Back, "InstPreMenu")
	
	$id_But_Loader = GUICtrlCreateButton("更新Fabric", 10, 110, 160, 40)
	SetFonts($id_But_Loader)
	GUICtrlSetOnEvent($id_But_Loader, "InstLoader")
		
	$id_But_Zt = GUICtrlCreateButton("更新Zerotier", 10, 160, 160, 40)
	SetFonts($id_But_Zt)
	GUICtrlSetOnEvent($id_But_Zt, "InstZerotier")
	
	; $id_But_Ts = GUICtrlCreateButton("更新Tailscale", 10, 160, 160, 40)
	; SetFonts($id_But_Ts)
	; GUICtrlSetOnEvent($id_But_Ts, "InstTailscale")
	
EndFunc


Func UninstallMenu()
	GUISwitch($win_main)
	GUICtrlDelete($id_But_First)
	GUICtrlDelete($id_But_Update)
	GUICtrlDelete($id_But_Uninstall)
	
	$id_But_Zt = GUICtrlCreateButton("卸载Zerotier", 10, 10, 160, 40)
	SetFonts($id_But_Zt)
	GUICtrlSetOnEvent($id_But_Zt, "UninZerotier")
	
	$id_But_Ts = GUICtrlCreateButton("卸载Tailscale", 10, 60, 160, 40)
	SetFonts($id_But_Ts)
	GUICtrlSetOnEvent($id_But_Ts, "UninTailscale")
	
	$id_But_Back = GUICtrlCreateButton("返回", 10, 210, 160, 40)
	SetFonts($id_But_Back)
	GUICtrlSetOnEvent($id_But_Back, "InstPreMenu")
EndFunc



Func OpenMcLink()
	GUICtrlSetState($id_But_Link, $GUI_DISABLE)
	GUICtrlSetData($id_But_Link, "已打开链接")
	ShellExecute("https://aka.ms/minecraftClientWindows")
EndFunc

Func InstZerotier()
	GUICtrlSetState($id_But_Zt, $GUI_DISABLE)
	GUICtrlSetData($id_But_Zt, "正在安装...")
	ShellExecute(".\ThirdParty\Zerotier\ins.bat", "", "", $SHEX_OPEN, @SW_HIDE)
	GUICtrlSetData($id_But_Zt, "已完成")
EndFunc

; Func InstTailscale()
	; GUICtrlSetState($id_But_Ts, $GUI_DISABLE)
	; GUICtrlSetData($id_But_Ts, "正在安装...")
	; ShellExecute(".\ThirdParty\Tailscale\tailscale.msi", "", "", $SHEX_OPEN, @SW_HIDE)
	; GUICtrlSetData($id_But_Ts, "已完成")
; EndFunc

Func UninZerotier()
	GUICtrlSetState($id_But_Zt, $GUI_DISABLE)
	GUICtrlSetData($id_But_Zt, "正在卸载...")
	ShellExecuteWait(".\ThirdParty\Zerotier\uni.bat", "", "", $SHEX_OPEN, @SW_HIDE)
	GUICtrlSetData($id_But_Zt, "已完成")
EndFunc

Func UninTailscale()
	GUICtrlSetState($id_But_Ts, $GUI_DISABLE)
	GUICtrlSetData($id_But_Ts, "正在卸载...")
	ShellExecuteWait(".\ThirdParty\Tailscale\tailscale.msi", "", "", $SHEX_OPEN, @SW_HIDE)
	GUICtrlSetData($id_But_Ts, "已完成")
EndFunc

Func InstLoader()
	GUICtrlSetState($id_But_Loader, $GUI_DISABLE)
	GUICtrlSetData($id_But_Loader, "正在安装...")
	SplashTextOn("“Fabric 安装器” 安装说明", "可移动窗口至其他位置"&@lf&"完成后本窗口会自动消失"&@lf&""&@lf&"游戏版本 选择→【1.21.1】"&@lf&"加载器版本 选择 →【最新版】"&@lf&"其他内容无需改动"&@lf&""&@lf&"最后点【安装】"&@lf&"完成后会弹框提示"&@lf&"弹框建议下载Fabric-API，关闭弹框"&@lf&"“安装”上方显示“完成”表示安装完成"&@lf&"最后关闭“Fabric 安装器”窗口即可", 320, 280, -1, -1, 16)
	ShellExecuteWait(".\ThirdParty\Fabric\ins.exe")
	SplashOff()
	GUICtrlSetData($id_But_Loader, "已完成")
EndFunc

Func InstMods()
	GUICtrlSetState($id_But_Mods, $GUI_DISABLE)
	GUICtrlSetData($id_But_Mods, "正在安装...")
	ShellExecuteWait(".\Content\ins.bat")
	GUICtrlSetData($id_But_Mods, "已完成")
EndFunc

Func OnExit()
	Exit
EndFunc
