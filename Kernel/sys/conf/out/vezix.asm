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
	ld sp,0c622h
	xor a	
	ld hl,0d80eh
	ld de,0c5b4h
	push de	
	sbc hl,de
	dec hl	
	ld b,h	
	ld c,l	
	pop hl	
	inc de	
	ld (hl),a	
	ldir
	call sub_c182h
	ld hl,lc58fh
	call sub_c130h
	ld hl,lc59ch
	call sub_c130h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c13dh
	ld hl,lc599h
	call sub_c130h
	call sub_c254h
	call sub_c4e5h
	call sub_c27fh
	ld hl,00000h
	ld bc,00000h
	call sub_c18bh
	ld h,(ix+007h)
	ld l,(ix+006h)
	inc (hl)	
	call sub_c1b2h
	call sub_c277h
	ld hl,00000h
	ld bc,00000h
	call sub_c18bh
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld bc,00200h
	call sub_c0deh
	halt	
sub_c0deh:
	call sub_c003h
	ld d,b	
	ld e,c	
lc0e3h:
	ld c,010h
	ld b,00ah
	call sub_c16ah
	ld b,00dh
	call sub_c16ah
	push hl	
	call sub_c10fh
	ld b,03ah
	call sub_c16ah
	pop hl	
lc0f9h:
	ld b,020h
	call sub_c16ah
	push hl	
	ld h,(hl)	
	call sub_c115h
	pop hl	
	inc hl	
	dec de	
	ld a,d	
	or e	
	ret z	
	dec c	
	jr nz,lc0f9h
	jr lc0e3h
	ret	
sub_c10fh:
	push hl	
	call sub_c115h
	pop hl	
	ld h,l	
sub_c115h:
	call sub_c003h
	ld a,h	
	rra	
	rra	
	rra	
	rra	
	call sub_c121h
	ld a,h	
sub_c121h:
	and 00fh
	add a,030h
	cp 03ah
	jr c,lc12bh
	add a,027h
lc12bh:
	ld b,a	
	call sub_c16ah
	ret	
sub_c130h:
	call sub_c003h
lc133h:
	ld a,(hl)	
	or a	
	ret z	
	ld b,a	
	call sub_c16ah
	inc hl	
	jr lc133h
sub_c13dh:
	call sub_c003h
	ld d,030h
	ld bc,0d8f0h
	call sub_c15eh
	ld bc,0fc18h
	call sub_c15eh
	ld bc,0ff9ch
	call sub_c15eh
	ld bc,0fff6h
	call sub_c15eh
	ld bc,0ffffh
	dec d	
sub_c15eh:
	ld a,02fh
lc160h:
	inc a	
	add hl,bc	
	jr c,lc160h
	sbc hl,bc
	ld b,a	
	cp d	
	ret z	
	dec d	
sub_c16ah:
	in a,(010h)
	and 002h
	jr z,sub_c16ah
	ld a,b	
	out (011h),a
	ret	
sub_c174h:
	ld hl,lc5adh
	call sub_c130h
	pop hl	
	call sub_c13dh
lc17eh:
	di	
	halt	
	jr lc17eh
sub_c182h:
	ld a,003h
	out (010h),a
	ld a,015h
	out (010h),a
	ret	
sub_c18bh:
	call sub_c003h
	call sub_c1bfh
	bit 1,(ix+002h)
	ret nz	
	set 0,(ix+002h)
lc19ah:
	ld e,(ix+00bh)
	ld h,004h
	call sub_c063h
	ld de,lc4e9h
	add hl,de	
	ld a,(hl)	
	inc hl	
	ld h,(hl)	
	ld l,a	
	push ix
	call sub_c072h
	pop ix
	ret	
sub_c1b2h:
	call sub_c003h
	res 1,(ix+002h)
	res 0,(ix+002h)
	jr lc19ah
sub_c1bfh:
	call sub_c003h
	xor a	
	ld ix,0d222h
	ld iy,00000h
	ex af,af'	
	ld a,006h
lc1ceh:
	ex af,af'	
	ex de,hl	
	bit 7,d
	jr nz,lc1f0h
	ld h,(ix+00bh)
	ld l,(ix+00ah)
	or a	
	sbc hl,de
	jr nz,lc1f0h
	ld h,(ix+009h)
	ld l,(ix+008h)
	or a	
	sbc hl,bc
	jr nz,lc1f0h
	push ix
	pop iy
	jr lc236h
lc1f0h:
	bit 3,(ix+002h)
	jr nz,lc204h
	cp (ix+005h)
	jr z,lc1fdh
	jr nc,lc204h
lc1fdh:
	push ix
	pop iy
	ld a,(ix+005h)
