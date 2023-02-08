; bio.s
; device block i/o

.text

; get block, if the appropriate block
; already exists, then return it.
; otherwise free a block and return it
; hl = dev
; bc = blkno
;
; uses: hl, ix, iy
getblk:
	call	svnhl
	ex	de,hl	; de = dev
	ld	a,c_nbuf
	ld	ix,buftab
0:
	; first we search for buffers
	; that already contain desired
	; information
	ld	(ix+buf_t.dev.high),h
	ld	(ix+buf_t.dev.low),l
	or	a
	sbc	hl,de
	jr	nz,1f
	ld	(ix+buf_t.blkno.high),h
	ld	(ix+buf_t.blkno.low),l
	or	a
	sbc	hl,bc
	jr	nz,1f
	; found blocks
1:
	dec 	a
	jr	nz,0b
	; alight, just grab one off the
	; free list

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
; busy and add to free list
; ix = pointer to buf header
;
; uses: af
brelse:
	; reset the busy flag
	res	b_busy,(ix+buf_t.flag),a
	ld	(ix+buf_t.flag),a
	
	; add the free list
	push	hl
	push	ix
	pop	hl
	ld	ix,fr_head
	call	ixnext
	jr	z,0f
	
	; set as tail?
	ld	ix,fr_tail
	ld	(ix+buf_t.next.high),h
	ld	(ix+buf_t.next.low),l
	jr	1f
0:
	; empty, set head as block
	ld	(fr_head),hl
1:
	; set tail and return
	ld	(fr_tail),hl
	pop	hl
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