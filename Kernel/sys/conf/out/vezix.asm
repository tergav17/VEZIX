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
	ld sp,0c783h
	xor a	
	ld hl,0d96fh
	ld de,0c6eeh
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c171h
	ld hl,lc6c9h
	call sub_c11bh
	ld hl,lc6d6h
	call sub_c11bh
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c128h
	ld hl,lc6d3h
	call sub_c11bh
	call sub_c246h
	call sub_c622h
	call sub_c278h
	ld hl,lc6ddh
	ld (0c6efh),hl
	ld hl,lc4a5h
	call sub_c3a4h
	ld a,(0c6eeh)
	or a	
	jp nz,lc15fh
	call sub_c4bdh
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
	ld h,000h
	ld l,a	
	push hl	
	ld hl,lc6e7h
	call sub_c11bh
	pop hl	
	call sub_c128h
lc16dh:
	di	
	halt	
	jr lc16dh
sub_c171h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c17ah:
	call sub_c003h
	call sub_c1aeh
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
lc189h:
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc626h
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
sub_c1a1h:
	call sub_c003h
	res 1,(ix+002h)
	res 0,(ix+002h)
	jr lc189h
sub_c1aeh:
	call sub_c003h
	xor a	
	ld ix,0d383h
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc1bdh:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc1dfh
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc1dfh
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc1dfh
	push ix
	pop iy
	jr lc228h
lc1dfh:
	bit 3,(ix+002h)
	jr nz,lc1f3h
	cp (ix+005h)
	jr z,lc1ech
	jr nc,lc1f3h
lc1ech:
	push ix
	pop iy
	ld a,(ix+005h)
lc1f3h:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc1bdh
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc20fh
	cp e	
	call z,lc15fh
lc20fh:
	bit 4,(ix+002h)
	call nz,sub_c1a1h
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc228h:
	ld c,006h
	ld iy,0d383h
	ld a,(ix+005h)
lc231h:
	cp (iy+005h)
	jr c,lc239h
	inc (iy+005h)
lc239h:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc231h
	ld (ix+005h),000h
	ret	
sub_c246h:
	ld c,006h
	ld hl,0c783h
	ld ix,0d383h
	xor a	
lc250h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c269h
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc250h
	ret	
sub_c269h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c271h:
	ld h,(ix+007h)
	ld l,(ix+006h)
	ret	
sub_c278h:
	ld h,0ffh
	call sub_c1aeh
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c17ah
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,lc15fh
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	call sub_c271h
	ldir
	call sub_c269h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d3d3h),hl
	ld hl,00000h
	ld (0d3d1h),hl
	ret	
sub_c2b1h:
	call sub_c003h
	ex de,hl	
lc2b5h:
	ld ix,0d3e9h
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
	ld iy,0d3d1h
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
	call lc15fh
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
	jr nz,lc326h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc326h
	ld a,017h
	ld (0c6eeh),a
	ret	
lc326h:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c35dh
	call sub_c34ch
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c269h
	push iy
	pop ix
	ret	
sub_c34ch:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c35dh:
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
	call sub_c17ah
	pop iy
	ret	
sub_c379h:
	xor a	
	dec (ix+045h)
	ret nz	
	ld (ix+040h),a
	ld (ix+043h),a
	ret	
sub_c385h:
	call sub_c003h
	xor a	
	cp h	
	jr nz,lc3a3h
	ld a,l	
	cp 012h
	jr nc,lc3a3h
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
lc3a3h:
	ret	
sub_c3a4h:
	call sub_c003h
	ld (0c720h),hl
	ld hl,(0c6f5h)
	ld b,h	
	ld c,l	
	ld hl,(0c6f3h)
	call sub_c49bh
	cp 02fh
	jr nz,lc3bfh
	ld hl,00000h
	ld bc,00001h
lc3bfh:
	call sub_c2b1h
lc3c2h:
	jr nz,lc3cbh
	call sub_c49bh
	cp 02fh
	jr lc3c2h
lc3cbh:
	ld a,(0c6eeh)
	or a	
	jr z,lc3d9h
lc3d1h:
	call sub_c379h
	ld ix,00000h
	ret	
