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
	ld sp,0c783h		;c073
	xor a			;c076
	ld hl,0d96fh		;c077
	ld de,0c6eeh		;c07a
	push de			;c07d
	sbc hl,de		;c07e
	dec hl			;c080
	ld b,h			;c081
	ld c,l			;c082
	pop hl			;c083
	inc de			;c084
	ld (hl),a			;c085
	ldir		;c086
	call sub_c171h		;c088
	ld hl,lc6c9h		;c08b
	call sub_c11bh		;c08e
	ld hl,lc6d6h		;c091
	call sub_c11bh		;c094
	xor a			;c097
	ld hl,lc000h		;c098
	ld de,00000h		;c09b
	sbc hl,de		;c09e
	call sub_c128h		;c0a0
	ld hl,lc6d3h		;c0a3
	call sub_c11bh		;c0a6
	call sub_c246h		;c0a9
	call sub_c622h		;c0ac
	call sub_c278h		;c0af
	ld hl,lc6ddh		;c0b2
	ld (0c6efh),hl		;c0b5
	ld hl,lc4a5h		;c0b8
	call sub_c3a4h		;c0bb
	ld a,(0c6eeh)		;c0be
	or a			;c0c1
	jp nz,lc15fh		;c0c2
	call sub_c4bdh		;c0c5
	halt			;c0c8
	call sub_c003h		;c0c9
	ld d,b			;c0cc
	ld e,c			;c0cd
lc0ceh:
	ld c,010h		;c0ce
	ld b,00ah		;c0d0
	call sub_c155h		;c0d2
	ld b,00dh		;c0d5
	call sub_c155h		;c0d7
	push hl			;c0da
	call sub_c0fah		;c0db
	ld b,03ah		;c0de
	call sub_c155h		;c0e0
	pop hl			;c0e3
lc0e4h:
	ld b,020h		;c0e4
	call sub_c155h		;c0e6
	push hl			;c0e9
	ld h,(hl)			;c0ea
	call sub_c100h		;c0eb
	pop hl			;c0ee
	inc hl			;c0ef
	dec de			;c0f0
	ld a,d			;c0f1
	or e			;c0f2
	ret z			;c0f3
	dec c			;c0f4
	jr nz,lc0e4h		;c0f5
	jr lc0ceh		;c0f7
	ret			;c0f9
sub_c0fah:
	push hl			;c0fa
	call sub_c100h		;c0fb
	pop hl			;c0fe
	ld h,l			;c0ff
sub_c100h:
	call sub_c003h		;c100
	ld a,h			;c103
	rra			;c104
	rra			;c105
	rra			;c106
	rra			;c107
	call sub_c10ch		;c108
	ld a,h			;c10b
sub_c10ch:
	and 00fh		;c10c
	add a,030h		;c10e
	cp 03ah		;c110
	jr c,lc116h		;c112
	add a,027h		;c114
lc116h:
	ld b,a			;c116
	call sub_c155h		;c117
	ret			;c11a
sub_c11bh:
	call sub_c003h		;c11b
lc11eh:
	ld a,(hl)			;c11e
	or a			;c11f
	ret z			;c120
	ld b,a			;c121
	call sub_c155h		;c122
	inc hl			;c125
	jr lc11eh		;c126
sub_c128h:
	call sub_c003h		;c128
	ld d,030h		;c12b
	ld bc,0d8f0h		;c12d
	call sub_c149h		;c130
	ld bc,0fc18h		;c133
	call sub_c149h		;c136
	ld bc,0ff9ch		;c139
	call sub_c149h		;c13c
	ld bc,0fff6h		;c13f
	call sub_c149h		;c142
	ld bc,0ffffh		;c145
	dec d			;c148
sub_c149h:
	ld a,02fh		;c149
lc14bh:
	inc a			;c14b
	add hl,bc			;c14c
	jr c,lc14bh		;c14d
	sbc hl,bc		;c14f
	ld b,a			;c151
	cp d			;c152
	ret z			;c153
	dec d			;c154
