; MakeFunction sets up everything you need to make an assembly function 
; callable from C and debuggable with a symbolic debugger. It does the following:
; - export the function's transition vector
; - export the function name
; - create a toc entry for the function's transition vector
; - create the transition vector, which must contain
;     - the function entry point (the name of the function)
;     - the TOC anchor (the predefined variable TOC[tc0])
; - tell PPCAsm to create a function entry point symbol for symbolic debuggers
; - create a csect for the function (one csect per function lets the
;	linker do dead code stripping, resulting in smaller executables)
	
	MACRO
	MakeFunction &fnName
		EXPORT &fnName[DS]
 		EXPORT .&fnName[PR]
		
		TC &fnName[TC], &fnName[DS]
			
		CSECT &fnName[DS]
			DC.L .&fnName[PR]
 			DC.L TOC[tc0]
		
		CSECT .&fnName[PR]
		FUNCTION .&fnName[PR]	
		
	ENDM
	
linkageArea:		set 24	; constant comes from the PowerPC Runtime Architecture Document
CalleesParams:		set	32	; always leave space for GPR's 3-10
CalleesLocalVars:	set 0	; ClickHandler doesn't have any
numGPRs:			set 0	; num volitile GPR's (GPR's 13-31) used by ClickHandler
numFPRs:			set 0	; num volitile FPR's (FPR's 14-31) used by ClickHandler

spaceToSave:	set linkageArea + CalleesParams + CalleesLocalVars + 4*numGPRs + 8*numFPRs  

	; declare the C function DisplayAlert as external
	import .DisplayAlert
	
	import gHelloString		; global variable from C program
	import gGoodbyeString	; global variable from C program

	toc
		tc gHelloString[TC], gHelloString
		tc gGoodbyeString[TC], gGoodbyeString
	

; Call the MakeFunction macro, defined in MakeFunction.s to begin the function
	MakeFunction	ClickHandler		
	
; PROLOGUE - called routine's responsibilities
		mflr	r0					; Get link register
		stw		r0, 0x0008(SP)		; Store the link resgister on the stack
		stwu	SP, -spaceToSave(SP); skip over the stack space where the caller		
									; might have saved stuff
		
; FUNCTION BODY
		extsh	r3,r3
		li      r9,0
		cmpwi	r3,1
		bne		else_if
		lwz		r4,gHelloString[TC](RTOC)
		lwz     r9,0x0000(r4)
		b		end_of_if
else_if:
		cmpwi	cr1,r3,2
		bne		cr1,end_of_if
		lwz		r5,gGoodbyeString[TC](RTOC)
		lwz     r9,0x0000(r5)
end_of_if:
	
		ori     r3,r9,0x0000
		
		; Now call DisplayAlert.  The parameter is in register 3
		; No need to save any registers since we don't use them after this call.

		bl		.DisplayAlert
		nop						; this may be fixed up by the linker

; EPILOGUE - return sequence		
		lwz		r0,0x8+spaceToSave(SP)	; Get the saved link register
		addic	SP,SP,spaceToSave		; Reset the stack pointer
		mtlr	r0						; Reset the link register
		blr								; return via the link register
	
	csect .ClickHandler[pr]
		dc.b 'AsmSample Example - end of assembly code'















	