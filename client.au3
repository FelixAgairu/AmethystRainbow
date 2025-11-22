#include <Constants.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

DllCall("user32.dll", "bool", "SetProcessDPIAware")
#RequireAdmin
Opt("GUIOnEventMode", 1)

; $win_gif GIF help wnd
; $win_tips TEXT help wnd
; $win_main MENU wnd
Global $win_gif, $win_tips, $win_main

; First screen
Global $id_But_Yes, $id_Edit_Info, $id_But_Help_Text, $id_But_Help_Gif
Global $id_But_Exit
Global $id_But_First, $id_But_Update, $id_But_Uninstall, $id_But_Manually
Global $id_But_Link, $id_But_Zt, $id_But_Ts, $id_But_Loader, $id_But_Mods
Global $id_But_Back

Global $data_But_Wait = "请稍后..."
Global $data_Edit_Info = "按钮：“继续”"&@crlf&"  开始安装流程"&@crlf&""&@crlf&"按钮：“主要帮助”"&@crlf&"按钮：“图文帮助”"&@crlf&"  打开相关帮助窗口"&@crlf&""&@crlf&"按钮：“退出”"&@crlf&"  关闭本程序"

_StartMain()

Exit

Func SetFonts($ctrl_ID)
	GUICtrlSetFont($ctrl_ID, 13, 500, 0, "Microsoft YaHei")
EndFunc

Func ShowGifWnd()
	If Not $win_gif Then
		$win_gif = GUICreate("图文帮助", 800, 600, 0, 0)
		Global $win_gif_pic = GUICtrlCreatePic(".\Manual\Help01.jpg", 0, 0, 800, 600)
		GUICtrlSetOnEvent($win_gif_pic, "GifWndNextFrame")
		GUISetOnEvent($GUI_EVENT_CLOSE, "CloseGifWnd")
		GUISetState(@SW_SHOW, $win_gif)
		
		Global $win_gif_frames[17]
		For $i = 1 To 17
			$win_gif_frames[$i - 1] = ".\Manual\Help" & StringFormat("%02d", $i) & ".jpg"
		Next

		Global $win_gif_index = 0
	EndIf
	GUISwitch($win_main)
EndFunc

Func GifWndNextFrame()
    $win_gif_index = Mod($win_gif_index + 1, UBound($win_gif_frames))
    GUICtrlSetImage($win_gif_pic, $win_gif_frames[$win_gif_index])
EndFunc

Func CloseGifWnd()
	GUIDelete($win_gif)
	$win_gif = Null
EndFunc


Func ShowTextHelp()
	If Not $win_tips Then
		Local $title = "安装器介绍"
		Local $text = "“首次安装”及“更新”仅支持官方启动器"&@crlf&""&@crlf&"首次安装："&@crlf&"    下载官方启动器："&@crlf&"        将打开浏览器下载“国际版”启动器安装包"&@crlf&"        官网：https://aka.ms/minecraftClientWindows"&@crlf&"    安装联机工具："&@crlf&"        将安装 Zerotier 用于建立虚拟局域网*"&@crlf&"        安装完成后 QQ 联系 1034002918"&@crlf&"		进行 IP 地址分配"&@crlf&"        否则无法连接到服务器"&@crlf&"    安装模组加载器："&@crlf&"        将安装 Fabric 模组加载器"&@crlf&"        ！可能需要加速器或 Virtual Private Network！"&@crlf&"        安装模组加载器前应关闭官方启动器"&@crlf&"    安装客户端文件："&@crlf&"        使用 Batch 脚本复制所需模组及配置文件"&@crlf&"        原因是部分模组不支持配置文件同步"&@crlf&""&@crlf&"更新："&@crlf&"    一般只需更新模组加载器和客户端文件"&@crlf&"    不需要更新联机工具"&@crlf&""&@crlf&"卸载："&@crlf&"    卸载 Zerotier"&@crlf&""&@crlf&"手动安装："&@crlf&"    自行复制模组至所需位置"&@crlf&"    必须同时复制 config 文件夹"&@crlf&"    否则会导致模组同步异常"&@crlf&"    例如：时间或天气与服务器不同步"&@crlf&""&@crlf&"调整内存分配："&@crlf&"    官方默认分配 2 GB 内存（-Xmx2G）"&@crlf&"    会造成游戏闪退或卡在进度条界面"&@crlf&"    建议的完整 JVM 参数位于最下方"&@crlf&"============================================"&@crlf&"-Xms6G -Xmx6G -XX:+UseZGC -XX:+ZGenerational"&@crlf&"============================================"&@crlf&"    可复制上方两行 = 中间的内容"&@crlf&"    替换原有启动参数"&@crlf&"    启动失败可尝试降低内存分配大小，例如："&@crlf&"-Xms5G -Xmx5G -XX:+UseZGC -XX:+ZGenerational"&@crlf&""&@crlf&"建议使用服务器 IP 地址："&@crlf&"10.245.54.52:25565"&@crlf&""&@crlf&"或使用 mDNS 主机名称："&@crlf&"gameforce1.local:25565"&@crlf&""&@crlf&""&@crlf&"额外内容："&@crlf&"    最新无模组 Java 版 1.21.10 服务器端口号"&@crlf&"    12110"&@crlf&""&@crlf&"    推荐 Temurin JVM 21 LTS："&@crlf&"    https://adoptium.net/temurin/releases?version=21&os=windows"&@crlf&""&@crlf&""&@crlf&"*实际游戏服务器为："&@crlf&"    TUF GAMING B450M-PRO S"&@crlf&"    AMD Ryzen 9 3900X"&@crlf&"    32 GB 3200 MHz DDR4 (JVM Heap 16 GB)"&@crlf&"    256 GB NVMe SSD"&@crlf&""&@crlf&"这种性能的服务器太奢侈了"&@crlf&"所以只能用虚拟局域网联机（伪·服务器）"&@crlf&""
		$win_tips = GUICreate($title, 750, 750, 0, 0, $GUI_SS_DEFAULT_GUI - $WS_MINIMIZEBOX + $WS_SIZEBOX)
		Local $edit = GUICtrlCreateEdit($text, -1, -1, 752, 752, $ES_MULTILINE + $WS_VSCROLL + $ES_READONLY + $WS_TABSTOP)
		SetFonts($edit)
		GUISetOnEvent($GUI_EVENT_CLOSE, "CloseTextHelp")
		
		GUISetState(@SW_SHOW, $win_tips)
	EndIf
	GUISwitch($win_main)
