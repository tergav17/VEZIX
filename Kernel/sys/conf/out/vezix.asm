; z80dasm 1.1.6
; command line: z80dasm -lag 0xC000 -o vezix.asm vezix

	org	0c000h

lc000h:
	jp lc073h		;c000
sub_c003h:
	pop iy		;c003
	push af			;c005
	push bc			;c006
	push de			;c007
	ld de,lc00eh		;c008
	push de			;c00b
	jp (iy)		;c00c
lc00eh:
	pop de			;c00e
	pop bc			;c00f
	pop af			;c010
	ret			;c011
sub_c012h:
	push de			;c012
	defb 0ddh,054h	;ld d,ixh		;c013
	defb 0ddh,05dh	;ld e,ixl		;c015
	ld a,(de)			;c017
	inc de			;c018
	or a			;c019
	defb 0ddh,06fh	;ld ixl,a		;c01a
	ld a,(de)			;c01c
	defb 0ddh,067h	;ld ixh,a		;c01d
	jr nz,lc022h		;c01f
	or a			;c021
lc022h:
	pop de			;c022
	ret			;c023
sub_c024h:
	xor a			;c024
	ld (ix+000h),a		;c025
	ld (ix+001h),a		;c028
	cp (hl)			;c02b
	jr nz,lc041h		;c02c
	inc hl			;c02e
	cp (hl)			;c02f
	dec hl			;c030
	jr nz,lc041h		;c031
	call sub_c038h		;c033
	inc hl			;c036
	inc hl			;c037
sub_c038h:
	defb 0ddh,07dh	;ld a,ixl		;c038
	ld (hl),a			;c03a
	inc hl			;c03b
	defb 0ddh,07ch	;ld a,ixh		;c03c
	ld (hl),a			;c03e
	dec hl			;c03f
	ret			;c040
lc041h:
	inc hl			;c041
	inc hl			;c042
	push hl			;c043
	ld a,(hl)			;c044
	inc hl			;c045
	ld h,(hl)			;c046
	ld l,a			;c047
	call sub_c038h		;c048
	pop hl			;c04b
	jr sub_c038h		;c04c
sub_c04eh:
	xor a			;c04e
	cp (hl)			;c04f
	jr nz,lc056h		;c050
	inc hl			;c052
	cp (hl)			;c053
	dec hl			;c054
	ret z			;c055
lc056h:
	ld a,(ix+000h)		;c056
	ld (hl),a			;c059
	inc hl			;c05a
	ld a,(ix+001h)		;c05b
	ld (hl),a			;c05e
	ld a,001h		;c05f
	or a			;c061
	ret			;c062
sub_c063h:
	push bc			;c063
	ld d,000h		;c064
	ld l,d			;c066
	ld b,008h		;c067
lc069h:
	add hl,hl			;c069
	jp nc,lc06eh		;c06a
	add hl,de			;c06d
lc06eh:
	djnz lc069h		;c06e
	pop bc			;c070
	ret			;c071
sub_c072h:
	jp (hl)			;c072
lc073h:
	di			;c073
	ld sp,0c78ah		;c074
	xor a			;c077
	ld hl,0d96fh		;c078
	ld de,0c6f5h		;c07b
	push de			;c07e
	sbc hl,de		;c07f
	dec hl			;c081
	ld b,h			;c082
	ld c,l			;c083
	pop hl			;c084
	inc de			;c085
	ld (hl),a			;c086
	ldir		;c087
	call sub_c177h		;c089
	ld hl,lc6d0h		;c08c
	call sub_c121h		;c08f
	ld hl,lc6ddh		;c092
	call sub_c121h		;c095
	xor a			;c098
	ld hl,lc000h		;c099
	ld de,04000h		;c09c
	sbc hl,de		;c09f
	call sub_c12eh		;c0a1
	ld hl,lc6dah		;c0a4
	call sub_c121h		;c0a7
	call sub_c24ch		;c0aa
	call sub_c628h		;c0ad
	call sub_c27eh		;c0b0
	ld hl,lc6e4h		;c0b3
	ld (0c6f6h),hl		;c0b6
	ld hl,lc4abh		;c0b9
	call sub_c3aah		;c0bc
	ld a,(0c6f5h)		;c0bf
	jp lc0cch		;c0c2
	or a			;c0c5
	jp nz,lc165h		;c0c6
	call sub_c4c3h		;c0c9
