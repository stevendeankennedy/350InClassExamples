;; Last week examples

INCLUDE Irvine32.inc

mPrintLn MACRO myStr	
	push edx
	mov edx, OFFSET myStr
	call WriteString
	call Crlf
	pop edx
ENDM

mOption MACRO theNum
	cmp eax, theNum
	echo theNum
	je LOPT_&theNum
ENDM

.data

;; have some menu, for various logical ops
;; x AND y, x OR y, NOT x, x XOR y, exit

	menu1 BYTE "Select from the following:",0
	menu2 BYTE "1: x AND y, 2: x OR y, 3: NOT x, 4: x XOR y, 5: exit",0
	prompt BYTE "Select 1-5",0
	prompt2 BYTE ">",0
	errMsg BYTE "Invalid Input",0
	tstMsg BYTE "TEST",0
	
	someNums DWORD 15h, 14h, 3h, 2h, 1h, 7h, 8h, 1h

.code
main PROC
	
	;call runLogic
	call runLargest
	exit
main ENDP

runLargest PROC
	push ebp
	mov ebp, esp
	sub esp, 4 ; largestSoFar
	
	;mov DWORD PTR [esp-4], 0 ; init local var
	
	; go one by one, putting elements into eax, jumping if they are not larger...
	mov ecx, LENGTHOF someNums - 1
	mov eax, someNums[ecx * TYPE someNums]

L_Loop:
	cmp eax, someNums[ecx * TYPE someNums]
	jge L_Step2
	mov eax, someNums[ecx * TYPE someNums]
	
L_Step2:
	loop L_Loop
	
	cmp eax, someNums[ecx * TYPE someNums]
	jge L_Step3
	mov eax, someNums[ecx * TYPE someNums]

L_Step3:

	;mov .., [esp-4] ; largestSoFar
	
	mov esp, ebp
	pop ebp
	ret
runLargest ENDP

; display the prompt, we'll use the macro for this
; display menu
; get input
; do operations
runLogic PROC

	; Reminder: this is alloc for x and y.  It needs to be deallocated.
	; 	C-style dealloc would then remove this memory after the call	
L_MainLoop:
	mPrintLn prompt
	
	; get a number selection from user
	call ReadInt
	cmp eax, 1
	jae L_VALID
	mPrintLn errMsg
	jmp L_MainLoop
L_VALID:
	; TODO: more options
	mov edx, eax
	mPrintln prompt2
	call ReadHex ; puts input in eax
	push eax ; Y
	mPrintln prompt2
	call ReadHex
	push eax ; X
	mov eax, edx

	mOption 1
	mOption 2
	mOption 3
	mOption 4
	mOption 5
LOPT_1:
	call runAND
	jmp L_MainLoop
LOPT_2:
	call runOR
	jmp L_MainLoop
LOPT_3:
	call runNOT
	jmp L_MainLoop
LOPT_4:
	call runXOR
	jmp L_MainLoop
LOPT_5:
	; nothing... all done
LALLDONE:
	ret
runLogic ENDP

; do x AND y
; pre: x and y are pushed (in that order)
; post: eax contains result: x AND y
runAND PROC
	push ebp
	mov ebp, esp
	
	mov eax, DWORD PTR [esp+8]  ; X
	mov ebx, DWORD PTR [esp+12] ; Y
	
	and eax, ebx
	
	mov esp, ebp
	pop ebp
	ret 8 ; dealloc x and y off of the stack (reminder, this is STDCALL mode)
runAND ENDP

; do x OR y
; pre: x and y are pushed (in that order)
; post: eax contains result: x OR y
runOR PROC
	push ebp
	mov ebp, esp
	
	mov eax, DWORD PTR [esp+8]  ; X
	mov ebx, DWORD PTR [esp+12] ; Y
	
	or eax, ebx
	
	mov esp, ebp
	pop ebp
	ret 8 ; dealloc x and y off of the stack (reminder, this is STDCALL mode)
runOR ENDP

; TODO: Actually properly debug this.
; do NOT y
; pre: x and y are pushed (in that order)
; post: eax contains result: x OR y
runNOT PROC
	push ebp
	mov ebp, esp
	
	mov eax, DWORD PTR [esp+8]  ; X
	mov ebx, DWORD PTR [esp+12] ; Y
	
	not eax
	
	mov esp, ebp
	pop ebp
	ret 8 ; dealloc x and y off of the stack (reminder, this is STDCALL mode)
runNOT ENDP

; do x OR y
; pre: x and y are pushed (in that order)
; post: eax contains result: x OR y
runXOR PROC
	push ebp
	mov ebp, esp
	
	mov eax, DWORD PTR [esp+8]  ; X
	mov ebx, DWORD PTR [esp+12] ; Y
	
	xor eax, ebx
	
	mov esp, ebp
	pop ebp
	ret 8 ; dealloc x and y off of the stack (reminder, this is STDCALL mode)
runXOR ENDP

END main