sub_c155h:
	in a,(010h)		;c155
	and 002h		;c157
	jr z,sub_c155h		;c159
	ld a,b			;c15b
	out (011h),a		;c15c
	ret			;c15e
lc15fh:
	ld h,000h		;c15f
	ld l,a			;c161
	push hl			;c162
	ld hl,lc6e7h		;c163
	call sub_c11bh		;c166
	pop hl			;c169
	call sub_c128h		;c16a
lc16dh:
	di			;c16d
	halt			;c16e
	jr lc16dh		;c16f
sub_c171h:
	ld a,003h		;c171
	out (010h),a		;c173
	ld a,015h		;c175
	out (010h),a		;c177
	ret			;c179
sub_c17ah:
	call sub_c003h		;c17a
	call sub_c1aeh		;c17d
	bit 1,(ix+002h)		;c180
	ret nz			;c184
	set 0,(ix+002h)		;c185
lc189h:
	ld e,(ix+00bh)		;c189
	ld h,004h		;c18c
	call sub_c063h		;c18e
	ld de,lc626h		;c191
	add hl,de			;c194
	ld a,(hl)			;c195
	inc hl			;c196
	ld h,(hl)			;c197
	ld l,a			;c198
	push ix		;c199
	call sub_c072h		;c19b
	pop ix		;c19e
	ret			;c1a0
sub_c1a1h:
	call sub_c003h		;c1a1
	res 1,(ix+002h)		;c1a4
	res 0,(ix+002h)		;c1a8
	jr lc189h		;c1ac
sub_c1aeh:
	call sub_c003h		;c1ae
	xor a			;c1b1
	ld ix,0d383h		;c1b2
	ld iy,00000h		;c1b6
	ex af,af'			;c1ba
	ld a,006h		;c1bb
lc1bdh:
	ex af,af'			;c1bd
	ex de,hl			;c1be
	bit 7,d		;c1bf
	jr nz,lc1dfh		;c1c1
	ld h,(ix+00bh)		;c1c3
	ld l,(ix+00ah)		;c1c6
	or a			;c1c9
	sbc hl,de		;c1ca
	jr nz,lc1dfh		;c1cc
	ld h,(ix+009h)		;c1ce
	ld l,(ix+008h)		;c1d1
	or a			;c1d4
	sbc hl,bc		;c1d5
	jr nz,lc1dfh		;c1d7
	push ix		;c1d9
	pop iy		;c1db
	jr lc228h		;c1dd
lc1dfh:
	bit 3,(ix+002h)		;c1df
	jr nz,lc1f3h		;c1e3
	cp (ix+005h)		;c1e5
	jr z,lc1ech		;c1e8
	jr nc,lc1f3h		;c1ea
lc1ech:
	push ix		;c1ec
	pop iy		;c1ee
	ld a,(ix+005h)		;c1f0
lc1f3h:
	ld hl,0000dh		;c1f3
	ex de,hl			;c1f6
	add ix,de		;c1f7
	ex af,af'			;c1f9
	dec a			;c1fa
	jr nz,lc1bdh		;c1fb
	push bc			;c1fd
	push hl			;c1fe
	push iy		;c1ff
	pop ix		;c201
	defb 0fdh,054h	;ld d,iyh		;c203
	defb 0fdh,05dh	;ld e,iyl		;c205
	xor a			;c207
	cp d			;c208
	jr nz,lc20fh		;c209
	cp e			;c20b
	call z,lc15fh		;c20c
lc20fh:
	bit 4,(ix+002h)		;c20f
	call nz,sub_c1a1h		;c213
	pop hl			;c216
	ld (ix+00bh),h		;c217
	ld (ix+00ah),l		;c21a
	pop hl			;c21d
	ld (ix+009h),h		;c21e
	ld (ix+008h),l		;c221
	ld (ix+002h),008h		;c224