lc0cch:
	jp lc0cch		;c0cc
	call sub_c003h		;c0cf
	ld d,b			;c0d2
	ld e,c			;c0d3
lc0d4h:
	ld c,010h		;c0d4
	ld b,00ah		;c0d6
	call sub_c15bh		;c0d8
	ld b,00dh		;c0db
	call sub_c15bh		;c0dd
	push hl			;c0e0
	call sub_c100h		;c0e1
	ld b,03ah		;c0e4
	call sub_c15bh		;c0e6
	pop hl			;c0e9
lc0eah:
	ld b,020h		;c0ea
	call sub_c15bh		;c0ec
	push hl			;c0ef
	ld h,(hl)			;c0f0
	call sub_c106h		;c0f1
	pop hl			;c0f4
	inc hl			;c0f5
	dec de			;c0f6
	ld a,d			;c0f7
	or e			;c0f8
	ret z			;c0f9
	dec c			;c0fa
	jr nz,lc0eah		;c0fb
	jr lc0d4h		;c0fd
	ret			;c0ff
sub_c100h:
	push hl			;c100
	call sub_c106h		;c101
	pop hl			;c104
	ld h,l			;c105
sub_c106h:
	call sub_c003h		;c106
	ld a,h			;c109
	rra			;c10a
	rra			;c10b
	rra			;c10c
	rra			;c10d
	call sub_c112h		;c10e
	ld a,h			;c111
sub_c112h:
	and 00fh		;c112
	add a,030h		;c114
	cp 03ah		;c116
	jr c,lc11ch		;c118
	add a,027h		;c11a
lc11ch:
	ld b,a			;c11c
	call sub_c15bh		;c11d
	ret			;c120
sub_c121h:
	call sub_c003h		;c121
lc124h:
	ld a,(hl)			;c124
	or a			;c125
	ret z			;c126
	ld b,a			;c127
	call sub_c15bh		;c128
	inc hl			;c12b
	jr lc124h		;c12c
sub_c12eh:
	call sub_c003h		;c12e
	ld d,030h		;c131
	ld bc,0d8f0h		;c133
	call sub_c14fh		;c136
	ld bc,0fc18h		;c139
	call sub_c14fh		;c13c
	ld bc,0ff9ch		;c13f
	call sub_c14fh		;c142
	ld bc,0fff6h		;c145
	call sub_c14fh		;c148
	ld bc,0ffffh		;c14b
	dec d			;c14e
sub_c14fh:
	ld a,02fh		;c14f
lc151h:
	inc a			;c151
	add hl,bc			;c152
	jr c,lc151h		;c153
	sbc hl,bc		;c155
	ld b,a			;c157
	cp d			;c158
	ret z			;c159
	dec d			;c15a
sub_c15bh:
	in a,(080h)		;c15b
	bit 1,a		;c15d
	jr z,sub_c15bh		;c15f
	ld a,b			;c161
	out (081h),a		;c162
	ret			;c164
lc165h:
	ld h,000h		;c165
	ld l,a			;c167
	push hl			;c168
	ld hl,lc6eeh		;c169
	call sub_c121h		;c16c
	pop hl			;c16f
	call sub_c12eh		;c170
lc173h:
	di			;c173
	halt			;c174
	jr lc173h		;c175
sub_c177h:
	ld a,003h		;c177
	out (080h),a		;c179
	ld a,016h		;c17b
	out (080h),a		;c17d
	ret			;c17f
sub_c180h:
	call sub_c003h		;c180
	call sub_c1b4h		;c183
	bit 1,(ix+002h)		;c186
	ret nz			;c18a
	set 0,(ix+002h)		;c18b
lc18fh:
	ld e,(ix+00bh)		;c18f
	ld h,004h		;c192
	call sub_c063h		;c194
	ld de,lc62ch		;c197
	add hl,de			;c19a
	ld a,(hl)			;c19b
	inc hl			;c19c
	ld h,(hl)			;c19d
	ld l,a			;c19e
	push ix		;c19f
	call sub_c072h		;c1a1
	pop ix		;c1a4
	ret			;c1a6
sub_c1a7h:
	call sub_c003h		;c1a7
	res 1,(ix+002h)		;c1aa
	res 0,(ix+002h)		;c1ae
	jr lc18fh		;c1b2
sub_c1b4h:
	call sub_c003h		;c1b4
	xor a			;c1b7
	ld ix,0d38ah		;c1b8
	ld iy,00000h		;c1bc
	ex af,af'			;c1c0
	ld a,006h		;c1c1
lc1c3h:
	ex af,af'			;c1c3
	ex de,hl			;c1c4
	bit 7,d		;c1c5
	jr nz,lc1e5h		;c1c7
	ld h,(ix+00bh)		;c1c9
	ld l,(ix+00ah)		;c1cc
	or a			;c1cf
	sbc hl,de		;c1d0
	jr nz,lc1e5h		;c1d2
	ld h,(ix+009h)		;c1d4
	ld l,(ix+008h)		;c1d7
	or a			;c1da
	sbc hl,bc		;c1db
	jr nz,lc1e5h		;c1dd
	push ix		;c1df
	pop iy		;c1e1
	jr lc22eh		;c1e3
lc1e5h:
	bit 3,(ix+002h)		;c1e5
	jr nz,lc1f9h		;c1e9
	cp (ix+005h)		;c1eb
	jr z,lc1f2h		;c1ee
	jr nc,lc1f9h		;c1f0
lc1f2h:
	push ix		;c1f2
	pop iy		;c1f4
	ld a,(ix+005h)		;c1f6
lc1f9h:
	ld hl,0000dh		;c1f9
	ex de,hl			;c1fc
	add ix,de		;c1fd
	ex af,af'			;c1ff
	dec a			;c200
	jr nz,lc1c3h		;c201
	push bc			;c203
	push hl			;c204
	push iy		;c205
	pop ix		;c207
	defb 0fdh,054h	;ld d,iyh		;c209
	defb 0fdh,05dh	;ld e,iyl		;c20b
	xor a			;c20d
	cp d			;c20e
	jr nz,lc215h		;c20f
	cp e			;c211
	call z,lc165h		;c212
lc215h:
	bit 4,(ix+002h)		;c215
	call nz,sub_c1a7h		;c219
	pop hl			;c21c
	ld (ix+00bh),h		;c21d
	ld (ix+00ah),l		;c220
	pop hl			;c223
	ld (ix+009h),h		;c224
	ld (ix+008h),l		;c227
	ld (ix+002h),008h		;c22a
lc22eh:
	ld c,006h		;c22e
	ld iy,0d38ah		;c230
	ld a,(ix+005h)		;c234
lc237h:
	cp (iy+005h)		;c237
	jr c,lc23fh		;c23a
	inc (iy+005h)		;c23c
lc23fh:
	ld de,0000dh		;c23f
	add iy,de		;c242
	dec c			;c244
	jr nz,lc237h		;c245
	ld (ix+005h),000h		;c247
	ret			;c24b
sub_c24ch:
	ld c,006h		;c24c
	ld hl,0c78ah		;c24e
	ld ix,0d38ah		;c251
	xor a			;c255
lc256h:
	ld (ix+007h),h		;c256
	ld (ix+006h),l		;c259
	ld (ix+003h),c		;c25c
	call sub_c26fh		;c25f
	ld de,0000dh		;c262
	add ix,de		;c265
	ld de,00200h		;c267
	add hl,de			;c26a
	dec c			;c26b
	jr nz,lc256h		;c26c
	ret			;c26e
sub_c26fh:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)		;c26f
	ld (ix+002h),a		;c273
	ret			;c276
sub_c277h:
	ld h,(ix+007h)		;c277
	ld l,(ix+006h)		;c27a
	ret			;c27d
sub_c27eh:
	ld h,0ffh		;c27e
	call sub_c1b4h		;c280
	push ix		;c283
	ld hl,00000h		;c285
	ld bc,00001h		;c288
	call sub_c180h		;c28b
	pop iy		;c28e
	ld a,(ix+00ch)		;c290
	or a			;c293
	call nz,lc165h		;c294
	ld bc,00200h		;c297
	ld d,(iy+007h)		;c29a
	ld e,(iy+006h)		;c29d
	call sub_c277h		;c2a0
	ldir		;c2a3
	call sub_c26fh		;c2a5
	defb 0fdh,054h	;ld d,iyh		;c2a8
	defb 0fdh,05dh	;ld e,iyl		;c2aa
	ex de,hl			;c2ac
	ld (0d3dah),hl		;c2ad
	ld hl,00000h		;c2b0
	ld (0d3d8h),hl		;c2b3
	ret			;c2b6
sub_c2b7h:
	call sub_c003h		;c2b7
	ex de,hl			;c2ba
lc2bbh:
	ld ix,0d3f0h		;c2bb
	ld a,014h		;c2bf
	ld iy,00000h		;c2c1
lc2c5h:
	ld h,(ix+042h)		;c2c5
	ld l,(ix+041h)		;c2c8
	or a			;c2cb
	sbc hl,de		;c2cc
	jr nz,lc308h		;c2ce
	ld h,(ix+044h)		;c2d0
	ld l,(ix+043h)		;c2d3
	or a			;c2d6
	sbc hl,bc		;c2d7
	jr nz,lc308h		;c2d9
	bit 3,(ix+040h)		;c2db
	ret z			;c2df
	ld iy,0d3d8h		;c2e0
	ld c,000h		;c2e4
lc2e6h:
	ld a,(iy+005h)		;c2e6
	defb 0ddh,0bch	;cp ixh		;c2e9
	jr nz,lc2fdh		;c2eb
	ld a,(iy+004h)		;c2ed
	defb 0ddh,0bdh	;cp ixl		;c2f0
	jr nz,lc2fdh		;c2f2
	ld bc,00001h		;c2f4
	defb 0fdh,054h	;ld d,iyh		;c2f7
	defb 0fdh,05dh	;ld e,iyl		;c2f9
	jr lc2bbh		;c2fb
lc2fdh:
	ld de,00006h		;c2fd
	add iy,de		;c300
	dec c			;c302
	jr nz,lc2e6h		;c303
	call lc165h		;c305
lc308h:
	ex af,af'			;c308
	xor a			;c309
	cp (ix+045h)		;c30a
	jr nz,lc313h		;c30d
	push ix		;c30f
	pop iy		;c311
lc313h:
	ex af,af'			;c313
	ld hl,00046h		;c314
	ex de,hl			;c317
	add ix,de		;c318
	ex de,hl			;c31a
	dec a			;c31b
	jr nz,lc2c5h		;c31c
	defb 0fdh,0bch	;cp iyh		;c31e
	jr nz,lc32ch		;c320
	defb 0fdh,0bdh	;cp iyl		;c322
	jr nz,lc32ch		;c324
	ld a,017h		;c326
	ld (0c6f5h),a		;c328
	ret			;c32b
lc32ch:
	ld (iy+042h),d		;c32c
	ld (iy+041h),e		;c32f
	ld (iy+044h),b		;c332
	ld (iy+043h),c		;c335
	inc (iy+045h)		;c338
	call sub_c363h		;c33b
	call sub_c352h		;c33e
	defb 0fdh,054h	;ld d,iyh		;c341
	defb 0fdh,05dh	;ld e,iyl		;c343
	ld bc,00040h		;c345
	ldir		;c348
	call sub_c26fh		;c34a
	push iy		;c34d
	pop ix		;c34f
	ret			;c351
sub_c352h:
	ld h,040h		;c352
	ld a,007h		;c354
	and e			;c356
	ld e,a			;c357
	call sub_c063h		;c358
	ld d,(ix+007h)		;c35b
	ld e,(ix+006h)		;c35e
	add hl,de			;c361
	ret			;c362
sub_c363h:
	ld h,b			;c363
	ld l,c			;c364
	ld a,l			;c365
	srl h		;c366
	rra			;c368
	srl h		;c369
	rra			;c36b
	srl h		;c36c
	rra			;c36e
	ld l,a			;c36f
	inc hl			;c370
	inc hl			;c371
	push bc			;c372
	ld b,h			;c373
	ld c,l			;c374
	pop hl			;c375
	ex de,hl			;c376
	push iy		;c377
	call sub_c180h		;c379
	pop iy		;c37c
	ret			;c37e
sub_c37fh:
	xor a			;c37f
	dec (ix+045h)		;c380
	ret nz			;c383
	ld (ix+040h),a		;c384
	ld (ix+043h),a		;c387
	ret			;c38a
sub_c38bh:
	call sub_c003h		;c38b
	xor a			;c38e
	cp h			;c38f
	jr nz,lc3a9h		;c390
	ld a,l			;c392
	cp 012h		;c393
	jr nc,lc3a9h		;c395
	sla l		;c397
	ld de,00018h		;c399
	add hl,de			;c39c
	defb 0ddh,054h	;ld d,ixh		;c39d
	defb 0ddh,05dh	;ld e,ixl		;c39f
	add hl,de			;c3a1
	ld a,(hl)			;c3a2
	inc hl			;c3a3
	ld h,(hl)			;c3a4
	ld l,a			;c3a5
	or h			;c3a6
	ret nz			;c3a7
	ret			;c3a8
lc3a9h:
	ret			;c3a9
sub_c3aah:
	call sub_c003h		;c3aa
	ld (0c727h),hl		;c3ad
	ld hl,(0c6fch)		;c3b0
	ld b,h			;c3b3
	ld c,l			;c3b4
	ld hl,(0c6fah)		;c3b5
	call sub_c4a1h		;c3b8
	cp 02fh		;c3bb
	jr nz,lc3c5h		;c3bd
	ld hl,00000h		;c3bf
	ld bc,00001h		;c3c2
lc3c5h:
	call sub_c2b7h		;c3c5
lc3c8h:
	jr nz,lc3d1h		;c3c8
	call sub_c4a1h		;c3ca
	cp 02fh		;c3cd
	jr lc3c8h		;c3cf
lc3d1h:
	ld a,(0c6f5h)		;c3d1
	or a			;c3d4
	jr z,lc3dfh		;c3d5
lc3d7h:
	call sub_c37fh		;c3d7
	ld ix,00000h		;c3da
	ret			;c3de
lc3dfh:
	cp e			;c3df
	ret z			;c3e0
	ld a,(ix+001h)		;c3e1
	and 060h		;c3e4
	xor 040h		;c3e6
	jr z,lc3f1h		;c3e8
	ld a,014h		;c3ea
	ld (0c6f5h),a		;c3ec
	jr lc3d7h		;c3ef
lc3f1h:
	ld hl,0c708h		;c3f1
	ld b,020h		;c3f4
	ld a,e			;c3f6
lc3f7h:
	cp 02fh		;c3f7
	jr z,lc40ah		;c3f9
	or a			;c3fb
	jr z,lc40ah		;c3fc
	xor a			;c3fe
	cp b			;c3ff
	jr z,lc405h		;c400
	ld (hl),e			;c402
	inc hl			;c403
	dec b			;c404
lc405h:
	call sub_c4a1h		;c405
	jr lc3f7h		;c408
lc40ah:
	xor a			;c40a
	ld (hl),a			;c40b
	ld a,e			;c40c
lc40dh:
	cp 02fh		;c40d
	jr nz,lc416h		;c40f
	call sub_c4a1h		;c411
	jr lc40dh		;c414
lc416h:
	ld h,(ix+009h)		;c416
	ld l,(ix+008h)		;c419
	xor a			;c41c
	add hl,hl			;c41d
	rla			;c41e
	add hl,hl			;c41f
	rla			;c420
	add hl,hl			;c421
	rla			;c422
	ld l,h			;c423
	ld h,a			;c424
	ld (0c729h),hl		;c425
	ld hl,00000h		;c428
lc42bh:
	push hl			;c42b
	push ix		;c42c
	call sub_c38bh		;c42e
	ld b,h			;c431
	ld c,l			;c432
	ld h,(ix+042h)		;c433
	ld l,(ix+041h)		;c436
	call sub_c180h		;c439
	call sub_c277h		;c43c
	ld d,010h		;c43f
lc441h:
	push hl			;c441
	ld hl,(0c729h)		;c442
	ld a,h			;c445
	or l			;c446
	jr z,lc492h		;c447
	dec hl			;c449
	ld (0c729h),hl		;c44a
	pop hl			;c44d
	push hl			;c44e
	inc hl			;c44f
	inc hl			;c450
	ld bc,0c708h		;c451
	ld a,01eh		;c454
lc456h:
	ex af,af'			;c456
	ld a,(bc)			;c457
	cp (hl)			;c458
	jr nz,lc466h		;c459
	or a			;c45b
	jr z,lc477h		;c45c
	ex af,af'			;c45e
	dec a			;c45f
	jr z,lc477h		;c460
	inc hl			;c462
	inc bc			;c463
	jr lc456h		;c464
lc466h:
	pop hl			;c466
	ld bc,00020h		;c467
	add hl,bc			;c46a
	dec d			;c46b
	jr nz,lc441h		;c46c
	call sub_c26fh		;c46e
	pop ix		;c471
	pop hl			;c473
	inc hl			;c474
	jr lc42bh		;c475
lc477h:
	pop hl			;c477
	ld c,(hl)			;c478
	inc hl			;c479
	ld b,(hl)			;c47a
	call sub_c26fh		;c47b
	pop ix		;c47e
	pop hl			;c480
	ld h,(ix+042h)		;c481
	ld l,(ix+041h)		;c484
	push hl			;c487
	call sub_c37fh		;c488
	pop hl			;c48b
	call sub_c2b7h		;c48c
	jp lc3d1h		;c48f
lc492h:
	pop hl			;c492
	call sub_c26fh		;c493
	pop ix		;c496
	pop hl			;c498
	ld a,002h		;c499
	ld (0c6f5h),a		;c49b
	jp lc3d7h		;c49e
sub_c4a1h:
	push hl			;c4a1
	ld hl,(0c727h)		;c4a2
	call sub_c072h		;c4a5
	pop hl			;c4a8
	ld e,a			;c4a9
	ret			;c4aa
lc4abh:
	push hl			;c4ab
	ld hl,(0c6f6h)		;c4ac
	ld a,(hl)			;c4af
	inc hl			;c4b0
	ld (0c6f6h),hl		;c4b1
	pop hl			;c4b4
	ret			;c4b5
	push hl			;c4b6
	ld hl,(0c6f6h)		;c4b7
	call sub_c5f5h		;c4ba
	inc hl			;c4bd
	ld (0c6f6h),hl		;c4be
	pop hl			;c4c1
	ret			;c4c2
sub_c4c3h:
	call sub_c003h		;c4c3
lc4c6h:
	ld a,(0d968h)		;c4c6
	or a			;c4c9
	jr z,lc4ceh		;c4ca
	jr lc4c6h		;c4cc
lc4ceh:
	inc a			;c4ce
	ld (0d968h),a		;c4cf
	ld h,(ix+042h)		;c4d2
	ld l,(ix+041h)		;c4d5
	ld (0c72bh),hl		;c4d8
	push ix		;c4db
	ld hl,0ffffh		;c4dd
	call sub_c1b4h		;c4e0
	ld (0c729h),ix		;c4e3
	xor a			;c4e7
	ld (0c733h),a		;c4e8
	exx			;c4eb
	call sub_c277h		;c4ec
	exx			;c4ef
	ld bc,00200h		;c4f0
lc4f3h:
	ld hl,(0c700h)		;c4f3
	call sub_c5f7h		;c4f6
	ld d,a			;c4f9
	or e			;c4fa
	jr z,lc519h		;c4fb
	inc hl			;c4fd
	inc hl			;c4fe
	ld (0c700h),hl		;c4ff
	ld hl,0c733h		;c502
	inc (hl)			;c505
	ex de,hl			;c506
lc507h:
	call sub_c5f5h		;c507
	inc hl			;c50a
	exx			;c50b
	ld (hl),a			;c50c
	inc hl			;c50d
	exx			;c50e
	or a			;c50f
	jp z,lc4f3h		;c510
	dec bc			;c513
	ld b,a			;c514
	or c			;c515
	jr nz,lc507h		;c516
	inc a			;c518
lc519h:
	pop ix		;c519
	jp nz,lc5eah		;c51b
	ld hl,00000h		;c51e
	push hl			;c521
	call sub_c38bh		;c522
	ld b,h			;c525
	ld c,l			;c526
	ld hl,(0c72bh)		;c527
	push ix		;c52a
	call sub_c180h		;c52c
	ld a,(0c6f5h)		;c52f
	or a			;c532
	jp nz,lc5e4h		;c533
	call sub_c277h		;c536
	ld a,018h		;c539
	cp (hl)			;c53b
	inc hl			;c53c
	jr nz,lc545h		;c53d
	ld a,00eh		;c53f
	cp (hl)			;c541
	inc hl			;c542
	jr z,lc54dh		;c543
lc545h:
	ld a,008h		;c545
	ld (0c6f5h),a		;c547
	jp lc5e4h		;c54a
lc54dh:
	inc hl			;c54d
	ld b,(hl)			;c54e
	inc hl			;c54f
	ld c,(hl)			;c550
	ex de,hl			;c551
	ld hl,04000h		;c552
	sbc hl,bc		;c555
	ld (0c72dh),hl		;c557
	ex de,hl			;c55a
	ld de,00008h		;c55b
	add hl,de			;c55e
	ld d,(hl)			;c55f
	inc hl			;c560
	ld e,(hl)			;c561
	inc hl			;c562
	ld (0c72fh),de		;c563
	ld a,(hl)			;c567
	inc hl			;c568
	ld h,(hl)			;c569
	ld l,a			;c56a
	ld b,h			;c56b
	ld c,l			;c56c
	ld de,08000h		;c56d
	or a			;c570
	sbc hl,de		;c571
	jr nc,lc57ch		;c573
	ld a,007h		;c575
	ld (0c6f5h),a		;c577
	jr lc5e4h		;c57a
lc57ch:
	ld de,04000h		;c57c
	call sub_c609h		;c57f
lc582h:
	ld hl,(0c72fh)		;c582
	ld b,h			;c585
	ld c,l			;c586
	ld de,00200h		;c587
	or a			;c58a
	sbc hl,de		;c58b
	push af			;c58d
	jr c,lc598h		;c58e
	ld b,d			;c590
	ld c,e			;c591
	ld hl,04000h		;c592
	ld (0c731h),hl		;c595
lc598h:
	call sub_c277h		;c598
	ld de,(0c731h)		;c59b
	call sub_c606h		;c59f
	ld (0c731h),de		;c5a2
	call sub_c26fh		;c5a6
	pop af			;c5a9
	jr c,lc5c6h		;c5aa
	pop ix		;c5ac
	pop hl			;c5ae
	inc hl			;c5af
	push hl			;c5b0
	call sub_c38bh		;c5b1
	ld b,h			;c5b4
	ld c,l			;c5b5
	ld hl,(0c72bh)		;c5b6
	push ix		;c5b9
	call sub_c180h		;c5bb
	ld a,(0c6f5h)		;c5be
	or a			;c5c1
	jr nz,lc5e4h		;c5c2
	jr lc582h		;c5c4
lc5c6h:
	ld hl,(0c72dh)		;c5c6
	ld a,h			;c5c9
	or l			;c5ca
	jr z,lc5cdh		;c5cb
lc5cdh:
	call sub_c37fh		;c5cd
	ld ix,(0c729h)		;c5d0
	call sub_c26fh		;c5d4
	ld hl,0bffeh		;c5d7
	ld (0c786h),hl		;c5da
	ld de,04000h		;c5dd
	call sub_c601h		;c5e0
	ret			;c5e3
lc5e4h:
	call sub_c26fh		;c5e4
	pop ix		;c5e7
	pop hl			;c5e9
lc5eah:
	call sub_c37fh		;c5ea
	ld ix,(0c729h)		;c5ed
	call sub_c26fh		;c5f1
	ret			;c5f4
sub_c5f5h:
	ld a,(hl)			;c5f5
	ret			;c5f6
sub_c5f7h:
	ld e,(hl)			;c5f7
	inc hl			;c5f8
	ld d,(hl)			;c5f9
	dec hl			;c5fa
	ret			;c5fb
	ldir		;c5fc
	ret			;c5fe
	ld (hl),a			;c5ff
	ret			;c600
sub_c601h:
	ld (hl),e			;c601
	inc hl			;c602
	ld (hl),d			;c603
	dec hl			;c604
	ret			;c605
sub_c606h:
	ldir		;c606
	ret			;c608
sub_c609h:
	ld h,d			;c609
	ld l,e			;c60a
	ld (hl),000h		;c60b
	inc de			;c60d
	dec bc			;c60e
	ldir		;c60f
	ret			;c611
	ld sp,0c774h		;c612
	pop ix		;c615
	pop iy		;c617
	pop af			;c619
	pop bc			;c61a
	pop de			;c61b
	pop hl			;c61c
	ex af,af'			;c61d
	exx			;c61e
	pop af			;c61f
	pop bc			;c620
	pop de			;c621
	pop hl			;c622
	ld sp,hl			;c623
	ld hl,(0c788h)		;c624
	ret			;c627
sub_c628h:
	call sub_c63bh		;c628
	ret			;c62b
lc62ch:
	ld c,h			;c62c
	add a,069h		;c62d
	exx			;c62f
	ld a,(03ac6h)		;c630
	add a,03ah		;c633
	add a,03ah		;c635
	add a,03ah		;c637
	add a,0c9h		;c639
sub_c63bh:
	ld a,001h		;c63b
	call sub_c645h		;c63d
	ld a,082h		;c640
	call sub_c6c1h		;c642
sub_c645h:
	out (011h),a		;c645
	ld a,0efh		;c647
	out (017h),a		;c649
	ret			;c64b
	xor a			;c64c
	ld (ix+004h),a		;c64d
	ld hl,0d96bh		;c650
	call sub_c024h		;c653
	ld a,(0d969h)		;c656
	or a			;c659
	jr z,lc65dh		;c65a
	ret			;c65c
lc65dh:
	ld ix,0d96bh		;c65d
	call sub_c012h		;c661
	ret z			;c664
	ld a,001h		;c665
	ld (0d969h),a		;c667
	ld a,001h		;c66a
	out (012h),a		;c66c
	call sub_c6c1h		;c66e
	ld a,(ix+008h)		;c671
	out (013h),a		;c674
	ld a,(ix+009h)		;c676
	out (014h),a		;c679
	ld a,(ix+00ah)		;c67b
	out (015h),a		;c67e
	ld a,0e0h		;c680
	out (016h),a		;c682
	bit 0,(ix+002h)		;c684
	jr nz,lc6a0h		;c688
	call sub_c6c1h		;c68a
	ld a,030h		;c68d
	out (017h),a		;c68f
	call sub_c6c1h		;c691
	call sub_c277h		;c694
	ld bc,00010h		;c697
	otir		;c69a
	otir		;c69c
	jr lc6b4h		;c69e
lc6a0h:
	call sub_c6c1h		;c6a0
	ld a,020h		;c6a3
	out (017h),a		;c6a5
	call sub_c6c1h		;c6a7
	call sub_c277h		;c6aa
	ld bc,00010h		;c6ad
	inir		;c6b0
	inir		;c6b2
lc6b4h:
	xor a			;c6b4
	ld (0d969h),a		;c6b5
	ld hl,0d96bh		;c6b8
	call sub_c04eh		;c6bb
	jr nz,lc65dh		;c6be
	ret			;c6c0
sub_c6c1h:
	push af			;c6c1
lc6c2h:
	in a,(017h)		;c6c2
	bit 7,a		;c6c4
	jr nz,lc6c2h		;c6c6
lc6c8h:
	in a,(017h)		;c6c8
	bit 6,a		;c6ca
	jr z,lc6c8h		;c6cc
	pop af			;c6ce
	ret			;c6cf
lc6d0h:
	halt			;c6d0
	ld h,l			;c6d1
	ld a,d			;c6d2
	ld l,c			;c6d3
	ld a,b			;c6d4
	jr nz,$+100		;c6d5
	ld l,a			;c6d7
	ld l,a			;c6d8
	ld (hl),h			;c6d9
lc6dah:
	ld a,(bc)			;c6da
	dec c			;c6db
	nop			;c6dc
lc6ddh:
	ld l,l			;c6dd
	ld h,l			;c6de
	ld l,l			;c6df
	jr nz,$+63		;c6e0
	jr nz,lc6e4h		;c6e2
lc6e4h:
	cpl			;c6e4
	ld h,l			;c6e5
	ld (hl),h			;c6e6
	ld h,e			;c6e7
	cpl			;c6e8
	ld l,c			;c6e9
	ld l,(hl)			;c6ea
	ld l,c			;c6eb
	ld (hl),h			;c6ec
	nop			;c6ed
lc6eeh:
	ld (hl),b			;c6ee
	ld h,c			;c6ef
	ld l,(hl)			;c6f0
	ld l,c			;c6f1
	ld h,e			;c6f2
	jr nz,$+2		;c6f3
