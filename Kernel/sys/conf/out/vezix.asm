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
	ld sp,0c6b0h
	xor a	
	ld hl,0d89ch
	ld de,0c635h
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
	ld hl,lc610h
	call sub_c105h
	ld hl,lc61dh
	call sub_c105h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c112h
	ld hl,lc61ah
	call sub_c105h
	call sub_c22ch
	call sub_c569h
	call sub_c25eh
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
	ld hl,lc62eh
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
	ld de,lc56dh
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
sub_c187h:
	call sub_c003h
	res 1,(ix+002h)
	res 0,(ix+002h)
	jr lc16fh
sub_c194h:
	call sub_c003h
	xor a	
	ld ix,0d2b0h
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
	jr lc20eh
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
	call nz,sub_c187h
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc20eh:
	ld c,006h
	ld iy,0d2b0h
	ld a,(ix+005h)
lc217h:
	cp (iy+005h)
	jr c,lc21fh
	inc (iy+005h)
lc21fh:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc217h
	ld (ix+005h),000h
	ret	
sub_c22ch:
	ld c,006h
	ld hl,0c6b0h
	ld ix,0d2b0h
	xor a	
lc236h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c24fh
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc236h
	ret	
sub_c24fh:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c257h:
	ld h,(ix+007h)
	ld l,(ix+006h)
	ret	
sub_c25eh:
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
	call sub_c257h
	ldir
	call sub_c24fh
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d300h),hl
	ld hl,00000h
	ld (0d2feh),hl
	ret	
sub_c297h:
	call sub_c003h
	ex de,hl	
lc29bh:
	ld ix,0d316h
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
	ld iy,0d2feh
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
	call sub_c149h
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
	jr nz,lc30ch
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc30ch
	ld a,017h
	ld (0c635h),a
	ret	
lc30ch:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c343h
	call sub_c332h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c24fh
	push iy
	pop ix
	ret	
sub_c332h:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c343h:
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
sub_c35fh:
	xor a	
	dec (ix+045h)
	ret nz	
	ld (ix+040h),a
	ld (ix+043h),a
	ret	
sub_c36bh:
	call sub_c003h
	xor a	
	cp h	
	jr nz,lc389h
	ld a,l	
	cp 012h
	jr nc,lc389h
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
lc389h:
	ret	
	call sub_c003h
	ld (0c667h),hl
	ld hl,(0c63ch)
	ld b,h	
	ld c,l	
	ld hl,(0c63ah)
	call sub_c481h
	cp 02fh
	jr nz,lc3a5h
	ld hl,00000h
	ld bc,00001h
lc3a5h:
	call sub_c297h
lc3a8h:
	jr nz,lc3b1h
	call sub_c481h
	cp 02fh
	jr lc3a8h
lc3b1h:
	ld a,(0c635h)
	or a	
	jr z,lc3bfh
lc3b7h:
	call sub_c35fh
	ld ix,00000h
	ret	
lc3bfh:
	cp e	
	ret z	
	ld a,(ix+001h)
	and 060h
	xor 040h
	jr z,lc3d1h
	ld a,014h
	ld (0c635h),a
	jr lc3b7h
lc3d1h:
	ld hl,0c648h
	ld b,020h
	ld a,e	
lc3d7h:
	cp 02fh
	jr z,lc3eah
	or a	
	jr z,lc3eah
	xor a	
	cp b	
	jr z,lc3e5h
	ld (hl),e	
	inc hl	
	dec b	
lc3e5h:
	call sub_c481h
	jr lc3d7h
lc3eah:
	xor a	
	ld (hl),a	
	ld a,e	
lc3edh:
	cp 02fh
	jr nz,lc3f6h
	call sub_c481h
	jr lc3edh
lc3f6h:
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
	ld (0c669h),hl
	ld hl,00000h
lc40bh:
	push hl	
	push ix
	call sub_c36bh
	ld b,h	
	ld c,l	
	ld h,(ix+042h)
	ld l,(ix+041h)
	call sub_c160h
	call sub_c257h
	ld d,010h
lc421h:
	push hl	
	ld hl,(0c669h)
	ld a,h	
	or l	
	jr z,lc472h
	dec hl	
	ld (0c669h),hl
	pop hl	
	push hl	
	inc hl	
	inc hl	
	ld bc,0c648h
	ld a,01eh
lc436h:
	ex af,af'	
	ld a,(bc)	
	cp (hl)	
	jr nz,lc446h
	or a	
	jr z,lc457h
	ex af,af'	
	dec a	
	jr z,lc457h
	inc hl	
	inc bc	
	jr lc436h
lc446h:
	pop hl	
	ld bc,00020h
	add hl,bc	
	dec d	
	jr nz,lc421h
	call sub_c24fh
	pop ix
	pop hl	
	inc hl	
	jr lc40bh
