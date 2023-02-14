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
sub_c063h:
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
	ld hl,0ceedh
	ld de,0c292h
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
	ld hl,lc27eh
	call sub_c0aeh
	ld hl,lc28bh
	call sub_c0aeh
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c0bbh
	ld hl,lc288h
	call sub_c0aeh
	call sub_c1aah
	call sub_c1d5h
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
	call sub_c118h
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc1d9h
	add hl,de	
	call sub_c117h
	ret	
sub_c117h:
	jp (hl)	
sub_c118h:
	call sub_c003h
	xor a	
	ld ix,0ce92h
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc127h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc149h
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc149h
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc149h
	push ix
	pop iy
	jr lc18ch
lc149h:
	bit 3,(ix+002h)
	jr nz,lc15dh
	cp (ix+005h)
	jr z,lc156h
	jr nc,lc15dh
lc156h:
	push ix
	pop iy
	ld a,(ix+005h)
lc15dh:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc127h
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc176h
	cp e	
lc176h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	ld (ix+002h),008h
lc18ch:
	ld c,006h
	ld iy,0ce92h
	ld a,(ix+005h)
lc195h:
	cp (iy+005h)
	jr c,lc19dh
	inc (iy+005h)
lc19dh:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc195h
	ld (ix+005h),000h
	ret	
sub_c1aah:
	ld c,006h
	ld hl,0c292h
	ld ix,0ce92h
	xor a	
lc1b4h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c1cdh
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc1b4h
	ret	
sub_c1cdh:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c1d5h:
	call sub_c1e8h
	ret	
lc1d9h:
	jp p,0e0c1h
	adc a,0e7h
	pop bc	
	rst 20h	
	pop bc	
	rst 20h	
	pop bc	
	rst 20h	
	pop bc	
	rst 20h	
	pop bc	
	ret	
sub_c1e8h:
	ld b,020h
	ld a,001h
lc1ech:
	out (0fdh),a
	dec b	
	jr nz,lc1ech
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0cee2h
	call sub_c024h
	ld a,(0cee0h)
	or a	
	jr z,lc203h
	ret	
lc203h:
	ld ix,0cee2h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0cee0h),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc21ah
	ld a,003h
lc21ah:
	ld (0cee6h),a
	ld a,(ix+00ah)
	ld (0cee7h),a
	ld a,(ix+008h)
	and 007h
	rlca	
	rlca	
	or (ix+004h)
	ld (0cee8h),a
	ld (ix+009h),h
	ld (ix+008h),l
	ld a,l	
	srl h
	rra	
	srl h
	rra	
	srl h
	rra	
	ld l,a	
	ld (0cee9h),hl
	ld (ix+007h),h
	ld (ix+006h),l
	ld a,(ix+004h)
	or a	
lc24eh:
	jr z,lc256h
	ld de,00080h
	add hl,de	
	jr lc24eh
lc256h:
	ld (0ceebh),hl
	ld b,007h
	ld hl,0cee6h
lc25eh:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc25eh
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc203h
	xor a	
	ld (0cee0h),a
	ld hl,0cee2h
	call sub_c04eh
	jr nz,lc203h
	ret	
lc27eh:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc288h:
	ld a,(bc)	
	dec c	
	nop	
lc28bh:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,$+2
