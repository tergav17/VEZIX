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
	ld sp,0c5f3h
	xor a	
	ld hl,0d770h
	ld de,0c585h
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c188h
	ld hl,lc560h
	call sub_c136h
	ld hl,lc56dh
	call sub_c136h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c143h
	ld hl,lc56ah
	call sub_c136h
	call sub_c24dh
	call sub_c4b6h
	call sub_c278h
	ld hl,lc574h
	ld (0c586h),hl
	ld hl,lc4abh
	call sub_c3a7h
	defb 0ddh,054h	;ld d,ixh
	defb 0ddh,05dh	;ld e,ixl
	ex de,hl	
	ld bc,00046h
	call sub_c0e4h
	ld hl,00000h
	call sub_c388h
	ld b,h	
	ld c,l	
	ld hl,00000h
	call sub_c191h
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld bc,00200h
	call sub_c0e4h
	halt	
sub_c0e4h:
	call sub_c003h
	ld d,b	
	ld e,c	
lc0e9h:
	ld c,010h
	ld b,00ah
	call sub_c170h
	ld b,00dh
	call sub_c170h
	push hl	
	call sub_c115h
	ld b,03ah
	call sub_c170h
	pop hl	
lc0ffh:
	ld b,020h
	call sub_c170h
	push hl	
	ld h,(hl)	
	call sub_c11bh
	pop hl	
	inc hl	
	dec de	
	ld a,d	
	or e	
	ret z	
	dec c	
	jr nz,lc0ffh
	jr lc0e9h
	ret	
sub_c115h:
	push hl	
	call sub_c11bh
	pop hl	
	ld h,l	
sub_c11bh:
	call sub_c003h
	ld a,h	
	rra	
	rra	
	rra	
	rra	
	call sub_c127h
	ld a,h	
sub_c127h:
	and 00fh
	add a,030h
	cp 03ah
	jr c,lc131h
	add a,027h
lc131h:
	ld b,a	
	call sub_c170h
	ret	
sub_c136h:
	call sub_c003h
lc139h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c170h
	inc hl	
	jr lc139h
sub_c143h:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c164h
	ld bc,0fc18h
	call sub_c164h
	ld bc,0ff9ch
	call sub_c164h
	ld bc,0fff6h
	call sub_c164h
	ld bc,0ffffh
	dec d	
sub_c164h:
	ld a,02fh
lc166h:
	inc a	
	add hl,bc	
	jr c,lc166h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c170h:
	in a,(010h)
	and 002h
	jr z,sub_c170h
	ld a,b	
	out (011h),a
	ret	
sub_c17ah:
	ld hl,lc57eh
	call sub_c136h
	pop hl	
	call sub_c143h
lc184h:
	di	
	halt	
	jr lc184h
sub_c188h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c191h:
	call sub_c003h
	call sub_c1b8h
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc4bah
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
sub_c1b8h:
	call sub_c003h
	xor a	
	ld ix,0d185h
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc1c7h:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc1e9h
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc1e9h
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc1e9h
	push ix
	pop iy
	jr lc22fh
lc1e9h:
	bit 3,(ix+002h)
	jr nz,lc1fdh
	cp (ix+005h)
	jr z,lc1f6h
	jr nc,lc1fdh
lc1f6h:
	push ix
	pop iy
	ld a,(ix+005h)
lc1fdh:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc1c7h
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc219h
	cp e	
	call z,sub_c17ah
lc219h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc22fh:
	ld c,006h
	ld iy,0d185h
	ld a,(ix+005h)
lc238h:
	cp (iy+005h)
	jr c,lc240h
	inc (iy+005h)
lc240h:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc238h
	ld (ix+005h),000h
	ret	
sub_c24dh:
	ld c,006h
	ld hl,0c585h
	ld ix,0d185h
	xor a	
lc257h:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c270h
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc257h
	ret	
sub_c270h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c278h:
	ld h,0ffh
	call sub_c1b8h
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c191h
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c17ah
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c270h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d1d5h),hl
	ld hl,00000h
	ld (0d1d3h),hl
	ret	
sub_c2b4h:
	call sub_c003h
	ex de,hl	
lc2b8h:
	ld ix,0d1ebh
	ld a,014h
	ld iy,00000h
lc2c2h:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc305h
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc305h
	bit 3,(ix+040h)
	ret z	
	ld iy,0d1d3h
	ld c,000h
lc2e3h:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc2fah
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc2fah
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc2b8h
lc2fah:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc2e3h
	call sub_c17ah
lc305h:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc310h
	push ix
	pop iy
lc310h:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc2c2h
	defb 0fdh,0bch	;cp iyh
	jr nz,lc329h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc329h
	ld a,017h
	ld (0c585h),a
	ret	
lc329h:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c360h
	call sub_c34fh
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c270h
	push iy
	pop ix
	ret	
sub_c34fh:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c360h:
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
	call sub_c191h
	pop iy
	ret	
sub_c37ch:
	xor a	
	dec (ix+045h)
	ret nz	
	ld (ix+040h),a
	ld (ix+043h),a
	ret	
