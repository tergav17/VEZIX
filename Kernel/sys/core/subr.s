; subr.s
; intermediate level
; subroutines

.text

; maps a logical inode block to a disk
; block
; hl = inode blkno
; ix = inode
; 
; hl = disk blkno
; ix = inode
; uses: hl, iy
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
	
	; hl=(hl)
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	
	; return if not zero
	or	h
	ret	nz
	
	; todo allocate block
	ret
	
9:
	; todo indirect block
	ret
	
; takes in a symbolic pathname and
; parses it into an inode
; hl = path function
;
; ix = inode
; saves: af, bc, de
.globl namei
namei:
	call	svnhl
	
	; set up pfunc
	ld	(u+u_t.pfunc),hl
	
	; set default directory
	ld	hl,(u+u_t.cnum)
	ld	b,h
	ld	c,l
	ld	hl,(u+u_t.cdev)
	
	call	pchar
	cp	'/'
	jr	nz,0f
	
	; set root directory
	ld	hl,c_rootd
	ld	bc,rootino
	
	; get the inode for this dir
0:	call	iget
	
	; skip over all '/'
1:	jr	nz,cloop
	call	pchar
	cp	'/'
	jr	1b

	; start of cloop
cloop:	ld	a,(u+u_t.error)
	or	a
	jr	z,1f
	
	; error!, zero ix and return
nerr:	call	iput
	ld	ix,0
	ret

	; return if last char = '\0'
1:	cp	e
	ret	z
	
	; ok, get another component
	; current ino must be a dir
	ld	a,(ix+dino_t.mode.high)
	and	0+(1<<m_dev)+(1<<m_dir)
	xor	1<<m_dir
	jr	z,2f
	
	; not a dir, error out!
	ld	a,enotdir
	ld	(u+u_t.error),a
	jr	nerr
	
	; collect into dirbuf
2:	ld	hl,u+u_t.dbuf
	ld	b,32

	ld	a,e	; check '\0'
3:	cp	'/'	; or '/'
	jr	z,0f
	or	a
	jr	z,0f
	
	; if dirbuf full, skip
	xor	a
	cp	b
	jr	z,4f
	ld	(hl),e
	inc	hl
	dec	b
	
4:	call	pchar
	jr	3b
	
0:	xor	a
	ld	(hl),a
	ld	a,e
	
	; skip over all '/'
1:	cp	'/'
	jr	nz,2f
	call	pchar
	jr	1b
	
	; perpare for search

	; calculate count, max 2048
	; entires in a directory
2:	ld	h,(ix+cino_t.node.size.low.high)
	ld	l,(ix+cino_t.node.size.low.low)
	xor	a
	add	hl,hl
	rla
	add	hl,hl
	rla
	add	hl,hl
	rla
	ld	l,h
	ld	h,a

	; load count as gp0
	ld	(u+u_t.gp0),hl
	
	; start at block 0
	ld	hl,0

	; save ix and hl, then read
	; the current block in
3:	push	hl
	push	ix
	call	bmap
	
	ld	b,h
	ld	c,l
	ld	h,(ix+cino_t.dev.high)
	ld	l,(ix+cino_t.dev.low)
	call	bread
	
	; set pointer to buffer
	call	hlbuff
	ld	d,16	; 16 entries per block
	
	; start the search
	; first we check if there are any more entires
4:	push	hl
	ld	hl,(u+u_t.gp0)
	ld	a,h
	or	l
	jr	z,8f
	dec	hl
	ld	(u+u_t.gp0),hl
	pop	hl

	; search block
	push	hl 
	inc	hl
	inc	hl
	ld	bc,u+u_t.dbuf
	ld	a,30	; length of dirent
	
	; compare with dirbuf
5:	ex	af,af'
	ld	a,(bc)
	cp	(hl)
	jr	nz,6f
	
	; are we at the end?
	or	a
	jr	z,7f
	ex	af,af'
	dec	a
	jr	z,7f
	
	; next char and loop
	inc	hl
	inc	bc
	jr	5b
	
	; check failed!
6:	pop	hl

	ld	bc,32
	add	hl,bc
	dec	d
	jr	nz,4b
	
	; we need a new block
	call	brelse
	pop	ix
	pop	hl
	inc	hl
	jr	3b
	
	; found it!
7:	pop	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	
	; clear context for block searches
	call	brelse
	pop	ix
	pop	hl
	
	; grab the current device
	ld	h,(ix+cino_t.dev.high)
	ld	l,(ix+cino_t.dev.low)
	
	; grab the next inode
	push	hl
	call	iput
	pop	hl
	call	iget
	
	; return to cloop 
	jp	cloop

	; we ran out of entires
8:	pop	hl
	call	brelse
	pop	ix
	pop	hl
	
	; not found!
	ld	a,enoent
	ld	(u+u_t.error),a
	jp	nerr

	

; returns the next character in the 
; pfunc
;
; a = e = next character
; uses: af, e
pchar:
	push	hl
	ld	hl,(u+u_t.pfunc)
	call	jphl
	pop	hl
	ld	e,a
	ret
	
; returns next character from string
; pointed to byte u.dirp from kernel
; memory
.globl schar
schar:
	push	hl
	ld	hl,(u+u_t.dirp)
	ld	a,(hl)
	inc	hl
	ld	(u+u_t.dirp),hl
	pop	hl
	ret
	
; returns next character from string
; pointed to byte u.dirp from user
; memory
.globl uchar
uchar:
	push	hl
	ld	hl,(u+u_t.dirp)
	call	fubyte
	inc	hl
	ld	(u+u_t.dirp),hl
	pop	hl
	ret