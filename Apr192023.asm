; demonstrate a 2d array
; 1,2,3
; 4,5,6
; 7,8,9

INCLUDE Irvine32.inc
.data

arr	BYTE	1h, 2h, 3h
	BYTE	4h, 5h, 6h
	BYTE	7h, 8h, 9h

str1 BYTE	"Hello",0
str2 BYTE	"Hello",0

three =	3

.code
main PROC

; 2d array example
mov ah, arr[SIZEOF arr * 2 + TYPE arr * 1]

mov ebx, SIZEOF arr
mov ecx, LENGTHOF arr
mov edx, TYPE arr

; compare array example
	cld ; one direction, harry styles says -->
	mov esi, OFFSET str1 ; source
	mov edi, OFFSET str2 ; destination
	mov ecx, LENGTHOF str1

	repe cmpsb
	; if they are not equal, go to that part
	jne L_NOTEQUAL
	; -->they are equal
	mov eax, 1
	jmp L_BELOW
L_NOTEQUAL:
	; not equal part
	mov eax, -1
L_BELOW:

; linear search example
	mov edi, OFFSET str1 ; technically we didn't need this
	mov eax, 'l'
	mov ecx, LENGTHOF str1 ; technically repeating this too
	cld
	repne scasb
	je L_BELOW2
	mov eax, -1
	jmp L_END
L_BELOW2:
	dec edi ; ? why decrement?
	mov eax, edi
L_END:
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