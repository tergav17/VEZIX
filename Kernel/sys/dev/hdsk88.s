; hdsk88.s
; altair 88-hdsk driver

.extern ixnext, ixlink, ixunlink

.text

; 88-hdsk strategy call
; used to link in a new buffer
; for the driver to fullfil
; ix = buffer to attach
;
; uses: all
hd8strat:
	; attach buf to devtab
	ld	hl,hd8tab.io_head
	call	ixlink
	
	; start if not active
	ld	a,(hd8tab.active)
	or	a
	jr	z,hd8start
	ret
	
	
	
; 88-hdsk activity start
; this just blocks for now, will change
; when interrupts get added
hd8start:
	; return if nothing to do
	ld	ix,hd8tab.io_next
	call	ixnext
	ret	z
	
	; set activity flag
	ld	a,1
	ld	(hd8tab.active),a
	
	; do stuff here
	
	; reset activity flag
	xor	a
	ld	(hd8tab.active),a
	
	; unlink block from device
	ld	hl,hd8tab.io_next
	call	ixunlink

	; continue if there is another block to grab
	jr	nz,hd8start

	ret

.bss

.defl devtab_t[1] hd8tab