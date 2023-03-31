; 

INCLUDE Irvine32.inc
.data


.code
main PROC
	;push 5 ; b
	;push 6 ; a
	;call myadd
	;call WriteInt

	;push 5
	;call myfact
	;call WriteInt

	call run_example
	call WriteInt

	exit
main ENDP

run_example proc
	; make stack frame
	push ebp
	mov ebp,esp

	sub esp, 12
	mov DWORD PTR [ebp-4], 75	; b
	mov DWORD PTR [ebp-8], 69	; c
	mov DWORD PTR [ebp-12], 2	; d

	mov eax, DWORD PTR [ebp-4]
	add eax, DWORD PTR [ebp-8]
	mov ebx, DWORD PTR [ebp-12]
	mul ebx
	
	mov esp, ebp
	pop ebp
	ret
run_example endp

myfact proc
	; stack frame
	push ebp
	mov ebp, esp

	mov eax, [ebp+8]; n
	cmp eax, 1
	ja L1
	mov eax, 1
	jmp L2

L1:
	; recursion
	dec eax
	push eax ; myfact(n-1)
	call myfact

L_AfterRecursion:
	mov ebx, [ebp+8]
	mul ebx ; eax = eax * ebx

L2:
	; stack frame and cleanup
	pop ebp
	ret 4
myfact endp

; add procedure
; adds a and b
; pre: a and b are on the stack
; post: eax contains a + b
myadd proc
	push ebp ; stack frames stuff
	mov ebp, esp
	;sub ebp, 8  ; <- come back to this on Friday
	; pop eax  ;; <- don't do this
	mov eax, [ebp + 8]
	add eax, [ebp + 12]

	;mov esp, esp ; clean up stack frame
	pop ebp
	ret 8
myadd endp


END main