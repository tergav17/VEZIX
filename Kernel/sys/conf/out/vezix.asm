; z80dasm 1.1.6
; command line: z80dasm -l -g 0xC000 -o vezix.asm vezix

	org	0c000h

lc000h:
	jp lc073h
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
	jr nz,lc056h
	inc hl	
	cp (hl)	
	dec hl	
	ret z	
lc056h:
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
sub_c072h:
	jp (hl)	
lc073h:
	ld sp,0c49bh
	xor a	
	ld hl,0d686h
	ld de,0c45bh
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c168h
	ld hl,lc440h
	call sub_c116h
	ld hl,lc44dh
	call sub_c116h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c123h
	ld hl,lc44ah
	call sub_c116h
	call sub_c22dh
	call sub_c385h
	call sub_c258h
	ld hl,00000h
	ld bc,00001h
	call sub_c294h
	ld hl,lc073h
	ld bc,00040h
	call sub_c0c5h
	halt	
sub_c0c5h:
	ld d,b	
	ld e,c	
	call sub_c003h
lc0cah:
	ld c,010h
	ld b,00ah
	call sub_c150h
	ld b,00dh
	call sub_c150h
	push hl	
	call sub_c0f5h
	ld b,03ah
	call sub_c150h
	pop hl	
lc0e0h:
	ld b,020h
	call sub_c150h
	push hl	
	ld h,(hl)	
	call sub_c0fbh
	pop hl	
	dec de	
	ld a,d	
	or e	
	ret z	
	dec c	
	jr nz,lc0e0h
	jr lc0cah
	ret	
sub_c0f5h:
	push hl	
	call sub_c0fbh
	pop hl	
	ld h,l	
sub_c0fbh:
	call sub_c003h
	ld a,h	
	rra	
	rra	
	rra	
	rra	
	call sub_c107h
	ld a,h	
sub_c107h:
	and 00fh
	add a,030h
	cp 03ah
	jr c,lc111h
	add a,027h
lc111h:
	ld b,a	
	call sub_c150h
	ret	
sub_c116h:
	call sub_c003h
lc119h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c150h
	inc hl	
	jr lc119h
sub_c123h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c144h
	ld bc,0fc18h
	call sub_c144h
	ld bc,0ff9ch
	call sub_c144h
	ld bc,0fff6h
	call sub_c144h
	ld bc,0ffffh
	dec d	
sub_c144h:
	ld a,02fh
lc146h:
	inc a	
	add hl,bc	
	jr c,lc146h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c150h:
	in a,(010h)
	and 002h
	jr z,sub_c150h
	ld a,b	
	out (011h),a
	ret	
sub_c15ah:
	ld hl,lc454h
	call sub_c116h
	pop hl	
	call sub_c123h
lc164h:
	di	
	halt	
	jr lc164h
sub_c168h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c171h:
	call sub_c003h
	call sub_c198h
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,006h
	call sub_c063h
	ld de,0c39ah
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
sub_c198h:
	call sub_c003h
	xor a	
	ld ix,0d09bh
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc1a7h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc1c9h
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc1c9h
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc1c9h
	push ix
	pop iy
	jr lc20fh
lc1c9h:
	bit 3,(ix+002h)
	jr nz,lc1ddh
	cp (ix+005h)
	jr z,lc1d6h
	jr nc,lc1ddh
lc1d6h:
	push ix
	pop iy
	ld a,(ix+005h)
lc1ddh:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc1a7h
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc1f9h
	cp e	
	call z,sub_c15ah
lc1f9h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc20fh:
	ld c,006h
	ld iy,0d09bh
	ld a,(ix+005h)
lc218h:
	cp (iy+005h)
	jr c,lc220h
	inc (iy+005h)
lc220h:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc218h
	ld (ix+005h),000h
	ret	
sub_c22dh:
	ld c,006h
	ld hl,0c49bh
	ld ix,0d09bh
	xor a	
lc237h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c250h
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc237h
	ret	
sub_c250h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c258h:
	ld h,0ffh
	call sub_c198h
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c171h
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c15ah
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c250h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d0ebh),hl
	ld hl,00000h
	ld (0d0e9h),hl
	ret	
sub_c294h:
	call sub_c003h
	ex de,hl	
lc298h:
	ld ix,0d101h
	ld a,014h
	ld iy,00000h
lc2a2h:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc2e5h
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc2e5h
	bit 3,(ix+040h)
	ret z	
	ld iy,0d0e9h
	ld c,000h
lc2c3h:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc2dah
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc2dah
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc298h
lc2dah:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc2c3h
	call sub_c15ah
lc2e5h:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc2f0h
	push ix
	pop iy
lc2f0h:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc2a2h
	defb 0fdh,0bch	;cp iyh
	jr nz,lc304h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc304h
	ret	
lc304h:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c33bh
	call sub_c32ah
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c250h
	push iy
	pop ix
	ret	
sub_c32ah:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c33bh:
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
	call sub_c171h
	pop iy
	ret	
	xor a	
	dec (ix+045h)
	ret nz	
	ld (ix+040h),a
	ld (ix+043h),a
	ret	
	call sub_c003h
	xor a	
	cp h	
	jr nz,lc384h
	ld a,l	
	cp 012h
	jr nc,lc384h
	sla h
	ld de,00018h
	add hl,de	
	defb 0ddh,054h	;ld d,ixh
	defb 0ddh,05dh	;ld e,ixl
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	or a	
	ret nz	
	ld a,h	
	or a	
	ret nz	
	ret	
lc384h:
	ret	
sub_c385h:
	ld hl,lc398h
	ld b,001h
lc38ah:
	push hl	
	push bc	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	call sub_c072h
	pop bc	
	pop hl	
	djnz lc38ah
	ret	
lc398h:
	xor c	
	jp lc3b3h
	ld a,c	
	sub 0a8h
	jp 0c3a8h
	xor b	
	jp 0c3a8h
	xor b	
	jp 006c9h
	jr nz,lc3eah
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
lc3b3h:
	xor a	
	ld (ix+004h),a
	ld hl,0d67bh
	call sub_c024h
	ld a,(0d679h)
	or a	
	jr z,lc3c4h
	ret	
lc3c4h:
	ld ix,0d67bh
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d679h),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc3dbh
	ld a,003h
lc3dbh:
	ld (0d67fh),a
	ld a,(ix+00ah)
	ld (0d680h),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc3eah:
	rlca	
	or (ix+004h)
	ld (0d681h),a
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
	ld (0d682h),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc40fh:
	jr z,lc418h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc40fh
lc418h:
	ld (0d684h),hl
	ld b,007h
	ld hl,0d67fh
lc420h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc420h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc3c4h
	xor a	
	ld (0d679h),a
	ld hl,0d67bh
	call sub_c04eh
	jr nz,lc3c4h
	ret	
lc440h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc44ah:
	ld a,(bc)	
	dec c	
	nop	
lc44dh:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc454h
lc454h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
