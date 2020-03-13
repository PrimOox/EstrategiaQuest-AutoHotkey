#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
/*
This is a trash 
multiline 
comment 
*/
; -----------------------------------------------------------------------------
; Formata Enunciado
; -----------------------------------------------------------------------------
^+v:: ; Ctrl + Shift + V
; Trim para remover lixo
Clipboard := trim(clipboard,"`n`r`t ")
; Remove espaços duplicados no meio / quebra de linha
;clipboard := RegExReplace(clipboard, "\S\s\K\s+(?=\S)")
; Remove espaços duplicados
clipboard := RegExReplace(clipboard, " +", " ")


; Remove break lines 
loop
   {
	  Clipboard := StrReplace(clipboard, "`r`n"," ", count)
        if (Count = 0)  ; No more replacements needed.
                break
   }   
     
SendInput ^v

return
;-----------------------------------------------------------------------------------
; Formata alternativas
; ----------------------------------------------------------------------------------
Formata_alternativas:

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
loop
   {
	  Clipboard := StrReplace(clipboard, "`r`n ", "`r`n", count)
        if (Count = 0)  ; No more replacements needed.
                break
   }
       
; Remove espaços duplicados no meio / quebra de linha
;clipboard := RegExReplace(clipboard, "\S\s\K\s+(?=\S)")

trim(clipboard)

; remove espacos no comeco
; Find the position of the first non-whitespace character
position := RegExMatch(clipboard, "\S")
; Replace the same amount of space characters as the 'position' minus 1 starting from the beginning of each line.
clipboard := RegExReplace(clipboard, "m)^[ ]{" . position - 1 . "}")


; cola
SendInput ^v

return
; -----------------------------------------------------------------------------
; Cola alternativas
; -----------------------------------------------------------------------------
; Apertar F2 na (A) com todas abertas em branco
#IfWinActive ahk_exe chrome.exe
F2:: ; F2

a = 1
gosub Formata_alternativas
Send {Ctrl down}ax{Ctrl up}

Loop, 6
	{
	SendInput ^v
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
