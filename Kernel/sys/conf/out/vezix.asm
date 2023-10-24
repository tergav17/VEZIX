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
	ld sp,0c77fh
	xor a	
	ld hl,0d96bh
	ld de,0c6eah
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c16dh
	ld hl,lc6c5h
	call sub_c11bh
	ld hl,lc6d2h
	call sub_c11bh
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c128h
	ld hl,lc6cfh
	call sub_c11bh
	call sub_c242h
	call sub_c61eh
	call sub_c274h
	ld hl,lc6d9h
	ld (0c6ebh),hl
	ld hl,lc4a1h
	call sub_c3a0h
	ld a,(0c6eah)
	or a	
	jp nz,lc15fh
	call sub_c4b9h
	halt	
	call sub_c003h
	ld d,b	
	ld e,c	
lc0ceh:
	ld c,010h
	ld b,00ah
	call sub_c155h
	ld b,00dh
	call sub_c155h
	push hl	
	call sub_c0fah
	ld b,03ah
	call sub_c155h
	pop hl	
lc0e4h:
	ld b,020h
	call sub_c155h
	push hl	
	ld h,(hl)	
	call sub_c100h
	pop hl	
	inc hl	
	dec de	
	ld a,d	
	or e	
	ret z	
	dec c	
	jr nz,lc0e4h
	jr lc0ceh
	ret	
sub_c0fah:
	push hl	
	call sub_c100h
	pop hl	
	ld h,l	
sub_c100h:
	call sub_c003h
	ld a,h	
	rra	
	rra	
	rra	
	rra	
	call sub_c10ch
	ld a,h	
sub_c10ch:
	and 00fh
	add a,030h
	cp 03ah
	jr c,lc116h
	add a,027h
lc116h:
	ld b,a	
	call sub_c155h
	ret	
sub_c11bh:
	call sub_c003h
lc11eh:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c155h
	inc hl	
	jr lc11eh
sub_c128h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c149h
	ld bc,0fc18h
	call sub_c149h
	ld bc,0ff9ch
	call sub_c149h
	ld bc,0fff6h
	call sub_c149h
	ld bc,0ffffh
	dec d	
sub_c149h:
	ld a,02fh
lc14bh:
	inc a	
	add hl,bc	
	jr c,lc14bh
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c155h:
	in a,(010h)
	and 002h
	jr z,sub_c155h
	ld a,b	
	out (011h),a
	ret	
lc15fh:
	ld hl,lc6e3h
	call sub_c11bh
	pop hl	
	call sub_c128h
lc169h:
	di	
	halt	
	jr lc169h
sub_c16dh:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c176h:
	call sub_c003h
	call sub_c1aah
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
lc185h:
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc622h
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
sub_c19dh:
	call sub_c003h
	res 1,(ix+002h)
	res 0,(ix+002h)
	jr lc185h
sub_c1aah:
	call sub_c003h
	xor a	
	ld ix,0d37fh
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc1b9h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc1dbh
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc1dbh
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc1dbh
	push ix
	pop iy
	jr lc224h
lc1dbh:
	bit 3,(ix+002h)
	jr nz,lc1efh
	cp (ix+005h)
	jr z,lc1e8h
	jr nc,lc1efh
lc1e8h:
	push ix
	pop iy
	ld a,(ix+005h)
lc1efh:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc1b9h
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc20bh
	cp e	
	call z,lc15fh
lc20bh:
	bit 4,(ix+002h)
	call nz,sub_c19dh
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc224h:
	ld c,006h
	ld iy,0d37fh
	ld a,(ix+005h)
lc22dh:
	cp (iy+005h)
	jr c,lc235h
	inc (iy+005h)
lc235h:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc22dh
	ld (ix+005h),000h
	ret	
sub_c242h:
	ld c,006h
	ld hl,0c77fh
	ld ix,0d37fh
	xor a	
lc24ch:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c265h
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc24ch
	ret	
sub_c265h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c26dh:
	ld h,(ix+007h)
	ld l,(ix+006h)
	ret	
sub_c274h:
	ld h,0ffh
	call sub_c1aah
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c176h
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,lc15fh
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	call sub_c26dh
	ldir
	call sub_c265h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d3cfh),hl
	ld hl,00000h
	ld (0d3cdh),hl
	ret	
sub_c2adh:
	call sub_c003h
	ex de,hl	
lc2b1h:
	ld ix,0d3e5h
	ld a,014h
	ld iy,00000h
lc2bbh:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc2feh
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc2feh
	bit 3,(ix+040h)
	ret z	
	ld iy,0d3cdh
	ld c,000h
lc2dch:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc2f3h
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc2f3h
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc2b1h
lc2f3h:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc2dch
	call lc15fh
lc2feh:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc309h
	push ix
	pop iy
lc309h:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc2bbh
	defb 0fdh,0bch	;cp iyh
	jr nz,lc322h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc322h
	ld a,017h
	ld (0c6eah),a
	ret	
lc322h:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c359h
	call sub_c348h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c265h
	push iy
	pop ix
	ret	
