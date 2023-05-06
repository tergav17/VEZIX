; text.s
; user core management

.text

; profile execute
; this function will overlay a core
; image stored in the passed open inode
; onto the current profile.
; b = set to 1 to skip arg gathering
; ix = image to overlay
;
; saves: af, bc, de
.globl pexec
pexec:
	call	svnhl
	
	; check execnt
0:	ld	a,(execnt)
	or	a
	jr	z,1f
	
	; todo: sleep operation
	
	jr	0b
	
	; set execnt
	inc	a
	ld	(execnt),a
	
	; grab a block for args
	push	ix
	ld	hl,nodev
	call	getblk
	
	
	
	
	
	; regain inode
	ld	(u+u_t.gp0),ix
	pop	ix

	; load image into memory

	; close file and release arg block
	call	iput
	ld	ix,(u+u_t.gp0)
	call	brelse
	ret
	
	
.bss

; exec count
; only one process can exec at a given
; time
.defl byte execnt 0