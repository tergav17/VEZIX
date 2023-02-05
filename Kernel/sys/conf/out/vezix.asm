; z80dasm 1.1.6
; command line: z80dasm -l -g 0xC000 -o vezix.asm vezix

	org	0c000h

lc000h:
	jp lc012h
sub_c003h:
	pop iy
	push af	
	push bc	
	push de	
	ld de,lc00eh
	push de	
	jp (iy)
lc00eh:
	pop de	
	pop bc	
	pop af	
	ret	
lc012h:
	ld sp,lc000h
	call sub_c066h
	ld hl,lc06fh
	call sub_c025h
	ld hl,00045h
	call sub_c032h
	halt	
sub_c025h:
	call sub_c003h
lc028h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c05ch
	inc hl	
	jr lc028h
sub_c032h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c050h
	ld bc,0fc18h
	call sub_c050h
	ld c,09ch
	call sub_c050h
	ld c,0f6h
	call sub_c050h
	ld c,0ffh
	inc d	
sub_c050h:
	ld a,02fh
lc052h:
	inc a	
	add hl,bc	
	jr c,lc052h
	sbc hl,bc
	ld b,a	
	cp d	
	ld d,000h
sub_c05ch:
	in a,(010h)
	and 002h
	jr z,sub_c05ch
	ld a,b	
	out (011h),a
	ret	
sub_c066h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
lc06fh:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+120
	ld sp,00d0ah
	nop	
