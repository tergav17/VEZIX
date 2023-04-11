; subr.s
; intermediate level
; subroutines

.text

; maps a logical inode block to a disk
; block
; hl = inode blkno
; ix = inode
; 
; bc = disk blkno
; ix = inode
; uses: iy
.globl bmap
bmap:
	call	svnhl
	
	; check to see if block is
	; directly mapped
	xor	a
	cp	h
	jr	nz,9f
	ld	a,l
	cp	18
	jr	nc,9f
	
	; get the directly mapped block
	sla	l
	ld	de,cino_t.node.addr
	add	hl,de
	ld	d,ixh
	ld	e,ixl
	add	hl,de
	
	; bc=(hl)
	ld	b,(hl)
	inc	hl
	ld	c,(hl)
	
	; return if not zero
	ld	a,b
	or	c
	ret	nz
	
	; todo allocate block
	ret
	
9:
	; indirect block
	ret