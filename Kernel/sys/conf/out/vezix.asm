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
	ld sp,0c7a4h		;c074
	xor a			;c077
	ld hl,0d989h		;c078
	ld de,0c70fh		;c07b
	push de			;c07e
	sbc hl,de		;c07f
	dec hl			;c081
	ld b,h			;c082
	ld c,l			;c083
	pop hl			;c084
	inc de			;c085
	ld (hl),a			;c086
	ldir		;c087
	call sub_c180h		;c089
	ld hl,lc6eah		;c08c
	call sub_c12ah		;c08f
	ld hl,lc6f7h		;c092
	call sub_c12ah		;c095
	xor a			;c098
	ld hl,lc000h		;c099
	ld de,08000h		;c09c
	sbc hl,de		;c09f
	call sub_c137h		;c0a1
	ld hl,lc6f4h		;c0a4
	call sub_c12ah		;c0a7
	call sub_c255h		;c0aa
	call sub_c642h		;c0ad
	call sub_c287h		;c0b0
	ld hl,lc6feh		;c0b3
	ld (0c710h),hl		;c0b6
	ld hl,lc4b4h		;c0b9
	call sub_c3b3h		;c0bc
	ld a,(0c70fh)		;c0bf
	or a			;c0c2
	jp nz,lc16eh		;c0c3
	ld hl,08000h		;c0c6
	ld de,00000h		;c0c9
	ld (0c71ah),hl		;c0cc
	call sub_c615h		;c0cf
	call sub_c4cch		;c0d2
lc0d5h:
	jp lc0d5h		;c0d5
	call sub_c003h		;c0d8
	ld d,b			;c0db
	ld e,c			;c0dc
lc0ddh:
	ld c,010h		;c0dd
	ld b,00ah		;c0df
	call sub_c164h		;c0e1
	ld b,00dh		;c0e4
	call sub_c164h		;c0e6
	push hl			;c0e9
	call sub_c109h		;c0ea
	ld b,03ah		;c0ed
	call sub_c164h		;c0ef
	pop hl			;c0f2
lc0f3h:
	ld b,020h		;c0f3
	call sub_c164h		;c0f5
	push hl			;c0f8
	ld h,(hl)			;c0f9
	call sub_c10fh		;c0fa
	pop hl			;c0fd
	inc hl			;c0fe
	dec de			;c0ff
	ld a,d			;c100
	or e			;c101
	ret z			;c102
	dec c			;c103
	jr nz,lc0f3h		;c104
	jr lc0ddh		;c106
	ret			;c108
sub_c109h:
	push hl			;c109
	call sub_c10fh		;c10a
	pop hl			;c10d
	ld h,l			;c10e
sub_c10fh:
	call sub_c003h		;c10f
	ld a,h			;c112
	rra			;c113
	rra			;c114
	rra			;c115
	rra			;c116
	call sub_c11bh		;c117
	ld a,h			;c11a
sub_c11bh:
	and 00fh		;c11b
	add a,030h		;c11d
	cp 03ah		;c11f
	jr c,lc125h		;c121
	add a,027h		;c123
lc125h:
	ld b,a			;c125
	call sub_c164h		;c126
	ret			;c129
sub_c12ah:
	call sub_c003h		;c12a
lc12dh:
	ld a,(hl)			;c12d
	or a			;c12e
	ret z			;c12f
	ld b,a			;c130
	call sub_c164h		;c131
	inc hl			;c134
	jr lc12dh		;c135
sub_c137h:
	call sub_c003h		;c137
	ld d,030h		;c13a
	ld bc,0d8f0h		;c13c
	call sub_c158h		;c13f
	ld bc,0fc18h		;c142
	call sub_c158h		;c145
	ld bc,0ff9ch		;c148
	call sub_c158h		;c14b
	ld bc,0fff6h		;c14e
	call sub_c158h		;c151
	ld bc,0ffffh		;c154
	dec d			;c157
