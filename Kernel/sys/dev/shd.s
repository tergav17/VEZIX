; shd.s
; simh hard disk driver

.extern ixnext, ixlink, ixunlink

; command block for simh hdsk
.type simhd_t {
	byte	cmd,
	byte	hd,
	byte	sector,
	word_t	track,
	word_t	dma
}

; device commands
h_reset	=	1
h_read	=	2
h_write	=	3
h_param	=	4

; device port
h_port	=	0xfd

.text

; simh hd init routine
.globl shdinit
shdinit:
	ld	b,32
	ld	a,h_reset
0:
	out	(h_port),a
	dec	b
	jr	nz,0b
	ret

; simh hd strategy call
; used to link in a new buffer
; for the driver to fullfil
; ix = buffer to attach
;
; uses: all
.globl shdstrat
shdstrat:
	; reset transferred sector counter
	xor	a
	ld	(ix+buf_t.scount),a

	; attach buf to devtab
	ld	hl,shdtab.io_head
	call	ixlink
	
	; start if not active
	ld	a,(shdtab.active)
	or	a
	jr	z,shdstart
	ret
	
	
	
; simh activity start
; this just blocks for now, will change
; when interrupts get added
;
; uses: all
shdstart:
	; return if nothing to do
	ld	ix,shdtab.io_head
	call	ixnext
	ret	z
	
	; set activity flag
	ld	a,1
	ld	(shdtab.active),a
	
	; do stuff here
	
	; set parameters
	ld	a,h_read
	bit	b_read,(ix+buf_t.flag)
	jr	nz,0f
	ld	a,h_write
0:
	ld	(parblk.cmd),a
	ld	a,(ix+buf_t.dev.low)
	ld	(parblk.hd),a

	; calculate sector
	ld	a,(ix+buf_t.blkno.low)
	and	0x07
	rlca
	rlca
	or	(ix+buf_t.scount)
	ld	(parblk.sector),a
	
	; calculate track
	ld	(ix+buf_t.blkno.high),h
	ld	(ix+buf_t.blkno.low),l
	ld	a,l
	srl	h
	rra
	srl	h
	rra
	srl	h
	rra
	ld	l,a
	ld	(parblk.track),hl
	
	; set dma location
	ld	(ix+buf_t.addr.high),h
	ld	(ix+buf_t.addr.low),l
	ld	a,(ix+buf_t.scount)
	or	a
0:
	jr	z,1f
	ld	de,128
	add	hl,de
	jr	0b
1:
	ld	(parblk.dma),hl
	
	; execute command
	ld	b,$simhd_t
	ld	hl,parblk
0:
	ld	a,(hl)
	out	(h_port),a
	inc	hl
	dec	b
	jr	nz,0b
	in	a,(h_port)
	; todo: set error bits
	
	; increment scount
	ld	a,4
	inc	(ix+buf_t.scount)
	cp	(ix+buf_t.scount)
	jr	nz,shdstart
	
	; end of stuff
9:
	
	; reset activity flag
	xor	a
	ld	(shdtab.active),a
	
	; unlink block from device
	ld	hl,shdtab.io_head
	call	ixunlink
	
	; todo: call iodone

	; continue if there is another block to grab
	jr	nz,shdstart

	ret

.bss

.globl shdtab
.defl devtab_t shdtab	0

.defl simhd_t parblk	0