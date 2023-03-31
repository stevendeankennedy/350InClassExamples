; In class example 2/27/23
; by Steve and friends and also Ricky

COMMENT ! 
This is now 
a block
comment forever
until I finish with
!

INCLUDE Irvine32.inc

.data
;arrayD     DWORD 1000h,2000h,3000h
;myWord		WORD 65535
okay	BYTE "Valid!",0
;notokay	BYTE "Invalid binary",0

.code
main PROC
StateA:
	; read INT
	call ReadDec

	cmp eax, 1
	je StateB
	cmp eax, 0
	je StateB
	jmp StateA ; probably should have a D for errors
StateB:
	; read INT
	call ReadDec
	cmp eax, 1
	je StateB
	cmp eax, 0
	je StateB
	cmp eax, 'b'
	je StateC
	jmp StateA
StateC:
	; print out the VALID message
	mov edx, OFFSET okay
	call WriteString


	;mov eax, 9
	;call someProc
	;call aRecusiveProc

	;call someLogicProc
	;mov eax, 0
	;mov al, 'a'
	;call capitalize
	
	;call ifExample


	mov ecx, 4
	call recursion2

	exit
main ENDP

; precondition: ecx = n
recursion2 PROC
	; base case
	;	if (n == 0) just ret
	cmp ecx, 0
	jne L_Recursion
L_Base:
	ret

L_Recursion:
	; recursive case
	;  otherwise, call recursion2 with ecx -1
	dec ecx
	call recursion2

	ret
recursion2 ENDP

ifExample PROC
	mov eax, 6
	mov ebx, 4

	cmp eax, ebx
	jz L_Smaller
L_Larger:
	mov eax, 0FFFFFFFFh
	jmp L_After
L_Smaller:
	mov eax, 0

L_After:

	ret
ifExample ENDP


capitalize PROC
	and al, 11011111b
	
	call writeChar

	ret
capitalize ENDP

someLogicProc PROC
	mov eax, 0ffffh
	mov ebx, 0eabch

	xor	eax, ebx

	not eax

	ret
someLogicproc ENDP

aRecusiveProc PROC
	call aRecusiveProc
	ret
aRecusiveProc ENDP

someProc PROC
	push eax

	mov eax, 11
	call someOther

	pop eax
	ret
someProc ENDP

someOther PROC
	push ebx
	push eax
	
	mov eax, 1
	mov ebx, 1
	
	pop eax
	pop ebx
	ret
someOther ENDP

END main