lc228h:
	ld c,006h		;c228
	ld iy,0d383h		;c22a
	ld a,(ix+005h)		;c22e
lc231h:
	cp (iy+005h)		;c231
	jr c,lc239h		;c234
	inc (iy+005h)		;c236
lc239h:
	ld de,0000dh		;c239
	add iy,de		;c23c
	dec c			;c23e
	jr nz,lc231h		;c23f
	ld (ix+005h),000h		;c241
	ret			;c245
sub_c246h:
	ld c,006h		;c246
	ld hl,0c783h		;c248
	ld ix,0d383h		;c24b
	xor a			;c24f
lc250h:
	ld (ix+007h),h		;c250
	ld (ix+006h),l		;c253
	ld (ix+003h),c		;c256
	call sub_c269h		;c259
	ld de,0000dh		;c25c
	add ix,de		;c25f
	ld de,00200h		;c261
	add hl,de			;c264
	dec c			;c265
	jr nz,lc250h		;c266
	ret			;c268
sub_c269h:
	defb 0ddh,0cbh,002h,09fh	;res 3,(ix+002h) & ld a,(ix+002h)		;c269
	ld (ix+002h),a		;c26d
	ret			;c270
sub_c271h:
	ld h,(ix+007h)		;c271
	ld l,(ix+006h)		;c274
	ret			;c277
sub_c278h:
	ld h,0ffh		;c278
	call sub_c1aeh		;c27a
	push ix		;c27d
	ld hl,00000h		;c27f
	ld bc,00001h		;c282
	call sub_c17ah		;c285
	pop iy		;c288
	ld a,(ix+00ch)		;c28a
	or a			;c28d
	call nz,lc15fh		;c28e
	ld bc,00200h		;c291
	ld d,(iy+007h)		;c294
	ld e,(iy+006h)		;c297
	call sub_c271h		;c29a
	ldir		;c29d
	call sub_c269h		;c29f
	defb 0fdh,054h	;ld d,iyh		;c2a2
	defb 0fdh,05dh	;ld e,iyl		;c2a4
	ex de,hl			;c2a6
	ld (0d3d3h),hl		;c2a7
	ld hl,00000h		;c2aa
	ld (0d3d1h),hl		;c2ad
	ret			;c2b0
sub_c2b1h:
	call sub_c003h		;c2b1
	ex de,hl			;c2b4
lc2b5h:
	ld ix,0d3e9h		;c2b5
	ld a,014h		;c2b9
	ld iy,00000h		;c2bb
lc2bfh:
	ld h,(ix+042h)		;c2bf
	ld l,(ix+041h)		;c2c2
	or a			;c2c5
	sbc hl,de		;c2c6
	jr nz,lc302h		;c2c8
	ld h,(ix+044h)		;c2ca
	ld l,(ix+043h)		;c2cd
	or a			;c2d0
	sbc hl,bc		;c2d1
	jr nz,lc302h		;c2d3
	bit 3,(ix+040h)		;c2d5
	ret z			;c2d9
	ld iy,0d3d1h		;c2da
	ld c,000h		;c2de
lc2e0h:
	ld a,(iy+005h)		;c2e0
	defb 0ddh,0bch	;cp ixh		;c2e3
	jr nz,lc2f7h		;c2e5
	ld a,(iy+004h)		;c2e7
	defb 0ddh,0bdh	;cp ixl		;c2ea
	jr nz,lc2f7h		;c2ec
	ld bc,00001h		;c2ee
	defb 0fdh,054h	;ld d,iyh		;c2f1
	defb 0fdh,05dh	;ld e,iyl		;c2f3
	jr lc2b5h		;c2f5
lc2f7h:
	ld de,00006h		;c2f7
	add iy,de		;c2fa
	dec c			;c2fc
	jr nz,lc2e0h		;c2fd
	call lc15fh		;c2ff