sub_c158h:
	ld a,02fh		;c158
lc15ah:
	inc a			;c15a
	add hl,bc			;c15b
	jr c,lc15ah		;c15c
	sbc hl,bc		;c15e
	ld b,a			;c160
	cp d			;c161
	ret z			;c162
	dec d			;c163
sub_c164h:
	in a,(080h)		;c164
	bit 1,a		;c166
	jr z,sub_c164h		;c168
	ld a,b			;c16a
	out (081h),a		;c16b
	ret			;c16d
lc16eh:
	ld h,000h		;c16e
	ld l,a			;c170
	push hl			;c171
	ld hl,lc708h		;c172
	call sub_c12ah		;c175
	pop hl			;c178
	call sub_c137h		;c179
lc17ch:
	di			;c17c
	halt			;c17d
	jr lc17ch		;c17e
sub_c180h:
	ld a,003h		;c180
	out (080h),a		;c182
	ld a,016h		;c184
	out (080h),a		;c186
	ret			;c188
sub_c189h:
	call sub_c003h		;c189
	call sub_c1bdh		;c18c
	bit 1,(ix+002h)		;c18f
	ret nz			;c193
	set 0,(ix+002h)		;c194
lc198h:
	ld e,(ix+00bh)		;c198
	ld h,004h		;c19b
	call sub_c063h		;c19d
	ld de,lc646h		;c1a0
	add hl,de			;c1a3
	ld a,(hl)			;c1a4
	inc hl			;c1a5
	ld h,(hl)			;c1a6
	ld l,a			;c1a7
	push ix		;c1a8
	call sub_c072h		;c1aa
	pop ix		;c1ad
	ret			;c1af
sub_c1b0h:
	call sub_c003h		;c1b0
	res 1,(ix+002h)		;c1b3
	res 0,(ix+002h)		;c1b7
	jr lc198h		;c1bb
sub_c1bdh:
	call sub_c003h		;c1bd
	xor a			;c1c0
	ld ix,0d3a4h		;c1c1
	ld iy,00000h		;c1c5
	ex af,af'			;c1c9
	ld a,006h		;c1ca
lc1cch:
	ex af,af'			;c1cc
	ex de,hl			;c1cd
	bit 7,d		;c1ce
	jr nz,lc1eeh		;c1d0
	ld h,(ix+00bh)		;c1d2
	ld l,(ix+00ah)		;c1d5
	or a			;c1d8
	sbc hl,de		;c1d9
	jr nz,lc1eeh		;c1db
	ld h,(ix+009h)		;c1dd
	ld l,(ix+008h)		;c1e0
	or a			;c1e3
	sbc hl,bc		;c1e4
	jr nz,lc1eeh		;c1e6
	push ix		;c1e8
	pop iy		;c1ea
	jr lc237h		;c1ec
lc1eeh:
	bit 3,(ix+002h)		;c1ee
	jr nz,lc202h		;c1f2
	cp (ix+005h)		;c1f4
	jr z,lc1fbh		;c1f7
	jr nc,lc202h		;c1f9
lc1fbh:
	push ix		;c1fb
	pop iy		;c1fd
	ld a,(ix+005h)		;c1ff
lc202h:
	ld hl,0000dh		;c202
	ex de,hl			;c205
	add ix,de		;c206
	ex af,af'			;c208
	dec a			;c209
	jr nz,lc1cch		;c20a
	push bc			;c20c
	push hl			;c20d
	push iy		;c20e
	pop ix		;c210
	defb 0fdh,054h	;ld d,iyh		;c212
	defb 0fdh,05dh	;ld e,iyl		;c214
	xor a			;c216
	cp d			;c217
	jr nz,lc21eh		;c218
	cp e			;c21a
	call z,lc16eh		;c21b
lc21eh:
	bit 4,(ix+002h)		;c21e
	call nz,sub_c1b0h		;c222
	pop hl			;c225
	ld (ix+00bh),h		;c226
	ld (ix+00ah),l		;c229
	pop hl			;c22c
	ld (ix+009h),h		;c22d
	ld (ix+008h),l		;c230
	ld (ix+002h),008h		;c233
