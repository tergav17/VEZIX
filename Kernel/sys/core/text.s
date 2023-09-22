; text.s
; user core management

.text

; profile execute
; this function will overlay a core
; image stored in the passed open inode
; onto the current profile.
; passed inode will be closed
; b = set to 1 to skip arg gathering
; ix = image to overlay
;
; saves: af, bc, de
.globl pexec
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
	
	; grab a block for args
	push	ix
	ld	hl,nodev
	call	getblk
	ld	(u+u_t.gp0),ix
	
	; start loading args into said block
	; set arg count to 0
	xor	a
	ld	(u+u_t.gpa),a
	
	; set buffer address
	; and count
	exx
	ld	h,(ix+buf_t.addr.high)
	ld	l,(ix+buf_t.addr.low)
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
	ld	hl,u+u_t.gpa
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
	jr	nz,exbad

	; load first block to check args 
	

	; close file and release arg block
exbad:	call	iput
	ld	ix,(u+u_t.gp0)
	call	brelse
	ret
	
.bss

; exec count
; only one process can exec at a given
; time
.defl byte execnt 0