lc302h:
	ex af,af'			;c302
	xor a			;c303
	cp (ix+045h)		;c304
	jr nz,lc30dh		;c307
	push ix		;c309
	pop iy		;c30b
lc30dh:
	ex af,af'			;c30d
	ld hl,00046h		;c30e
	ex de,hl			;c311
	add ix,de		;c312
	ex de,hl			;c314
	dec a			;c315
	jr nz,lc2bfh		;c316
	defb 0fdh,0bch	;cp iyh		;c318
	jr nz,lc326h		;c31a
	defb 0fdh,0bdh	;cp iyl		;c31c
	jr nz,lc326h		;c31e
	ld a,017h		;c320
	ld (0c6eeh),a		;c322
	ret			;c325
lc326h:
	ld (iy+042h),d		;c326
	ld (iy+041h),e		;c329
	ld (iy+044h),b		;c32c
	ld (iy+043h),c		;c32f
	inc (iy+045h)		;c332
	call sub_c35dh		;c335
	call sub_c34ch		;c338
	defb 0fdh,054h	;ld d,iyh		;c33b
	defb 0fdh,05dh	;ld e,iyl		;c33d
	ld bc,00040h		;c33f
	ldir		;c342
	call sub_c269h		;c344
	push iy		;c347
	pop ix		;c349
	ret			;c34b
sub_c34ch:
	ld h,040h		;c34c
	ld a,007h		;c34e
	and e			;c350
	ld e,a			;c351
	call sub_c063h		;c352
	ld d,(ix+007h)		;c355
	ld e,(ix+006h)		;c358
	add hl,de			;c35b
	ret			;c35c
sub_c35dh:
	ld h,b			;c35d
	ld l,c			;c35e
	ld a,l			;c35f
	srl h		;c360
	rra			;c362
	srl h		;c363
	rra			;c365
	srl h		;c366
	rra			;c368
	ld l,a			;c369
	inc hl			;c36a
	inc hl			;c36b
	push bc			;c36c
	ld b,h			;c36d
	ld c,l			;c36e
	pop hl			;c36f
	ex de,hl			;c370
	push iy		;c371
	call sub_c17ah		;c373
	pop iy		;c376
	ret			;c378
sub_c379h:
	xor a			;c379
	dec (ix+045h)		;c37a
	ret nz			;c37d
	ld (ix+040h),a		;c37e
	ld (ix+043h),a		;c381
	ret			;c384
sub_c385h:
	call sub_c003h		;c385
	xor a			;c388
	cp h			;c389
	jr nz,lc3a3h		;c38a
	ld a,l			;c38c
	cp 012h		;c38d
	jr nc,lc3a3h		;c38f
	sla l		;c391
	ld de,00018h		;c393
	add hl,de			;c396
	defb 0ddh,054h	;ld d,ixh		;c397
	defb 0ddh,05dh	;ld e,ixl		;c399
	add hl,de			;c39b
	ld a,(hl)			;c39c
	inc hl			;c39d
	ld h,(hl)			;c39e
	ld l,a			;c39f
	or h			;c3a0
	ret nz			;c3a1
	ret			;c3a2
lc3a3h:
	ret			;c3a3
sub_c3a4h:
	call sub_c003h		;c3a4
	ld (0c720h),hl		;c3a7
	ld hl,(0c6f5h)		;c3aa
	ld b,h			;c3ad
	ld c,l			;c3ae
	ld hl,(0c6f3h)		;c3af
	call sub_c49bh		;c3b2
	cp 02fh		;c3b5
	jr nz,lc3bfh		;c3b7
	ld hl,00000h		;c3b9
	ld bc,00001h		;c3bc
lc3bfh:
	call sub_c2b1h		;c3bf
lc3c2h:
	jr nz,lc3cbh		;c3c2
	call sub_c49bh		;c3c4
	cp 02fh		;c3c7
	jr lc3c2h		;c3c9
