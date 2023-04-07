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
	ld sp,0c49ch
	xor a	
	ld hl,0d687h
	ld de,0c45ch
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c169h
	ld hl,lc441h
	call sub_c117h
	ld hl,lc44eh
	call sub_c117h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c124h
	ld hl,lc44bh
	call sub_c117h
	call sub_c22eh
	call sub_c386h
	call sub_c259h
	ld hl,00000h
	ld bc,00001h
	call sub_c295h
	ld hl,lc073h
	ld bc,00040h
	call sub_c0c5h
	halt	
sub_c0c5h:
	call sub_c003h
	ld d,b	
	ld e,c	
lc0cah:
	ld c,010h
	ld b,00ah
	call sub_c151h
	ld b,00dh
	call sub_c151h
	push hl	
	call sub_c0f6h
	ld b,03ah
	call sub_c151h
	pop hl	
lc0e0h:
	ld b,020h
	call sub_c151h
	push hl	
	ld h,(hl)	
	call sub_c0fch
	pop hl	
	inc hl	
	dec de	
	ld a,d	
	or e	
	ret z	
	dec c	
	jr nz,lc0e0h
	jr lc0cah
	ret	
sub_c0f6h:
	push hl	
	call sub_c0fch
	pop hl	
	ld h,l	
sub_c0fch:
	call sub_c003h
	ld a,h	
	rra	
	rra	
	rra	
	rra	
	call sub_c108h
	ld a,h	
sub_c108h:
	and 00fh
	add a,030h
	cp 03ah
	jr c,lc112h
	add a,027h
lc112h:
	ld b,a	
	call sub_c151h
	ret	
sub_c117h:
	call sub_c003h
lc11ah:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c151h
	inc hl	
	jr lc11ah
sub_c124h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c145h
	ld bc,0fc18h
	call sub_c145h
	ld bc,0ff9ch
	call sub_c145h
	ld bc,0fff6h
	call sub_c145h
	ld bc,0ffffh
	dec d	
sub_c145h:
	ld a,02fh
lc147h:
	inc a	
	add hl,bc	
	jr c,lc147h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c151h:
	in a,(010h)
	and 002h
	jr z,sub_c151h
	ld a,b	
	out (011h),a
	ret	
sub_c15bh:
	ld hl,lc455h
	call sub_c117h
	pop hl	
	call sub_c124h
lc165h:
	di	
	halt	
	jr lc165h
sub_c169h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c172h:
	call sub_c003h
	call sub_c199h
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,006h
	call sub_c063h
	ld de,0c39bh
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
sub_c199h:
	call sub_c003h
	xor a	
	ld ix,0d09ch
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc1a8h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc1cah
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc1cah
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc1cah
	push ix
	pop iy
	jr lc210h
lc1cah:
	bit 3,(ix+002h)
	jr nz,lc1deh
	cp (ix+005h)
	jr z,lc1d7h
	jr nc,lc1deh
lc1d7h:
	push ix
	pop iy
	ld a,(ix+005h)
lc1deh:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc1a8h
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc1fah
	cp e	
	call z,sub_c15bh
lc1fah:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc210h:
	ld c,006h
	ld iy,0d09ch
	ld a,(ix+005h)
lc219h:
	cp (iy+005h)
	jr c,lc221h
	inc (iy+005h)
lc221h:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc219h
	ld (ix+005h),000h
	ret	
sub_c22eh:
	ld c,006h
	ld hl,0c49ch
	ld ix,0d09ch
	xor a	
lc238h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c251h
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc238h
	ret	
sub_c251h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c259h:
	ld h,0ffh
	call sub_c199h
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c172h
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c15bh
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c251h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d0ech),hl
	ld hl,00000h
	ld (0d0eah),hl
	ret	
sub_c295h:
	call sub_c003h
	ex de,hl	
lc299h:
	ld ix,0d102h
	ld a,014h
	ld iy,00000h
lc2a3h:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc2e6h
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc2e6h
	bit 3,(ix+040h)
	ret z	
	ld iy,0d0eah
	ld c,000h
lc2c4h:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc2dbh
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc2dbh
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc299h
lc2dbh:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc2c4h
	call sub_c15bh
lc2e6h:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc2f1h
	push ix
	pop iy
lc2f1h:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc2a3h
	defb 0fdh,0bch	;cp iyh
	jr nz,lc305h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc305h
	ret	
lc305h:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c33ch
	call sub_c32bh
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c251h
	push iy
	pop ix
	ret	
sub_c32bh:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c33ch:
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
	call sub_c172h
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
	jr nz,lc385h
	ld a,l	
	cp 012h
	jr nc,lc385h
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
lc385h:
	ret	
sub_c386h:
	ld hl,lc399h
	ld b,001h
lc38bh:
	push hl	
	push bc	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	call sub_c072h
	pop bc	
	pop hl	
	djnz lc38bh
	ret	
lc399h:
	xor d	
	jp lc3b4h
	ld a,d	
	sub 0a9h
	jp 0c3a9h
	xor c	
	jp 0c3a9h
	xor c	
	jp 006c9h
	jr nz,lc3ebh
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
lc3b4h:
	xor a	
	ld (ix+004h),a
	ld hl,0d67ch
	call sub_c024h
	ld a,(0d67ah)
	or a	
	jr z,lc3c5h
	ret	
lc3c5h:
	ld ix,0d67ch
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d67ah),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc3dch
	ld a,003h
lc3dch:
	ld (0d680h),a
	ld a,(ix+00ah)
	ld (0d681h),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc3ebh:
	rlca	
	or (ix+004h)
	ld (0d682h),a
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
	ld (0d683h),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc410h:
	jr z,lc419h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc410h
lc419h:
	ld (0d685h),hl
	ld b,007h
	ld hl,0d680h
lc421h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc421h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc3c5h
	xor a	
	ld (0d67ah),a
	ld hl,0d67ch
	call sub_c04eh
	jr nz,lc3c5h
	ret	
lc441h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc44bh:
	ld a,(bc)	
	dec c	
	nop	
lc44eh:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc455h
lc455h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
