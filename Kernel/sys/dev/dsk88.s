; dsk88.s
; altair 88-dsk driver

.extern ixnext, ixlink, ixunlink

.text

; 88-dsk init routine
.globl fd8init
fd8init:
	ret

; 88-dsk strategy call
; used to link in a new buffer
; for the driver to fullfil
; ix = buffer to attach
;
; uses: all
.globl fd8strat
fd8strat:
	; attach buf to devtab
	ld	hl,fd8tab.io_head
	call	ixlink
	
	; start if not active
	ld	a,(fd8tab.active)
	or	a
	jr	z,hd8start
	ret
	
	
	
; 88-dsk activity start
; this just blocks for now, will change
; when interrupts get added
fd8start:
	; return if nothing to do
	ld	ix,fd8tab.io_next
	call	ixnext
	ret	z
	
	; set activity flag
	ld	a,1
	ld	(fd8tab.active),a
	
	; do stuff here
	
	; reset activity flag
	xor	a
	ld	(fd8tab.active),a
	
	; unlink block from device
	ld	hl,fd8tab.io_next
	call	ixunlink

	; continue if there is another block to grab
	jr	nz,hd8start

	ret

.bss

.defl devtab_t[1] fd8tab