lc3cbh:
	ld a,(0c6eeh)		;c3cb
	or a			;c3ce
	jr z,lc3d9h		;c3cf
lc3d1h:
	call sub_c379h		;c3d1
	ld ix,00000h		;c3d4
	ret			;c3d8
lc3d9h:
	cp e			;c3d9
	ret z			;c3da
	ld a,(ix+001h)		;c3db
	and 060h		;c3de
	xor 040h		;c3e0
	jr z,lc3ebh		;c3e2
	ld a,014h		;c3e4
	ld (0c6eeh),a		;c3e6
	jr lc3d1h		;c3e9
lc3ebh:
	ld hl,0c701h		;c3eb
	ld b,020h		;c3ee
	ld a,e			;c3f0
lc3f1h:
	cp 02fh		;c3f1
	jr z,lc404h		;c3f3
	or a			;c3f5
	jr z,lc404h		;c3f6
	xor a			;c3f8
	cp b			;c3f9
	jr z,lc3ffh		;c3fa
	ld (hl),e			;c3fc
	inc hl			;c3fd
	dec b			;c3fe
lc3ffh:
	call sub_c49bh		;c3ff
	jr lc3f1h		;c402
lc404h:
	xor a			;c404
	ld (hl),a			;c405
	ld a,e			;c406
lc407h:
	cp 02fh		;c407
	jr nz,lc410h		;c409
	call sub_c49bh		;c40b
	jr lc407h		;c40e
lc410h:
	ld h,(ix+009h)		;c410
	ld l,(ix+008h)		;c413
	xor a			;c416
	add hl,hl			;c417
	rla			;c418
	add hl,hl			;c419
	rla			;c41a
	add hl,hl			;c41b
	rla			;c41c
	ld l,h			;c41d
	ld h,a			;c41e
	ld (0c722h),hl		;c41f
	ld hl,00000h		;c422
lc425h:
	push hl			;c425
	push ix		;c426
	call sub_c385h		;c428
	ld b,h			;c42b
	ld c,l			;c42c
	ld h,(ix+042h)		;c42d
	ld l,(ix+041h)		;c430
	call sub_c17ah		;c433
	call sub_c271h		;c436
	ld d,010h		;c439
lc43bh:
	push hl			;c43b
	ld hl,(0c722h)		;c43c
	ld a,h			;c43f
	or l			;c440
	jr z,lc48ch		;c441
	dec hl			;c443
	ld (0c722h),hl		;c444
	pop hl			;c447
	push hl			;c448
	inc hl			;c449
	inc hl			;c44a
	ld bc,0c701h		;c44b
	ld a,01eh		;c44e
lc450h:
	ex af,af'			;c450
	ld a,(bc)			;c451
	cp (hl)			;c452
	jr nz,lc460h		;c453
	or a			;c455
	jr z,lc471h		;c456
	ex af,af'			;c458
	dec a			;c459
	jr z,lc471h		;c45a
	inc hl			;c45c
	inc bc			;c45d
	jr lc450h		;c45e
lc460h:
	pop hl			;c460
	ld bc,00020h		;c461
	add hl,bc			;c464
	dec d			;c465
	jr nz,lc43bh		;c466
	call sub_c269h		;c468
	pop ix		;c46b
	pop hl			;c46d
	inc hl			;c46e
	jr lc425h		;c46f
lc471h:
	pop hl			;c471
	ld c,(hl)			;c472
	inc hl			;c473
	ld b,(hl)			;c474
	call sub_c269h		;c475
	pop ix		;c478
	pop hl			;c47a
	ld h,(ix+042h)		;c47b
	ld l,(ix+041h)		;c47e
	push hl			;c481
	call sub_c379h		;c482
	pop hl			;c485
	call sub_c2b1h		;c486
	jp lc3cbh		;c489
lc48ch:
	pop hl			;c48c
	call sub_c269h		;c48d
	pop ix		;c490
	pop hl			;c492
	ld a,002h		;c493
	ld (0c6eeh),a		;c495
	jp lc3d1h		;c498