lc237h:
	ld c,006h		;c237
	ld iy,0d3a4h		;c239
	ld a,(ix+005h)		;c23d
lc240h:
	cp (iy+005h)		;c240
	jr c,lc248h		;c243
	inc (iy+005h)		;c245
lc248h:
	ld de,0000dh		;c248
	add iy,de		;c24b
	dec c			;c24d
	jr nz,lc240h		;c24e
	ld (ix+005h),000h		;c250
	ret			;c254
sub_c255h:
	ld c,006h		;c255
	ld hl,0c7a4h		;c257
	ld ix,0d3a4h		;c25a
	xor a			;c25e
lc25fh:
	ld (ix+007h),h		;c25f
	ld (ix+006h),l		;c262
	ld (ix+003h),c		;c265
	call sub_c278h		;c268
	ld de,0000dh		;c26b
	add ix,de		;c26e
	ld de,00200h		;c270
	add hl,de			;c273
	dec c			;c274
	jr nz,lc25fh		;c275
	ret			;c277
sub_c278h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)		;c278
	ld (ix+002h),a		;c27c
	ret			;c27f
sub_c280h:
	ld h,(ix+007h)		;c280
	ld l,(ix+006h)		;c283
	ret			;c286
sub_c287h:
	ld h,0ffh		;c287
	call sub_c1bdh		;c289
	push ix		;c28c
	ld hl,00000h		;c28e
	ld bc,00001h		;c291
	call sub_c189h		;c294
	pop iy		;c297
	ld a,(ix+00ch)		;c299
	or a			;c29c
	call nz,lc16eh		;c29d
	ld bc,00200h		;c2a0
	ld d,(iy+007h)		;c2a3
	ld e,(iy+006h)		;c2a6
	call sub_c280h		;c2a9
	ldir		;c2ac
	call sub_c278h		;c2ae
	defb 0fdh,054h	;ld d,iyh		;c2b1
	defb 0fdh,05dh	;ld e,iyl		;c2b3
	ex de,hl			;c2b5
	ld (0d3f4h),hl		;c2b6
	ld hl,00000h		;c2b9
	ld (0d3f2h),hl		;c2bc
	ret			;c2bf
sub_c2c0h:
	call sub_c003h		;c2c0
	ex de,hl			;c2c3
lc2c4h:
	ld ix,0d40ah		;c2c4
	ld a,014h		;c2c8
	ld iy,00000h		;c2ca
lc2ceh:
	ld h,(ix+042h)		;c2ce
	ld l,(ix+041h)		;c2d1
	or a			;c2d4
	sbc hl,de		;c2d5
	jr nz,lc311h		;c2d7
	ld h,(ix+044h)		;c2d9
	ld l,(ix+043h)		;c2dc
	or a			;c2df
	sbc hl,bc		;c2e0
	jr nz,lc311h		;c2e2
	bit 3,(ix+040h)		;c2e4
	ret z			;c2e8
	ld iy,0d3f2h		;c2e9
	ld c,000h		;c2ed
lc2efh:
	ld a,(iy+005h)		;c2ef
	defb 0ddh,0bch	;cp ixh		;c2f2
	jr nz,lc306h		;c2f4
	ld a,(iy+004h)		;c2f6
	defb 0ddh,0bdh	;cp ixl		;c2f9
	jr nz,lc306h		;c2fb
	ld bc,00001h		;c2fd
	defb 0fdh,054h	;ld d,iyh		;c300
	defb 0fdh,05dh	;ld e,iyl		;c302
	jr lc2c4h		;c304
lc306h:
	ld de,00006h		;c306
	add iy,de		;c309
	dec c			;c30b
	jr nz,lc2efh		;c30c
	call lc16eh		;c30e
