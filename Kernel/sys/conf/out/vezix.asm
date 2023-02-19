; z80dasm 1.1.6
; command line: z80dasm -l -g 0xC000 -o vezix.asm vezix

	org	0c000h

lc000h:
	jp lc072h
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
sub_c012h:
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
sub_c024h:
	xor a	
	ld (ix+000h),a
	ld (ix+001h),a
	cp (hl)	
	jr nz,lc041h
	inc hl	
	cp (hl)	
	dec hl	
	jr nz,lc041h
	call sub_c038h
	inc hl	
	inc hl	
sub_c038h:
	defb 0ddh,07dh	;ld a,ixl
	ld (hl),a	
	inc hl	
	defb 0ddh,07ch	;ld a,ixh
	ld (hl),a	
	dec hl	
	ret	
lc041h:
	inc hl	
	inc hl	
	push hl	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	call sub_c038h
	pop hl	
	jr sub_c038h
sub_c04eh:
	xor a	
	cp (hl)	
	jr nz,lc069h
	inc hl	
	cp (hl)	
	dec hl	
	ret z	
	ld a,(ix+000h)
	ld (hl),a	
	inc hl	
	ld a,(ix+001h)
	ld (hl),a	
	ld a,001h
	or a	
	ret	
sub_c063h:
	push bc	
	ld d,000h
	ld l,d	
	ld b,008h
lc069h:
	add hl,hl	
	jp nc,lc06eh
	add hl,de	
lc06eh:
	djnz lc069h
	pop bc	
	ret	
lc072h:
	ld sp,0c3bch
	xor a	
	ld hl,0d5a7h
	ld de,0c37ch
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c104h
	ld hl,lc361h
	call sub_c0b2h
	ld hl,lc36eh
	call sub_c0b2h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c0bfh
	ld hl,lc36bh
	call sub_c0b2h
	call sub_c1cah
	call sub_c2b7h
	call sub_c1f5h
	halt	
sub_c0b2h:
	call sub_c003h
lc0b5h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c0ech
	inc hl	
	jr lc0b5h
sub_c0bfh:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c0e0h
	ld bc,0fc18h
	call sub_c0e0h
	ld bc,0ff9ch
	call sub_c0e0h
	ld bc,0fff6h
	call sub_c0e0h
	ld bc,0ffffh
	dec d	
sub_c0e0h:
	ld a,02fh
lc0e2h:
	inc a	
	add hl,bc	
	jr c,lc0e2h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c0ech:
	in a,(010h)
	and 002h
	jr z,sub_c0ech
	ld a,b	
	out (011h),a
	ret	
sub_c0f6h:
	ld hl,lc375h
	call sub_c0b2h
	pop hl	
	call sub_c0bfh
lc100h:
	di	
	halt	
	jr lc100h
sub_c104h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c10dh:
	call sub_c003h
	call sub_c135h
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc2bbh
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c134h
	pop ix
	ret	
sub_c134h:
	jp (hl)	
sub_c135h:
	call sub_c003h
	xor a	
	ld ix,0cfbch
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc144h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc166h
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc166h
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc166h
	push ix
	pop iy
	jr lc1ach
lc166h:
	bit 3,(ix+002h)
	jr nz,lc17ah
	cp (ix+005h)
	jr z,lc173h
	jr nc,lc17ah
lc173h:
	push ix
	pop iy
	ld a,(ix+005h)
lc17ah:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc144h
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc196h
	cp e	
	call z,sub_c0f6h
lc196h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc1ach:
	ld c,006h
	ld iy,0cfbch
	ld a,(ix+005h)
lc1b5h:
	cp (iy+005h)
	jr c,lc1bdh
	inc (iy+005h)
lc1bdh:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc1b5h
	ld (ix+005h),000h
	ret	
sub_c1cah:
	ld c,006h
	ld hl,0c3bch
	ld ix,0cfbch
	xor a	
lc1d4h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c1edh
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc1d4h
	ret	
sub_c1edh:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c1f5h:
	ld h,0ffh
	call sub_c135h
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c10dh
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c0f6h
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c1edh
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d00ch),hl
	ld hl,00000h
	ld (0d00ah),hl
	ret	
	call sub_c003h
	ex de,hl	
	ld ix,0d022h
	ld a,014h
	ld iy,00000h
lc23fh:
	ld h,(ix+042h)
	ld l,(ix+041h)
	sbc hl,de
	jr nz,lc254h
	ld h,(ix+044h)
	ld l,(ix+043h)
	sbc hl,bc
	jr nz,lc254h
	ret	
lc254h:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc25fh
	push ix
	pop iy
lc25fh:
	ex af,af'	
	dec a	
	jr nz,lc23fh
	defb 0fdh,0bch	;cp iyh
	jr nz,lc26ch
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc26ch
	ret	
lc26ch:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	ld h,b	
	ld l,c	
	ld a,l	
	srl h
	rra	
	srl h
	rra	
	srl h
	rra	
	ld l,a	
	inc hl	
	inc hl	
	push bc	
	ld b,h	
	ld c,l	
	pop hl	
	ex de,hl	
	push iy
	call sub_c10dh
	pop iy
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c1edh
	push iy
	pop ix
	ret	
sub_c2b7h:
	call 0c2cah
	ret	
lc2bbh:
	call nc,09ac2h
	push de	
	ret	
	jp nz,0c2c9h
	ret	
	jp nz,0c2c9h
	ret	
	jp nz,006c9h
	jr nz,lc30bh
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d59ch
	call sub_c024h
	ld a,(0d59ah)
	or a	
	jr z,lc2e5h
	ret	
lc2e5h:
	ld ix,0d59ch
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d59ah),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc2fch
	ld a,003h
lc2fch:
	ld (0d5a0h),a
	ld a,(ix+00ah)
	ld (0d5a1h),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc30bh:
	rlca	
	or (ix+004h)
	ld (0d5a2h),a
	ld h,(ix+009h)
	ld l,(ix+008h)
	ld a,l	
	srl h
	rra	
	srl h
	rra	
	srl h
	rra	
	ld l,a	
	ld (0d5a3h),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc330h:
	jr z,lc339h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc330h
lc339h:
	ld (0d5a5h),hl
	ld b,007h
	ld hl,0d5a0h
lc341h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc341h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc2e5h
	xor a	
	ld (0d59ah),a
	ld hl,0d59ch
	call sub_c04eh
	jr nz,lc2e5h
	ret	
lc361h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc36bh:
	ld a,(bc)	
	dec c	
	nop	
lc36eh:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc375h
lc375h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
