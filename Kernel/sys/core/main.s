; main.s
; kernel entry and setup
;
; sets up hardware and crafts proc 0

.text
.globl main
main:
	; place stack in kstack
	di
	ld	sp,u+$u_t
	
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
	
	; attempt to load init into core
	; start with namei
	ld	hl,str_init
	ld	(u+u_t.dirp),hl
	ld	hl,schar
	call	namei
	
	; check for errors
	ld	a,(u+u_t.error)
	or	a
	jp	nz,panic
	
	; exec /etc/init
	ld	hl,c_ubase
	ld	de,0
	ld	(u+u_t.args + 2),hl
	call	suword
	call	pexec
	
	; go to user space
	; jp	uret
	
	;ld	hl,0
	;ld	bc,0
	;call	bread
	
	;ld	h,(ix+buf_t.addr.high)
	;ld	l,(ix+buf_t.addr.low)
	;inc	(hl)
	
	;call	bwrite
	;call	brelse
	
	;ld	hl,0
	;ld	bc,0
	;call	bread
	
	;ld	h,(ix+buf_t.addr.high)
	;ld	l,(ix+buf_t.addr.low)
	;ld	bc,512
	;call	kdump
	
	; attempt to load init into core
	;ld	hl,str_init
	;ld	(u+u_t.dirp),hl
	;ld	hl,schar
	;call	namei
	
	;ld	d,ixh
	;ld	e,ixl
	;ex	de,hl
	;ld	bc,$cino_t
	;call	kdump
	
	;ld	hl,0
	;call	bmap
	
	;ld	b,h
	;ld	c,l
	;ld	hl,c_rootd
	;call	bread

	;ld	h,(ix+buf_t.addr.high)
	;ld	l,(ix+buf_t.addr.low)
	;call	kputs
	
	
	
haltloop:jp	haltloop
	

.bss

; User structure
; contains stack and per-process
; state information
.globl u
.defl u_t u 0
	
.data
.defl byte str_vez	"vezix boot"
.defl byte str_crlf	"\n\r\0"
.defl byte str_mem	"mem = \0"
.defl byte str_init	"/etc/init\0"


	