lc204h:
	ld hl,0000dh
	ex de,hl	
	add ix,de
	ex af,af'	
	dec a	
	jr nz,lc1ceh
	push bc	
	push hl	
	push iy
	pop ix
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	xor a	
	cp d	
	jr nz,lc220h
	cp e	
	call z,sub_c174h
lc220h:
	bit 4,(ix+002h)
	pop hl	
	ld (ix+00bh),h
	ld (ix+00ah),l
	pop hl	
	ld (ix+009h),h
	ld (ix+008h),l
	ld (ix+002h),008h
lc236h:
	ld c,006h
	ld iy,0d222h
	ld a,(ix+005h)
lc23fh:
	cp (iy+005h)
	jr c,lc247h
	inc (iy+005h)
lc247h:
	ld de,0000dh
	add iy,de
	dec c	
	jr nz,lc23fh
	ld (ix+005h),000h
	ret	
sub_c254h:
	ld c,006h
	ld hl,0c622h
	ld ix,0d222h
	xor a	
lc25eh:
	ld (ix+007h),h
	ld (ix+006h),l
	ld (ix+003h),c
	call sub_c277h
	ld de,0000dh
	add ix,de
	ld de,00200h
	add hl,de	
	dec c	
	jr nz,lc25eh
	ret	
sub_c277h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)
	ld (ix+002h),a
	ret	
sub_c27fh:
	ld h,0ffh
	call sub_c1bfh
	push ix
	ld hl,00000h
	ld bc,00001h
	call sub_c18bh
	pop iy
	ld a,(ix+00ch)
	or a	
	call nz,sub_c174h
	ld bc,00200h
	ld d,(iy+007h)
	ld e,(iy+006h)
	ld h,(ix+007h)
	ld l,(ix+006h)
	ldir
	call sub_c277h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ex de,hl	
	ld (0d272h),hl
	ld hl,00000h
	ld (0d270h),hl
	ret	
sub_c2bbh:
	call sub_c003h
	ex de,hl	
lc2bfh:
	ld ix,0d288h
	ld a,014h
	ld iy,00000h
lc2c9h:
	ld h,(ix+042h)
	ld l,(ix+041h)
	or a	
	sbc hl,de
	jr nz,lc30ch
	ld h,(ix+044h)
	ld l,(ix+043h)
	or a	
	sbc hl,bc
	jr nz,lc30ch
	bit 3,(ix+040h)
	ret z	
	ld iy,0d270h
	ld c,000h
lc2eah:
	ld a,(iy+005h)
	defb 0ddh,0bch	;cp ixh
	jr nz,lc301h
	ld a,(iy+004h)
	defb 0ddh,0bdh	;cp ixl
	jr nz,lc301h
	ld bc,00001h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	jr lc2bfh
lc301h:
	ld de,00006h
	add iy,de
	dec c	
	jr nz,lc2eah
	call sub_c174h
lc30ch:
	ex af,af'	
	xor a	
	cp (ix+045h)
	jr nz,lc317h
	push ix
	pop iy
lc317h:
	ex af,af'	
	ld hl,00046h
	ex de,hl	
	add ix,de
	ex de,hl	
	dec a	
	jr nz,lc2c9h
	defb 0fdh,0bch	;cp iyh
	jr nz,lc330h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc330h
	ld a,017h
	ld (0c5b4h),a
	ret	
lc330h:
	ld (iy+042h),d
	ld (iy+041h),e
	ld (iy+044h),b
	ld (iy+043h),c
	inc (iy+045h)
	call sub_c367h
	call sub_c356h
	defb 0fdh,054h	;ld d,iyh
	defb 0fdh,05dh	;ld e,iyl
	ld bc,00040h
	ldir
	call sub_c277h
	push iy
	pop ix
	ret	
sub_c356h:
	ld h,040h
	ld a,007h
	and e	
	ld e,a	
	call sub_c063h
	ld d,(ix+007h)
	ld e,(ix+006h)
	add hl,de	
	ret	
sub_c367h:
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
	call sub_c18bh
	pop iy
	ret	
sub_c383h:
	xor a	
	dec (ix+045h)
	ret nz	
	ld (ix+040h),a
	ld (ix+043h),a
	ret	
sub_c38fh:
	call sub_c003h
	xor a	
	cp h	
	jr nz,lc3adh
	ld a,l	
	cp 012h
	jr nc,lc3adh
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
lc3adh:
	ret	
	call sub_c003h
	ld (0c5dch),hl
	ld hl,(0c5bbh)
	ld b,h	
	ld c,l	
	ld hl,(0c5b9h)
	call sub_c4a8h
	cp 02fh
	jr nz,lc3c9h
	ld hl,00000h
	ld bc,00001h