lc311h:
	ex af,af'			;c311
	xor a			;c312
	cp (ix+045h)		;c313
	jr nz,lc31ch		;c316
	push ix		;c318
	pop iy		;c31a
lc31ch:
	ex af,af'			;c31c
	ld hl,00046h		;c31d
	ex de,hl			;c320
	add ix,de		;c321
	ex de,hl			;c323
	dec a			;c324
	jr nz,lc2ceh		;c325
	defb 0fdh,0bch	;cp iyh		;c327
	jr nz,lc335h		;c329
	defb 0fdh,0bdh	;cp iyl		;c32b
	jr nz,lc335h		;c32d
	ld a,017h		;c32f
	ld (0c70fh),a		;c331
	ret			;c334
lc335h:
	ld (iy+042h),d		;c335
	ld (iy+041h),e		;c338
	ld (iy+044h),b		;c33b
	ld (iy+043h),c		;c33e
	inc (iy+045h)		;c341
	call sub_c36ch		;c344
	call sub_c35bh		;c347
	defb 0fdh,054h	;ld d,iyh		;c34a
	defb 0fdh,05dh	;ld e,iyl		;c34c
	ld bc,00040h		;c34e
	ldir		;c351
	call sub_c278h		;c353
	push iy		;c356
	pop ix		;c358
	ret			;c35a
sub_c35bh:
	ld h,040h		;c35b
	ld a,007h		;c35d
	and e			;c35f
	ld e,a			;c360
	call sub_c063h		;c361
	ld d,(ix+007h)		;c364
	ld e,(ix+006h)		;c367
	add hl,de			;c36a
	ret			;c36b
sub_c36ch:
	ld h,b			;c36c
	ld l,c			;c36d
	ld a,l			;c36e
	srl h		;c36f
	rra			;c371
	srl h		;c372
	rra			;c374
	srl h		;c375
	rra			;c377
	ld l,a			;c378
	inc hl			;c379
	inc hl			;c37a
	push bc			;c37b
	ld b,h			;c37c
	ld c,l			;c37d
	pop hl			;c37e
	ex de,hl			;c37f
	push iy		;c380
	call sub_c189h		;c382
	pop iy		;c385
	ret			;c387
sub_c388h:
	xor a			;c388
	dec (ix+045h)		;c389
	ret nz			;c38c
	ld (ix+040h),a		;c38d
	ld (ix+043h),a		;c390
	ret			;c393
sub_c394h:
	call sub_c003h		;c394
	xor a			;c397
	cp h			;c398
	jr nz,lc3b2h		;c399
	ld a,l			;c39b
	cp 012h		;c39c
	jr nc,lc3b2h		;c39e
	sla l		;c3a0
	ld de,00018h		;c3a2
	add hl,de			;c3a5
	defb 0ddh,054h	;ld d,ixh		;c3a6
	defb 0ddh,05dh	;ld e,ixl		;c3a8
	add hl,de			;c3aa
	ld a,(hl)			;c3ab
	inc hl			;c3ac
	ld h,(hl)			;c3ad
	ld l,a			;c3ae
	or h			;c3af
	ret nz			;c3b0
	ret			;c3b1
lc3b2h:
	ret			;c3b2
sub_c3b3h:
	call sub_c003h		;c3b3
	ld (0c741h),hl		;c3b6
	ld hl,(0c716h)		;c3b9
	ld b,h			;c3bc
	ld c,l			;c3bd
	ld hl,(0c714h)		;c3be
	call sub_c4aah		;c3c1
	cp 02fh		;c3c4
	jr nz,lc3ceh		;c3c6
	ld hl,00000h		;c3c8
	ld bc,00001h		;c3cb
lc3ceh:
	call sub_c2c0h		;c3ce
lc3d1h:
	jr nz,lc3dah		;c3d1
	call sub_c4aah		;c3d3
	cp 02fh		;c3d6
	jr lc3d1h		;c3d8
