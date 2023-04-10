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
	ld sp,0c49fh
	xor a	
	ld hl,0d68ah
	ld de,0c45fh
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c16ch
	ld hl,lc444h
	call sub_c11ah
	ld hl,lc451h
	call sub_c11ah
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c127h
	ld hl,lc44eh
	call sub_c11ah
	call sub_c231h
	call sub_c389h
	call sub_c25ch
	ld hl,00000h
	ld bc,00001h
	call sub_c175h
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld bc,00040h
	call sub_c0c8h
	halt	
sub_c0c8h:
	call sub_c003h
	ld d,b	
	ld e,c	
lc0cdh:
	ld c,010h
	ld b,00ah
	call sub_c154h
	ld b,00dh
	call sub_c154h
	push hl	
	call sub_c0f9h
	ld b,03ah
	call sub_c154h
	pop hl	
lc0e3h:
	ld b,020h
	call sub_c154h
	push hl	
	ld h,(hl)	
	call sub_c0ffh
	pop hl	
	inc hl	
	dec de	
	ld a,d	
	or e	
	ret z	
	dec c	
	jr nz,lc0e3h
	jr lc0cdh
	ret	
sub_c0f9h:
	push hl	
	call sub_c0ffh
	pop hl	
	ld h,l	
sub_c0ffh:
	call sub_c003h
	ld a,h	
	rra	
	rra	
	rra	
	rra	
	call sub_c10bh
	ld a,h	
sub_c10bh:
	and 00fh
	add a,030h
	cp 03ah
	jr c,lc115h
	add a,027h
lc115h:
	ld b,a	
	call sub_c154h
	ret	
sub_c11ah:
	call sub_c003h
lc11dh:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c154h
	inc hl	
	jr lc11dh
sub_c127h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c148h
	ld bc,0fc18h
	call sub_c148h
	ld bc,0ff9ch
	call sub_c148h
	ld bc,0fff6h
	call sub_c148h
	ld bc,0ffffh
	dec d	
sub_c148h:
	ld a,02fh
lc14ah:
	inc a	
	add hl,bc	
	jr c,lc14ah
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c154h:
	in a,(010h)
	and 002h
	jr z,sub_c154h
	ld a,b	
	out (011h),a
	ret	
sub_c15eh:
	ld hl,lc458h
	call sub_c11ah
	pop hl	
	call sub_c127h
lc168h:
	di	
	halt	
	jr lc168h
sub_c16ch:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c175h:
	call sub_c003h
	call sub_c19ch
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,006h
	call sub_c063h
	ld de,0c39eh
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
sub_c19ch:
	call sub_c003h
	xor a	
	ld ix,0d09fh
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc1abh:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc1cdh
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc1cdh
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc1cdh
	push ix
	pop iy
	jr lc213h
lc1cdh:
	bit 3,(ix+002h)
	jr nz,lc1e1h
	cp (ix+005h)
	jr z,lc1dah
	jr nc,lc1e1h
lc1dah:
	push ix
	pop iy
	ld a,(ix+005h)
lc1e1h:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc1abh
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc1fdh
	cp e	
	call z,sub_c15eh
lc1fdh:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc213h:
	ld c,006h
	ld iy,0d09fh
	ld a,(ix+005h)
lc21ch:
	cp (iy+005h)
	jr c,lc224h
	inc (iy+005h)
lc224h:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc21ch
	ld (ix+005h),000h
	ret	
sub_c231h:
	ld c,006h
	ld hl,0c49fh
	ld ix,0d09fh
	xor a	
lc23bh:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c254h
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc23bh
	ret	
sub_c254h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c25ch:
	ld h,0ffh
	call sub_c19ch
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c175h
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c15eh
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c254h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d0efh),hl
	ld hl,00000h
	ld (0d0edh),hl
	ret	
	call sub_c003h
	ex de,hl	
lc29ch:
	ld ix,0d105h
	ld a,014h
	ld iy,00000h
lc2a6h:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc2e9h
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc2e9h
	bit 3,(ix+040h)
	ret z	
	ld iy,0d0edh
	ld c,000h
lc2c7h:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc2deh
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc2deh
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc29ch
lc2deh:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc2c7h
	call sub_c15eh
lc2e9h:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc2f4h
	push ix
	pop iy
lc2f4h:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc2a6h
	defb 0fdh,0bch	;cp iyh
	jr nz,lc308h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc308h
	ret	
lc308h:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c33fh
	call sub_c32eh
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c254h
	push iy
	pop ix
	ret	
sub_c32eh:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c33fh:
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
	call sub_c175h
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
	jr nz,lc388h
	ld a,l	
	cp 012h
	jr nc,lc388h
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
lc388h:
	ret	
sub_c389h:
	ld hl,lc39ch
	ld b,001h
lc38eh:
	push hl	
	push bc	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	call sub_c072h
	pop bc	
	pop hl	
	djnz lc38eh
	ret	
lc39ch:
	xor l	
	jp lc3b7h
	ld a,l	
	sub 0ach
	jp 0c3ach
	xor h	
	jp 0c3ach
	xor h	
	jp 006c9h
	jr nz,lc3eeh
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
lc3b7h:
	xor a	
	ld (ix+004h),a
	ld hl,0d67fh
	call sub_c024h
	ld a,(0d67dh)
	or a	
	jr z,lc3c8h
	ret	
lc3c8h:
	ld ix,0d67fh
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d67dh),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc3dfh
	ld a,003h
lc3dfh:
	ld (0d683h),a
	ld a,(ix+00ah)
	ld (0d684h),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc3eeh:
	rlca	
	or (ix+004h)
	ld (0d685h),a
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
	ld (0d686h),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc413h:
	jr z,lc41ch
	ld de,00080h
	add hl,de	
	dec a	
	jr lc413h
lc41ch:
	ld (0d688h),hl
	ld b,007h
	ld hl,0d683h
lc424h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc424h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc3c8h
	xor a	
	ld (0d67dh),a
	ld hl,0d67fh
	call sub_c04eh
	jr nz,lc3c8h
	ret	
lc444h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc44eh:
	ld a,(bc)	
	dec c	
	nop	
lc451h:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc458h
lc458h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
