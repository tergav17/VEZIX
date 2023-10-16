; text.s
; user core management

.text

; profile execute
; this function will overlay a core
; image stored in the passed open inode
; onto the current profile.
; passed inode will be closed
; ix = inode of executable file
;
; saves: af, bc, de
.globl pexec

; local variables
exargs	= u+u_t.gp0
exdev	= u+u_t.gp1
exoff	= u+u_t.gp2
excount	= u+u_t.gp3
expoint	= u+u_t.gp4

exargc	= u+u_t.gpa

pexec:
	call	svnhl
	
	; first things first, check
	; inode permissions
	
	; todo: check
	
	; check execnt
0:	ld	a,(execnt)
	or	a
	jr	z,1f
	
	; todo: sleep operation
	
	jr	0b
	
	; set execnt 
1:	inc	a
	ld	(execnt),a
	
	; set exdev
	ld	h,(ix+cino_t.dev.high)
	ld	l,(ix+cino_t.dev.low)
	ld	(exdev),hl
	
	; grab a block for args
	push	ix
	ld	hl,nodev
	call	getblk
	ld	(exargs),ix
	
	; start loading args into said block
	; set arg count to 0
	xor	a
	ld	(exargc),a
	
	; set buffer address
	; and count
	exx
	call	hlbuff
	exx
	ld	bc,512
	
	; do we have another argument to load?
2:	ld	hl,(u+u_t.args + 2)
	call	fuword
	
	; is it zero?
	ld	d,a
	or	e
	jr	z,9f	; z flag set
	
	; increment argument pointer
	; and arg count
	inc	hl
	inc	hl
	ld	(u+u_t.args + 2),hl
	ld	hl,exargc
	inc	(hl)
	
	; copy user bytes into buffer
	ex	de,hl
	
	; fetch byte
3:	call	fubyte
	inc	hl

	; copy to buffer
	exx
	ld	(hl),a
	inc	hl
	exx
	
	; is it 0?
	or	a
	jp	z,2b
	
	; do another?
	dec	bc
	ld	b,a
	or	c
	jr	nz,3b
	
	; error!
	inc	a	; flag not z
	
	; regain inode
9:	pop	ix
	
	; did we encounter an error?
	jp	nz,exbad

	; load first block to check args 
	ld	hl,0
	push	hl
	call	bmap
	ld	b,h
	ld	c,l
	ld	hl,(exdev)
	push	ix
	call	bread
	ld	a,(u+u_t.error)
	or	a
	jp	nz,exbadb
	
	; read in magic number and
	; get load in addresses
	call	hlbuff
	ld	a,0x18 
	cp	(hl)
	inc	hl
	jr	nz,0f
	ld	a,0x0E
	cp	(hl)
	inc	hl
	jr	z,1f
	
	; error!
0:	ld	a,enoexec
	ld	(u+u_t.error),a
	jp	exbadb
	
	; calculate image offset
1:	inc	hl
	ld	b,(hl)
	inc	hl
	ld	c,(hl)
	ex	de,hl
	ld	hl,c_ubase
	sbc	hl,bc
	ld	(exoff),hl
	ex	de,hl
	
	; get image count
	ld	de,8
	add	hl,de
	ld	d,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	(excount),de
	
	
	; get image size
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	b,h
	ld	c,l
	ld	de,c_utop-c_ubase
	or	a
	sbc	hl,de
	jr	nc,2f
	
	; error!
	ld	a,e2big
	ld	(u+u_t.error),a
	jr	exbadb

	; commit to core image
	; clear core
2:	ld	de,c_ubase
	call	uclear
	
	; figure out how many bytes
	; to copy from block
3:	ld	hl,(excount)
	ld	b,h
	ld	c,l
	ld	de,512
	or	a
	sbc	hl,de
	push	af
	jr	c,4f
	ld	b,d
	ld	c,e
	
	ld	hl,c_ubase
	ld	(expoint),hl

	; copy block
4:	call	hlbuff
	ld	de,(expoint)
	call	sublock
	
	; release current block
	ld	(expoint),de
	call 	brelse
	pop	af
	jr	c,5f	; do more?
	pop	ix
	pop	hl
	inc	hl
	push	hl
	call	bmap
	ld	b,h
	ld	c,l
	ld	hl,(exdev)
	push	ix
	call	bread
	ld	a,(u+u_t.error)
	or	a
	jr	nz,exbadb
	
	; continue copying
	jr	3b
	
	
	; we are done loading
5:	ld	hl,(exoff)
	ld	a,h
	or	l
	jr	z,9f
	
	; do relocation here


	; initialize stack segmnet
	; release inode
9:	call	iput
	ld	ix,(exargs)
	
	
	
	; same as exbad, but releases
	; current block
exbadb:	call	brelse
	pop	ix
	pop	hl

	; close file and release arg 
	; block
exbad:	call	iput
	ld	ix,(exargs)
	call	brelse
	ret
	
.bss

; exec count
; only one process can exec at a given
; time
.defl byte execnt 0