lc3c9h:
	call sub_c2bbh
lc3cch:
	jr nz,lc3d5h
	call sub_c4a8h
	cp 02fh
	jr lc3cch
lc3d5h:
	ld a,(0c5b4h)
	or a	
	jr z,lc3e3h
lc3dbh:
	call sub_c383h
	ld ix,00000h
	ret	
lc3e3h:
	cp e	
	ret z	
	ld a,(ix+001h)
	and 060h
	xor 040h
	jr z,lc3f5h
	ld a,014h
	ld (0c5b4h),a
	jr lc3dbh
lc3f5h:
	ld hl,0c5bdh
	ld b,020h
	ld a,e	
lc3fbh:
	cp 02fh
	jr z,lc40eh
	or a	
	jr z,lc40eh
	xor a	
	cp b	
	jr z,lc409h
	ld (hl),e	
	inc hl	
	dec b	
lc409h:
	call sub_c4a8h
	jr lc3fbh
lc40eh:
	xor a	
	ld (hl),a	
	ld a,e	
lc411h:
	cp 02fh
	jr nz,lc41ah
	call sub_c4a8h
	jr lc411h
lc41ah:
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
	ld (0c5deh),hl
	ld hl,00000h
lc42fh:
	push hl	
	push ix
	call sub_c38fh
	ld b,h	
	ld c,l	
	ld h,(ix+042h)
	ld l,(ix+041h)
	call sub_c18bh
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld d,010h
lc448h:
	push hl	
	ld hl,(0c5deh)
	ld a,h	
	or l	
	jr z,lc499h
	dec hl	
	ld (0c5deh),hl
	pop hl	
	push hl	
	inc hl	
	inc hl	
	ld bc,0c5bdh
	ld a,01eh
lc45dh:
	ex af,af'	
	ld a,(bc)	
	cp (hl)	
	jr nz,lc46dh
	or a	
	jr z,lc47eh
	ex af,af'	
	dec a	
	jr z,lc47eh
	inc hl	
	inc bc	
	jr lc45dh
lc46dh:
	pop hl	
	ld bc,00020h
	add hl,bc	
	dec d	
	jr nz,lc448h
	call sub_c277h
	pop ix
	pop hl	
	inc hl	
	jr lc42fh
lc47eh:
	pop hl	
	ld c,(hl)	
	inc hl	
	ld b,(hl)	
	call sub_c277h
	pop ix
	pop hl	
	ld h,(ix+042h)
	ld l,(ix+041h)
	push hl	
	call sub_c383h
	pop hl	
	call sub_c2bbh
	jp lc3d5h
lc499h:
	pop hl	
	call sub_c277h
	pop ix
	pop hl	
	ld a,002h
	ld (0c5b4h),a
	jp lc3dbh
sub_c4a8h:
	push hl	
	ld hl,(0c5dch)
	call sub_c072h
	pop hl	
	ld e,a	
	ret	
	push hl	
	ld hl,(0c5b5h)
	ld a,(hl)	
	inc hl	
	ld (0c5b5h),hl
	pop hl	
	ret	
	call sub_c003h
lc4c0h:
	ld a,(0d800h)
	or a	
	jr z,sub_c4e5h
	jr lc4c0h
	inc a	
	ld (0d800h),a
	push ix
	ld hl,0ffffh
	call sub_c1bfh
	ld (0c5deh),ix
	pop ix
	call sub_c383h
	ld ix,(0c5deh)
	call sub_c277h
	ret	
sub_c4e5h:
	call 0c4f8h
	ret	
lc4e9h:
	ld (bc),a	
	push bc	
	ld bc,0f7d8h
	call nz,0c4f7h
	rst 30h	
	call nz,0c4f7h
	rst 30h	
	call nz,006c9h
	jr nz,lc539h
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d803h
	call sub_c024h
	ld a,(0d801h)
	or a	
	jr z,lc513h
	ret	
lc513h:
	ld ix,0d803h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d801h),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc52ah
	ld a,003h
lc52ah:
	ld (0d807h),a
	ld a,(ix+00ah)
	ld (0d808h),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc539h:
	rlca	
	or (ix+004h)
	ld (0d809h),a
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
	ld (0d80ah),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc55eh:
	jr z,lc567h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc55eh
lc567h:
	ld (0d80ch),hl
	ld b,007h
	ld hl,0d807h
lc56fh:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc56fh
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc513h
	xor a	
	ld (0d801h),a
	ld hl,0d803h
	call sub_c04eh
	jr nz,lc513h
	ret	
lc58fh:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc599h:
	ld a,(bc)	
	dec c	
	nop	
lc59ch:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc5a3h
lc5a3h:
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
lc5adh:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
