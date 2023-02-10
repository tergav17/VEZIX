; z80dasm 1.1.6
; command line: z80dasm -l -g 0xC000 -o vezix.asm vezix

	org	0c000h

lc000h:
	jp lc024h
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
	push de	
	defb 0ddh,054h	;ld d,ixh
	defb 0ddh,05dh	;ld e,ixl
	ld a,(de)	
	inc de	
	or a	
	defb 0ddh,06fh	;ld ixl,a
	ld a,(de)	
	defb 0ddh,067h	;ld ixh,a
	jr nz,lc022h
	or a	
lc022h:
	pop de	
	ret	
lc024h:
	ld sp,lc000h
	xor a	
	ld hl,0cdd4h
	ld de,0c18ch
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c0a2h
	ld hl,lc178h
	call sub_c05eh
	ld hl,lc185h
	call sub_c05eh
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c06bh
	ld hl,lc182h
	call sub_c05eh
	call sub_c13dh
	halt	
sub_c05eh:
	call sub_c003h
lc061h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c098h
	inc hl	
	jr lc061h
sub_c06bh:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c08ch
	ld bc,0fc18h
	call sub_c08ch
	ld bc,0ff9ch
	call sub_c08ch
	ld bc,0fff6h
	call sub_c08ch
	ld bc,0ffffh
	dec d	
sub_c08ch:
	ld a,02fh
lc08eh:
	inc a	
	add hl,bc	
	jr c,lc08eh
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c098h:
	in a,(010h)
	and 002h
	jr z,sub_c098h
	ld a,b	
	out (011h),a
	ret	
sub_c0a2h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
	call sub_c003h
	xor a	
	ld ix,0cd8ch
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc0bah:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc0dch
	ld h,(ix+00ah)
	ld l,(ix+009h)
	or a	
	sbc hl,de
	jr nz,lc0dch
	ld h,(ix+008h)
	ld l,(ix+007h)
	or a	
	sbc hl,bc
	jr nz,lc0dch
	push ix
	pop iy
	jr lc0fah
lc0dch:
	bit 3,(ix+002h)
	jr nz,lc0f0h
	cp (ix+004h)
	jr z,lc0e9h
	jr nc,lc0f0h
lc0e9h:
	push ix
	pop iy
	ld a,(ix+004h)
lc0f0h:
	ld hl,0000ch
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc0bah
lc0fah:
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc109h
	cp e	
lc109h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00ah),h
	ld (ix+009h),l
	pop hl	
	ld (ix+00ah),h
	ld (ix+009h),l
	ld (ix+002h),008h
	ld c,006h
	ld iy,0cd8ch
	ld a,(ix+004h)
lc128h:
	cp (iy+004h)
	jr c,lc130h
	inc (iy+004h)
lc130h:
	ld de,0000ch
	add iy,de
	dec c	
	jr nz,lc128h
	ld (ix+004h),000h
	ret	
sub_c13dh:
	ld c,006h
	ld hl,0c18ch
	ld ix,0cd8ch
	xor a	
lc147h:
	ld (ix+006h),h
	ld (ix+005h),l
	ld (ix+003h),c
	call sub_c160h
	ld de,0000ch
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	ret z	
	jr lc147h
sub_c160h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
	halt	
	pop bc	
	nop	
	nop	
	ld (hl),a	
	pop bc	
	ld (hl),a	
	pop bc	
	ld (hl),a	
	pop bc	
	ld (hl),a	
	pop bc	
	ld (hl),a	
	pop bc	
	ret	
	ret	
lc178h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc182h:
	ld a,(bc)	
	dec c	
	nop	
lc185h:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,$+2
