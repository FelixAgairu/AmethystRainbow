#include <Constants.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>

#RequireAdmin

Opt("GUIOnEventMode", 1)

Global $id_But_First, $id_But_Update, $id_But_Uninstall
Global $id_But_Link, $id_But_Zt, $id_But_Ts, $id_But_Loader, $id_But_Mods, $id_But_UnZt

_StartA()
Exit



Func _StartA()
	GUICreate("Amethyst 🏳️‍🌈", 150, 150, -1, -1, BitXOR($GUI_SS_DEFAULT_GUI, $WS_MINIMIZEBOX))
	GUISetIcon(".\ico.ico", 0)
	GUISetOnEvent($GUI_EVENT_CLOSE, "OnExit")
	
	$id_But_First = GUICtrlCreateButton("首次安装", 5, 5, 140, 30)
	GUICtrlSetOnEvent($id_But_First, "InstFristMenu")

	$id_But_Update = GUICtrlCreateButton("更新", 5, 40, 140, 30)
	GUICtrlSetOnEvent($id_But_Update, "InstUpdateMenu")
	
	$id_But_Uninstall = GUICtrlCreateButton("卸载", 5, 75, 140, 30)
	GUICtrlSetOnEvent($id_But_Uninstall, "UninstallMenu")
	
	
	GUISetState(@SW_SHOW)
	
	While 1
		Sleep(1000)
	WEnd
EndFunc



Func InstFristMenu()
	GUICtrlDelete($id_But_First)
	GUICtrlDelete($id_But_Update)
	GUICtrlDelete($id_But_Uninstall)
	

	
	
	
	$id_But_Link = GUICtrlCreateButton("下载官方Java版", 5, 5, 140, 30)
	GUICtrlSetOnEvent($id_But_Link, "OpenMcLink")
	
	; $id_But_Zt = GUICtrlCreateButton("安装Zerotier", 5, 40, 140, 30)
	; GUICtrlSetOnEvent($id_But_Zt, "InstZerotier")
	
	$id_But_Ts = GUICtrlCreateButton("安装Tailscale", 5, 40, 140, 30)
	GUICtrlSetOnEvent($id_But_Ts, "InstTailscale")
	
	$id_But_Loader = GUICtrlCreateButton("安装Fabric", 5, 75, 140, 30)
	GUICtrlSetOnEvent($id_But_Loader, "InstLoader")
	
	$id_But_Mods = GUICtrlCreateButton("安装客户端文件", 5, 110, 140, 30)
	GUICtrlSetOnEvent($id_But_Mods, "InstMods")
	
EndFunc

Func InstUpdateMenu()
	GUICtrlDelete($id_But_First)
	GUICtrlDelete($id_But_Update)
	GUICtrlDelete($id_But_Uninstall)
	
	; $id_But_Zt = GUICtrlCreateButton("更新Zerotier", 5, 5, 140, 30)
	; GUICtrlSetOnEvent($id_But_Zt, "InstZerotier")
	$id_But_Ts = GUICtrlCreateButton("更新Tailscale", 5, 5, 140, 30)
	GUICtrlSetOnEvent($id_But_Ts, "InstTailscale")
	$id_But_Loader = GUICtrlCreateButton("更新Fabric", 5, 40, 140, 30)
	GUICtrlSetOnEvent($id_But_Loader, "InstLoader")
	$id_But_Mods = GUICtrlCreateButton("更新客户端文件", 5, 75, 140, 30)
	GUICtrlSetOnEvent($id_But_Mods, "InstMods")
EndFunc


Func UninstallMenu()
	GUICtrlDelete($id_But_First)
	GUICtrlDelete($id_But_Update)
	GUICtrlDelete($id_But_Uninstall)
	
	Local $id_But_Zt = GUICtrlCreateButton("卸载Zerotier", 5, 5, 140, 30)
	GUICtrlSetOnEvent($id_But_Zt, "UninZerotier")
	
	Local $id_But_Ts = GUICtrlCreateButton("卸载Tailscale", 5, 40, 140, 30)
	GUICtrlSetOnEvent($id_But_Ts, "UninTailscale")
EndFunc



Func OpenMcLink()
	GUICtrlSetState($id_But_Link, $GUI_DISABLE)
	GUICtrlSetData($id_But_Link, "已打开链接")
	ShellExecute("https://aka.ms/minecraftClientWindows")
EndFunc

; Func InstZerotier()
	; GUICtrlSetState($id_But_Zt, $GUI_DISABLE)
	; GUICtrlSetData($id_But_Zt, "正在安装...")
	; ShellExecute(".\ThirdParty\Zerotier\ins.bat", "", "", $SHEX_OPEN, @SW_HIDE)
	; GUICtrlSetData($id_But_Zt, "已完成")
; EndFunc

Func InstTailscale()
	GUICtrlSetState($id_But_Ts, $GUI_DISABLE)
	GUICtrlSetData($id_But_Ts, "正在安装...")
	ShellExecute(".\ThirdParty\Tailscale\tailscale.msi", "", "", $SHEX_OPEN, @SW_HIDE)
	GUICtrlSetData($id_But_Ts, "已完成")
EndFunc

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
	SplashTextOn("Mod加载器（Fabric）安装说明", "可移动窗口至其他位置"&@lf&"窗口会自动消失"&@lf&""&@lf&"Minecraft Version 选择→【1.21.1】"&@lf&"Loader Version 选择 →【“最新版”】"&@lf&"Launcher Location →【“默认”】"&@lf&"Create profile 【✓选中】"&@lf&""&@lf&"最后点【Install】安装"&@lf&"完成后会弹框提示"&@lf&"弹框建议下载Fabric-API，关闭弹框"&@lf&"“Install”上方显示“Done”表示安装完成", 320, 280, -1, -1, 16)
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