sub_c49bh:
	push hl			;c49b
	ld hl,(0c720h)		;c49c
	call sub_c072h		;c49f
	pop hl			;c4a2
	ld e,a			;c4a3
	ret			;c4a4
lc4a5h:
	push hl			;c4a5
	ld hl,(0c6efh)		;c4a6
	ld a,(hl)			;c4a9
	inc hl			;c4aa
	ld (0c6efh),hl		;c4ab
	pop hl			;c4ae
	ret			;c4af
	push hl			;c4b0
	ld hl,(0c6efh)		;c4b1
	call sub_c5efh		;c4b4
	inc hl			;c4b7
	ld (0c6efh),hl		;c4b8
	pop hl			;c4bb
	ret			;c4bc
sub_c4bdh:
	call sub_c003h		;c4bd
lc4c0h:
	ld a,(0d961h)		;c4c0
	or a			;c4c3
	jr z,lc4c8h		;c4c4
	jr lc4c0h		;c4c6
lc4c8h:
	inc a			;c4c8
	ld (0d961h),a		;c4c9
	ld h,(ix+042h)		;c4cc
	ld l,(ix+041h)		;c4cf
	ld (0c724h),hl		;c4d2
	push ix		;c4d5
	ld hl,0ffffh		;c4d7
	call sub_c1aeh		;c4da
	ld (0c722h),ix		;c4dd
	xor a			;c4e1
	ld (0c72ch),a		;c4e2
	exx			;c4e5
	call sub_c271h		;c4e6
	exx			;c4e9
	ld bc,00200h		;c4ea
lc4edh:
	ld hl,(0c6f9h)		;c4ed
	call sub_c5f1h		;c4f0
	ld d,a			;c4f3
	or e			;c4f4
	jr z,lc513h		;c4f5
	inc hl			;c4f7
	inc hl			;c4f8
	ld (0c6f9h),hl		;c4f9
	ld hl,0c72ch		;c4fc
	inc (hl)			;c4ff
	ex de,hl			;c500
lc501h:
	call sub_c5efh		;c501
	inc hl			;c504
	exx			;c505
	ld (hl),a			;c506
	inc hl			;c507
	exx			;c508
	or a			;c509
	jp z,lc4edh		;c50a
	dec bc			;c50d
	ld b,a			;c50e
	or c			;c50f
	jr nz,lc501h		;c510
	inc a			;c512
lc513h:
	pop ix		;c513
	jp nz,lc5e4h		;c515
	ld hl,00000h		;c518
	push hl			;c51b
	call sub_c385h		;c51c
	ld b,h			;c51f
	ld c,l			;c520
	ld hl,(0c724h)		;c521
	push ix		;c524
	call sub_c17ah		;c526
	ld a,(0c6eeh)		;c529
	or a			;c52c
	jp nz,lc5deh		;c52d
	call sub_c271h		;c530
	ld a,018h		;c533
	cp (hl)			;c535
	inc hl			;c536
	jr nz,lc53fh		;c537
	ld a,00eh		;c539
	cp (hl)			;c53b
	inc hl			;c53c
	jr z,lc547h		;c53d
lc53fh:
	ld a,008h		;c53f
	ld (0c6eeh),a		;c541
	jp lc5deh		;c544
lc547h:
	inc hl			;c547
	ld b,(hl)			;c548
	inc hl			;c549
	ld c,(hl)			;c54a
	ex de,hl			;c54b
	ld hl,00000h		;c54c
	sbc hl,bc		;c54f
	ld (0c726h),hl		;c551
	ex de,hl			;c554
	ld de,00008h		;c555
	add hl,de			;c558
	ld d,(hl)			;c559
	inc hl			;c55a
	ld e,(hl)			;c55b
	inc hl			;c55c
	ld (0c728h),de		;c55d
	ld a,(hl)			;c561
	inc hl			;c562
	ld h,(hl)			;c563
	ld l,a			;c564
	ld b,h			;c565
	ld c,l			;c566
	ld de,lc000h		;c567
	or a			;c56a
	sbc hl,de		;c56b
	jr nc,lc576h		;c56d
	ld a,007h		;c56f
	ld (0c6eeh),a		;c571
	jr lc5deh		;c574
