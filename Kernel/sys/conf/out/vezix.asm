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
	ld sp,0c5e9h
	xor a	
	ld hl,0d7d4h
	ld de,0c57bh
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c17ah
	ld hl,lc556h
	call sub_c128h
	ld hl,lc563h
	call sub_c128h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c135h
	ld hl,lc560h
	call sub_c128h
	call sub_c23fh
	call sub_c4ach
	call sub_c26ah
	ld hl,lc56ah
	ld (0c57ch),hl
	ld hl,lc49dh
	call sub_c399h
	ld hl,00000h
	call sub_c37ah
	ld b,h	
	ld c,l	
	ld hl,00000h
	call sub_c183h
	ld h,(ix+007h)
	ld l,(ix+006h)
	call sub_c128h
	halt	
	call sub_c003h
	ld d,b	
	ld e,c	
lc0dbh:
	ld c,010h
	ld b,00ah
	call sub_c162h
	ld b,00dh
	call sub_c162h
	push hl	
	call sub_c107h
	ld b,03ah
	call sub_c162h
	pop hl	
lc0f1h:
	ld b,020h
	call sub_c162h
	push hl	
	ld h,(hl)	
	call sub_c10dh
	pop hl	
	inc hl	
	dec de	
	ld a,d	
	or e	
	ret z	
	dec c	
	jr nz,lc0f1h
	jr lc0dbh
	ret	
sub_c107h:
	push hl	
	call sub_c10dh
	pop hl	
	ld h,l	
sub_c10dh:
	call sub_c003h
	ld a,h	
	rra	
	rra	
	rra	
	rra	
	call sub_c119h
	ld a,h	
sub_c119h:
	and 00fh
	add a,030h
	cp 03ah
	jr c,lc123h
	add a,027h
lc123h:
	ld b,a	
	call sub_c162h
	ret	
sub_c128h:
	call sub_c003h
lc12bh:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c162h
	inc hl	
	jr lc12bh
sub_c135h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c156h
	ld bc,0fc18h
	call sub_c156h
	ld bc,0ff9ch
	call sub_c156h
	ld bc,0fff6h
	call sub_c156h
	ld bc,0ffffh
	dec d	
sub_c156h:
	ld a,02fh
lc158h:
	inc a	
	add hl,bc	
	jr c,lc158h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c162h:
	in a,(010h)
	and 002h
	jr z,sub_c162h
	ld a,b	
	out (011h),a
	ret	
sub_c16ch:
	ld hl,lc574h
	call sub_c128h
	pop hl	
	call sub_c135h
lc176h:
	di	
	halt	
	jr lc176h
sub_c17ah:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c183h:
	call sub_c003h
	call sub_c1aah
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc4b0h
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
sub_c1aah:
	call sub_c003h
	xor a	
	ld ix,0d1e9h
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
	jr lc221h
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
	call z,sub_c16ch
lc20bh:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc221h:
	ld c,006h
	ld iy,0d1e9h
	ld a,(ix+005h)
lc22ah:
	cp (iy+005h)
	jr c,lc232h
	inc (iy+005h)
lc232h:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc22ah
	ld (ix+005h),000h
	ret	
sub_c23fh:
	ld c,006h
	ld hl,0c5e9h
	ld ix,0d1e9h
	xor a	
lc249h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c262h
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc249h
	ret	
sub_c262h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c26ah:
	ld h,0ffh
	call sub_c1aah
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c183h
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c16ch
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c262h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d239h),hl
	ld hl,00000h
	ld (0d237h),hl
	ret	
sub_c2a6h:
	call sub_c003h
	ex de,hl	
lc2aah:
	ld ix,0d24fh
	ld a,014h
	ld iy,00000h
lc2b4h:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc2f7h
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc2f7h
	bit 3,(ix+040h)
	ret z	
	ld iy,0d237h
	ld c,000h
lc2d5h:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc2ech
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc2ech
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc2aah
lc2ech:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc2d5h
	call sub_c16ch
lc2f7h:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc302h
	push ix
	pop iy
lc302h:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc2b4h
	defb 0fdh,0bch	;cp iyh
	jr nz,lc31bh
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc31bh
	ld a,017h
	ld (0c57bh),a
	ret	
lc31bh:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c352h
	call sub_c341h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c262h
	push iy
	pop ix
	ret	
sub_c341h:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c352h:
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
	call sub_c183h
	pop iy
	ret	
sub_c36eh:
	xor a	
	dec (ix+045h)
	ret nz	
	ld (ix+040h),a
	ld (ix+043h),a
	ret	
sub_c37ah:
	call sub_c003h
	xor a	
	cp h	
	jr nz,lc398h
	ld a,l	
	cp 012h
	jr nc,lc398h
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
lc398h:
	ret	
