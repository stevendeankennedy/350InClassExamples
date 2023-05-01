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
	je LOPT&theNum
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

.code
main PROC
	
	call runLogic
	exit
main ENDP

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
	mPrintln prompt2
	call ReadHex ; puts input in eax
	push eax ; Y
	mPrintln prompt2
	call ReadHex
	push eax ; X

	mOption 1
;	mOption 2
;	mOption 3
;	mOption 4
LOPT1:
	call runAND

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

END main