lc3dah:
	ld a,(0c70fh)		;c3da
	or a			;c3dd
	jr z,lc3e8h		;c3de
lc3e0h:
	call sub_c388h		;c3e0
	ld ix,00000h		;c3e3
	ret			;c3e7
lc3e8h:
	cp e			;c3e8
	ret z			;c3e9
	ld a,(ix+001h)		;c3ea
	and 060h		;c3ed
	xor 040h		;c3ef
	jr z,lc3fah		;c3f1
	ld a,014h		;c3f3
	ld (0c70fh),a		;c3f5
	jr lc3e0h		;c3f8
lc3fah:
	ld hl,0c722h		;c3fa
	ld b,020h		;c3fd
	ld a,e			;c3ff
lc400h:
	cp 02fh		;c400
	jr z,lc413h		;c402
	or a			;c404
	jr z,lc413h		;c405
	xor a			;c407
	cp b			;c408
	jr z,lc40eh		;c409
	ld (hl),e			;c40b
	inc hl			;c40c
	dec b			;c40d
lc40eh:
	call sub_c4aah		;c40e
	jr lc400h		;c411
lc413h:
	xor a			;c413
	ld (hl),a			;c414
	ld a,e			;c415
lc416h:
	cp 02fh		;c416
	jr nz,lc41fh		;c418
	call sub_c4aah		;c41a
	jr lc416h		;c41d
lc41fh:
	ld h,(ix+009h)		;c41f
	ld l,(ix+008h)		;c422
	xor a			;c425
	add hl,hl			;c426
	rla			;c427
	add hl,hl			;c428
	rla			;c429
	add hl,hl			;c42a
	rla			;c42b
	ld l,h			;c42c
	ld h,a			;c42d
	ld (0c743h),hl		;c42e
	ld hl,00000h		;c431
lc434h:
	push hl			;c434
	push ix		;c435
	call sub_c394h		;c437
	ld b,h			;c43a
	ld c,l			;c43b
	ld h,(ix+042h)		;c43c
	ld l,(ix+041h)		;c43f
	call sub_c189h		;c442
	call sub_c280h		;c445
	ld d,010h		;c448
lc44ah:
	push hl			;c44a
	ld hl,(0c743h)		;c44b
	ld a,h			;c44e
	or l			;c44f
	jr z,lc49bh		;c450
	dec hl			;c452
	ld (0c743h),hl		;c453
	pop hl			;c456
	push hl			;c457
	inc hl			;c458
	inc hl			;c459
	ld bc,0c722h		;c45a
	ld a,01eh		;c45d
lc45fh:
	ex af,af'			;c45f
	ld a,(bc)			;c460
	cp (hl)			;c461
	jr nz,lc46fh		;c462
	or a			;c464
	jr z,lc480h		;c465
	ex af,af'			;c467
	dec a			;c468
	jr z,lc480h		;c469
	inc hl			;c46b
	inc bc			;c46c
	jr lc45fh		;c46d
lc46fh:
	pop hl			;c46f
	ld bc,00020h		;c470
	add hl,bc			;c473
	dec d			;c474
	jr nz,lc44ah		;c475
	call sub_c278h		;c477
	pop ix		;c47a
	pop hl			;c47c
	inc hl			;c47d
	jr lc434h		;c47e
lc480h:
	pop hl			;c480
	ld c,(hl)			;c481
	inc hl			;c482
	ld b,(hl)			;c483
	call sub_c278h		;c484
	pop ix		;c487
	pop hl			;c489
	ld h,(ix+042h)		;c48a
	ld l,(ix+041h)		;c48d
	push hl			;c490
	call sub_c388h		;c491
	pop hl			;c494
	call sub_c2c0h		;c495
	jp lc3dah		;c498
lc49bh:
	pop hl			;c49b
	call sub_c278h		;c49c
	pop ix		;c49f
	pop hl			;c4a1
	ld a,002h		;c4a2
	ld (0c70fh),a		;c4a4
	jp lc3e0h		;c4a7
