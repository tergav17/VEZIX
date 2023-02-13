; z80dasm 1.1.6
; command line: z80dasm -l -g 0xC000 -o vezix.asm vezix

	org	0c000h

lc000h:
	jp lc071h
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
	jr nz,lc068h
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
	push bc	
	ld d,c	
	ld l,d	
	ld b,008h
lc068h:
	add hl,hl	
	jp nc,lc06dh
	add hl,de	
lc06dh:
	djnz lc068h
	pop bc	
	ret	
lc071h:
	ld sp,lc000h
	xor a	
	ld hl,0ce80h
	ld de,0c232h
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c0f2h
	ld hl,lc21eh
	call sub_c0aeh
	ld hl,lc22bh
	call sub_c0aeh
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c0bbh
	ld hl,lc228h
	call sub_c0aeh
	call sub_c18dh
	call sub_c1b0h
	halt	
sub_c0aeh:
	call sub_c003h
lc0b1h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c0e8h
	inc hl	
	jr lc0b1h
sub_c0bbh:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c0dch
	ld bc,0fc18h
	call sub_c0dch
	ld bc,0ff9ch
	call sub_c0dch
	ld bc,0fff6h
	call sub_c0dch
	ld bc,0ffffh
	dec d	
sub_c0dch:
	ld a,02fh
lc0deh:
	inc a	
	add hl,bc	
	jr c,lc0deh
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c0e8h:
	in a,(010h)
	and 002h
	jr z,sub_c0e8h
	ld a,b	
	out (011h),a
	ret	
sub_c0f2h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
	call sub_c003h
	xor a	
	ld ix,0ce32h
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc10ah:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc12ch
	ld h,(ix+00ah)
	ld l,(ix+009h)
	or a	
	sbc hl,de
	jr nz,lc12ch
	ld h,(ix+008h)
	ld l,(ix+007h)
	or a	
	sbc hl,bc
	jr nz,lc12ch
	push ix
	pop iy
	jr lc14ah
lc12ch:
	bit 3,(ix+002h)
	jr nz,lc140h
	cp (ix+004h)
	jr z,lc139h
	jr nc,lc140h
lc139h:
	push ix
	pop iy
	ld a,(ix+004h)
lc140h:
	ld hl,0000ch
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc10ah
lc14ah:
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc159h
	cp e	
lc159h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00ah),h
	ld (ix+009h),l
	pop hl	
	ld (ix+00ah),h
	ld (ix+009h),l
	ld (ix+002h),008h
	ld c,006h
	ld iy,0ce32h
	ld a,(ix+004h)
lc178h:
	cp (iy+004h)
	jr c,lc180h
	inc (iy+004h)
lc180h:
	ld de,0000ch
	add iy,de
	dec c	
	jr nz,lc178h
	ld (ix+004h),000h
	ret	
sub_c18dh:
	ld c,006h
	ld hl,0c232h
	ld ix,0ce32h
	xor a	
lc197h:
	ld (ix+006h),h
	ld (ix+005h),l
	ld (ix+003h),c
	call sub_c1ddh
	ld de,0000ch
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc197h
	ret	
sub_c1b0h:
	ld a,001h
	ld bc,lc1e7h
lc1b5h:
	call sub_c1d3h
	ld hl,00004h
	add hl,bc	
	ld b,h	
	ld c,l	
	dec a	
	jr nz,lc1b5h
	ld a,001h
	ld bc,lc1e9h
lc1c6h:
	call sub_c1d3h
	ld hl,0000ch
	add hl,bc	
	ld b,h	
	ld c,l	
	dec a	
	jr nz,lc1c6h
	ret	
sub_c1d3h:
	call sub_c003h
	ld h,b	
	ld l,c	
	ld d,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,d	
	jp (hl)	
sub_c1ddh:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
	rst 30h	
	pop bc	
lc1e7h:
	or 0c1h
lc1e9h:
	push af	
	pop bc	
	push af	
	pop bc	
	push af	
	pop bc	
	push af	
	pop bc	
	push af	
	pop bc	
	push af	
	pop bc	
	ret	
	ret	
	ld hl,0ce7ch
	call sub_c024h
	ld a,(0ce7ah)
	or a	
	jr z,lc204h
	ret	
lc204h:
	ld ix,0ce7ch
	call sub_c012h
	ret z	
	ld a,001h
	ld (0ce7ah),a
	xor a	
	ld (0ce7ah),a
	ld hl,0ce7ch
	call sub_c04eh
	jr nz,lc204h
	ret	
lc21eh:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc228h:
	ld a,(bc)	
	dec c	
	nop	
lc22bh:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,$+2
