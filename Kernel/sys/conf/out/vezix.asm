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
lc072h:
	ld sp,0c400h
	xor a	
	ld hl,0d5ebh
	ld de,0c3c0h
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c113h
	ld hl,lc3a5h
	call sub_c0c1h
	ld hl,lc3b2h
	call sub_c0c1h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c0ceh
	ld hl,lc3afh
	call sub_c0c1h
	call sub_c1d9h
	call sub_c2fbh
	call sub_c204h
	ld hl,00000h
	ld bc,00033h
	call sub_c240h
	push ix
	pop hl	
	call sub_c0ceh
	halt	
sub_c0c1h:
	call sub_c003h
lc0c4h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c0fbh
	inc hl	
	jr lc0c4h
sub_c0ceh:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c0efh
	ld bc,0fc18h
	call sub_c0efh
	ld bc,0ff9ch
	call sub_c0efh
	ld bc,0fff6h
	call sub_c0efh
	ld bc,0ffffh
	dec d	
sub_c0efh:
	ld a,02fh
lc0f1h:
	inc a	
	add hl,bc	
	jr c,lc0f1h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c0fbh:
	in a,(010h)
	and 002h
	jr z,sub_c0fbh
	ld a,b	
	out (011h),a
	ret	
sub_c105h:
	ld hl,lc3b9h
	call sub_c0c1h
	pop hl	
	call sub_c0ceh
lc10fh:
	di	
	halt	
	jr lc10fh
sub_c113h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c11ch:
	call sub_c003h
	call sub_c144h
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc2ffh
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c143h
	pop ix
	ret	
sub_c143h:
	jp (hl)	
sub_c144h:
	call sub_c003h
	xor a	
	ld ix,0d000h
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc153h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc175h
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc175h
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc175h
	push ix
	pop iy
	jr lc1bbh
lc175h:
	bit 3,(ix+002h)
	jr nz,lc189h
	cp (ix+005h)
	jr z,lc182h
	jr nc,lc189h
lc182h:
	push ix
	pop iy
	ld a,(ix+005h)
lc189h:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc153h
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc1a5h
	cp e	
	call z,sub_c105h
lc1a5h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc1bbh:
	ld c,006h
	ld iy,0d000h
	ld a,(ix+005h)
lc1c4h:
	cp (iy+005h)
	jr c,lc1cch
	inc (iy+005h)
lc1cch:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc1c4h
	ld (ix+005h),000h
	ret	
sub_c1d9h:
	ld c,006h
	ld hl,0c400h
	ld ix,0d000h
	xor a	
lc1e3h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c1fch
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc1e3h
	ret	
sub_c1fch:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c204h:
	ld h,0ffh
	call sub_c144h
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c11ch
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c105h
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c1fch
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d050h),hl
	ld hl,00000h
	ld (0d04eh),hl
	ret	
sub_c240h:
	call sub_c003h
	ex de,hl	
lc244h:
	ld ix,0d066h
	ld a,014h
	ld iy,00000h
lc24eh:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc291h
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc291h
	bit 4,(ix+040h)
	ret z	
	ld iy,0d04eh
	ld c,000h
lc26fh:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc286h
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc286h
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc244h
lc286h:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc26fh
	call sub_c105h
lc291h:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc29ch
	push ix
	pop iy
lc29ch:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc24eh
	defb 0fdh,0bch	;cp iyh
	jr nz,lc2b0h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc2b0h
	ret	
lc2b0h:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	ld h,b	
	ld l,c	
	ld a,l	
	srl h
lc2c4h:
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
	call sub_c11ch
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
	call sub_c1fch
	push iy
	pop ix
	ret	
sub_c2fbh:
	call 0c30eh
	ret	
lc2ffh:
	jr lc2c4h
	sbc a,0d5h
	dec c	
	jp 0c30dh
	dec c	
	jp 0c30dh
	dec c	
	jp 006c9h
	jr nz,lc34fh
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d5e0h
	call sub_c024h
	ld a,(0d5deh)
	or a	
	jr z,lc329h
	ret	
lc329h:
	ld ix,0d5e0h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d5deh),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc340h
	ld a,003h
lc340h:
	ld (0d5e4h),a
	ld a,(ix+00ah)
	ld (0d5e5h),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc34fh:
	rlca	
	or (ix+004h)
	ld (0d5e6h),a
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
	ld (0d5e7h),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc374h:
	jr z,lc37dh
	ld de,00080h
	add hl,de	
	dec a	
	jr lc374h
lc37dh:
	ld (0d5e9h),hl
	ld b,007h
	ld hl,0d5e4h
lc385h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc385h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc329h
	xor a	
	ld (0d5deh),a
	ld hl,0d5e0h
	call sub_c04eh
	jr nz,lc329h
	ret	
lc3a5h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc3afh:
	ld a,(bc)	
	dec c	
	nop	
lc3b2h:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc3b9h
lc3b9h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