sub_c4aah:
	push hl			;c4aa
	ld hl,(0c741h)		;c4ab
	call sub_c072h		;c4ae
	pop hl			;c4b1
	ld e,a			;c4b2
	ret			;c4b3
lc4b4h:
	push hl			;c4b4
	ld hl,(0c710h)		;c4b5
	ld a,(hl)			;c4b8
	inc hl			;c4b9
	ld (0c710h),hl		;c4ba
	pop hl			;c4bd
	ret			;c4be
	push hl			;c4bf
	ld hl,(0c710h)		;c4c0
	call sub_c609h		;c4c3
	inc hl			;c4c6
	ld (0c710h),hl		;c4c7
	pop hl			;c4ca
	ret			;c4cb
sub_c4cch:
	call sub_c003h		;c4cc
lc4cfh:
	ld a,(0d982h)		;c4cf
	or a			;c4d2
	jr z,lc4d7h		;c4d3
	jr lc4cfh		;c4d5
lc4d7h:
	inc a			;c4d7
	ld (0d982h),a		;c4d8
	ld h,(ix+042h)		;c4db
	ld l,(ix+041h)		;c4de
	ld (0c745h),hl		;c4e1
	push ix		;c4e4
	ld hl,0ffffh		;c4e6
	call sub_c1bdh		;c4e9
	ld (0c743h),ix		;c4ec
	xor a			;c4f0
	ld (0c74dh),a		;c4f1
	exx			;c4f4
	call sub_c280h		;c4f5
	exx			;c4f8
	ld bc,00200h		;c4f9
lc4fch:
	ld hl,(0c71ah)		;c4fc
	call sub_c60bh		;c4ff
	ld d,a			;c502
	or e			;c503
	jr z,lc522h		;c504
	inc hl			;c506
	inc hl			;c507
	ld (0c71ah),hl		;c508
	ld hl,0c74dh		;c50b
	inc (hl)			;c50e
	ex de,hl			;c50f
lc510h:
	call sub_c609h		;c510
	inc hl			;c513
	exx			;c514
	ld (hl),a			;c515
	inc hl			;c516
	exx			;c517
	or a			;c518
	jp z,lc4fch		;c519
	dec bc			;c51c
	ld b,a			;c51d
	or c			;c51e
	jr nz,lc510h		;c51f
	inc a			;c521
lc522h:
	pop ix		;c522
	jp nz,lc5feh		;c524
	ld hl,00000h		;c527
	push hl			;c52a
	call sub_c394h		;c52b
	ld b,h			;c52e
	ld c,l			;c52f
	ld hl,(0c745h)		;c530
	push ix		;c533
	call sub_c189h		;c535
	ld a,(0c70fh)		;c538
	or a			;c53b
	jp nz,lc5f8h		;c53c
	call sub_c280h		;c53f
	ld a,018h		;c542
	cp (hl)			;c544
	inc hl			;c545
	jr nz,lc54eh		;c546
	ld a,00eh		;c548
	cp (hl)			;c54a
	inc hl			;c54b
	jr z,lc556h		;c54c
lc54eh:
	ld a,008h		;c54e
	ld (0c70fh),a		;c550
	jp lc5f8h		;c553
lc556h:
	inc hl			;c556
	ld c,(hl)			;c557
	inc hl			;c558
	ld b,(hl)			;c559
	ex de,hl			;c55a
	ld hl,08000h		;c55b
	sbc hl,bc		;c55e
	ld (0c747h),hl		;c560
	ex de,hl			;c563
	ld de,00008h		;c564
	add hl,de			;c567
	ld e,(hl)			;c568
	inc hl			;c569
	ld d,(hl)			;c56a
	inc hl			;c56b
	ld (0c749h),de		;c56c
	ld e,(hl)			;c570
	inc hl			;c571
	ld d,(hl)			;c572
	ld hl,04000h		;c573
	or a			;c576
	ld b,d			;c577
	ld c,e			;c578
	sbc hl,de		;c579
	jr nc,lc584h		;c57b
	ld a,007h		;c57d
	ld (0c70fh),a		;c57f
	jr lc5f8h		;c582