sub_c388h:
	call sub_c003h
	xor a	
	cp h	
	jr nz,lc3a6h
	ld a,l	
	cp 012h
	jr nc,lc3a6h
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
lc3a6h:
	ret	
sub_c3a7h:
	call sub_c003h
	ld (0c5adh),hl
	ld hl,(0c58ch)
	ld b,h	
	ld c,l	
	ld hl,(0c58ah)
	call sub_c4a1h
	cp 02fh
	jr nz,lc3c2h
	ld hl,00000h
	ld bc,00001h
lc3c2h:
	call sub_c2b4h
lc3c5h:
	jr nz,lc3ceh
	call sub_c4a1h
	cp 02fh
	jr lc3c5h
lc3ceh:
	ld a,(0c585h)
	or a	
	jr z,lc3dch
lc3d4h:
	call sub_c37ch
	ld ix,00000h
	ret	
lc3dch:
	cp e	
	ret z	
	ld a,(ix+001h)
	and 060h
	xor 040h
	jr z,lc3eeh
	ld a,014h
	ld (0c585h),a
	jr lc3d4h
lc3eeh:
	ld hl,0c58eh
	ld b,020h
	ld a,e	
lc3f4h:
	cp 02fh
	jr z,lc407h
	or a	
	jr z,lc407h
	xor a	
	cp b	
	jr z,lc402h
	ld (hl),e	
	inc hl	
	dec b	
lc402h:
	call sub_c4a1h
	jr lc3f4h
lc407h:
	xor a	
	ld (hl),a	
	ld a,e	
lc40ah:
	cp 02fh
	jr nz,lc413h
	call sub_c4a1h
	jr lc40ah
lc413h:
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
	ld (0c5afh),hl
	ld hl,00000h
lc428h:
	push hl	
	push ix
	call sub_c388h
	ld b,h	
	ld c,l	
	ld h,(ix+042h)
	ld l,(ix+041h)
	call sub_c191h
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld d,010h
lc441h:
	push hl	
	ld hl,(0c5afh)
	ld a,h	
	or l	
	jr z,lc492h
	dec hl	
	ld (0c5afh),hl
	pop hl	
	push hl	
	inc hl	
	inc hl	
	ld bc,0c58eh
	ld a,01eh
lc456h:
	ex af,af'	
	ld a,(bc)	
	cp (hl)	
	jr nz,lc466h
	or a	
	jr z,lc477h
	ex af,af'	
	dec a	
	jr z,lc477h
	inc hl	
	inc bc	
	jr lc456h
lc466h:
	pop hl	
	ld bc,00020h
	add hl,bc	
	dec d	
	jr nz,lc441h
	call sub_c270h
	pop ix
	pop hl	
	inc hl	
	jr lc428h
lc477h:
	pop hl	
	ld c,(hl)	
	inc hl	
	ld b,(hl)	
	call sub_c270h
	pop ix
	pop hl	
	ld h,(ix+042h)
	ld l,(ix+041h)
	push hl	
	call sub_c37ch
	pop hl	
	call sub_c2b4h
	jp lc3ceh
lc492h:
	pop hl	
	call sub_c270h
	pop ix
	pop hl	
	ld a,002h
	ld (0c585h),a
	jp lc3d4h
sub_c4a1h:
	push hl	
	ld hl,(0c5adh)
	call sub_c072h
	pop hl	
	ld e,a	
	ret	
lc4abh:
	push hl	
	ld hl,(0c586h)
	ld a,(hl)	
	inc hl	
	ld (0c586h),hl
	pop hl	
	ret	
sub_c4b6h:
	call 0c4c9h
	ret	
lc4bah:
	out (0c4h),a
	ld h,e	
	rst 10h	
	ret z	
	call nz,0c4c8h
	ret z	
	call nz,0c4c8h
	ret z	
	call nz,006c9h
	jr nz,lc50ah
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d765h
	call sub_c024h
	ld a,(0d763h)
	or a	
	jr z,lc4e4h
	ret	
lc4e4h:
	ld ix,0d765h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d763h),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc4fbh
	ld a,003h
lc4fbh:
	ld (0d769h),a
	ld a,(ix+00ah)
	ld (0d76ah),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc50ah:
	rlca	
	or (ix+004h)
	ld (0d76bh),a
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
	ld (0d76ch),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc52fh:
	jr z,lc538h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc52fh
lc538h:
	ld (0d76eh),hl
	ld b,007h
	ld hl,0d769h
lc540h:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc540h
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc4e4h
	xor a	
	ld (0d763h),a
	ld hl,0d765h
	call sub_c04eh
	jr nz,lc4e4h
	ret	
lc560h:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc56ah:
	ld a,(bc)	
	dec c	
	nop	
lc56dh:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc574h
lc574h:
	cpl	
	ld (hl),h	
	ld h,l	
	ld (hl),e	
	ld (hl),h	
	ld l,074h
	ld a,b	
	ld (hl),h	
	nop	
lc57eh:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
