﻿#NoEnv
#SingleInstance Force
#NoTrayIcon
#Include ./lib/AOS.ahk
#Include ./lib/Gdip.ahk

AutoOS.PlayerManager.GetPlayerMouseSpeed(%1%) ; Get current player.
AutoOS.Setup()
OnMessage(0x4a, "ReceiveAsyncInput")  ; 0x4a is WM_COPYDATA
return

ReceiveAsyncInput(wParam, lParam)
{
	Critical, On	; This was the only way I found out so far to remove lag.... there should be a better way.
	string_address := NumGet(lParam + 2*A_PtrSize)  ; Retrieves the CopyDataStruct's lpData member.
	data := StrGet(string_address) 					; Copy the string out of the structure	.
	if InStr(data, "Exit", true)
		ExitApp
	Input.DynamicMouseMethod(data)
	Critical, Off
	return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}

^#ESC::
	ExitApp
return