EndFunc

Func CloseTextHelp()
	GUIDelete($win_tips)
	$win_tips = Null
EndFunc

Func ShowMenuWnd()
	$win_main = GUICreate("Amethyst 🏳️‍🌈", 340, 430, -1, -1, $GUI_SS_DEFAULT_GUI - $WS_MINIMIZEBOX)
	GUISetIcon(".\ico.ico", 0)
	GUISetOnEvent($GUI_EVENT_CLOSE, "OnExit")
	
	$id_But_Yes = GUICtrlCreateButton("继续", 10, 10, 320, 50)
	SetFonts($id_But_Yes)
	GUICtrlSetOnEvent($id_But_Yes, "InstPreMenu")
	
	$id_Edit_Info = GUICtrlCreateEdit($data_Edit_Info, 10, 70, 320, 230, $ES_READONLY)
	SetFonts($id_Edit_Info)
	GUICtrlSetState($id_Edit_Info, $GUI_DISABLE)
	
	$id_But_Help_Text = GUICtrlCreateButton("主要帮助", 10, 310, 155, 50)
	SetFonts($id_But_Help_Text)
	GUICtrlSetOnEvent($id_But_Help_Text, "ShowTextHelp")
	$id_But_Help_Gif = GUICtrlCreateButton("图文帮助", 175, 310, 155, 50)
	SetFonts($id_But_Help_Gif)
	GUICtrlSetOnEvent($id_But_Help_Gif, "ShowGifWnd")
	
	$id_But_Exit = GUICtrlCreateButton("退出", 10, 370, 320, 50)
	SetFonts($id_But_Exit)
	GUICtrlSetOnEvent($id_But_Exit, "OnExit")
	
	GUISetState(@SW_SHOW, $win_main)
EndFunc

Func _StartMain()
	ShowMenuWnd()
	
	While 1
		Sleep(1000)
	WEnd
EndFunc