lc576h:
	ld de,00000h		;c576
	call sub_c603h		;c579
lc57ch:
	ld hl,(0c728h)		;c57c
	ld b,h			;c57f
	ld c,l			;c580
	ld de,00200h		;c581
	or a			;c584
	sbc hl,de		;c585
	push af			;c587
	jr c,lc592h		;c588
	ld b,d			;c58a
	ld c,e			;c58b
	ld hl,00000h		;c58c
	ld (0c72ah),hl		;c58f
lc592h:
	call sub_c271h		;c592
	ld de,(0c72ah)		;c595
	call sub_c600h		;c599
	ld (0c72ah),de		;c59c
	call sub_c269h		;c5a0
	pop af			;c5a3
	jr c,lc5c0h		;c5a4
	pop ix		;c5a6
	pop hl			;c5a8
	inc hl			;c5a9
	push hl			;c5aa
	call sub_c385h		;c5ab
	ld b,h			;c5ae
	ld c,l			;c5af
	ld hl,(0c724h)		;c5b0
	push ix		;c5b3
	call sub_c17ah		;c5b5
	ld a,(0c6eeh)		;c5b8
	or a			;c5bb
	jr nz,lc5deh		;c5bc
	jr lc57ch		;c5be
lc5c0h:
	ld hl,(0c726h)		;c5c0
	ld a,h			;c5c3
	or l			;c5c4
	jr z,lc5c7h		;c5c5
lc5c7h:
	call sub_c379h		;c5c7
	ld ix,(0c722h)		;c5ca
	call sub_c269h		;c5ce
	ld hl,0bffeh		;c5d1
	ld (0c77fh),hl		;c5d4
	ld de,00000h		;c5d7
	call sub_c5fbh		;c5da
	ret			;c5dd
lc5deh:
	call sub_c269h		;c5de
	pop ix		;c5e1
	pop hl			;c5e3
lc5e4h:
	call sub_c379h		;c5e4
	ld ix,(0c722h)		;c5e7
	call sub_c269h		;c5eb
	ret			;c5ee
sub_c5efh:
	ld a,(hl)			;c5ef
	ret			;c5f0
sub_c5f1h:
	ld e,(hl)			;c5f1
	inc hl			;c5f2
	ld d,(hl)			;c5f3
	dec hl			;c5f4
	ret			;c5f5
	ldir		;c5f6
	ret			;c5f8
	ld (hl),a			;c5f9
	ret			;c5fa
sub_c5fbh:
	ld (hl),e			;c5fb
	inc hl			;c5fc
	ld (hl),d			;c5fd
	dec hl			;c5fe
	ret			;c5ff
sub_c600h:
	ldir		;c600
	ret			;c602
sub_c603h:
	ld h,d			;c603
	ld l,e			;c604
	ld (hl),000h		;c605
	inc de			;c607
	dec bc			;c608
	ldir		;c609
	ret			;c60b
	ld sp,0c76dh		;c60c
	pop ix		;c60f
	pop iy		;c611
	pop af			;c613
	pop bc			;c614
	pop de			;c615
	pop hl			;c616
	ex af,af'			;c617
	exx			;c618
	pop af			;c619
	pop bc			;c61a
	pop de			;c61b
	pop hl			;c61c
	ld sp,hl			;c61d
	ld hl,(0c781h)		;c61e
	ret			;c621
sub_c622h:
	call sub_c635h		;c622
	ret			;c625
