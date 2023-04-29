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
	ld sp,0c5f0h
	xor a	
	ld hl,0d7dbh
	ld de,0c582h
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
	ld hl,lc55dh
	call sub_c133h
	ld hl,lc56ah
	call sub_c133h
	xor a	
	ld hl,lc000h
	ld de,00000h
	sbc hl,de
	call sub_c140h
	ld hl,lc567h
	call sub_c133h
	call sub_c24ah
	call sub_c4b3h
	call sub_c275h
	ld hl,lc571h
	ld (0c583h),hl
	ld hl,lc4a8h
	call sub_c3a4h
	defb 0ddh,054h	;ld d,ixh
	defb 0ddh,05dh	;ld e,ixl
	ex de,hl	
	ld bc,00046h
	call sub_c0e1h
	ld hl,00000h
	call sub_c385h
	ld b,h	
	ld c,l	
	ld hl,00000h
	call sub_c18eh
	ld h,(ix+007h)
	ld l,(ix+006h)
	call sub_c133h
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
	ld hl,lc57bh
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
	ld de,lc4b7h
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
	ld ix,0d1f0h
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
	ld iy,0d1f0h
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
	ld hl,0c5f0h
	ld ix,0d1f0h
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
	ld (0d240h),hl
	ld hl,00000h
	ld (0d23eh),hl
	ret	
sub_c2b1h:
	call sub_c003h
	ex de,hl	
lc2b5h:
	ld ix,0d256h
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
	ld iy,0d23eh
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
	jr nz,lc326h
	defb 0fdh,0bdh	;cp iyl
	jr nz,lc326h
	ld a,017h
	ld (0c582h),a
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
	call sub_c26dh
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
	call sub_c18eh
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
	ld (0c5aah),hl
	ld hl,(0c589h)
	ld b,h	
	ld c,l	
	ld hl,(0c587h)
	call sub_c49eh
	cp 02fh
	jr nz,lc3bfh
	ld hl,00000h
	ld bc,00001h
lc3bfh:
	call sub_c2b1h
lc3c2h:
	jr nz,lc3cbh
	call sub_c49eh
	cp 02fh
	jr lc3c2h
lc3cbh:
	ld a,(0c582h)
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
	ld (0c582h),a
	jr lc3d1h
lc3ebh:
	ld hl,0c58bh
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
	call sub_c49eh
	jr lc3f1h
lc404h:
	xor a	
	ld (hl),a	
	ld a,e	
lc407h:
	cp 02fh
	jr nz,lc410h
	call sub_c49eh
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
	ld (0c5ach),hl
	ld hl,00000h
lc425h:
	push hl	
	push ix
	call sub_c385h
	ld b,h	
	ld c,l	
	ld h,(ix+042h)
	ld l,(ix+041h)
	call sub_c18eh
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld d,010h
lc43eh:
	push hl	
	ld hl,(0c5ach)
	ld a,h	
	or l	
	jr z,lc48fh
	dec hl	
	ld (0c5ach),hl
	pop hl	
	push hl	
	inc hl	
	inc hl	
	ld bc,0c58bh
	ld a,01eh
lc453h:
	ex af,af'	
	ld a,(bc)	
	cp (hl)	
	jr nz,lc463h
	or a	
	jr z,lc474h
	ex af,af'	
	dec a	
	jr z,lc474h
	inc hl	
	inc bc	
	jr lc453h
lc463h:
	pop hl	
	ld bc,00020h
	add hl,bc	
	dec d	
	jr nz,lc43eh
	call sub_c26dh
	pop ix
	pop hl	
	inc hl	
	jr lc425h
lc474h:
	pop hl	
	ld c,(hl)	
	inc hl	
	ld b,(hl)	
	call sub_c26dh
	pop ix
	pop hl	
	ld h,(ix+042h)
	ld l,(ix+041h)
	push hl	
	call sub_c379h
	pop hl	
	call sub_c2b1h
	jp lc3cbh
lc48fh:
	pop hl	
	call sub_c26dh
	pop ix
	pop hl	
	ld a,002h
	ld (0c582h),a
	jp lc3d1h
sub_c49eh:
	push hl	
	ld hl,(0c5aah)
	call sub_c072h
	pop hl	
	ld e,a	
	ret	
lc4a8h:
	push hl	
	ld hl,(0c583h)
	ld a,(hl)	
	inc hl	
	ld (0c583h),hl
	pop hl	
	ret	
sub_c4b3h:
	call 0c4c6h
	ret	
lc4b7h:
	ret nc	
	call nz,0d7ceh
	push bc	
	call nz,0c4c5h
	push bc	
	call nz,0c4c5h
	push bc	
	call nz,006c9h
	jr nz,lc507h
	ld bc,0fdd3h
	dec b	
	jr nz,$-3
	ret	
	xor a	
	ld (ix+004h),a
	ld hl,0d7d0h
	call sub_c024h
	ld a,(0d7ceh)
	or a	
	jr z,lc4e1h
	ret	
lc4e1h:
	ld ix,0d7d0h
	call sub_c012h
	ret z	
	ld a,001h
	ld (0d7ceh),a
	ld a,002h
	bit 0,(ix+002h)
	jr nz,lc4f8h
	ld a,003h
lc4f8h:
	ld (0d7d4h),a
	ld a,(ix+00ah)
	ld (0d7d5h),a
	ld a,(ix+008h)
	and 007h
	rlca	
lc507h:
	rlca	
	or (ix+004h)
	ld (0d7d6h),a
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
	ld (0d7d7h),hl
	ld h,(ix+007h)
	ld l,(ix+006h)
	ld a,(ix+004h)
	or a	
lc52ch:
	jr z,lc535h
	ld de,00080h
	add hl,de	
	dec a	
	jr lc52ch
lc535h:
	ld (0d7d9h),hl
	ld b,007h
	ld hl,0d7d4h
lc53dh:
	ld a,(hl)	
	out (0fdh),a
	inc hl	
	dec b	
	jr nz,lc53dh
	in a,(0fdh)
	ld a,004h
	inc (ix+004h)
	cp (ix+004h)
	jr nz,lc4e1h
	xor a	
	ld (0d7ceh),a
	ld hl,0d7d0h
	call sub_c04eh
	jr nz,lc4e1h
	ret	
lc55dh:
	halt	
	ld h,l	
	ld a,d	
	ld l,c	
	ld a,b	
	jr nz,$+100
	ld l,a	
	ld l,a	
	ld (hl),h	
lc567h:
	ld a,(bc)	
	dec c	
	nop	
lc56ah:
	ld l,l	
	ld h,l	
	ld l,l	
	jr nz,$+63
	jr nz,lc571h
lc571h:
	cpl	
	ld (hl),h	
	ld h,l	
	ld (hl),e	
	ld (hl),h	
	ld l,074h
	ld a,b	
	ld (hl),h	
	nop	
lc57bh:
	ld (hl),b	
	ld h,c	
	ld l,(hl)	
	ld l,c	
	ld h,e	
	jr nz,$+2