Func InstPreMenu()
	GUISwitch($win_main)
	
	GUICtrlDelete($id_But_Yes)
	GUICtrlDelete($id_Edit_Info)
	
	GUICtrlDelete($id_But_Back)
	
	GUICtrlDelete($id_But_Link)
	GUICtrlDelete($id_But_Zt)
	GUICtrlDelete($id_But_Loader)
	GUICtrlDelete($id_But_Mods)
	
	$id_But_First = GUICtrlCreateButton($data_But_Wait, 10, 10, 320, 50)
	SetFonts($id_But_First)
	GUICtrlSetOnEvent($id_But_First, "InstFristMenu")

	$id_But_Update = GUICtrlCreateButton($data_But_Wait, 10, 70, 320, 50)
	SetFonts($id_But_Update)
	GUICtrlSetOnEvent($id_But_Update, "InstUpdateMenu")
	
	$id_But_Uninstall = GUICtrlCreateButton($data_But_Wait, 10, 130, 320, 50)
	SetFonts($id_But_Uninstall)
	GUICtrlSetOnEvent($id_But_Uninstall, "UninstallMenu")
	
	$id_But_Manually = GUICtrlCreateButton($data_But_Wait, 10, 250, 320, 50)
	SetFonts($id_But_Manually)
	GUICtrlSetOnEvent($id_But_Manually, "OpenFolderManually")
	
	
	GUICtrlSetState($id_But_First, $GUI_DISABLE)
	GUICtrlSetState($id_But_Update, $GUI_DISABLE)
	GUICtrlSetState($id_But_Uninstall, $GUI_DISABLE)
	GUICtrlSetState($id_But_Manually, $GUI_DISABLE)
	
	Sleep(500)
	GUICtrlSetData($id_But_First, "首次安装")
	Sleep(500)
	GUICtrlSetState($id_But_First, $GUI_ENABLE)
	Sleep(200)
	GUICtrlSetData($id_But_Update, "更新")
	Sleep(200)
	GUICtrlSetState($id_But_Update, $GUI_ENABLE)
	Sleep(90)
	GUICtrlSetData($id_But_Uninstall, "卸载")
	Sleep(90)
	GUICtrlSetState($id_But_Uninstall, $GUI_ENABLE)
	Sleep(25)
	GUICtrlSetData($id_But_Manually, "手动安装")
	Sleep(25)
	GUICtrlSetState($id_But_Manually, $GUI_ENABLE)
EndFunc

Func CreateBackButton()
	GUISwitch($win_main)
	
	$id_But_Back = GUICtrlCreateButton("返回", 10, 250, 320, 50)
	SetFonts($id_But_Back)
	GUICtrlSetOnEvent($id_But_Back, "InstPreMenu")
EndFunc

Func DeleteOldButton()
	GUISwitch($win_main)
	GUICtrlDelete($id_But_First)
	GUICtrlDelete($id_But_Update)
	GUICtrlDelete($id_But_Uninstall)
	GUICtrlDelete($id_But_Manually)
EndFunc

Func InstFristMenu()
	DeleteOldButton()
	CreateBackButton()
	
	$id_But_Link = GUICtrlCreateButton($data_But_Wait, 10, 10, 320, 50)
	SetFonts($id_But_Link)
	GUICtrlSetOnEvent($id_But_Link, "OpenMcLink")
	
	$id_But_Zt = GUICtrlCreateButton($data_But_Wait, 10, 70, 320, 50)
	SetFonts($id_But_Zt)
	GUICtrlSetOnEvent($id_But_Zt, "InstZerotier")
	
	; $id_But_Ts = GUICtrlCreateButton($data_But_Wait, 10, 70, 320, 50)
	; SetFonts($id_But_Ts)
	; GUICtrlSetOnEvent($id_But_Ts, "InstTailscale")
	
	$id_But_Loader = GUICtrlCreateButton($data_But_Wait, 10, 130, 320, 50)
	SetFonts($id_But_Loader)
	GUICtrlSetOnEvent($id_But_Loader, "InstLoader")
	
	$id_But_Mods = GUICtrlCreateButton($data_But_Wait, 10, 190, 320, 50)
	SetFonts($id_But_Mods)
	GUICtrlSetOnEvent($id_But_Mods, "InstMods")
	
	GUICtrlSetState($id_But_Link, $GUI_DISABLE)
	GUICtrlSetState($id_But_Zt, $GUI_DISABLE)
	; GUICtrlSetState($id_But_Ts, $GUI_DISABLE)
	GUICtrlSetState($id_But_Loader, $GUI_DISABLE)
	GUICtrlSetState($id_But_Mods, $GUI_DISABLE)
	
	Sleep(500)
	GUICtrlSetData($id_But_Link, "①　下载官方启动器")
	Sleep(500)
	GUICtrlSetState($id_But_Link, $GUI_ENABLE)
	Sleep(150)
	GUICtrlSetData($id_But_Zt, "②　　安装联机工具")
	Sleep(150)
	GUICtrlSetState($id_But_Zt, $GUI_ENABLE)
	; Sleep(90)
	; GUICtrlSetData($id_But_Ts, "③安装Tailscale")
	; Sleep(90)
	; GUICtrlSetState($id_But_Ts, $GUI_ENABLE)
	Sleep(60)
	GUICtrlSetData($id_But_Loader, "③　安装模组加载器")
	Sleep(60)
	GUICtrlSetState($id_But_Loader, $GUI_ENABLE)
	Sleep(10)
	GUICtrlSetData($id_But_Mods, "④　安装客户端文件")
	Sleep(10)
	GUICtrlSetState($id_But_Mods, $GUI_ENABLE)
