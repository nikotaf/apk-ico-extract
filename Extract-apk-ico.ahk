#NoTrayIcon
#SingleInstance force

; v1.0-196c 21-Nov-2009 www.autohotkey.com/forum/topic51354.html
;    | by Skan | 19-Nov-2009
StrX(H,BS="",BO=0,BT=1,ES="",EO=0,ET=1,ByRef N="")
{
	Return SubStr(H,P:=(((Z:=StrLen(ES))+(X:=StrLen(H))+StrLen(BS)-Z-X)?((T:=InStr(H,BS,0,((BO<0)?(1):(BO))))?(T+BT):(X+1)):(1)),(N:=P+((Z)?((T:=InStr(H,ES,0,((EO)?(P+1):(0))))?(T-P+Z+(0-ET)):(X+P)):(X)))-P)
}

aapt := "" ; full path to aapt.exe
pkzip := "" ; full path to cli pkzip
_7zip := "" ; full path to cli 7z.exe
winrar := "" ; full path to winrar.exe
iview := "" ; full path to i_view32.exe

if aapt is space
	ExitApp
Loop, %0%
{
	SplitPath, %A_Index%, fname, fdir, ext, name
	StringReplace,name,name,",,ALL ; "
	Break
}
if name is space
{
	MsgBox,36,Warning,Add right click integration with APK's?
	IfMsgBox,No
	{
		RegDelete, HKEY_CLASSES_ROOT\apkfile\shell\Extract icon here
		ExitApp
	}
	RegRead, ahkpath,HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AutoHotkey.exe
	if ErrorLevel
	{
		MsgBox, Autohotkey is not installed!`r`nThe application will now exit.
		ExitApp
	}
	script := A_ScriptDir . "\" . A_ScriptName
	RegWrite, REG_SZ,HKEY_CLASSES_ROOT\.apk,,apkfile
	RegWrite, REG_SZ,HKEY_CLASSES_ROOT\apkfile\shell\Extract icon here\command,,"%ahkpath%" "%script%" "`%1"
	if ErrorLevel
	{
		RegWrite, REG_SZ,HKEY_CURRENT_USER\Software\Classes\.apk,,apkfile
		RegWrite, REG_SZ,HKEY_CURRENT_USER\Software\Classes\apkfile\shell\Extract icon here\command,,"%ahkpath%" "%script%" "`%1"
	}
	ExitApp
}
RunWait, %comspec% /c ""%aapt%" d --values badging "%fdir%\%name%.%ext%" > "%A_Temp%\%name%.info"",,Hide
Loop
{
    FileReadLine, line, %A_Temp%\%name%.info, %A_Index%
    if ErrorLevel
        Break
     IfInString, line,application: label ; line that holds apk icon
	{
		path:=StrX(line," icon='",0,7,"'",5,1)
		Break
	}
}
StringReplace, path,path,/,\,ALL ; path inside archive
StringSplit,tmp,path,\
image:=tmp%tmp0%
FileDelete,%A_Temp%\%name%.info
if pkzip is not space
	RunWait, %comspec% /c ""%pkzip%" -extract -nozipextension "%fdir%\%name%.%ext%" %path% "%A_Temp%"",,Hide
if _7zip is not space
	RunWait, %comspec% /c ""%_7zip%" e -o"%A_Temp%" "%fdir%\%name%.%ext%" %path%",,Hide
if winrar is not space
	RunWait, %comspec% /c ""%winrar%" e -ibck -or "%fdir%\%name%.%ext%" %path% "%A_Temp%\"",,Hide
IfExist, %A_Temp%\%image%
	if iview is not space
	{
		RunWait, %comspec% /c ""%iview%" "%A_Temp%\%image%" /convert=%fdir%\%name%.ico",,Hide
		FileDelete,%A_Temp%\%image%
	}
IfExist, %A_Temp%\%image%
	FileMove, %A_Temp%\%image%,%fdir%\%image%