sub_c348h:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c359h:
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
	call sub_c176h
	pop iy
	ret	
sub_c375h:
	xor a	
	dec (ix+045h)
	ret nz	
	ld (ix+040h),a
	ld (ix+043h),a
	ret	
sub_c381h:
	call sub_c003h
	xor a	
	cp h	
	jr nz,lc39fh
	ld a,l	
	cp 012h
	jr nc,lc39fh
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
lc39fh:
	ret	
sub_c3a0h:
	call sub_c003h
	ld (0c71ch),hl
	ld hl,(0c6f1h)
	ld b,h	
	ld c,l	
	ld hl,(0c6efh)
	call sub_c497h
	cp 02fh
	jr nz,lc3bbh
	ld hl,00000h
	ld bc,00001h
lc3bbh:
	call sub_c2adh
lc3beh:
	jr nz,lc3c7h
	call sub_c497h
	cp 02fh
	jr lc3beh
lc3c7h:
	ld a,(0c6eah)
	or a	
	jr z,lc3d5h
lc3cdh:
	call sub_c375h
	ld ix,00000h
	ret	
lc3d5h:
	cp e	
	ret z	
	ld a,(ix+001h)
	and 060h
	xor 040h
	jr z,lc3e7h
	ld a,014h
	ld (0c6eah),a
	jr lc3cdh
lc3e7h:
	ld hl,0c6fdh
	ld b,020h
	ld a,e	
lc3edh:
	cp 02fh
	jr z,lc400h
	or a	
	jr z,lc400h
	xor a	
	cp b	
	jr z,lc3fbh
	ld (hl),e	
	inc hl	
	dec b	
lc3fbh:
	call sub_c497h
	jr lc3edh
lc400h:
	xor a	
	ld (hl),a	
	ld a,e	
lc403h:
	cp 02fh
	jr nz,lc40ch
	call sub_c497h
	jr lc403h
lc40ch:
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
	ld (0c71eh),hl
	ld hl,00000h
lc421h:
	push hl	
	push ix
	call sub_c381h
	ld b,h	
	ld c,l	
	ld h,(ix+042h)
	ld l,(ix+041h)
	call sub_c176h
	call sub_c26dh
	ld d,010h
lc437h:
	push hl	
	ld hl,(0c71eh)
	ld a,h	
	or l	
	jr z,lc488h
	dec hl	
	ld (0c71eh),hl
	pop hl	
	push hl	
	inc hl	
	inc hl	
	ld bc,0c6fdh
	ld a,01eh
lc44ch:
	ex af,af'	
	ld a,(bc)	
	cp (hl)	
	jr nz,lc45ch
	or a	
	jr z,lc46dh
	ex af,af'	
	dec a	
	jr z,lc46dh
	inc hl	
	inc bc	
	jr lc44ch
lc45ch:
	pop hl	
	ld bc,00020h
	add hl,bc	
	dec d	
	jr nz,lc437h
	call sub_c265h
	pop ix
	pop hl	
	inc hl	
	jr lc421h
lc46dh:
	pop hl	
	ld c,(hl)	
	inc hl	
	ld b,(hl)	
	call sub_c265h
	pop ix
	pop hl	
	ld h,(ix+042h)
	ld l,(ix+041h)
	push hl	
	call sub_c375h
	pop hl	
	call sub_c2adh
	jp lc3c7h
lc488h:
	pop hl	
	call sub_c265h
	pop ix
	pop hl	
	ld a,002h
	ld (0c6eah),a
	jp lc3cdh
sub_c497h:
	push hl	
	ld hl,(0c71ch)
	call sub_c072h
	pop hl	
	ld e,a	
	ret	
lc4a1h:
	push hl	
	ld hl,(0c6ebh)
	ld a,(hl)	
	inc hl	
	ld (0c6ebh),hl
	pop hl	
	ret	
	push hl	
	ld hl,(0c6ebh)
	call sub_c5ebh
	inc hl	
	ld (0c6ebh),hl
	pop hl	
	ret	
sub_c4b9h:
	call sub_c003h
lc4bch:
	ld a,(0d95dh)
	or a	
	jr z,lc4c4h
	jr lc4bch
lc4c4h:
	inc a	
	ld (0d95dh),a
	ld h,(ix+042h)
	ld l,(ix+041h)
	ld (0c720h),hl
	push ix
	ld hl,0ffffh
	call sub_c1aah
	ld (0c71eh),ix
	xor a	
	ld (0c728h),a
	exx	
	call sub_c26dh
	exx	
	ld bc,00200h
lc4e9h:
	ld hl,(0c6f5h)
	call sub_c5edh
	ld d,a	
	or e	
	jr z,lc50fh
	inc hl	
	inc hl	
	ld (0c6f5h),hl
	ld hl,0c728h
	inc (hl)	
	ex de,hl	
lc4fdh:
	call sub_c5ebh
	inc hl	
	exx	
	ld (hl),a	
	inc hl	
	exx	
	or a	
	jp z,lc4e9h
	dec bc	
	ld b,a	
	or c	
	jr nz,lc4fdh
	inc a	