sub_c399h:
	call sub_c003h
	ld (0c5a3h),hl
	ld hl,(0c582h)
	ld b,h	
	ld c,l	
	ld hl,(0c580h)
	call sub_c493h
	cp 02fh
	jr nz,lc3b4h
	ld hl,00000h
	ld bc,00001h
lc3b4h:
	call sub_c2a6h
lc3b7h:
	jr nz,lc3c0h
	call sub_c493h
	cp 02fh
	jr lc3b7h
lc3c0h:
	ld a,(0c57bh)
	or a	
	jr z,lc3ceh
lc3c6h:
	call sub_c36eh
	ld ix,00000h
	ret	
lc3ceh:
	cp e	
	ret z	
	ld a,(ix+001h)
	and 060h
	xor 040h
	jr z,lc3e0h
	ld a,014h
	ld (0c57bh),a
	jr lc3c6h
lc3e0h:
	ld hl,0c584h
	ld b,020h
	ld a,e	
lc3e6h:
	cp 02fh
	jr z,lc3f9h
	or a	
	jr z,lc3f9h
	xor a	
	cp b	
	jr z,lc3f4h
	ld (hl),e	
	inc hl	
	dec b	
lc3f4h:
	call sub_c493h
	jr lc3e6h
lc3f9h:
	xor a	
	ld (hl),a	
	ld a,e	
lc3fch:
	cp 02fh
	jr nz,lc405h
	call sub_c493h
	jr lc3fch
lc405h:
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
	ld (0c5a5h),hl
	ld hl,00000h
lc41ah:
	push hl	
	push ix
	call sub_c37ah
	ld b,h	
	ld c,l	
	ld h,(ix+042h)
	ld l,(ix+041h)
	call sub_c183h
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld d,010h
lc433h:
	push hl	
	ld hl,(0c5a5h)
	ld a,h	
	or l	
	jr z,lc484h
	dec hl	
	ld (0c5a5h),hl
	pop hl	
	push hl	
	inc hl	
	inc hl	
	ld bc,0c584h
	ld a,01eh
lc448h:
	ex af,af'	
	ld a,(bc)	
	cp (hl)	
	jr nz,lc458h
	or a	
	jr z,lc469h
	ex af,af'	
	dec a	
	jr z,lc469h
	inc hl	
	inc bc	
	jr lc448h
lc458h:
	pop hl	
	ld bc,00020h
	add hl,bc	
	dec d	
	jr nz,lc433h
	call sub_c262h
	pop ix
	pop hl	
	inc hl	
	jr lc41ah
lc469h:
	pop hl	
	ld c,(hl)	
	inc hl	
	ld b,(hl)	
	call sub_c262h
	pop ix
	pop hl	
	ld h,(ix+042h)
	ld l,(ix+041h)
	push hl	
	call sub_c36eh
	pop hl	
	call sub_c2a6h
	jp lc3c0h
lc484h:
	pop hl	
	call sub_c262h
	pop ix
	pop hl	
	ld a,002h
	ld (0c57bh),a
	jp lc3c6h
sub_c493h:
	push hl	
	ld hl,(0c5a3h)
	call sub_c072h
	pop hl	
	ld e,a	
	ret	
lc49dh:
	push hl	
	ld hl,(0c57ch)
	ld a,(hl)	
	inc hl	
	ld (0c57ch),hl
	pop hl	
	ret	
	call sub_c003h
	ret	
sub_c4ach:
	call 0c4bfh
	ret	
lc4b0h:
	ret	
	call nz,0d7c7h
	cp (hl)	
	call nz,0c4beh
	cp (hl)	
	call nz,0c4beh
	cp (hl)	
	call nz,006c9h
	jr nz,lc500h
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d7c9h
	call sub_c024h
	ld a,(0d7c7h)
	or a	
	jr z,lc4dah
	ret	
lc4dah:
	ld ix,0d7c9h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d7c7h),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc4f1h
	ld a,003h
lc4f1h:
	ld (0d7cdh),a
	ld a,(ix+00ah)
	ld (0d7ceh),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc500h:
	rlca	
	or (ix+004h)
	ld (0d7cfh),a
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
	ld (0d7d0h),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc525h:
	jr z,lc52eh
	ld de,00080h
	add hl,de	
	dec a	
	jr lc525h
lc52eh:
	ld (0d7d2h),hl
	ld b,007h
	ld hl,0d7cdh
lc536h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc536h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc4dah
	xor a	
	ld (0d7c7h),a
	ld hl,0d7c9h
	call sub_c04eh
	jr nz,lc4dah
	ret	
lc556h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc560h:
	ld a,(bc)	
	dec c	
	nop	
lc563h:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc56ah
lc56ah:
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
lc574h:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
