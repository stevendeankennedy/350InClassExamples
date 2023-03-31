; Program template

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	; declare variables here
	myByte BYTE 10h
	myByte2 BYTE 0FFh

	myWord WORD +1111h
	myStr BYTE "AB"

	myDword DWORD 12345678h

.code
main proc
	; write your code here
	inc myByte
	inc myByte2

	mov ax, myWord
	neg ax

	mov ah, myStr
	mov al, myStr+1
	neg ax

	; second example
	mov ax, WORD PTR myDword

	invoke ExitProcess,0
main endp
end main