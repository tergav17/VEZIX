; bio.s
; device block i/o

.text

; get block, if the appropriate block
; already exists, then return it.
; otherwise free a block and return it
;
; uses: hl; iy
getblk:
	call	svnhl
	ret

; buffer init
;
; uses: af, bc, de, hl, ix
.globl binit
binit:
	ld	c,c_nbuf
	ld	hl,m_buf
	ld	ix,buftab
	xor	a
0:
	; reset flag byte
	ld	(ix+buf_t.flag),a
	
	; set address of block
	ld	(ix+buf_t.addr.high),h
	ld	(ix+buf_t.addr.low),l
	
	ld	de,$buf_t
	add	ix,de
	ld	de,512
	add	hl,de
	
	dec	c
	ret	z
	jr	0b

.bss

; definition of actual buffers
.defl byte[512 * c_nbuf] m_buf

; definition of buffer headers
; for now, these will point to the
; buffers in kernel memory, but this
; could in theory be changed
.defl buf_t[c_nbuf] buftab