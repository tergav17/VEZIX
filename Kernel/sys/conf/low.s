; low.s
; bottom of kernel image
;
; contains entry, base addresses, and misc routines

.extern main

.text
.globl t_base
t_base:
	jp	main	; system entry point

; saves all but hl, de is not passed 
; to function
;
; uses: iy, hl
.globl svnhl
svnhl:
	pop	iy
	push	af
	push	bc
	push	de
	ld	de,0f
	push	de
	jp	(iy)
0:
	pop	de
	pop	bc
	pop	af
	ret
	
; moves forward in a linked list
; z will be set if pointer is null
; ix = pointer to list
;
; uses: af
.globl ixnext
ixnext:
	push	de
	ld	d,ixh
	ld	e,ixl
	ld	a,(de)
	inc	de
	or	a
	ld	ixl,a
	ld	a,(de)
	ld	ixh,a
	jr	nz,0f
	or	a
0:
	pop	de
	ret


.bss
.globl b_base
b_base:

; add a zero at the bottom of memory
; to ensure that 0x0000 is always null
.def byte	
