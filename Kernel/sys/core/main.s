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
	ld	hl,str_mem
	call	kputs
	xor	a
	ld	hl,c_utop
	ld	de,c_ubase
	sbc	hl,de
	call	kputd
	ld	hl,str_crlf
	call	kputs
	
	; init subsystems
	call	binit	; buf init
	call	dinit	; device init
	call	iinit	; mount root
	
	halt
	
	
.data
.defl byte str_vez	"vezix boot"
.defl byte str_crlf	"\n\r\0"
.defl byte str_mem	"mem = \0"

	