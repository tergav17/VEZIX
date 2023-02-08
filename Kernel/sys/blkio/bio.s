; bio.s
; device block i/o

.text

; get block, if the appropriate block
; already exists, then return it.
; otherwise free a block and return it
; hl = dev
; bc = blkno
;
; uses: af', hl, ix, iy
getblk:
	call	svnhl
	ex	de,hl	; de = dev
	ld	a,c_nbuf
	ld	ix,buftab
	ld	iy,0	; iy = result
	ex	af,af'
	xor	a	; a' = age
0:
	; first we search for buffers
	; that already contain desired
	; information
	ld	(ix+buf_t.dev.high),h
	ld	(ix+buf_t.dev.low),l
	or	a
	sbc	hl,de
	jr	nz,2f
	ld	(ix+buf_t.blkno.high),h
	ld	(ix+buf_t.blkno.low),l
	or	a
	sbc	hl,bc
	jr	nz,2f
1:
	; found blk in use
	push	ix
	pop	iy
	jr	5f
2:
	; skip if busy
	bit	b_busy,(ix+buf_t.flag)
	jr	4f
	
	; skip if age is lower
	cp	(ix+buf_t.age)
	jr	z,3f
	jr	nc,4f
3:
	; set iy = ix
	push	ix
	pop	iy
4:
	; advance forward
	ex	af,af'
	dec 	a
	ex	af,af'
	jr	nz,0b
5:
	; search complete
	

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
	
	; release block
	call	brelse
	
	; increment pointers
	ld	de,$buf_t
	add	ix,de
	ld	de,512
	add	hl,de
	
	dec	c
	ret	z
	jr	0b



; releases a block. sets flag to not
; busy
; ix = pointer to buf header
;
; uses: af
brelse:
	; reset the busy flag
	res	b_busy,(ix+buf_t.flag),a
	ld	(ix+buf_t.flag),a
	ret
	

.bss

; definition of actual buffers
.defl byte[512 * c_nbuf] m_buf

; definition of buffer headers
; for now, these will point to the
; buffers in kernel memory, but this
; could in theory be changed
.defl buf_t[c_nbuf] buftab