EndFunc

Func InstUpdateMenu()
	DeleteOldButton()
	CreateBackButton()
	
	$id_But_Mods = GUICtrlCreateButton($data_But_Wait, 10, 10, 320, 50)
	SetFonts($id_But_Mods)
	GUICtrlSetOnEvent($id_But_Mods, "InstMods")
	
	$id_But_Loader = GUICtrlCreateButton($data_But_Wait, 10, 70, 320, 50)
	SetFonts($id_But_Loader)
	GUICtrlSetOnEvent($id_But_Loader, "InstLoader")
		
	$id_But_Zt = GUICtrlCreateButton($data_But_Wait, 10, 130, 320, 50)
	SetFonts($id_But_Zt)
	GUICtrlSetOnEvent($id_But_Zt, "InstZerotier")
	
	; $id_But_Ts = GUICtrlCreateButton($data_But_Wait, 10, 190, 320, 50)
	; SetFonts($id_But_Ts)
	; GUICtrlSetOnEvent($id_But_Ts, "InstTailscale")
	
	GUICtrlSetState($id_But_Mods, $GUI_DISABLE)
	GUICtrlSetState($id_But_Loader, $GUI_DISABLE)
	GUICtrlSetState($id_But_Zt, $GUI_DISABLE)
	; GUICtrlSetState($id_But_Ts, $GUI_DISABLE)
	
	Sleep(400)
	GUICtrlSetData($id_But_Mods, "更新客户端文件")
	Sleep(400)
	GUICtrlSetState($id_But_Mods, $GUI_ENABLE)
	Sleep(100)
	GUICtrlSetData($id_But_Loader, "更新模组加载器")
	Sleep(100)
	GUICtrlSetState($id_But_Loader, $GUI_ENABLE)
	Sleep(25)
	GUICtrlSetData($id_But_Zt, "更新联机工具")
	Sleep(25)
	GUICtrlSetState($id_But_Zt, $GUI_ENABLE)
	; Sleep(10)
	; GUICtrlSetData($id_But_Ts, "更新Tailscale")
	; Sleep(10)
	; GUICtrlSetState($id_But_Ts, $GUI_ENABLE)
EndFunc


Func UninstallMenu()
	DeleteOldButton()
	CreateBackButton()
	
	$id_But_Zt = GUICtrlCreateButton($data_But_Wait, 10, 10, 320, 50)
	SetFonts($id_But_Zt)
	GUICtrlSetOnEvent($id_But_Zt, "UninZerotier")
	
	; $id_But_Ts = GUICtrlCreateButton($data_But_Wait, 10, 70, 320, 50)
	; SetFonts($id_But_Ts)
	; GUICtrlSetOnEvent($id_But_Ts, "UninTailscale")
	
	GUICtrlSetState($id_But_Zt, $GUI_DISABLE)
	; GUICtrlSetState($id_But_Ts, $GUI_DISABLE)
	
	Sleep(100)
	GUICtrlSetData($id_But_Zt, "卸载联机工具")
	Sleep(100)
	GUICtrlSetState($id_But_Zt, $GUI_ENABLE)
	; Sleep(25)
	; GUICtrlSetData($id_But_Ts, "卸载Tailscale")
	; Sleep(25)
	; GUICtrlSetState($id_But_Ts, $GUI_ENABLE)
EndFunc

Func OpenFolderManually()
	GUICtrlSetState($id_But_Manually, $GUI_DISABLE)
	GUICtrlSetData($id_But_Manually, "已打开文件夹")
	ShellExecute(".\Content\.minecraft")
	Sleep(2000)
	GUICtrlSetData($id_But_Manually, "手动安装")
	GUICtrlSetState($id_But_Manually, $GUI_ENABLE)
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
	SplashTextOn("“Fabric 安装器” 安装说明", "可移动窗口至其他位置"&@lf&"完成后本窗口会自动消失"&@lf&""&@lf&"游戏版本 选择→【1.21.1】"&@lf&""&@lf&"其他内容无需改动"&@lf&""&@lf&"最后点【安装】"&@lf&"完成后会弹框提示"&@lf&"弹框建议下载Fabric-API等，关闭弹框即可"&@lf&"“安装”上方显示“完成”表示安装完成"&@lf&"最后关闭“Fabric 安装器”窗口即可", 480, 360, -1, -1, 16)
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
