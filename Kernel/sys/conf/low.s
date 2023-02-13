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
; ix = pointer to linkable object
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
	
; adds ix to a linked list
; ix = pointer to linkable object
; hl = pointer to list header
;
; uses: af, hl
.globl ixlink
ixlink:
	; set ix next to null
	xor	a
	ld	(ix+0),a
	ld	(ix+1),a

	; see if head is null
	cp	(hl)
	jr	nz,2f
	inc	hl
	cp	(hl)
	dec	hl
	jr	nz,2f
	; head is null
	call	1f
0:
	inc	hl
	inc	hl
1:
	; write ix to (hl)
	ld	a,ixl
	ld	(hl),a
	inc	hl
	ld	a,ixh
	ld	(hl),a
	dec	hl
	ret
2:
	; head over to the tail
	inc	hl
	inc	hl
	push	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	call	1b
	pop	hl
	jr	1b
	

; removes the first element from a
; linked list and returns it
; hl = pointer to list header
;
; ix = pointer to first element
; z will bet set if list is empty
; uses: af, hl, ix
.globl ixunlink
ixunlink:
	xor	a
	cp	(hl)
	jr	nz,0f
	inc	hl
	cp	(hl)
	dec	hl
	ret	z
	
	; set (hl) to (ix)
	ld	a,(ix+0)
	ld	(hl),a
	inc	hl
	ld	a,(ix+1)
	ld	(hl),a
	
	; reset z flag
	ld	a,1
	or	a
	ret
	
	
	
; multiply, hl = h * e
; h = operand
; e = operand
;
; hl = result
; uses: de, hl
.globl mulhe
mulhe:
	push	bc
	ld	d,c
	ld	l,d
	ld	b,8
0:
	add	hl,hl
	jp	nc,1f
	add	hl,de
1:
	djnz	0b
	pop	bc
	ret


.bss
.globl b_base
b_base:

; add a zero at the bottom of memory
; to ensure that 0x0000 is always null
.def byte	
