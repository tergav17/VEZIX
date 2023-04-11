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
	ld sp,0c48dh
	xor a	
	ld hl,0d678h
	ld de,0c44dh
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c16bh
	ld hl,lc432h
	call sub_c119h
	ld hl,lc43fh
	call sub_c119h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c126h
	ld hl,lc43ch
	call sub_c119h
	call sub_c230h
	call sub_c388h
	call sub_c25bh
	ld hl,00000h
	ld bc,00001h
	call sub_c297h
	defb 0ddh,054h	;ld d,ixh
	defb 0ddh,05dh	;ld e,ixl
	ex de,hl	
	ld bc,00046h
	call sub_c0c7h
	halt	
sub_c0c7h:
	call sub_c003h
	ld d,b	
	ld e,c	
lc0cch:
	ld c,010h
	ld b,00ah
	call sub_c153h
	ld b,00dh
	call sub_c153h
	push hl	
	call sub_c0f8h
	ld b,03ah
	call sub_c153h
	pop hl	
lc0e2h:
	ld b,020h
	call sub_c153h
	push hl	
	ld h,(hl)	
	call sub_c0feh
	pop hl	
	inc hl	
	dec de	
	ld a,d	
	or e	
	ret z	
	dec c	
	jr nz,lc0e2h
	jr lc0cch
	ret	
sub_c0f8h:
	push hl	
	call sub_c0feh
	pop hl	
	ld h,l	
sub_c0feh:
	call sub_c003h
	ld a,h	
	rra	
	rra	
	rra	
	rra	
	call sub_c10ah
	ld a,h	
sub_c10ah:
	and 00fh
	add a,030h
	cp 03ah
	jr c,lc114h
	add a,027h
lc114h:
	ld b,a	
	call sub_c153h
	ret	
sub_c119h:
	call sub_c003h
lc11ch:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c153h
	inc hl	
	jr lc11ch
sub_c126h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c147h
	ld bc,0fc18h
	call sub_c147h
	ld bc,0ff9ch
	call sub_c147h
	ld bc,0fff6h
	call sub_c147h
	ld bc,0ffffh
	dec d	
sub_c147h:
	ld a,02fh
lc149h:
	inc a	
	add hl,bc	
	jr c,lc149h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c153h:
	in a,(010h)
	and 002h
	jr z,sub_c153h
	ld a,b	
	out (011h),a
	ret	
sub_c15dh:
	ld hl,lc446h
	call sub_c119h
	pop hl	
	call sub_c126h
lc167h:
	di	
	halt	
	jr lc167h
sub_c16bh:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c174h:
	call sub_c003h
	call sub_c19bh
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc38ch
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
sub_c19bh:
	call sub_c003h
	xor a	
	ld ix,0d08dh
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc1aah:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc1cch
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc1cch
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc1cch
	push ix
	pop iy
	jr lc212h
lc1cch:
	bit 3,(ix+002h)
	jr nz,lc1e0h
	cp (ix+005h)
	jr z,lc1d9h
	jr nc,lc1e0h
lc1d9h:
	push ix
	pop iy
	ld a,(ix+005h)
lc1e0h:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc1aah
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc1fch
	cp e	
	call z,sub_c15dh
lc1fch:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc212h:
	ld c,006h
	ld iy,0d08dh
	ld a,(ix+005h)
lc21bh:
	cp (iy+005h)
	jr c,lc223h
	inc (iy+005h)
lc223h:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc21bh
	ld (ix+005h),000h
	ret	
sub_c230h:
	ld c,006h
	ld hl,0c48dh
	ld ix,0d08dh
	xor a	
lc23ah:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c253h
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc23ah
	ret	
sub_c253h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c25bh:
	ld h,0ffh
	call sub_c19bh
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c174h
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c15dh
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c253h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d0ddh),hl
	ld hl,00000h
	ld (0d0dbh),hl
	ret	
sub_c297h:
	call sub_c003h
	ex de,hl	
lc29bh:
	ld ix,0d0f3h
	ld a,014h
	ld iy,00000h
lc2a5h:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc2e8h
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc2e8h
	bit 3,(ix+040h)
	ret z	
	ld iy,0d0dbh
	ld c,000h
lc2c6h:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc2ddh
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc2ddh
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc29bh
lc2ddh:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc2c6h
	call sub_c15dh
lc2e8h:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc2f3h
	push ix
	pop iy
lc2f3h:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc2a5h
	defb 0fdh,0bch	;cp iyh
	jr nz,lc307h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc307h
	ret	
lc307h:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c33eh
	call sub_c32dh
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c253h
	push iy
	pop ix
	ret	
sub_c32dh:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c33eh:
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
	call sub_c174h
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
	jr nz,lc387h
	ld a,l	
	cp 012h
	jr nc,lc387h
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
lc387h:
	ret	
sub_c388h:
	call 0c39bh
	ret	
lc38ch:
	and l	
	jp 0d66bh
	sbc a,d	
	jp 0c39ah
	sbc a,d	
	jp 0c39ah
	sbc a,d	
	jp 006c9h
	jr nz,lc3dch
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d66dh
	call sub_c024h
	ld a,(0d66bh)
	or a	
	jr z,lc3b6h
	ret	
lc3b6h:
	ld ix,0d66dh
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d66bh),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc3cdh
	ld a,003h
lc3cdh:
	ld (0d671h),a
	ld a,(ix+00ah)
	ld (0d672h),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc3dch:
	rlca	
	or (ix+004h)
	ld (0d673h),a
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
	ld (0d674h),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc401h:
	jr z,lc40ah
	ld de,00080h
	add hl,de	
	dec a	
	jr lc401h
lc40ah:
	ld (0d676h),hl
	ld b,007h
	ld hl,0d671h
lc412h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc412h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc3b6h
	xor a	
	ld (0d66bh),a
	ld hl,0d66dh
	call sub_c04eh
	jr nz,lc3b6h
	ret	
lc432h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc43ch:
	ld a,(bc)	
	dec c	
	nop	
lc43fh:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc446h
lc446h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
