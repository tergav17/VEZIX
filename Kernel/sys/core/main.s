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
	call	binit
	call	dinit
	
	ld	hl,str_flag
	call	kputs
	
	; read a block
	ld	hl,0x0000 ; dev 0,0
	ld	bc,0x0002 ; block #2
	call	bread
	call	brelse
	
	ld	hl,0x0000
	ld	bc,0x0002
	call	getblk
	
	ld	h,0
	ld	l,(ix+buf_t.serial)
	call	kputd
	
	halt
	
	
.data
.defl byte str_vez	"vezix boot"
.defl byte str_crlf	"\n\r\0"
.defl byte str_mem	"mem = \0"
.defl byte str_flag	"flag\n\r\0"

	