lc584h:
	ld h,b			;c584
	ld l,c			;c585
	ld de,(0c749h)		;c586
	sbc hl,de		;c58a
	ld b,h			;c58c
	ld c,l			;c58d
	ld hl,08000h		;c58e
	add hl,de			;c591
	ex de,hl			;c592
	call sub_c61dh		;c593
lc596h:
	ld hl,(0c749h)		;c596
	ld b,h			;c599
	ld c,l			;c59a
	ld de,00200h		;c59b
	or a			;c59e
	sbc hl,de		;c59f
	push af			;c5a1
	jr c,lc5ach		;c5a2
	ld b,d			;c5a4
	ld c,e			;c5a5
	ld hl,08000h		;c5a6
	ld (0c74bh),hl		;c5a9
lc5ach:
	call sub_c280h		;c5ac
	ld de,(0c74bh)		;c5af
	call sub_c61ah		;c5b3
	ld (0c74bh),de		;c5b6
	call sub_c278h		;c5ba
	pop af			;c5bd
	jr c,lc5dah		;c5be
	pop ix		;c5c0
	pop hl			;c5c2
	inc hl			;c5c3
	push hl			;c5c4
	call sub_c394h		;c5c5
	ld b,h			;c5c8
	ld c,l			;c5c9
	ld hl,(0c745h)		;c5ca
	push ix		;c5cd
	call sub_c189h		;c5cf
	ld a,(0c70fh)		;c5d2
	or a			;c5d5
	jr nz,lc5f8h		;c5d6
	jr lc596h		;c5d8
lc5dah:
	ld hl,(0c747h)		;c5da
	ld a,h			;c5dd
	or l			;c5de
	jr z,lc5e1h		;c5df
lc5e1h:
	call sub_c388h		;c5e1
	ld ix,(0c743h)		;c5e4
	call sub_c278h		;c5e8
	ld hl,0bffeh		;c5eb
	ld (0c7a0h),hl		;c5ee
	ld de,08000h		;c5f1
	call sub_c615h		;c5f4
	ret			;c5f7
lc5f8h:
	call sub_c278h		;c5f8
	pop ix		;c5fb
	pop hl			;c5fd
lc5feh:
	call sub_c388h		;c5fe
	ld ix,(0c743h)		;c601
	call sub_c278h		;c605
	ret			;c608
sub_c609h:
	ld a,(hl)			;c609
	ret			;c60a
sub_c60bh:
	ld e,(hl)			;c60b
	inc hl			;c60c
	ld d,(hl)			;c60d
	dec hl			;c60e
	ret			;c60f
	ldir		;c610
	ret			;c612
	ld (hl),a			;c613
	ret			;c614
sub_c615h:
	ld (hl),e			;c615
	inc hl			;c616
	ld (hl),d			;c617
	dec hl			;c618
	ret			;c619
sub_c61ah:
	ldir		;c61a
	ret			;c61c
sub_c61dh:
	ld a,b			;c61d
	or c			;c61e
	ret z			;c61f
	ld h,d			;c620
	ld l,e			;c621
	ld (hl),000h		;c622
	inc de			;c624
	dec bc			;c625
	ld a,b			;c626
	or c			;c627
	ret z			;c628
	ldir		;c629
	ret			;c62b
	ld sp,0c78eh		;c62c
	pop ix		;c62f
	pop iy		;c631
	pop af			;c633
	pop bc			;c634
	pop de			;c635
	pop hl			;c636
	ex af,af'			;c637
	exx			;c638
	pop af			;c639
	pop bc			;c63a
	pop de			;c63b
	pop hl			;c63c
	ld sp,hl			;c63d
	ld hl,(0c7a2h)		;c63e
	ret			;c641
