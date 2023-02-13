; bio.s
; device block i/o

.text

; get block, if the appropriate block
; already exists, then return it.
; otherwise free a block and return it
; hl = dev
; bc = blkno
; 
; ix = pointer to buffer
; saved: af, bc, de
.globl getblk
getblk:
	call	svnhl
	xor	a	; a' = age
	ld	ix,buftab
	ld	iy,0	; iy = result
	ex	af,af'
	ld	a,c_nbuf
0:
	ex	af,af'
	ex	de,hl	; de = dev
	; skip existing seach if nodev
	bit	7,d
	jr	nz,2f
	
	; first we search for buffers
	; that already contain desired
	; information
	ld	h,(ix+buf_t.dev.high)
	ld	l,(ix+buf_t.dev.low)
	or	a
	sbc	hl,de
	jr	nz,2f
	ld	h,(ix+buf_t.blkno.high)
	ld	l,(ix+buf_t.blkno.low)
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
	jr	nz,4f
	
	; skip if age is lower
	cp	(ix+buf_t.age)
	jr	z,3f
	jr	nc,4f
3:
	; set iy = ix, set age
	push	ix
	pop	iy
	ld	a,(ix+buf_t.age)
4:
	; advance forward
	ld	hl,$buf_t
	ex	de,hl
	add	ix,de
	ex	af,af'
	dec 	a
	jr	nz,0b
5:
	; search complete
	; panic if no result
	push	bc
	push	hl
	push	iy
	pop	ix 
	ld	d,iyh
	ld	e,iyl
	xor	a
	cp	d
	jr	nz,0f
	cp	e
	; jp	panic todo
0:
	; write out if delwr
	bit	b_delwr,(ix+buf_t.flag)
	;call	nz,bwrite todo
	
	; todo: sleep if busy
	
	; set new flags
	pop	hl
	ld	(ix+buf_t.dev.high),h
	ld	(ix+buf_t.dev.low),l
	pop	hl
	ld	(ix+buf_t.dev.high),h
	ld	(ix+buf_t.dev.low),l
	ld	(ix+buf_t.flag),1<<b_busy
	
	; update age
	ld	c,c_nbuf
	ld	iy,buftab
	ld	a,(ix+buf_t.age)
1:
	cp	(iy+buf_t.age)
	jr	c,2f
	inc	(iy+buf_t.age)
2:
	ld	de,$buf_t
	add	iy,de
	dec	c
	jr	nz,1b
	ld	(ix+buf_t.age),0
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
	
	; set the serial #, debugging
	ld	(ix+buf_t.serial),c
	
	; release block
	call	brelse
	
	; increment pointers
	ld	de,$buf_t
	add	ix,de
	ld	de,512
	add	hl,de
	
	dec	c
	jr	nz,0b
	ret
	
	
; dev init
;
; uses: all
.globl dinit
dinit:	
	; init devices, start with bdev
	ld	a,c_nbdev
	ld	bc,bdevsw + bdev_t.init
0:
	call	2f
	ld	hl,$bdev_t
	add	hl,bc
	ld	b,h
	ld	c,l
	dec	a
	jr	nz,0b
	
	; init cdev
	ld	a,c_ncdev
	ld	bc,cdevsw + cdev_t.init
1:
	call	2f
	ld	hl,$cdev_t
	add	hl,bc
	ld	b,h
	ld	c,l
	dec	a
	jr	nz,1b
	ret
	
2:
	call	svnhl
	ld	h,b
	ld	l,c
	ld	d,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,d
	jp	(hl)
	
	



; releases a block. sets flag to not
; busy
; ix = pointer to buf header
;
; uses: af
.globl brelse
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