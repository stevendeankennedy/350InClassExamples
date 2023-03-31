; A program example
; by me

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
; data`

.code
main proc
	; code
	Invoke ExitProcess,0
main endp
end main