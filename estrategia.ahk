#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#IfWinActive ahk_exe chrome.exe
/*
This is a trash 
multiline 
comment 
*/

;-----------------------------------------------------------------------------------
; Formata alternativas
; ----------------------------------------------------------------------------------
^!+v:: ; Ctrl + Alt + Shift + V

; Trim para remover lixo
Clipboard := trim(clipboard,"`n`r`t ")

; Remove iniciais A) b) etc..
Clipboard := RegExReplace(ClipBoard," *([A-Ea-e])\)","")

; remove espacos no comeco
; Find the position of the first non-whitespace character
position := RegExMatch(clipboard, "\S")
; Replace the same amount of space characters as the 'position' minus 1 starting from the beginning of each line.
clipboard := RegExReplace(clipboard, "m)^[ ]{" . position - 1 . "}")

; Remove espaços no fim e paragrafos
loop
   {
	  Clipboard := StrReplace(clipboard, " `r`n","`r`n", count)
        if (Count = 0)  ; No more replacements needed.
                break
   }
loop
   {
	  Clipboard := StrReplace(clipboard, "`r`n`r`n", "`r`n", count)
        if (Count = 0)  ; No more replacements needed.
                break
   }   
; Remove espaços duplicados no meio
clipboard := RegExReplace(clipboard, "\S\s\K\s+(?=\S)")
; cola
SendInput ^v

return
; -----------------------------------------------------------------------------
; Formata Enunciado
; -----------------------------------------------------------------------------
^+v:: ; Ctrl + Shift + V
; Trim para remover lixo
Clipboard := trim(clipboard,"`n`r`t ")
; Remove espaços duplicados no meio
clipboard := RegExReplace(clipboard, "\S\s\K\s+(?=\S)")

/*
   loop
   {
	  Clipboard := StrReplace(clipboard, " `r`n","`r`n", count)
	  Clipboard := StrReplace(clipboard, "`r`n`r`n", "`r`n", count)
        if (Count = 0)  ; No more replacements needed.
                break
   }
*/

loop
   {
	  StringReplace, clipboard, clipboard, %A_Space% `r`n, %A_Space%, ALL ;Deprecated
	  StringReplace, clipboard, clipboard, `r`n, %A_Space%, ALL  ;Deprecated
      if ErrorLevel <> 0
                break
   }
SendInput ^v

return
; -----------------------------------------------------------------------------
; Cola alternativas
; -----------------------------------------------------------------------------
F2:: ; F2

a = 1

Loop, 6
	{
	Send {Ctrl down}{Shift down}v{Ctrl up}{Shift up}
	Send {Ctrl down}{Home}{Ctrl up}
	Send {End}{Right}
	Send {Shift down}{PgDn down}{PgDn down}{Shift up}
	Send {Ctrl down}x{Ctrl up}
	
	if a >= 5
		break
		
	Send {BS}
	Loop, 12
		{
			Send {Tab}
			Sleep, 20
		}
		a++
		
	}
return

; -----------------------------------------------------------------------------
; remove TODOS espaços
; Clipboard := RegExMatch(Clipboard, "\s") ? RegExReplace(Clipboard, "\s") : SubStr(Clipboard, 2)


; Remove quebras de linha
/*;Deprecated
loop
   {
	  StringReplace, clipboard, clipboard, %A_Space% `r`n, %A_Space%, ALL ;Deprecated
	  StringReplace, clipboard, clipboard, `r`n, %A_Space%, ALL  ;Deprecated
      if ErrorLevel <> 0
                break
   }
*/
