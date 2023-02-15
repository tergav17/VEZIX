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
	ld hl,0cf21h
	ld de,0c2c6h
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c116h
	ld hl,lc2abh
	call sub_c0d2h
	ld hl,lc2b8h
	call sub_c0d2h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c0dfh
	ld hl,lc2b5h
	call sub_c0d2h
	call sub_c1d6h
	call sub_c201h
	ld hl,lc2bfh
	call sub_c0d2h
	ld hl,00000h
	ld bc,00002h
	call sub_c11fh
	call sub_c1f9h
	ld hl,00000h
	ld bc,00002h
	call sub_c144h
	ld h,000h
	ld l,(ix+003h)
	call sub_c0dfh
	halt	
sub_c0d2h:
	call sub_c003h
lc0d5h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c10ch
	inc hl	
	jr lc0d5h
sub_c0dfh:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c100h
	ld bc,0fc18h
	call sub_c100h
	ld bc,0ff9ch
	call sub_c100h
	ld bc,0fff6h
	call sub_c100h
	ld bc,0ffffh
	dec d	
sub_c100h:
	ld a,02fh
lc102h:
	inc a	
	add hl,bc	
	jr c,lc102h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c10ch:
	in a,(010h)
	and 002h
	jr z,sub_c10ch
	ld a,b	
	out (011h),a
	ret	
sub_c116h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c11fh:
	call sub_c144h
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc205h
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
	ld ix,0cec6h
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
	jr lc1b8h
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
	jr nz,lc1a2h
	cp e	
lc1a2h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc1b8h:
	ld c,006h
	ld iy,0cec6h
	ld a,(ix+005h)
lc1c1h:
	cp (iy+005h)
	jr c,lc1c9h
	inc (iy+005h)
lc1c9h:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc1c1h
	ld (ix+005h),000h
	ret	
sub_c1d6h:
	ld c,006h
	ld hl,0c2c6h
	ld ix,0cec6h
	xor a	
lc1e0h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c1f9h
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc1e0h
	ret	
sub_c1f9h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c201h:
	call 0c214h
	ret	
lc205h:
	ld e,0c2h
	inc d	
	rst 8	
	inc de	
	jp nz,0c213h
	inc de	
	jp nz,0c213h
	inc de	
	jp nz,006c9h
	jr nz,lc255h
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0cf16h
	call sub_c024h
	ld a,(0cf14h)
	or a	
	jr z,lc22fh
	ret	
lc22fh:
	ld ix,0cf16h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0cf14h),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc246h
	ld a,003h
lc246h:
	ld (0cf1ah),a
	ld a,(ix+00ah)
	ld (0cf1bh),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc255h:
	rlca	
	or (ix+004h)
	ld (0cf1ch),a
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
	ld (0cf1dh),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc27ah:
	jr z,lc283h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc27ah
lc283h:
	ld (0cf1fh),hl
	ld b,007h
	ld hl,0cf1ah
lc28bh:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc28bh
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc22fh
	xor a	
	ld (0cf14h),a
	ld hl,0cf16h
	call sub_c04eh
	jr nz,lc22fh
	ret	
lc2abh:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc2b5h:
	ld a,(bc)	
	dec c	
	nop	
lc2b8h:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc2bfh
lc2bfh:
	ld h,(hl)	
	ld l,h	
	ld h,c	
	ld h,a	
	ld a,(bc)	
	dec c	
	nop	
