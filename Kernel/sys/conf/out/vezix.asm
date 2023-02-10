; z80dasm 1.1.6
; command line: z80dasm -l -g 0xC000 -o out/vezix.asm out/vezix

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
	ld hl,0cdceh
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
	call sub_c0bch
	ld hl,lc178h
	call sub_c077h
	ld hl,lc185h
	call sub_c077h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c084h
	ld hl,lc182h
	call sub_c077h
	call sub_c150h
	ld h,0ffh
	ld bc,00000h
	call sub_c0c5h
	call sub_c170h
	ld h,0ffh
	ld bc,00000h
	call sub_c0c5h
	push ix
	pop hl	
	call sub_c084h
	halt	
sub_c077h:
	call sub_c003h
lc07ah:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c0b2h
	inc hl	
	jr lc07ah
sub_c084h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c0a5h
	ld bc,0fc18h
	call sub_c0a5h
	ld bc,0ff9ch
	call sub_c0a5h
	ld bc,0fff6h
	call sub_c0a5h
	ld bc,0ffffh
	inc d	
sub_c0a5h:
	ld a,02fh
lc0a7h:
	inc a	
	add hl,bc	
	jr c,lc0a7h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	ld d,000h
sub_c0b2h:
	in a,(010h)
	and 002h
	jr z,sub_c0b2h
	ld a,b	
	out (011h),a
	ret	
sub_c0bch:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c0c5h:
	call sub_c003h
	xor a	
	ld ix,0cd8ch
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc0d4h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc0f6h
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,de
	jr nz,lc0f6h
	ld h,(ix+007h)
	ld l,(ix+006h)
	or a	
	sbc hl,bc
	jr nz,lc0f6h
	push ix
	pop iy
	jr lc111h
lc0f6h:
	bit 3,(ix+002h)
	jr nz,lc107h
	cp (ix+003h)
	jr z,lc103h
	jr nc,lc107h
lc103h:
	push ix
	pop iy
lc107h:
	ld hl,0000bh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc0d4h
lc111h:
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc120h
	cp e	
lc120h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
	ld c,006h
	ld iy,0cd8ch
	ld a,(ix+003h)
lc13fh:
	cp (iy+003h)
	jr nc,lc147h
	inc (iy+003h)
lc147h:
	ld de,0000bh
	add iy,de
	dec c	
	jr nz,lc13fh
	ret	
sub_c150h:
	ld c,006h
	ld hl,0c18ch
	ld ix,0cd8ch
	xor a	
lc15ah:
	ld (ix+005h),h
	ld (ix+004h),l
	call sub_c170h
	ld de,0000bh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	ret z	
	jr lc15ah
sub_c170h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
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
