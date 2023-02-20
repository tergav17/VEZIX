; iget.s
; manages inodes in core and disk

.text

; look up and inode depending on device
; and inumber. inode may be in core or
; on the physical disk
; hl = dev
; bc = i number
;
; ix = pointer to inode
; saved: af, bc, de
.globl iget
iget:
	call	svnhl
	ex	de,hl
	ld	ix,inode
	ld	a,c_nino
	ld	iy,0
	; look for the inode
0:
	; check if dev / number match
	ld	h,(ix+cino_t.dev.high)
	ld	l,(ix+cino_t.dev.low)
	or	a
	sbc	hl,de
	jr	nz,1f
	ld	h,(ix+cino_t.num.high)
	ld	l,(ix+cino_t.num.low)
	or	a
	sbc	hl,bc
	jr	nz,1f
	; todo check mount and ret
	ret
	
1:
	; see if the inode is empty
	ex	af,af'
	xor	a
	cp	(ix+cino_t.count)
	jr	nz,2f
	push	ix
	pop	iy
2:
	ex	af,af'
	ld	hl,$cino_t
	ex	de,hl
	add	ix,de
	ex	de,hl
	dec	a
	jr	nz,0b
	
	; couldn't find the inode
	; hopefully there is an empty
	; on at least
	cp	iyh
	jr	nz,3f
	cp	iyl
	jr	nz,3f
	; no empty inode!
	; todo return error
	ret
	
3:
	; set dev and ino, inc count
	ld	(iy+cino_t.dev.high),d
	ld	(iy+cino_t.dev.low),e
	ld	(iy+cino_t.num.high),b
	ld	(iy+cino_t.num.low),c
	inc	(iy+cino_t.count)
	
	; ok, lets read the inode in
	; first, calculate block #
	ld	h,b
	ld	l,c
	ld	a,l
	srl	h
	rra
	srl	h
	rra
	srl	h
	rra
	ld	l,a
	inc	hl
	inc	hl
	; bc = ino, de = dev, hl = blkno
	push	bc
	ld	b,h
	ld	c,l
	pop	hl
	ex	de,hl
	; bc = blkno, de = ino, hl = dev
	push	iy
	call	bread
	pop	iy
	
	; todo check for errors
	
	; copy into core
	ld	h,64
	ld	a,0x7
	and	e
	ld	e,a
	call	mulhe
	ld	d,(ix+buf_t.addr.high)
	ld	e,(ix+buf_t.addr.low)
	add	hl,de
	ld	d,iyh
	ld	e,iyl
	ld	bc,64
	ldir
	
	; release, set ix=iy, and ret
	call	brelse
	push	iy
	pop	ix
	ret