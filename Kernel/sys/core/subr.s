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
	; indirect block
	ret
	
; takes in a symbolic pathname and
; parses it into an inode
; flag defs:
; 	0: name sought
;	1: name create
;	2: name delete
; b = flag
; hl = path function
;
; ix = inode
; saves: af, bc, de
.globl namei
namei:
	call	svnhl
	
	; set up pfunc
	ld	d,b		; d = flag
	ld	(pfunc),hl
	
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
1:	jr	nz,2f
	call	pchar
	cp	'/'
	jr	1b

	; check for end and flag
2:	or	a
	jr	nz,cloop
	cp	d
	jr	z,cloop
	
	; error out
	ld	a,enoent
	ld	(u+u_t.error),a
	ret

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
	and	1<<m_dev&1<<m_dir
	xor	1<<m_dir
	jr	z,2f
	
	; not a dir, error out!
	ld	a,enotdir
	ld	(u+u_t.error),a
	jr	nerr
	
	; collect into dirbuf
2:	ld	hl,u+u_t.dbuf
	ld	b,c_dsize

	ld	a,e	; check '\0'
3:	cp	'/'	; or '/'
	jr	z,0f
	cp	'\0'
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
	
	; perpare for eloop
2:	ld	hl,0	; start at block 0

	; read the current block in
eloop:	push	hl
	call	bmap

; returns the next character in the 
; pfunc
;
; a = e = next character
; uses: af, e
pchar:
	push	hl
	ld	hl,(pfunc)
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

	
.bss
.defl word pfunc