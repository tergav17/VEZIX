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
	ld sp,0c5f7h
	xor a	
	ld hl,0d7e3h
	ld de,0c589h
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c157h
	ld hl,lc564h
	call sub_c105h
	ld hl,lc571h
	call sub_c105h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c112h
	ld hl,lc56eh
	call sub_c105h
	call sub_c229h
	call sub_c4bah
	call sub_c254h
	halt	
	call sub_c003h
	ld d,b	
	ld e,c	
lc0b8h:
	ld c,010h
	ld b,00ah
	call sub_c13fh
	ld b,00dh
	call sub_c13fh
	push hl	
	call sub_c0e4h
	ld b,03ah
	call sub_c13fh
	pop hl	
lc0ceh:
	ld b,020h
	call sub_c13fh
	push hl	
	ld h,(hl)	
	call sub_c0eah
	pop hl	
	inc hl	
	dec de	
	ld a,d	
	or e	
	ret z	
	dec c	
	jr nz,lc0ceh
	jr lc0b8h
	ret	
sub_c0e4h:
	push hl	
	call sub_c0eah
	pop hl	
	ld h,l	
sub_c0eah:
	call sub_c003h
	ld a,h	
	rra	
	rra	
	rra	
	rra	
	call sub_c0f6h
	ld a,h	
sub_c0f6h:
	and 00fh
	add a,030h
	cp 03ah
	jr c,lc100h
	add a,027h
lc100h:
	ld b,a	
	call sub_c13fh
	ret	
sub_c105h:
	call sub_c003h
lc108h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c13fh
	inc hl	
	jr lc108h
sub_c112h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c133h
	ld bc,0fc18h
	call sub_c133h
	ld bc,0ff9ch
	call sub_c133h
	ld bc,0fff6h
	call sub_c133h
	ld bc,0ffffh
	dec d	
sub_c133h:
	ld a,02fh
lc135h:
	inc a	
	add hl,bc	
	jr c,lc135h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c13fh:
	in a,(010h)
	and 002h
	jr z,sub_c13fh
	ld a,b	
	out (011h),a
	ret	
sub_c149h:
	ld hl,lc582h
	call sub_c105h
	pop hl	
	call sub_c112h
lc153h:
	di	
	halt	
	jr lc153h
sub_c157h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c160h:
	call sub_c003h
	call sub_c194h
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
lc16fh:
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc4beh
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
	call sub_c003h
	res 1,(ix+002h)
	res 0,(ix+002h)
	jr lc16fh
sub_c194h:
	call sub_c003h
	xor a	
	ld ix,0d1f7h
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc1a3h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc1c5h
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc1c5h
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc1c5h
	push ix
	pop iy
	jr lc20bh
lc1c5h:
	bit 3,(ix+002h)
	jr nz,lc1d9h
	cp (ix+005h)
	jr z,lc1d2h
	jr nc,lc1d9h
lc1d2h:
	push ix
	pop iy
	ld a,(ix+005h)
lc1d9h:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc1a3h
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc1f5h
	cp e	
	call z,sub_c149h
lc1f5h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc20bh:
	ld c,006h
	ld iy,0d1f7h
	ld a,(ix+005h)
lc214h:
	cp (iy+005h)
	jr c,lc21ch
	inc (iy+005h)
lc21ch:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc214h
	ld (ix+005h),000h
	ret	
sub_c229h:
	ld c,006h
	ld hl,0c5f7h
	ld ix,0d1f7h
	xor a	
lc233h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c24ch
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc233h
	ret	
sub_c24ch:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c254h:
	ld h,0ffh
	call sub_c194h
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c160h
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c149h
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c24ch
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d247h),hl
	ld hl,00000h
	ld (0d245h),hl
	ret	
sub_c290h:
	call sub_c003h
	ex de,hl	
lc294h:
	ld ix,0d25dh
	ld a,014h
	ld iy,00000h
lc29eh:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc2e1h
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc2e1h
	bit 3,(ix+040h)
	ret z	
	ld iy,0d245h
	ld c,000h
lc2bfh:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc2d6h
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc2d6h
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc294h
lc2d6h:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc2bfh
	call sub_c149h
lc2e1h:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc2ech
	push ix
	pop iy
lc2ech:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc29eh
	defb 0fdh,0bch	;cp iyh
	jr nz,lc305h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc305h
	ld a,017h
	ld (0c589h),a
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
	call sub_c24ch
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
	call sub_c160h
	pop iy
	ret	
sub_c358h:
	xor a	
	dec (ix+045h)
	ret nz	
	ld (ix+040h),a
	ld (ix+043h),a
	ret	
sub_c364h:
	call sub_c003h
	xor a	
	cp h	
	jr nz,lc382h
	ld a,l	
	cp 012h
	jr nc,lc382h
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
lc382h:
	ret	
	call sub_c003h
	ld (0c5b1h),hl
	ld hl,(0c590h)
	ld b,h	
	ld c,l	
	ld hl,(0c58eh)
	call sub_c47dh
	cp 02fh
	jr nz,lc39eh
	ld hl,00000h
	ld bc,00001h
