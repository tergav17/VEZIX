; rcide.s
; rc-2014  ide hard disk driver

.extern ixnext, ixlink, ixunlink
.extern hlbuff

.text

; rcide hd init routine
.globl ideinit
ideinit:
	ret

; rcide hd strategy call
; used to link in a new buffer
; for the driver to fullfil
; ix = buffer to attach
;
; uses: all
.globl idestrat
idestrat:
	; reset transferred sector counter
	xor	a
	ld	(ix+buf_t.scount),a

	; attach buf to devtab
	ld	hl,idetab.io_head
	call	ixlink
	
	; start if not active
	ld	a,(idetab.active)
	or	a
	jr	z,idestart
	ret
	
	
	
; rcide hd activity start
; this just blocks for now, will change
; when interrupts get added
;
; uses: all
idestart:
	; return if nothing to do
	ld	ix,idetab.io_head
	call	ixnext
	ret	z
	
	; set activity flag
	ld	a,1
	ld	(idetab.active),a
	
	; do stuff here
	
	; reset activity flag
	xor	a
	ld	(idetab.active),a
	
	; unlink block from device
	ld	hl,idetab.io_head
	call	ixunlink
	
	; todo: call iodone

	; continue if there is another block to grab
	jr	nz,idestart

	ret

.bss

.globl idetab
.defl devtab_t idetab	0