lc3d9h:
	cp e	
	ret z	
	ld a,(ix+001h)
	and 060h
	xor 040h
	jr z,lc3ebh
	ld a,014h
	ld (0c6eeh),a
	jr lc3d1h
lc3ebh:
	ld hl,0c701h
	ld b,020h
	ld a,e	
lc3f1h:
	cp 02fh
	jr z,lc404h
	or a	
	jr z,lc404h
	xor a	
	cp b	
	jr z,lc3ffh
	ld (hl),e	
	inc hl	
	dec b	
lc3ffh:
	call sub_c49bh
	jr lc3f1h
lc404h:
	xor a	
	ld (hl),a	
	ld a,e	
lc407h:
	cp 02fh
	jr nz,lc410h
	call sub_c49bh
	jr lc407h
lc410h:
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
	ld (0c722h),hl
	ld hl,00000h
lc425h:
	push hl	
	push ix
	call sub_c385h
	ld b,h	
	ld c,l	
	ld h,(ix+042h)
	ld l,(ix+041h)
	call sub_c17ah
	call sub_c271h
	ld d,010h
lc43bh:
	push hl	
	ld hl,(0c722h)
	ld a,h	
	or l	
	jr z,lc48ch
	dec hl	
	ld (0c722h),hl
	pop hl	
	push hl	
	inc hl	
	inc hl	
	ld bc,0c701h
	ld a,01eh
lc450h:
	ex af,af'	
	ld a,(bc)	
	cp (hl)	
	jr nz,lc460h
	or a	
	jr z,lc471h
	ex af,af'	
	dec a	
	jr z,lc471h
	inc hl	
	inc bc	
	jr lc450h
lc460h:
	pop hl	
	ld bc,00020h
	add hl,bc	
	dec d	
	jr nz,lc43bh
	call sub_c269h
	pop ix
	pop hl	
	inc hl	
	jr lc425h
lc471h:
	pop hl	
	ld c,(hl)	
	inc hl	
	ld b,(hl)	
	call sub_c269h
	pop ix
	pop hl	
	ld h,(ix+042h)
	ld l,(ix+041h)
	push hl	
	call sub_c379h
	pop hl	
	call sub_c2b1h
	jp lc3cbh
lc48ch:
	pop hl	
	call sub_c269h
	pop ix
	pop hl	
	ld a,002h
	ld (0c6eeh),a
	jp lc3d1h
sub_c49bh:
	push hl	
	ld hl,(0c720h)
	call sub_c072h
	pop hl	
	ld e,a	
	ret	
lc4a5h:
	push hl	
	ld hl,(0c6efh)
	ld a,(hl)	
	inc hl	
	ld (0c6efh),hl
	pop hl	
	ret	
	push hl	
	ld hl,(0c6efh)
	call sub_c5efh
	inc hl	
	ld (0c6efh),hl
	pop hl	
	ret	
sub_c4bdh:
	call sub_c003h
lc4c0h:
	ld a,(0d961h)
	or a	
	jr z,lc4c8h
	jr lc4c0h
lc4c8h:
	inc a	
	ld (0d961h),a
	ld h,(ix+042h)
	ld l,(ix+041h)
	ld (0c724h),hl
	push ix
	ld hl,0ffffh
	call sub_c1aeh
	ld (0c722h),ix
	xor a	
	ld (0c72ch),a
	exx	
	call sub_c271h
	exx	
	ld bc,00200h
lc4edh:
	ld hl,(0c6f9h)
	call sub_c5f1h
	ld d,a	
	or e	
	jr z,lc513h
	inc hl	
	inc hl	
	ld (0c6f9h),hl
	ld hl,0c72ch
	inc (hl)	
	ex de,hl	
lc501h:
	call sub_c5efh
	inc hl	
	exx	
	ld (hl),a	
	inc hl	
	exx	
	or a	
	jp z,lc4edh
	dec bc	
	ld b,a	
	or c	
	jr nz,lc501h
	inc a	
lc513h:
	pop ix
	jp nz,lc5e4h
	ld hl,00000h
	push hl	
	call sub_c385h
	ld b,h	
	ld c,l	
	ld hl,(0c724h)
	push ix
	call sub_c17ah
	ld a,(0c6eeh)
	or a	
	jp nz,lc5deh
	call sub_c271h
	ld a,018h
	cp (hl)	
	inc hl	
	jr nz,lc53fh
	ld a,00eh
	cp (hl)	
	inc hl	
	jr z,lc547h