lc50fh:
	pop ix
	jp nz,lc5e0h
	ld hl,00000h
	push hl	
	call sub_c381h
	ld b,h	
	ld c,l	
	ld hl,(0c720h)
	push ix
	call sub_c176h
	ld a,(0c6eah)
	or a	
	jp nz,lc5dah
	call sub_c26dh
	ld a,018h
	cp (hl)	
	inc hl	
	jr nz,lc53bh
	ld a,00eh
	cp (hl)	
	inc hl	
	jr z,lc543h
lc53bh:
	ld a,008h
	ld (0c6eah),a
	jp lc5dah
lc543h:
	inc hl	
	ld b,(hl)	
	inc hl	
	ld c,(hl)	
	ex de,hl	
	ld hl,00000h
	sbc hl,bc
	ld (0c722h),hl
	ex de,hl	
	ld de,00008h
	add hl,de	
	ld d,(hl)	
	inc hl	
	ld e,(hl)	
	inc hl	
	ld (0c724h),de
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ld b,h	
	ld c,l	
	ld de,lc000h
	or a	
	sbc hl,de
	jr nc,lc572h
	ld a,007h
	ld (0c6eah),a
	jr lc5dah
lc572h:
	ld de,00000h
	call sub_c5ffh
lc578h:
	ld hl,(0c724h)
	ld b,h	
	ld c,l	
	ld de,00200h
	or a	
	sbc hl,de
	push af	
	jr c,lc58eh
	ld b,d	
	ld c,e	
	ld hl,00000h
	ld (0c726h),hl
lc58eh:
	call sub_c26dh
	ld de,(0c726h)
	call sub_c5fch
	ld (0c726h),de
	call sub_c265h
	pop af	
	jr c,lc5bch
	pop ix
	pop hl	
	inc hl	
	push hl	
	call sub_c381h
	ld b,h	
	ld c,l	
	ld hl,(0c720h)
	push ix
	call sub_c176h
	ld a,(0c6eah)
	or a	
	jr nz,lc5dah
	jr lc578h
lc5bch:
	ld hl,(0c722h)
	ld a,h	
	or l	
	jr z,lc5c3h
lc5c3h:
	call sub_c375h
	ld ix,(0c71eh)
	call sub_c265h
	ld hl,0bffeh
	ld (0c77bh),hl
	ld de,00000h
	call sub_c5f7h
	ret	
lc5dah:
	call sub_c265h
	pop ix
	pop hl	
lc5e0h:
	call sub_c375h
	ld ix,(0c71eh)
	call sub_c265h
	ret	
sub_c5ebh:
	ld a,(hl)	
	ret	
sub_c5edh:
	ld e,(hl)	
lc5eeh:
	inc hl	
	ld d,(hl)	
lc5f0h:
	dec hl	
	ret	
lc5f2h:
	ldir
lc5f4h:
	ret	
	ld (hl),a	
lc5f6h:
	ret	
sub_c5f7h:
	ld (hl),e	
	inc hl	
	ld (hl),d	
	dec hl	
	ret	
sub_c5fch:
	ldir
	ret	
sub_c5ffh:
	ld h,d	
	ld l,e	
	ld (hl),000h
	inc de	
	dec bc	
	ldir
	ret	
	ld sp,0c769h
	pop ix
	pop iy
	pop af	
	pop bc	
	pop de	
	pop hl	
	ex af,af'	
	exx	
	pop af	
	pop bc	
	pop de	
	pop hl	
	ld sp,hl	
	ld hl,(0c77dh)
	ret	
sub_c61eh:
	call sub_c631h
	ret	
lc622h:
	dec sp	
	add a,05eh
	exx	
	jr nc,lc5eeh
	jr nc,lc5f0h
	jr nc,lc5f2h
	jr nc,lc5f4h
	jr nc,lc5f6h
	ret	
sub_c631h:
	ld b,020h
	ld a,001h
lc635h:
	out (0fdh),a
	dec b	
	jr nz,lc635h
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d960h
	call sub_c024h
	ld a,(0d95eh)
	or a	
	jr z,lc64ch
	ret	
lc64ch:
	ld ix,0d960h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d95eh),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc663h
	ld a,003h
lc663h:
	ld (0d964h),a
	ld a,(ix+00ah)
	ld (0d965h),a
	ld a,(ix+008h)
	and 007h
	rlca	
	rlca	
	or (ix+004h)
	ld (0d966h),a
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
	ld (0d967h),hl
	call sub_c26dh
	ld a,(ix+004h)
	or a	
lc694h:
	jr z,lc69dh
	ld de,00080h
	add hl,de	
	dec a	
	jr lc694h
lc69dh:
	ld (0d969h),hl
	ld b,007h
	ld hl,0d964h
lc6a5h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc6a5h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc64ch
	xor a	
	ld (0d95eh),a
	ld hl,0d960h
	call sub_c04eh
	jr nz,lc64ch
	ret	
lc6c5h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc6cfh:
	ld a,(bc)	
	dec c	
	nop	
lc6d2h:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc6d9h
lc6d9h:
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
lc6e3h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