lc626h:
	ccf			;c626
	add a,062h		;c627
	exx			;c629
	inc (hl)			;c62a
	add a,034h		;c62b
	add a,034h		;c62d
	add a,034h		;c62f
	add a,034h		;c631
	add a,0c9h		;c633
sub_c635h:
	ld b,020h		;c635
	ld a,001h		;c637
lc639h:
	out (0fdh),a		;c639
	dec b			;c63b
	jr nz,lc639h		;c63c
	ret			;c63e
	xor a			;c63f
	ld (ix+004h),a		;c640
	ld hl,0d964h		;c643
	call sub_c024h		;c646
	ld a,(0d962h)		;c649
	or a			;c64c
	jr z,lc650h		;c64d
	ret			;c64f
lc650h:
	ld ix,0d964h		;c650
	call sub_c012h		;c654
	ret z			;c657
	ld a,001h		;c658
	ld (0d962h),a		;c65a
	ld a,002h		;c65d
	bit 0,(ix+002h)		;c65f
	jr nz,lc667h		;c663
	ld a,003h		;c665
lc667h:
	ld (0d968h),a		;c667
	ld a,(ix+00ah)		;c66a
	ld (0d969h),a		;c66d
	ld a,(ix+008h)		;c670
	and 007h		;c673
	rlca			;c675
	rlca			;c676
	or (ix+004h)		;c677
	ld (0d96ah),a		;c67a
	ld h,(ix+009h)		;c67d
	ld l,(ix+008h)		;c680
	ld a,l			;c683
	srl h		;c684
	rra			;c686
	srl h		;c687
	rra			;c689
	srl h		;c68a
	rra			;c68c
	ld l,a			;c68d
	ld (0d96bh),hl		;c68e
	call sub_c271h		;c691
	ld a,(ix+004h)		;c694
	or a			;c697
lc698h:
	jr z,lc6a1h		;c698
	ld de,00080h		;c69a
	add hl,de			;c69d
	dec a			;c69e
	jr lc698h		;c69f
lc6a1h:
	ld (0d96dh),hl		;c6a1
	ld b,007h		;c6a4
	ld hl,0d968h		;c6a6
lc6a9h:
	ld a,(hl)			;c6a9
	out (0fdh),a		;c6aa
	inc hl			;c6ac
	dec b			;c6ad
	jr nz,lc6a9h		;c6ae
	in a,(0fdh)		;c6b0
	ld a,004h		;c6b2
	inc (ix+004h)		;c6b4
	cp (ix+004h)		;c6b7
	jr nz,lc650h		;c6ba
	xor a			;c6bc
	ld (0d962h),a		;c6bd
	ld hl,0d964h		;c6c0
	call sub_c04eh		;c6c3
	jr nz,lc650h		;c6c6
	ret			;c6c8
lc6c9h:
	halt			;c6c9
	ld h,l			;c6ca
	ld a,d			;c6cb
	ld l,c			;c6cc
	ld a,b			;c6cd
	jr nz,$+100		;c6ce
	ld l,a			;c6d0
	ld l,a			;c6d1
	ld (hl),h			;c6d2
lc6d3h:
	ld a,(bc)			;c6d3
	dec c			;c6d4
	nop			;c6d5
lc6d6h:
	ld l,l			;c6d6
	ld h,l			;c6d7
	ld l,l			;c6d8
	jr nz,$+63		;c6d9
	jr nz,lc6ddh		;c6db
lc6ddh:
	cpl			;c6dd
	ld h,l			;c6de
	ld (hl),h			;c6df
	ld h,e			;c6e0
	cpl			;c6e1
	ld l,c			;c6e2
	ld l,(hl)			;c6e3
	ld l,c			;c6e4
	ld (hl),h			;c6e5
	nop			;c6e6
lc6e7h:
	ld (hl),b			;c6e7
	ld h,c			;c6e8
	ld l,(hl)			;c6e9
	ld l,c			;c6ea
	ld h,e			;c6eb
	jr nz,$+2		;c6ec
