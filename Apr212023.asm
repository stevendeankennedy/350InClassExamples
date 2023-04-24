;; Bubble sort example

INCLUDE Irvine32.inc
.data

	;list DWORD 5, 1, 6, 4, 3, 7
	list DWORD 1, 2, 3, 4, 5, 7

.code
main PROC

	; call the bubba proc
	;call bubba
	call bogo
	exit
main ENDP

; BOGO sort procedure
; Pre: Have a list
; Post: List is sorted
; 1) randomize
; 2) repeat, unless it is sorted
bogo PROC
	
	mov ecx, LENGTHOF list
;L_AfterSortCheck:

	;; while list is unsorted, loop
L_Top:
	; 1) randomize
	call randomize
	mov eax, LENGTHOF list ; first index
	call randomRange
	mov esi, eax ; first index in esi
	mov eax, LENGTHOF list
	call randomRange
	mov edi, eax; second index
	mov eax, list[esi]
	mov ebx, list[edi]
	xchg esi, edi
	mov list[esi], eax
	mov list[edi], ebx
	loop L_Top
	mov ecx, LENGTHOF list
	
	mov esi, 0
L_Inner: ; 2) check to see if it is sorted
	mov eax, list[esi * TYPE list]
	inc esi
	mov ebx, list[esi * TYPE list]
	cmp eax, ebx
	; if not sorted, we are done
	jnb L_Top
	; otherwise, keep going, through the end of the list
	loop L_Inner
	; need a way out
	jmp L_END
;	jmp L_Top
	
L_END:
	; it is sorted!
	ret
bogo ENDP

; Bubble sort procedure
bubba PROC

	mov ecx, LENGTHOF list
	dec ecx 	; There are actually n-1 bubbles
	
	;; make your two loops
L1:
	mov esi, OFFSET list
	
	push ecx 	; we have to manage two counters some how
	mov ecx, LENGTHOF list
	dec ecx 	; it is too long, so subtract 1

	L2: ; bubbles	
		mov eax, [esi]	; something in array
		mov ebx, [esi + TYPE list]
		cmp eax, ebx ; compare first and second bubble elements
		ja L_GT
		jmp L_ELSE
		L_GT: 		; swap
			mov ebx, [esi + TYPE list] ; TODO: upgrade this line
			mov [esi + TYPE list], eax
			mov [esi], ebx
		L_ELSE: 	; essentially, don't do anything.  (don't change bubble)
			add esi, TYPE list
		
		loop L2
		pop ecx 	; get our counter back
		loop L1


		; just prints it out
		mov ecx, LENGTHOF list
		mov esi, 0
		L3: 
			mov eax, list[esi]
			call writeint
			add esi, TYPE list
			loop L3
			
	ret
bubba ENDP

; start two loops


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