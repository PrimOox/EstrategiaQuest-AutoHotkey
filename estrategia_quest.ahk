#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; #IfWinActive ahk_exe chrome.exe
/*
CopyLeft @diego.oap
diego_oliveira_alves@hotmail.com
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
 
   loop
   {
	  Clipboard := StrReplace(clipboard, " `r`n","`r`n", count)
	  Clipboard := StrReplace(clipboard, "`r`n`r`n", "`r`n", count)
        if (Count = 0)  ; No more replacements needed.
                break
   }

SendInput ^v

return
