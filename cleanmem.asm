	processor 6502
	
	seg code
	org $F000		; Define the code origin at $F000.  This is the start for an Atari cartride.
	
START:
	sei				; Disable interrupts
	cld				; Clear the BCD decimal math mode
	ldx #$FF		; Loads the X register with #$FF
	txs				; Transfer the X register to the (S)tack pointer

; Clear the Page Zero region ($00 to $FF)
; Meaning the entire RAM and also TIA registers
	
	lda #0			; A = 0
	ldx #$FF		; X = #$FF
	
MEMLOOP:
	sta	$0,x		; Store the value of A inside memory address $0 + X
	dex				; X-- , decrement X by 1
	bne	MEMLOOP		; Loop until X = 0( z-flag is set )

; Fill the ROM size to exactly 4KB and 'close'.  Cartridge needs this to start.o
	org $FFFC
	.word START		; Reset vector at $FFFC where the program starts
	.word START		; Interrupt vector at $FFFE (unused in the VSC)
	
