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
	ld sp,0c4c9h
	xor a	
	ld hl,0d6b4h
	ld de,0c489h
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c185h
	ld hl,lc46eh
	call sub_c133h
	ld hl,lc47bh
	call sub_c133h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c140h
	ld hl,lc478h
	call sub_c133h
	call sub_c24ah
	call sub_c3c4h
	call sub_c275h
	ld hl,00000h
	ld bc,00001h
	call sub_c2b1h
	defb 0ddh,054h	;ld d,ixh
	defb 0ddh,05dh	;ld e,ixl
	ex de,hl	
	ld bc,00046h
	call sub_c0e1h
	ld hl,00000h
	call sub_c380h
	ld b,h	
	ld c,l	
	ld hl,00000h
	call sub_c18eh
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld bc,00200h
	call sub_c0e1h
	halt	
sub_c0e1h:
	call sub_c003h
	ld d,b	
	ld e,c	
lc0e6h:
	ld c,010h
	ld b,00ah
	call sub_c16dh
	ld b,00dh
	call sub_c16dh
	push hl	
	call sub_c112h
	ld b,03ah
	call sub_c16dh
	pop hl	
lc0fch:
	ld b,020h
	call sub_c16dh
	push hl	
	ld h,(hl)	
	call sub_c118h
	pop hl	
	inc hl	
	dec de	
	ld a,d	
	or e	
	ret z	
	dec c	
	jr nz,lc0fch
	jr lc0e6h
	ret	
sub_c112h:
	push hl	
	call sub_c118h
	pop hl	
	ld h,l	
sub_c118h:
	call sub_c003h
	ld a,h	
	rra	
	rra	
	rra	
	rra	
	call sub_c124h
	ld a,h	
sub_c124h:
	and 00fh
	add a,030h
	cp 03ah
	jr c,lc12eh
	add a,027h
lc12eh:
	ld b,a	
	call sub_c16dh
	ret	
sub_c133h:
	call sub_c003h
lc136h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c16dh
	inc hl	
	jr lc136h
sub_c140h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c161h
	ld bc,0fc18h
	call sub_c161h
	ld bc,0ff9ch
	call sub_c161h
	ld bc,0fff6h
	call sub_c161h
	ld bc,0ffffh
	dec d	
sub_c161h:
	ld a,02fh
lc163h:
	inc a	
	add hl,bc	
	jr c,lc163h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c16dh:
	in a,(010h)
	and 002h
	jr z,sub_c16dh
	ld a,b	
	out (011h),a
	ret	
sub_c177h:
	ld hl,lc482h
	call sub_c133h
	pop hl	
	call sub_c140h
lc181h:
	di	
	halt	
	jr lc181h
sub_c185h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c18eh:
	call sub_c003h
	call sub_c1b5h
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc3c8h
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
sub_c1b5h:
	call sub_c003h
	xor a	
	ld ix,0d0c9h
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc1c4h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc1e6h
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc1e6h
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc1e6h
	push ix
	pop iy
	jr lc22ch
lc1e6h:
	bit 3,(ix+002h)
	jr nz,lc1fah
	cp (ix+005h)
	jr z,lc1f3h
	jr nc,lc1fah
lc1f3h:
	push ix
	pop iy
	ld a,(ix+005h)
lc1fah:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc1c4h
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc216h
	cp e	
	call z,sub_c177h
lc216h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc22ch:
	ld c,006h
	ld iy,0d0c9h
	ld a,(ix+005h)
lc235h:
	cp (iy+005h)
	jr c,lc23dh
	inc (iy+005h)
lc23dh:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc235h
	ld (ix+005h),000h
	ret	
sub_c24ah:
	ld c,006h
	ld hl,0c4c9h
	ld ix,0d0c9h
	xor a	
lc254h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c26dh
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc254h
	ret	
sub_c26dh:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c275h:
	ld h,0ffh
	call sub_c1b5h
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c18eh
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c177h
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c26dh
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d119h),hl
	ld hl,00000h
	ld (0d117h),hl
	ret	
sub_c2b1h:
	call sub_c003h
	ex de,hl	
lc2b5h:
	ld ix,0d12fh
	ld a,014h
	ld iy,00000h
lc2bfh:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc302h
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc302h
	bit 3,(ix+040h)
	ret z	
	ld iy,0d117h
	ld c,000h
lc2e0h:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc2f7h
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc2f7h
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc2b5h
lc2f7h:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc2e0h
	call sub_c177h
lc302h:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc30dh
	push ix
	pop iy
lc30dh:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc2bfh
	defb 0fdh,0bch	;cp iyh
	jr nz,lc321h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc321h
	ret	
lc321h:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c358h
	call sub_c347h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c26dh
	push iy
	pop ix
	ret	
sub_c347h:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c358h:
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
	call sub_c18eh
	pop iy
	ret	
	xor a	
	dec (ix+045h)
	ret nz	
	ld (ix+040h),a
	ld (ix+043h),a
	ret	
sub_c380h:
	call sub_c003h
	xor a	
	cp h	
	jr nz,lc39eh
	ld a,l	
	cp 012h
	jr nc,lc39eh
	sla l
	ld de,00018h
	add hl,de	
	defb 0ddh,054h	;ld d,ixh
	defb 0ddh,05dh	;ld e,ixl
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	or h	
	ret nz	
	ret	
lc39eh:
	ret	
	call sub_c003h
	ld (0d6a7h),hl
	call sub_c3b5h
	cp 02fh
	jr nz,lc3b2h
	ld hl,00000h
	ld bc,00001h
lc3b2h:
	call sub_c2b1h
sub_c3b5h:
	push hl	
	ld hl,(0d6a7h)
	call sub_c072h
	pop hl	
	ret	
	ld hl,(0d6a7h)
	ld a,(hl)	
	inc hl	
	ret	
sub_c3c4h:
	call sub_c3d7h
	ret	
lc3c8h:
	pop hl	
	jp 0d6a7h
	sub 0c3h
	sub 0c3h
	sub 0c3h
	sub 0c3h
	sub 0c3h
	ret	
sub_c3d7h:
	ld b,020h
	ld a,001h
lc3dbh:
	out (0fdh),a
	dec b	
	jr nz,lc3dbh
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d6a9h
	call sub_c024h
	ld a,(0d6a7h)
	or a	
	jr z,lc3f2h
	ret	
lc3f2h:
	ld ix,0d6a9h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d6a7h),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc409h
	ld a,003h
lc409h:
	ld (0d6adh),a
	ld a,(ix+00ah)
	ld (0d6aeh),a
	ld a,(ix+008h)
	and 007h
	rlca	
	rlca	
	or (ix+004h)
	ld (0d6afh),a
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
	ld (0d6b0h),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc43dh:
	jr z,lc446h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc43dh
lc446h:
	ld (0d6b2h),hl
	ld b,007h
	ld hl,0d6adh
lc44eh:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc44eh
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc3f2h
	xor a	
	ld (0d6a7h),a
	ld hl,0d6a9h
	call sub_c04eh
	jr nz,lc3f2h
	ret	
lc46eh:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc478h:
	ld a,(bc)	
	dec c	
	nop	
lc47bh:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc482h
lc482h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
