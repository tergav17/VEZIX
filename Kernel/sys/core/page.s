; page.s
; manages seperation between user space
; and kernel space

.text

; fetches a byte from user space
; hl = pointer to byte in userspace
;
; a = returned byte
; uses: af
.globl fubyte
fubyte:
	ld	a,(hl)
	ret
	
; fetches a word from user space
; hl = pointer to word in userspace
;
; de = returned word
; uses: f, de
.globl fuword
fuword:
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	hl
	ret
	
; fetches a block from user space
; bc = byte count
; de = destination in kernel space
; hl = source in user space
;
; uses: af, bc, de, hl
.globl fublock
fublock:
	ldir
	ret
	
; sets a byte in user space
; a = byte to set
; hl = pointer to byte in user space
;
; uses: af
.globl subyte
subyte:
	ld	(hl),a
	ret
	
; sets a word in user space
; de = word to set
; hl = pointer to word in user space
;
; uses: f
.globl suword
suword:
	ld	(hl),e
	inc	hl
	ld	(hl),d
	dec	hl
	ret
	
; sets a block in user space
; bc = byte count
; de = destination in user space
; hl = source in kernel space
;
; uses: af, bc, de, hl
.globl sublock
sublock:
	ldir
	ret
	
; clears a section of user space
; bc = byte count
; de = start of clear section
;
; uses: af, bc, de, hl
.globl uclear
uclear:
	ld	h,d
	ld	l,e
	ld	(hl),0
	inc	de
	dec	bc
	ldir
	ret