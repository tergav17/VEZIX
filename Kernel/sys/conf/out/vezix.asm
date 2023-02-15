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
	ld sp,lc000h
	xor a	
	ld hl,0cf16h
	ld de,0c2bbh
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c10bh
	ld hl,lc2a0h
	call sub_c0c7h
	ld hl,lc2adh
	call sub_c0c7h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c0d4h
	ld hl,lc2aah
	call sub_c0c7h
	call sub_c1cbh
	call sub_c1f6h
	ld hl,lc2b4h
	call sub_c0c7h
	ld hl,00000h
	ld bc,00002h
	call sub_c114h
	ld h,(ix+007h)
	ld l,(ix+006h)
	call sub_c0d4h
	halt	
sub_c0c7h:
	call sub_c003h
lc0cah:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c101h
	inc hl	
	jr lc0cah
sub_c0d4h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c0f5h
	ld bc,0fc18h
	call sub_c0f5h
	ld bc,0ff9ch
	call sub_c0f5h
	ld bc,0fff6h
	call sub_c0f5h
	ld bc,0ffffh
	dec d	
sub_c0f5h:
	ld a,02fh
lc0f7h:
	inc a	
	add hl,bc	
	jr c,lc0f7h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c101h:
	in a,(010h)
	and 002h
	jr z,sub_c101h
	ld a,b	
	out (011h),a
	ret	
sub_c10bh:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c114h:
	call sub_c139h
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc1fah
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c138h
	pop ix
	ret	
sub_c138h:
	jp (hl)	
sub_c139h:
	call sub_c003h
	xor a	
	ld ix,0cebbh
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc148h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc16ah
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc16ah
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc16ah
	push ix
	pop iy
	jr lc1adh
lc16ah:
	bit 3,(ix+002h)
	jr nz,lc17eh
	cp (ix+005h)
	jr z,lc177h
	jr nc,lc17eh
lc177h:
	push ix
	pop iy
	ld a,(ix+005h)
lc17eh:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc148h
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc197h
	cp e	
lc197h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc1adh:
	ld c,006h
	ld iy,0cebbh
	ld a,(ix+005h)
lc1b6h:
	cp (iy+005h)
	jr c,lc1beh
	inc (iy+005h)
lc1beh:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc1b6h
	ld (ix+005h),000h
	ret	
sub_c1cbh:
	ld c,006h
	ld hl,0c2bbh
	ld ix,0cebbh
	xor a	
lc1d5h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c1eeh
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc1d5h
	ret	
sub_c1eeh:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c1f6h:
	call 0c209h
	ret	
lc1fah:
	inc de	
	jp nz,0cf09h
	ex af,af'	
	jp nz,0c208h
	ex af,af'	
	jp nz,0c208h
	ex af,af'	
	jp nz,006c9h
	jr nz,lc24ah
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0cf0bh
	call sub_c024h
	ld a,(0cf09h)
	or a	
	jr z,lc224h
	ret	
lc224h:
	ld ix,0cf0bh
	call sub_c012h
	ret z	
	ld a,001h
	ld (0cf09h),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc23bh
	ld a,003h
lc23bh:
	ld (0cf0fh),a
	ld a,(ix+00ah)
	ld (0cf10h),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc24ah:
	rlca	
	or (ix+004h)
	ld (0cf11h),a
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
	ld (0cf12h),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc26fh:
	jr z,lc278h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc26fh
lc278h:
	ld (0cf14h),hl
	ld b,007h
	ld hl,0cf0fh
lc280h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc280h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc224h
	xor a	
	ld (0cf09h),a
	ld hl,0cf0bh
	call sub_c04eh
	jr nz,lc224h
	ret	
lc2a0h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc2aah:
	ld a,(bc)	
	dec c	
	nop	
lc2adh:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc2b4h
lc2b4h:
	ld h,(hl)	
	ld l,h	
	ld h,c	
	ld h,a	
	ld a,(bc)	
	dec c	
	nop	