lc457h:
	pop hl	
	ld c,(hl)	
	inc hl	
	ld b,(hl)	
	call sub_c24fh
	pop ix
	pop hl	
	ld h,(ix+042h)
	ld l,(ix+041h)
	push hl	
	call sub_c35fh
	pop hl	
	call sub_c297h
	jp lc3b1h
lc472h:
	pop hl	
	call sub_c24fh
	pop ix
	pop hl	
	ld a,002h
	ld (0c635h),a
	jp lc3b7h
sub_c481h:
	push hl	
	ld hl,(0c667h)
	call sub_c072h
	pop hl	
	ld e,a	
	ret	
	push hl	
	ld hl,(0c636h)
	ld a,(hl)	
	inc hl	
	ld (0c636h),hl
	pop hl	
	ret	
	push hl	
	ld hl,(0c636h)
	call sub_c555h
	inc hl	
	ld (0c636h),hl
	pop hl	
	ret	
	call sub_c003h
lc4a6h:
	ld a,(0d88eh)
	or a	
	jr z,lc4aeh
	jr lc4a6h
lc4aeh:
	inc a	
	ld (0d88eh),a
	ld h,(ix+042h)
	ld l,(ix+041h)
	ld (0c66bh),hl
	push ix
	ld hl,0ffffh
	call sub_c194h
	ld (0c669h),ix
	xor a	
	ld (0c66fh),a
	exx	
	call sub_c257h
	exx	
	ld bc,00200h
lc4d3h:
	ld hl,(0c640h)
	call sub_c557h
	ld d,a	
	or e	
	jr z,lc4f9h
	inc hl	
	inc hl	
	ld (0c640h),hl
	ld hl,0c66fh
	inc (hl)	
	ex de,hl	
lc4e7h:
	call sub_c555h
	inc hl	
	exx	
	ld (hl),a	
	inc hl	
	exx	
	or a	
	jp z,lc4d3h
	dec bc	
	ld b,a	
	or c	
	jr nz,lc4e7h
	inc a	
lc4f9h:
	pop ix
	jr nz,lc54ah
	ld hl,00000h
	call sub_c36bh
	ld b,h	
	ld c,l	
	ld hl,(0c66bh)
	push ix
	call sub_c160h
	ld a,(0c635h)
	or a	
	jr nz,lc545h
	call sub_c257h
	ld a,018h
	cp (hl)	
	inc hl	
	jr nz,lc522h
	ld a,00eh
	cp (hl)	
	inc hl	
	jr z,lc529h
lc522h:
	ld a,008h
	ld (0c635h),a
	jr lc545h
lc529h:
	inc hl	
	ld b,(hl)	
	inc hl	
	ld c,(hl)	
	ex de,hl	
	ld hl,00000h
	sbc hl,bc
	ld (0c66dh),hl
	ex de,hl	
	ld de,0000ah
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	ld de,lc000h
	or a	
	sbc hl,de
lc545h:
	call sub_c24fh
	pop ix
lc54ah:
	call sub_c35fh
	ld ix,(0c669h)
	call sub_c24fh
	ret	
sub_c555h:
	ld a,(hl)	
	ret	
sub_c557h:
	ld e,(hl)	
	inc hl	
	ld d,(hl)	
	dec hl	
	ret	
	ldir
	ret	
	ld (hl),a	
	ret	
	ld (hl),e	
	inc hl	
	ld (hl),d	
	dec hl	
	ret	
	ldir
	ret	
sub_c569h:
	call sub_c57ch
	ret	
lc56dh:
	add a,(hl)	
	push bc	
	adc a,a	
	ret c	
	ld a,e	
	push bc	
	ld a,e	
	push bc	
	ld a,e	
	push bc	
	ld a,e	
	push bc	
	ld a,e	
	push bc	
	ret	
sub_c57ch:
	ld b,020h
	ld a,001h
lc580h:
	out (0fdh),a
	dec b	
	jr nz,lc580h
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d891h
	call sub_c024h
	ld a,(0d88fh)
	or a	
	jr z,lc597h
	ret	
lc597h:
	ld ix,0d891h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d88fh),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc5aeh
	ld a,003h
lc5aeh:
	ld (0d895h),a
	ld a,(ix+00ah)
	ld (0d896h),a
	ld a,(ix+008h)
	and 007h
	rlca	
	rlca	
	or (ix+004h)
	ld (0d897h),a
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
	ld (0d898h),hl
	call sub_c257h
	ld a,(ix+004h)
	or a	
lc5dfh:
	jr z,lc5e8h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc5dfh
lc5e8h:
	ld (0d89ah),hl
	ld b,007h
	ld hl,0d895h
lc5f0h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc5f0h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc597h
	xor a	
	ld (0d88fh),a
	ld hl,0d891h
	call sub_c04eh
	jr nz,lc597h
	ret	
lc610h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc61ah:
	ld a,(bc)	
	dec c	
	nop	
lc61dh:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc624h
lc624h:
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
lc62eh:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