sub_c642h:
	call sub_c655h		;c642
	ret			;c645
lc646h:
	ld h,(hl)			;c646
	add a,083h		;c647
	exx			;c649
	ld d,h			;c64a
	add a,054h		;c64b
	add a,054h		;c64d
	add a,054h		;c64f
	add a,054h		;c651
	add a,0c9h		;c653
sub_c655h:
	ld a,001h		;c655
	call sub_c65fh		;c657
	ld a,082h		;c65a
	call sub_c6dbh		;c65c
sub_c65fh:
	out (011h),a		;c65f
	ld a,0efh		;c661
	out (017h),a		;c663
	ret			;c665
	xor a			;c666
	ld (ix+004h),a		;c667
	ld hl,0d985h		;c66a
	call sub_c024h		;c66d
	ld a,(0d983h)		;c670
	or a			;c673
	jr z,lc677h		;c674
	ret			;c676
lc677h:
	ld ix,0d985h		;c677
	call sub_c012h		;c67b
	ret z			;c67e
	ld a,001h		;c67f
	ld (0d983h),a		;c681
	ld a,001h		;c684
	out (012h),a		;c686
	call sub_c6dbh		;c688
	ld a,(ix+008h)		;c68b
	out (013h),a		;c68e
	ld a,(ix+009h)		;c690
	out (014h),a		;c693
	ld a,(ix+00ah)		;c695
	out (015h),a		;c698
	ld a,0e0h		;c69a
	out (016h),a		;c69c
	bit 0,(ix+002h)		;c69e
	jr nz,lc6bah		;c6a2
	call sub_c6dbh		;c6a4
	ld a,030h		;c6a7
	out (017h),a		;c6a9
	call sub_c6dbh		;c6ab
	call sub_c280h		;c6ae
	ld bc,00010h		;c6b1
	otir		;c6b4
	otir		;c6b6
	jr lc6ceh		;c6b8
lc6bah:
	call sub_c6dbh		;c6ba
	ld a,020h		;c6bd
	out (017h),a		;c6bf
	call sub_c6dbh		;c6c1
	call sub_c280h		;c6c4
	ld bc,00010h		;c6c7
	inir		;c6ca
	inir		;c6cc
lc6ceh:
	xor a			;c6ce
	ld (0d983h),a		;c6cf
	ld hl,0d985h		;c6d2
	call sub_c04eh		;c6d5
	jr nz,lc677h		;c6d8
	ret			;c6da
sub_c6dbh:
	push af			;c6db
lc6dch:
	in a,(017h)		;c6dc
	bit 7,a		;c6de
	jr nz,lc6dch		;c6e0
lc6e2h:
	in a,(017h)		;c6e2
	bit 6,a		;c6e4
	jr z,lc6e2h		;c6e6
	pop af			;c6e8
	ret			;c6e9
lc6eah:
	halt			;c6ea
	ld h,l			;c6eb
	ld a,d			;c6ec
	ld l,c			;c6ed
	ld a,b			;c6ee
	jr nz,$+100		;c6ef
	ld l,a			;c6f1
	ld l,a			;c6f2
	ld (hl),h			;c6f3
lc6f4h:
	ld a,(bc)			;c6f4
	dec c			;c6f5
	nop			;c6f6
lc6f7h:
	ld l,l			;c6f7
	ld h,l			;c6f8
	ld l,l			;c6f9
	jr nz,$+63		;c6fa
	jr nz,lc6feh		;c6fc
lc6feh:
	cpl			;c6fe
	ld h,l			;c6ff
	ld (hl),h			;c700
	ld h,e			;c701
	cpl			;c702
	ld l,c			;c703
	ld l,(hl)			;c704
	ld l,c			;c705
	ld (hl),h			;c706
	nop			;c707
lc708h:
	ld (hl),b			;c708
	ld h,c			;c709
	ld l,(hl)			;c70a
	ld l,c			;c70b
	ld h,e			;c70c
	jr nz,$+2		;c70d
