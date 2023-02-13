; shd.s
; simh hard disk driver

.extern ixnext, ixlink, ixunlink

.text

; simh hd init routine
.globl shdinit
shdinit:
	ret

; simh hd strategy call
; used to link in a new buffer
; for the driver to fullfil
; ix = buffer to attach
;
; uses: all
.globl shdstrat
shdstrat:
	; attach buf to devtab
	ld	hl,shdtab.io_head
	call	ixlink
	
	; start if not active
	ld	a,(shdtab.active)
	or	a
	jr	z,shdstart
	ret
	
	
	
; simh activity start
; this just blocks for now, will change
; when interrupts get added
shdstart:
	; return if nothing to do
	ld	ix,shdtab.io_head
	call	ixnext
	ret	z
	
	; set activity flag
	ld	a,1
	ld	(shdtab.active),a
	
	; do stuff here
	
	; reset activity flag
	xor	a
	ld	(shdtab.active),a
	
	; unlink block from device
	ld	hl,shdtab.io_head
	call	ixunlink

	; continue if there is another block to grab
	jr	nz,shdstart

	ret

.bss

.defl devtab_t[1] shdtab