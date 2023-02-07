; low.s
; bottom of object file
;
; contains entry, base addresses, and misc routines

.extern main

.text
.globl t_base
t_base:
	jp	main	; system entry point

; saves all but hl, de is not passed to function
;
; uses: iy, scr_1
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
	


.bss
.globl b_base
b_base: