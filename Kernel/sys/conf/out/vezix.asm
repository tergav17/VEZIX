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
	ld sp,0c728h		;c074
	xor a			;c077
	ld hl,0d90dh		;c078
	ld de,0c693h		;c07b
	push de			;c07e
	sbc hl,de		;c07f
	dec hl			;c081
	ld b,h			;c082
	ld c,l			;c083
	pop hl			;c084
	inc de			;c085
	ld (hl),a			;c086
	ldir		;c087
	call sub_c17eh		;c089
	ld hl,lc66eh		;c08c
	call sub_c121h		;c08f
	ld hl,lc67bh		;c092
	call sub_c121h		;c095
	xor a			;c098
	ld hl,lc000h		;c099
	ld de,00000h		;c09c
	sbc hl,de		;c09f
	call sub_c12eh		;c0a1
	ld hl,lc678h		;c0a4
	call sub_c121h		;c0a7
	jp lc0cch		;c0aa
	call sub_c253h		;c0ad
	call sub_c62fh		;c0b0
	call sub_c285h		;c0b3
	ld hl,lc682h		;c0b6
	ld (0c694h),hl		;c0b9
	ld hl,lc4b2h		;c0bc
	call sub_c3b1h		;c0bf
	ld a,(0c693h)		;c0c2
	or a			;c0c5
	jp nz,lc16ch		;c0c6
	call sub_c4cah		;c0c9
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
	ld a,b			;c15b
lc15ch:
	call 01c73h		;c15c
	jr z,lc15ch		;c15f
	ret			;c161
	in a,(080h)		;c162
	bit 1,a		;c164
	jr z,sub_c15bh		;c166
	ld a,b			;c168
	out (081h),a		;c169
	ret			;c16b
lc16ch:
	ld h,000h		;c16c
	ld l,a			;c16e
	push hl			;c16f
	ld hl,lc68ch		;c170
	call sub_c121h		;c173
	pop hl			;c176
	call sub_c12eh		;c177
lc17ah:
	di			;c17a
	halt			;c17b
	jr lc17ah		;c17c
sub_c17eh:
	ld a,003h		;c17e
	out (080h),a		;c180
	ld a,016h		;c182
	out (080h),a		;c184
	ret			;c186
sub_c187h:
	call sub_c003h		;c187
	call sub_c1bbh		;c18a
	bit 1,(ix+002h)		;c18d
	ret nz			;c191
	set 0,(ix+002h)		;c192
lc196h:
	ld e,(ix+00bh)		;c196
	ld h,004h		;c199
	call sub_c063h		;c19b
	ld de,lc633h		;c19e
	add hl,de			;c1a1
	ld a,(hl)			;c1a2
	inc hl			;c1a3
	ld h,(hl)			;c1a4
	ld l,a			;c1a5
	push ix		;c1a6
	call sub_c072h		;c1a8
	pop ix		;c1ab
	ret			;c1ad
sub_c1aeh:
	call sub_c003h		;c1ae
	res 1,(ix+002h)		;c1b1
	res 0,(ix+002h)		;c1b5
	jr lc196h		;c1b9
sub_c1bbh:
	call sub_c003h		;c1bb
	xor a			;c1be
	ld ix,0d328h		;c1bf
	ld iy,00000h		;c1c3
	ex af,af'			;c1c7
	ld a,006h		;c1c8
lc1cah:
	ex af,af'			;c1ca
	ex de,hl			;c1cb
	bit 7,d		;c1cc
	jr nz,lc1ech		;c1ce
	ld h,(ix+00bh)		;c1d0
	ld l,(ix+00ah)		;c1d3
	or a			;c1d6
	sbc hl,de		;c1d7
	jr nz,lc1ech		;c1d9
	ld h,(ix+009h)		;c1db
	ld l,(ix+008h)		;c1de
	or a			;c1e1
	sbc hl,bc		;c1e2
	jr nz,lc1ech		;c1e4
	push ix		;c1e6
	pop iy		;c1e8
	jr lc235h		;c1ea
lc1ech:
	bit 3,(ix+002h)		;c1ec
	jr nz,lc200h		;c1f0
	cp (ix+005h)		;c1f2
	jr z,lc1f9h		;c1f5
	jr nc,lc200h		;c1f7
lc1f9h:
	push ix		;c1f9
	pop iy		;c1fb
	ld a,(ix+005h)		;c1fd
lc200h:
	ld hl,0000dh		;c200
	ex de,hl			;c203
	add ix,de		;c204
	ex af,af'			;c206
	dec a			;c207
	jr nz,lc1cah		;c208
	push bc			;c20a
	push hl			;c20b
	push iy		;c20c
	pop ix		;c20e
	defb 0fdh,054h	;ld d,iyh		;c210
	defb 0fdh,05dh	;ld e,iyl		;c212
	xor a			;c214
	cp d			;c215
	jr nz,lc21ch		;c216
	cp e			;c218
	call z,lc16ch		;c219
lc21ch:
	bit 4,(ix+002h)		;c21c
	call nz,sub_c1aeh		;c220
	pop hl			;c223
	ld (ix+00bh),h		;c224
	ld (ix+00ah),l		;c227
	pop hl			;c22a
	ld (ix+009h),h		;c22b
	ld (ix+008h),l		;c22e
	ld (ix+002h),008h		;c231
lc235h:
	ld c,006h		;c235
	ld iy,0d328h		;c237
	ld a,(ix+005h)		;c23b
lc23eh:
	cp (iy+005h)		;c23e
	jr c,lc246h		;c241
	inc (iy+005h)		;c243
lc246h:
	ld de,0000dh		;c246
	add iy,de		;c249
	dec c			;c24b
	jr nz,lc23eh		;c24c
	ld (ix+005h),000h		;c24e
	ret			;c252
sub_c253h:
	ld c,006h		;c253
	ld hl,0c728h		;c255
	ld ix,0d328h		;c258
	xor a			;c25c
lc25dh:
	ld (ix+007h),h		;c25d
	ld (ix+006h),l		;c260
	ld (ix+003h),c		;c263
	call sub_c276h		;c266
	ld de,0000dh		;c269
	add ix,de		;c26c
	ld de,00200h		;c26e
	add hl,de			;c271
	dec c			;c272
	jr nz,lc25dh		;c273
	ret			;c275
sub_c276h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)		;c276
	ld (ix+002h),a		;c27a
	ret			;c27d
sub_c27eh:
	ld h,(ix+007h)		;c27e
	ld l,(ix+006h)		;c281
	ret			;c284
sub_c285h:
	ld h,0ffh		;c285
	call sub_c1bbh		;c287
	push ix		;c28a
	ld hl,00000h		;c28c
	ld bc,00001h		;c28f
	call sub_c187h		;c292
	pop iy		;c295
	ld a,(ix+00ch)		;c297
	or a			;c29a
	call nz,lc16ch		;c29b
	ld bc,00200h		;c29e
	ld d,(iy+007h)		;c2a1
	ld e,(iy+006h)		;c2a4
	call sub_c27eh		;c2a7
	ldir		;c2aa
	call sub_c276h		;c2ac
	defb 0fdh,054h	;ld d,iyh		;c2af
	defb 0fdh,05dh	;ld e,iyl		;c2b1
	ex de,hl			;c2b3
	ld (0d378h),hl		;c2b4
	ld hl,00000h		;c2b7
	ld (0d376h),hl		;c2ba
	ret			;c2bd
sub_c2beh:
	call sub_c003h		;c2be
	ex de,hl			;c2c1
lc2c2h:
	ld ix,0d38eh		;c2c2
	ld a,014h		;c2c6
	ld iy,00000h		;c2c8
lc2cch:
	ld h,(ix+042h)		;c2cc
	ld l,(ix+041h)		;c2cf
	or a			;c2d2
	sbc hl,de		;c2d3
	jr nz,lc30fh		;c2d5
	ld h,(ix+044h)		;c2d7
	ld l,(ix+043h)		;c2da
	or a			;c2dd
	sbc hl,bc		;c2de
	jr nz,lc30fh		;c2e0
	bit 3,(ix+040h)		;c2e2
	ret z			;c2e6
	ld iy,0d376h		;c2e7
	ld c,000h		;c2eb
lc2edh:
	ld a,(iy+005h)		;c2ed
	defb 0ddh,0bch	;cp ixh		;c2f0
	jr nz,lc304h		;c2f2
	ld a,(iy+004h)		;c2f4
	defb 0ddh,0bdh	;cp ixl		;c2f7
	jr nz,lc304h		;c2f9
	ld bc,00001h		;c2fb
	defb 0fdh,054h	;ld d,iyh		;c2fe
	defb 0fdh,05dh	;ld e,iyl		;c300
	jr lc2c2h		;c302
lc304h:
	ld de,00006h		;c304
	add iy,de		;c307
	dec c			;c309
	jr nz,lc2edh		;c30a
	call lc16ch		;c30c
lc30fh:
	ex af,af'			;c30f
	xor a			;c310
	cp (ix+045h)		;c311
	jr nz,lc31ah		;c314
	push ix		;c316
	pop iy		;c318
lc31ah:
	ex af,af'			;c31a
	ld hl,00046h		;c31b
	ex de,hl			;c31e
	add ix,de		;c31f
	ex de,hl			;c321
	dec a			;c322
	jr nz,lc2cch		;c323
	defb 0fdh,0bch	;cp iyh		;c325
	jr nz,lc333h		;c327
	defb 0fdh,0bdh	;cp iyl		;c329
	jr nz,lc333h		;c32b
	ld a,017h		;c32d
	ld (0c693h),a		;c32f
	ret			;c332
lc333h:
	ld (iy+042h),d		;c333
	ld (iy+041h),e		;c336
	ld (iy+044h),b		;c339
	ld (iy+043h),c		;c33c
	inc (iy+045h)		;c33f
	call sub_c36ah		;c342
	call sub_c359h		;c345
	defb 0fdh,054h	;ld d,iyh		;c348
	defb 0fdh,05dh	;ld e,iyl		;c34a
	ld bc,00040h		;c34c
	ldir		;c34f
	call sub_c276h		;c351
	push iy		;c354
	pop ix		;c356
	ret			;c358
sub_c359h:
	ld h,040h		;c359
	ld a,007h		;c35b
	and e			;c35d
	ld e,a			;c35e
	call sub_c063h		;c35f
	ld d,(ix+007h)		;c362
	ld e,(ix+006h)		;c365
	add hl,de			;c368
	ret			;c369
sub_c36ah:
	ld h,b			;c36a
	ld l,c			;c36b
	ld a,l			;c36c
	srl h		;c36d
	rra			;c36f
	srl h		;c370
	rra			;c372
	srl h		;c373
	rra			;c375
	ld l,a			;c376
	inc hl			;c377
	inc hl			;c378
	push bc			;c379
	ld b,h			;c37a
	ld c,l			;c37b
	pop hl			;c37c
	ex de,hl			;c37d
	push iy		;c37e
	call sub_c187h		;c380
	pop iy		;c383
	ret			;c385
sub_c386h:
	xor a			;c386
	dec (ix+045h)		;c387
	ret nz			;c38a
	ld (ix+040h),a		;c38b
	ld (ix+043h),a		;c38e
	ret			;c391
sub_c392h:
	call sub_c003h		;c392
	xor a			;c395
	cp h			;c396
	jr nz,lc3b0h		;c397
	ld a,l			;c399
	cp 012h		;c39a
	jr nc,lc3b0h		;c39c
	sla l		;c39e
	ld de,00018h		;c3a0
	add hl,de			;c3a3
	defb 0ddh,054h	;ld d,ixh		;c3a4
	defb 0ddh,05dh	;ld e,ixl		;c3a6
	add hl,de			;c3a8
	ld a,(hl)			;c3a9
	inc hl			;c3aa
	ld h,(hl)			;c3ab
	ld l,a			;c3ac
	or h			;c3ad
	ret nz			;c3ae
	ret			;c3af
lc3b0h:
	ret			;c3b0
sub_c3b1h:
	call sub_c003h		;c3b1
	ld (0c6c5h),hl		;c3b4
	ld hl,(0c69ah)		;c3b7
	ld b,h			;c3ba
	ld c,l			;c3bb
	ld hl,(0c698h)		;c3bc
	call sub_c4a8h		;c3bf
	cp 02fh		;c3c2
	jr nz,lc3cch		;c3c4
	ld hl,00000h		;c3c6
	ld bc,00001h		;c3c9
lc3cch:
	call sub_c2beh		;c3cc
lc3cfh:
	jr nz,lc3d8h		;c3cf
	call sub_c4a8h		;c3d1
	cp 02fh		;c3d4
	jr lc3cfh		;c3d6
lc3d8h:
	ld a,(0c693h)		;c3d8
	or a			;c3db
	jr z,lc3e6h		;c3dc
lc3deh:
	call sub_c386h		;c3de
	ld ix,00000h		;c3e1
	ret			;c3e5
lc3e6h:
	cp e			;c3e6
	ret z			;c3e7
	ld a,(ix+001h)		;c3e8
	and 060h		;c3eb
	xor 040h		;c3ed
	jr z,lc3f8h		;c3ef
	ld a,014h		;c3f1
	ld (0c693h),a		;c3f3
	jr lc3deh		;c3f6
lc3f8h:
	ld hl,0c6a6h		;c3f8
	ld b,020h		;c3fb
	ld a,e			;c3fd
lc3feh:
	cp 02fh		;c3fe
	jr z,lc411h		;c400
	or a			;c402
	jr z,lc411h		;c403
	xor a			;c405
	cp b			;c406
	jr z,lc40ch		;c407
	ld (hl),e			;c409
	inc hl			;c40a
	dec b			;c40b
lc40ch:
	call sub_c4a8h		;c40c
	jr lc3feh		;c40f
lc411h:
	xor a			;c411
	ld (hl),a			;c412
	ld a,e			;c413
lc414h:
	cp 02fh		;c414
	jr nz,lc41dh		;c416
	call sub_c4a8h		;c418
	jr lc414h		;c41b
lc41dh:
	ld h,(ix+009h)		;c41d
	ld l,(ix+008h)		;c420
	xor a			;c423
	add hl,hl			;c424
	rla			;c425
	add hl,hl			;c426
	rla			;c427
	add hl,hl			;c428
	rla			;c429
	ld l,h			;c42a
	ld h,a			;c42b
	ld (0c6c7h),hl		;c42c
	ld hl,00000h		;c42f
lc432h:
	push hl			;c432
	push ix		;c433
	call sub_c392h		;c435
	ld b,h			;c438
	ld c,l			;c439
	ld h,(ix+042h)		;c43a
	ld l,(ix+041h)		;c43d
	call sub_c187h		;c440
	call sub_c27eh		;c443
	ld d,010h		;c446
lc448h:
	push hl			;c448
	ld hl,(0c6c7h)		;c449
	ld a,h			;c44c
	or l			;c44d
	jr z,lc499h		;c44e
	dec hl			;c450
	ld (0c6c7h),hl		;c451
	pop hl			;c454
	push hl			;c455
	inc hl			;c456
	inc hl			;c457
	ld bc,0c6a6h		;c458
	ld a,01eh		;c45b
lc45dh:
	ex af,af'			;c45d
	ld a,(bc)			;c45e
	cp (hl)			;c45f
	jr nz,lc46dh		;c460
	or a			;c462
	jr z,lc47eh		;c463
	ex af,af'			;c465
	dec a			;c466
	jr z,lc47eh		;c467
	inc hl			;c469
	inc bc			;c46a
	jr lc45dh		;c46b
lc46dh:
	pop hl			;c46d
	ld bc,00020h		;c46e
	add hl,bc			;c471
	dec d			;c472
	jr nz,lc448h		;c473
	call sub_c276h		;c475
	pop ix		;c478
	pop hl			;c47a
	inc hl			;c47b
	jr lc432h		;c47c
lc47eh:
	pop hl			;c47e
	ld c,(hl)			;c47f
	inc hl			;c480
	ld b,(hl)			;c481
	call sub_c276h		;c482
	pop ix		;c485
	pop hl			;c487
	ld h,(ix+042h)		;c488
	ld l,(ix+041h)		;c48b
	push hl			;c48e
	call sub_c386h		;c48f
	pop hl			;c492
	call sub_c2beh		;c493
	jp lc3d8h		;c496
lc499h:
	pop hl			;c499
	call sub_c276h		;c49a
	pop ix		;c49d
	pop hl			;c49f
	ld a,002h		;c4a0
	ld (0c693h),a		;c4a2
	jp lc3deh		;c4a5
sub_c4a8h:
	push hl			;c4a8
	ld hl,(0c6c5h)		;c4a9
	call sub_c072h		;c4ac
	pop hl			;c4af
	ld e,a			;c4b0
	ret			;c4b1
lc4b2h:
	push hl			;c4b2
	ld hl,(0c694h)		;c4b3
	ld a,(hl)			;c4b6
	inc hl			;c4b7
	ld (0c694h),hl		;c4b8
	pop hl			;c4bb
	ret			;c4bc
	push hl			;c4bd
	ld hl,(0c694h)		;c4be
	call sub_c5fch		;c4c1
	inc hl			;c4c4
	ld (0c694h),hl		;c4c5
	pop hl			;c4c8
	ret			;c4c9
sub_c4cah:
	call sub_c003h		;c4ca
lc4cdh:
	ld a,(0d906h)		;c4cd
	or a			;c4d0
	jr z,lc4d5h		;c4d1
	jr lc4cdh		;c4d3
lc4d5h:
	inc a			;c4d5
	ld (0d906h),a		;c4d6
	ld h,(ix+042h)		;c4d9
	ld l,(ix+041h)		;c4dc
	ld (0c6c9h),hl		;c4df
	push ix		;c4e2
	ld hl,0ffffh		;c4e4
	call sub_c1bbh		;c4e7
	ld (0c6c7h),ix		;c4ea
	xor a			;c4ee
	ld (0c6d1h),a		;c4ef
	exx			;c4f2
	call sub_c27eh		;c4f3
	exx			;c4f6
	ld bc,00200h		;c4f7
lc4fah:
	ld hl,(0c69eh)		;c4fa
	call sub_c5feh		;c4fd
	ld d,a			;c500
	or e			;c501
	jr z,lc520h		;c502
	inc hl			;c504
	inc hl			;c505
	ld (0c69eh),hl		;c506
	ld hl,0c6d1h		;c509
	inc (hl)			;c50c
	ex de,hl			;c50d
lc50eh:
	call sub_c5fch		;c50e
	inc hl			;c511
	exx			;c512
	ld (hl),a			;c513
	inc hl			;c514
	exx			;c515
	or a			;c516
	jp z,lc4fah		;c517
	dec bc			;c51a
	ld b,a			;c51b
	or c			;c51c
	jr nz,lc50eh		;c51d
	inc a			;c51f
lc520h:
	pop ix		;c520
	jp nz,lc5f1h		;c522
	ld hl,00000h		;c525
	push hl			;c528
	call sub_c392h		;c529
	ld b,h			;c52c
	ld c,l			;c52d
	ld hl,(0c6c9h)		;c52e
	push ix		;c531
	call sub_c187h		;c533
	ld a,(0c693h)		;c536
	or a			;c539
	jp nz,lc5ebh		;c53a
	call sub_c27eh		;c53d
	ld a,018h		;c540
	cp (hl)			;c542
	inc hl			;c543
	jr nz,lc54ch		;c544
	ld a,00eh		;c546
	cp (hl)			;c548
	inc hl			;c549
	jr z,lc554h		;c54a
lc54ch:
	ld a,008h		;c54c
	ld (0c693h),a		;c54e
	jp lc5ebh		;c551
lc554h:
	inc hl			;c554
	ld b,(hl)			;c555
	inc hl			;c556
	ld c,(hl)			;c557
	ex de,hl			;c558
	ld hl,00000h		;c559
	sbc hl,bc		;c55c
	ld (0c6cbh),hl		;c55e
	ex de,hl			;c561
	ld de,00008h		;c562
	add hl,de			;c565
	ld d,(hl)			;c566
	inc hl			;c567
	ld e,(hl)			;c568
	inc hl			;c569
	ld (0c6cdh),de		;c56a
	ld a,(hl)			;c56e
	inc hl			;c56f
	ld h,(hl)			;c570
	ld l,a			;c571
	ld b,h			;c572
	ld c,l			;c573
	ld de,lc000h		;c574
	or a			;c577
	sbc hl,de		;c578
	jr nc,lc583h		;c57a
	ld a,007h		;c57c
	ld (0c693h),a		;c57e
	jr lc5ebh		;c581
lc583h:
	ld de,00000h		;c583
	call sub_c610h		;c586
lc589h:
	ld hl,(0c6cdh)		;c589
	ld b,h			;c58c
	ld c,l			;c58d
	ld de,00200h		;c58e
	or a			;c591
	sbc hl,de		;c592
	push af			;c594
	jr c,lc59fh		;c595
	ld b,d			;c597
	ld c,e			;c598
	ld hl,00000h		;c599
	ld (0c6cfh),hl		;c59c
lc59fh:
	call sub_c27eh		;c59f
	ld de,(0c6cfh)		;c5a2
	call sub_c60dh		;c5a6
	ld (0c6cfh),de		;c5a9
	call sub_c276h		;c5ad
	pop af			;c5b0
	jr c,lc5cdh		;c5b1
	pop ix		;c5b3
	pop hl			;c5b5
	inc hl			;c5b6
	push hl			;c5b7
	call sub_c392h		;c5b8
	ld b,h			;c5bb
	ld c,l			;c5bc
	ld hl,(0c6c9h)		;c5bd
	push ix		;c5c0
	call sub_c187h		;c5c2
	ld a,(0c693h)		;c5c5
	or a			;c5c8
	jr nz,lc5ebh		;c5c9
	jr lc589h		;c5cb
lc5cdh:
	ld hl,(0c6cbh)		;c5cd
	ld a,h			;c5d0
	or l			;c5d1
	jr z,lc5d4h		;c5d2
lc5d4h:
	call sub_c386h		;c5d4
	ld ix,(0c6c7h)		;c5d7
	call sub_c276h		;c5db
	ld hl,0bffeh		;c5de
	ld (0c724h),hl		;c5e1
	ld de,00000h		;c5e4
	call sub_c608h		;c5e7
	ret			;c5ea
lc5ebh:
	call sub_c276h		;c5eb
	pop ix		;c5ee
	pop hl			;c5f0
lc5f1h:
	call sub_c386h		;c5f1
	ld ix,(0c6c7h)		;c5f4
	call sub_c276h		;c5f8
	ret			;c5fb
sub_c5fch:
	ld a,(hl)			;c5fc
	ret			;c5fd
sub_c5feh:
	ld e,(hl)			;c5fe
	inc hl			;c5ff
	ld d,(hl)			;c600
	dec hl			;c601
	ret			;c602
	ldir		;c603
	ret			;c605
	ld (hl),a			;c606
	ret			;c607
sub_c608h:
	ld (hl),e			;c608
	inc hl			;c609
	ld (hl),d			;c60a
	dec hl			;c60b
	ret			;c60c
sub_c60dh:
	ldir		;c60d
	ret			;c60f
sub_c610h:
	ld h,d			;c610
	ld l,e			;c611
	ld (hl),000h		;c612
	inc de			;c614
	dec bc			;c615
	ldir		;c616
	ret			;c618
	ld sp,0c712h		;c619
	pop ix		;c61c
	pop iy		;c61e
	pop af			;c620
	pop bc			;c621
	pop de			;c622
	pop hl			;c623
	ex af,af'			;c624
	exx			;c625
	pop af			;c626
	pop bc			;c627
	pop de			;c628
	pop hl			;c629
	ld sp,hl			;c62a
	ld hl,(0c726h)		;c62b
	ret			;c62e
sub_c62fh:
	call sub_c642h		;c62f
	ret			;c632
lc633h:
	ld b,e			;c633
	add a,007h		;c634
	exx			;c636
	ld b,c			;c637
	add a,041h		;c638
	add a,041h		;c63a
	add a,041h		;c63c
	add a,041h		;c63e
	add a,0c9h		;c640
sub_c642h:
	ret			;c642
	xor a			;c643
	ld (ix+004h),a		;c644
	ld hl,0d909h		;c647
	call sub_c024h		;c64a
	ld a,(0d907h)		;c64d
	or a			;c650
	jr z,lc654h		;c651
	ret			;c653
lc654h:
	ld ix,0d909h		;c654
	call sub_c012h		;c658
	ret z			;c65b
	ld a,001h		;c65c
	ld (0d907h),a		;c65e
	xor a			;c661
	ld (0d907h),a		;c662
	ld hl,0d909h		;c665
	call sub_c04eh		;c668
	jr nz,lc654h		;c66b
	ret			;c66d
lc66eh:
	halt			;c66e
	ld h,l			;c66f
	ld a,d			;c670
	ld l,c			;c671
	ld a,b			;c672
	jr nz,$+100		;c673
	ld l,a			;c675
	ld l,a			;c676
	ld (hl),h			;c677
lc678h:
	ld a,(bc)			;c678
	dec c			;c679
	nop			;c67a
lc67bh:
	ld l,l			;c67b
	ld h,l			;c67c
	ld l,l			;c67d
	jr nz,$+63		;c67e
	jr nz,lc682h		;c680
lc682h:
	cpl			;c682
	ld h,l			;c683
	ld (hl),h			;c684
	ld h,e			;c685
	cpl			;c686
	ld l,c			;c687
	ld l,(hl)			;c688
	ld l,c			;c689
	ld (hl),h			;c68a
	nop			;c68b
lc68ch:
	ld (hl),b			;c68c
	ld h,c			;c68d
	ld l,(hl)			;c68e
	ld l,c			;c68f
	ld h,e			;c690
	jr nz,$+2		;c691