lc39eh:
	call sub_c290h
lc3a1h:
	jr nz,lc3aah
	call sub_c47dh
	cp 02fh
	jr lc3a1h
lc3aah:
	ld a,(0c589h)
	or a	
	jr z,lc3b8h
lc3b0h:
	call sub_c358h
	ld ix,00000h
	ret	
lc3b8h:
	cp e	
	ret z	
	ld a,(ix+001h)
	and 060h
	xor 040h
	jr z,lc3cah
	ld a,014h
	ld (0c589h),a
	jr lc3b0h
lc3cah:
	ld hl,0c592h
	ld b,020h
	ld a,e	
lc3d0h:
	cp 02fh
	jr z,lc3e3h
	or a	
	jr z,lc3e3h
	xor a	
	cp b	
	jr z,lc3deh
	ld (hl),e	
	inc hl	
	dec b	
lc3deh:
	call sub_c47dh
	jr lc3d0h
lc3e3h:
	xor a	
	ld (hl),a	
	ld a,e	
lc3e6h:
	cp 02fh
	jr nz,lc3efh
	call sub_c47dh
	jr lc3e6h
lc3efh:
	ld h,(ix+009h)
	ld l,(ix+008h)
	xor a	
	add hl,hl	
	rla	
	add hl,hl	
	rla	
	add hl,hl	
	rla	
	ld l,h	
	ld h,a	
	ld (0c5b3h),hl
	ld hl,00000h
lc404h:
	push hl	
	push ix
	call sub_c364h
	ld b,h	
	ld c,l	
	ld h,(ix+042h)
	ld l,(ix+041h)
	call sub_c160h
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld d,010h
lc41dh:
	push hl	
	ld hl,(0c5b3h)
	ld a,h	
	or l	
	jr z,lc46eh
	dec hl	
	ld (0c5b3h),hl
	pop hl	
	push hl	
	inc hl	
	inc hl	
	ld bc,0c592h
	ld a,01eh
lc432h:
	ex af,af'	
	ld a,(bc)	
	cp (hl)	
	jr nz,lc442h
	or a	
	jr z,lc453h
	ex af,af'	
	dec a	
	jr z,lc453h
	inc hl	
	inc bc	
	jr lc432h
lc442h:
	pop hl	
	ld bc,00020h
	add hl,bc	
	dec d	
	jr nz,lc41dh
	call sub_c24ch
	pop ix
	pop hl	
	inc hl	
	jr lc404h
lc453h:
	pop hl	
	ld c,(hl)	
	inc hl	
	ld b,(hl)	
	call sub_c24ch
	pop ix
	pop hl	
	ld h,(ix+042h)
	ld l,(ix+041h)
	push hl	
	call sub_c358h
	pop hl	
	call sub_c290h
	jp lc3aah
lc46eh:
	pop hl	
	call sub_c24ch
	pop ix
	pop hl	
	ld a,002h
	ld (0c589h),a
	jp lc3b0h
sub_c47dh:
	push hl	
	ld hl,(0c5b1h)
	call sub_c072h
	pop hl	
	ld e,a	
	ret	
	push hl	
	ld hl,(0c58ah)
	ld a,(hl)	
	inc hl	
	ld (0c58ah),hl
	pop hl	
	ret	
	call sub_c003h
lc495h:
	ld a,(0d7d5h)
	or a	
	jr z,sub_c4bah
	jr lc495h
	inc a	
	ld (0d7d5h),a
	push ix
	ld hl,0ffffh
	call sub_c194h
	ld (0c5b3h),ix
	pop ix
	call sub_c358h
	ld ix,(0c5b3h)
	call sub_c24ch
	ret	
sub_c4bah:
	call 0c4cdh
	ret	
lc4beh:
	rst 10h	
	call nz,0d7d6h
	call z,0ccc4h
	call nz,0c4cch
	call z,0ccc4h
	call nz,006c9h
	jr nz,lc50eh
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d7d8h
	call sub_c024h
	ld a,(0d7d6h)
	or a	
	jr z,lc4e8h
	ret	
lc4e8h:
	ld ix,0d7d8h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d7d6h),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc4ffh
	ld a,003h
lc4ffh:
	ld (0d7dch),a
	ld a,(ix+00ah)
	ld (0d7ddh),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc50eh:
	rlca	
	or (ix+004h)
	ld (0d7deh),a
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
	ld (0d7dfh),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc533h:
	jr z,lc53ch
	ld de,00080h
	add hl,de	
	dec a	
	jr lc533h
lc53ch:
	ld (0d7e1h),hl
	ld b,007h
	ld hl,0d7dch
lc544h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc544h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc4e8h
	xor a	
	ld (0d7d6h),a
	ld hl,0d7d8h
	call sub_c04eh
	jr nz,lc4e8h
	ret	
lc564h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc56eh:
	ld a,(bc)	
	dec c	
	nop	
lc571h:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc578h
lc578h:
	cpl	
	ld h,l	
	ld (hl),h	
	ld h,e	
	cpl	
	ld l,c	
	ld l,(hl)	
	ld l,c	
	ld (hl),h	
	nop	
lc582h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
