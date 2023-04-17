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
0:
	ld	ix,inode
	ld	a,c_nino
	ld	iy,0
	; look for the inode
1:
	; check if dev / number match
	ld	h,(ix+cino_t.dev.high)
	ld	l,(ix+cino_t.dev.low)
	or	a
	sbc	hl,de
	jr	nz,2f
	ld	h,(ix+cino_t.num.high)
	ld	l,(ix+cino_t.num.low)
	or	a
	sbc	hl,bc
	jr	nz,2f
	
	; inode mounted?
	bit	i_mnt,(ix+cino_t.flag)
	ret	z
	
	; check mount or panic
	ld	iy,mount
	ld	c,$c_nmnt
8:
	ld	a,(iy+mount_t.ino.high)
	cp	ixh
	jr	nz,9f
	ld	a,(iy+mount_t.ino.low)
	cp	ixl
	jr	nz,9f
	
	; ok, redirect to mounted inode
	ld	bc,rootino
	ld	d,iyh
	ld	e,iyl
	jr	0b
9:
	ld	de,$mount_t
	add	iy,de
	dec	c
	jr	nz,8b
	call	panic
	
2:
	; see if the inode is empty
	ex	af,af'
	xor	a
	cp	(ix+cino_t.count)
	jr	nz,3f
	push	ix
	pop	iy
3:
	ex	af,af'
	ld	hl,$cino_t
	ex	de,hl
	add	ix,de
	ex	de,hl
	dec	a
	jr	nz,1b
	
	; couldn't find the inode
	; hopefully there is an empty
	; on at least
	cp	iyh
	jr	nz,4f
	cp	iyl
	jr	nz,4f
	
	; no empty inode!
	ld	a,enfile
	ld	(u+u_t.error),enfile
	ret
	
4:
	; set dev and ino, inc count
	ld	(iy+cino_t.dev.high),d
	ld	(iy+cino_t.dev.low),e
	ld	(iy+cino_t.num.high),b
	ld	(iy+cino_t.num.low),c
	inc	(iy+cino_t.count)
	
	; read block
	call	inumread
	
	; todo check for errors
	
	; copy into core
	call	inumaddr
	ld	d,iyh
	ld	e,iyl
	ld	bc,64
	ldir
	
	; release, set ix=iy, and ret
	call	brelse
	push	iy
	pop	ix
	ret

; calcuated a sub-buffer address
; given an i number	
; de = ino
; ix = buffer
;
; hl = address to inode
; ix = buffer
; uses: af, bc, de
inumaddr:
	ld	h,64
	ld	a,0x7
	and	e
	ld	e,a
	call	mulhe
	ld	d,(ix+buf_t.addr.high)
	ld	e,(ix+buf_t.addr.low)
	add	hl,de
	ret
	
; reads a block containing an inode
; given a device and inumber
; bc = ino
; de = dev
;
; bc = blkno
; de = ino
; ix = buffer
; saved: iy
inumread:
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
	ret
	
; decrement reference count
; if on the last inode reference, then
; write the inode and deallocate if no
; links
; ix = inode
.globl iput
iput:
	xor	a
	dec	(ix+cino_t.count)
	ret	nz
	
	; deallocate inode
	ld	(ix+cino_t.flag),a
	ld	(ix+cino_t.num),a
	
	; todo writeback and deallocate
	; blocks
	
	ret
	