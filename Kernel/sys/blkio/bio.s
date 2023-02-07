; bio.s
; device block i/o

.text

; buffer init
;
; uses: all
.globl binit
binit:
	ld	c,c_nbuf
	ld	hl,m_buf
	ld	ix,buftab
	xor	a
0:
	ld	(ix+buf_t.flag),a	; reset flag
	ld	(ix+buf_t.addr.high),h	; set buffer address
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