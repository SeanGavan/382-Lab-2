;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Name: Sean Gavan
; Section: T5A
; Project: Lab 1 for ECE 382 - message decryption using XOR
; Date started: 16 Sept. 14
; Date last changed: 22 Sept. 14
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
;-------------------------------------------------------------------------------
			.text
myMessage:		.byte	0xef,0xc3,0xc2,0xcb,0xde,0xcd,0xd8,0xd9,0xc0,0xcd,0xd8,0xc5,0xc3,0xc2,0xdf,0x8d,0x8c,
			.byte	0x8c,0xf5,0xc3,0xd9,0x8c,0xc8,0xc9,0xcf,0xde,0xd5,0xdc,0xd8,0xc9,0xc8,0x8c,0xd8,0xc4,
			.byte	0xc9,0x8c,0xe9,0xef,0xe9,0x9f,0x94,0x9e,0x8c,0xc4,0xc5,0xc8,0xc8,0xc9,0xc2,0x8c,0xc1,
			.byte	0xc9,0xdf,0xdf,0xcd,0xcb,0xc9,0x8c,0xcd,0xc2,0xc8,0x8c,0xcd,0xcf,0xc4,0xc5,0xc9,0xda,
			.byte	0xc9,0xc8,0x8c,0xde,0xc9,0xdd,0xd9,0xc5,0xde,0xc9,0xc8,0x8c,0xca,0xd9,0xc2,0xcf,0xd8,
			.byte	0xc5,0xc3,0xc2,0xcd,0xc0,0xc5,0xd8,0xd5,0x8f
myZero:		.byte	0x00			; end of message trigger
myKey:		.byte	0xac			; key into ROM

			.data
myResult:  .space	94

RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------

	    mov.w	#myResult, r6		;
	    mov.w	#myKey, r9		;
	    mov.b	@r9+, r10		; 
            mov.w	#myMessage, r8		; load registers with necessary info for decryptMessage here
            mov.b	@r8+, r7		;

subs:
	    call	#decryptCharacter
            call    	#decryptMessage
	    cmp.b	#0x00, r7			; check for end of message
	    jeq		forever				
	    jmp		subs

forever:    jmp         forever

;-------------------------------------------------------------------------------
                                         	; Subroutines
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
;Subroutine Name: decryptMessage
;Author: Sean Gavan
;Function: Decrypts a string of bytes and stores the result in memory.  Accepts
;           the address of the encrypted message, address of the key, and address
;           of the decrypted message (pass-by-reference).  Accepts the length of
;           the message by value.  Uses the decryptCharacter subroutine to decrypt
;           each byte of the message.  Stores the results to the decrypted message
;           location.
;Inputs: r6 for the RAM pointer, r7 for the decrypted message, r8 for the next part
;		of the message
;Outputs: decrypted message in RAM, pointers moved, next location marked
;Registers destroyed: r5, r6, r7, r8
;-------------------------------------------------------------------------------

decryptMessage:
			mov.b	r7, 0(r6)
			inc.w	r6
			mov.b	@r8+, r7

            ret

;-------------------------------------------------------------------------------
;Subroutine Name: decryptCharacter
;Author: Sean Gavan
;Function: Decrypts a byte of data by XORing it with a key byte.  Returns the
;           decrypted byte in the same register the encrypted byte was passed in.
;           Expects both the encrypted data and key to be passed by value.
;Inputs: r7 for the character to be decrypted, r9 for the key to be XOR'd
;Outputs: decrypted character into r7
;Registers destroyed: r7
;-------------------------------------------------------------------------------

decryptCharacter:
			xor.w	r10, r7

            ret

;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect    .stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