lc53fh:
	ld a,008h
	ld (0c6eeh),a
	jp lc5deh
lc547h:
	inc hl	
	ld b,(hl)	
	inc hl	
	ld c,(hl)	
	ex de,hl	
	ld hl,00000h
	sbc hl,bc
	ld (0c726h),hl
	ex de,hl	
	ld de,00008h
	add hl,de	
	ld d,(hl)	
	inc hl	
	ld e,(hl)	
	inc hl	
	ld (0c728h),de
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ld b,h	
	ld c,l	
	ld de,lc000h
	or a	
	sbc hl,de
	jr nc,lc576h
	ld a,007h
	ld (0c6eeh),a
	jr lc5deh
lc576h:
	ld de,00000h
	call sub_c603h
lc57ch:
	ld hl,(0c728h)
	ld b,h	
	ld c,l	
	ld de,00200h
	or a	
	sbc hl,de
	push af	
	jr c,lc592h
	ld b,d	
	ld c,e	
	ld hl,00000h
	ld (0c72ah),hl
lc592h:
	call sub_c271h
	ld de,(0c72ah)
	call sub_c600h
	ld (0c72ah),de
	call sub_c269h
	pop af	
	jr c,lc5c0h
	pop ix
	pop hl	
	inc hl	
	push hl	
	call sub_c385h
	ld b,h	
	ld c,l	
	ld hl,(0c724h)
	push ix
	call sub_c17ah
	ld a,(0c6eeh)
	or a	
	jr nz,lc5deh
	jr lc57ch
lc5c0h:
	ld hl,(0c726h)
	ld a,h	
	or l	
	jr z,lc5c7h
lc5c7h:
	call sub_c379h
	ld ix,(0c722h)
	call sub_c269h
	ld hl,0bffeh
	ld (0c77fh),hl
	ld de,00000h
	call sub_c5fbh
	ret	
lc5deh:
	call sub_c269h
	pop ix
	pop hl	
lc5e4h:
	call sub_c379h
	ld ix,(0c722h)
	call sub_c269h
	ret	
sub_c5efh:
	ld a,(hl)	
	ret	
sub_c5f1h:
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	dec hl	
	ret	
	ldir
	ret	
	ld (hl),a	
	ret	
sub_c5fbh:
	ld (hl),e	
	inc hl	
	ld (hl),d	
	dec hl	
	ret	
sub_c600h:
	ldir
	ret	
sub_c603h:
	ld h,d	
	ld l,e	
	ld (hl),000h
	inc de	
	dec bc	
	ldir
	ret	
	ld sp,0c76dh
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
	ld hl,(0c781h)
	ret	
sub_c622h:
	call sub_c635h
	ret	
lc626h:
	ccf	
	add a,062h
	exx	
	inc (hl)	
	add a,034h
	add a,034h
	add a,034h
	add a,034h
	add a,0c9h
sub_c635h:
	ld b,020h
	ld a,001h
lc639h:
	out (0fdh),a
	dec b	
	jr nz,lc639h
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d964h
	call sub_c024h
	ld a,(0d962h)
	or a	
	jr z,lc650h
	ret	
lc650h:
	ld ix,0d964h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d962h),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc667h
	ld a,003h
lc667h:
	ld (0d968h),a
	ld a,(ix+00ah)
	ld (0d969h),a
	ld a,(ix+008h)
	and 007h
	rlca	
	rlca	
	or (ix+004h)
	ld (0d96ah),a
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
	ld (0d96bh),hl
	call sub_c271h
	ld a,(ix+004h)
	or a	
lc698h:
	jr z,lc6a1h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc698h
lc6a1h:
	ld (0d96dh),hl
	ld b,007h
	ld hl,0d968h
lc6a9h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc6a9h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc650h
	xor a	
	ld (0d962h),a
	ld hl,0d964h
	call sub_c04eh
	jr nz,lc650h
	ret	
lc6c9h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc6d3h:
	ld a,(bc)	
	dec c	
	nop	
lc6d6h:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc6ddh
lc6ddh:
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
lc6e7h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
