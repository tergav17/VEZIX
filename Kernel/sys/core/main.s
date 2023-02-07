; main.s
; kernel entry and setup
;
; sets up hardware and crafts proc 0

.text
.globl main
main:
	; place stack in uspace top
	ld	sp,c_utop
	
	; clear kernel memory
	xor	a
	ld	hl,b_top
	ld	de,b_base
	push	de
	sbc	hl,de
	dec	hl
	ld	b,h
	ld	c,l
	pop	hl
	inc	de
	ld	(hl),a
	ldir
	
	; init kernel debugging
	call	kinit
	ld	hl,str_vez
	call	kputs
	
	; init subsystems
	call	 binit
	
	halt
	
	
.data
.defl byte str_vez	"vezix boot\n\r\0"
	