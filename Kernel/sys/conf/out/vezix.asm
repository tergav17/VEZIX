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
	ld sp,0c44ah
	xor a	
	ld hl,0d635h
	ld de,0c40ah
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c127h
	ld hl,lc3efh
	call sub_c0d5h
	ld hl,lc3fch
	call sub_c0d5h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c0e2h
	ld hl,lc3f9h
	call sub_c0d5h
	call sub_c1edh
	call sub_c345h
	call sub_c218h
	ld hl,00000h
	ld bc,00001h
	call sub_c254h
	ld hl,00000h
	call sub_c323h
	ld b,h	
	ld c,l	
	ld h,(ix+042h)
	ld l,(ix+041h)
	call sub_c0e2h
	halt	
	call sub_c158h
	ld h,(ix+007h)
	ld l,(ix+006h)
sub_c0d5h:
	call sub_c003h
lc0d8h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c10fh
	inc hl	
	jr lc0d8h
sub_c0e2h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c103h
	ld bc,0fc18h
	call sub_c103h
	ld bc,0ff9ch
	call sub_c103h
	ld bc,0fff6h
	call sub_c103h
	ld bc,0ffffh
	dec d	
sub_c103h:
	ld a,02fh
lc105h:
	inc a	
	add hl,bc	
	jr c,lc105h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c10fh:
	in a,(010h)
	and 002h
	jr z,sub_c10fh
	ld a,b	
	out (011h),a
	ret	
sub_c119h:
	ld hl,lc403h
	call sub_c0d5h
	pop hl	
	call sub_c0e2h
lc123h:
	di	
	halt	
	jr lc123h
sub_c127h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c130h:
	call sub_c003h
	call sub_c158h
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc349h
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c157h
	pop ix
	ret	
sub_c157h:
	jp (hl)	
sub_c158h:
	call sub_c003h
	xor a	
	ld ix,0d04ah
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc167h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc189h
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc189h
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc189h
	push ix
	pop iy
	jr lc1cfh
lc189h:
	bit 3,(ix+002h)
	jr nz,lc19dh
	cp (ix+005h)
	jr z,lc196h
	jr nc,lc19dh
lc196h:
	push ix
	pop iy
	ld a,(ix+005h)
lc19dh:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc167h
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc1b9h
	cp e	
	call z,sub_c119h
lc1b9h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc1cfh:
	ld c,006h
	ld iy,0d04ah
	ld a,(ix+005h)
lc1d8h:
	cp (iy+005h)
	jr c,lc1e0h
	inc (iy+005h)
lc1e0h:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc1d8h
	ld (ix+005h),000h
	ret	
sub_c1edh:
	ld c,006h
	ld hl,0c44ah
	ld ix,0d04ah
	xor a	
lc1f7h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c210h
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc1f7h
	ret	
sub_c210h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c218h:
	ld h,0ffh
	call sub_c158h
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c130h
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c119h
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c210h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d09ah),hl
	ld hl,00000h
	ld (0d098h),hl
	ret	
sub_c254h:
	call sub_c003h
	ex de,hl	
lc258h:
	ld ix,0d0b0h
	ld a,014h
	ld iy,00000h
lc262h:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc2a5h
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc2a5h
	bit 3,(ix+040h)
	ret z	
	ld iy,0d098h
	ld c,000h
lc283h:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc29ah
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc29ah
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc258h
lc29ah:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc283h
	call sub_c119h
lc2a5h:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc2b0h
	push ix
	pop iy
lc2b0h:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc262h
	defb 0fdh,0bch	;cp iyh
	jr nz,lc2c4h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc2c4h
	ret	
lc2c4h:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c2fbh
	call sub_c2eah
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c210h
	push iy
	pop ix
	ret	
sub_c2eah:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c2fbh:
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
	call sub_c130h
	pop iy
	ret	
	xor a	
	dec (ix+045h)
	ret nz	
	ld (ix+040h),a
	ld (ix+043h),a
	ret	
sub_c323h:
	call sub_c003h
	xor a	
	cp h	
	jr nz,lc344h
	ld a,l	
	cp 012h
	jr nc,lc344h
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
lc344h:
	ret	
sub_c345h:
	call 0c358h
	ret	
lc349h:
	ld h,d	
	jp 0d628h
	ld d,a	
	jp 0c357h
	ld d,a	
	jp 0c357h
	ld d,a	
	jp 006c9h
	jr nz,lc399h
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d62ah
	call sub_c024h
	ld a,(0d628h)
	or a	
	jr z,lc373h
	ret	
lc373h:
	ld ix,0d62ah
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d628h),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc38ah
	ld a,003h
lc38ah:
	ld (0d62eh),a
	ld a,(ix+00ah)
	ld (0d62fh),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc399h:
	rlca	
	or (ix+004h)
	ld (0d630h),a
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
	ld (0d631h),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc3beh:
	jr z,lc3c7h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc3beh
lc3c7h:
	ld (0d633h),hl
	ld b,007h
	ld hl,0d62eh
lc3cfh:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc3cfh
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc373h
	xor a	
	ld (0d628h),a
	ld hl,0d62ah
	call sub_c04eh
	jr nz,lc373h
	ret	
lc3efh:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc3f9h:
	ld a,(bc)	
	dec c	
	nop	
lc3fch:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc403h
lc403h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
