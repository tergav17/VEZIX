; bio.s
; device block i/o

.text

; get block, if the appropriate block
; already exists, then return it.
; otherwise free a block and return it
; hl = dev
; de = blkno
;
; uses: hl, ix, iy
getblk:
	call	svnhl
	ld	b,0
	ld	c,c_nbuf
	ld	ix,buftab
0:
	; we are looking for the oldest
	; non-busy buf; or a match with
	; dev and blkno
	bit	b_busy,(ix+buf_t.flag)
;	jr	nz,
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



; releases a block, sets flag to not
; busy
; ix = pointer to buf header
;
; uses: af
brelse:
	res	b_busy,(ix+buf_t.flag),a
	ld	(ix+buf_t.flag),a
	ret
	

.bss

; free list
.defl word_t fr_head
.defl word_t fr_tail


; definition of actual buffers
.defl byte[512 * c_nbuf] m_buf

; definition of buffer headers
; for now, these will point to the
; buffers in kernel memory, but this
; could in theory be changed
.defl buf_t[c_nbuf] buftab