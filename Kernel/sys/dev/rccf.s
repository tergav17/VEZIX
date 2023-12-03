; rccf.s
; rc-2014 cf disk driver

.extern ixnext, ixlink, ixunlink
.extern hlbuff

; this driver code is based off of the
; cf code found in the rc2014 cp/m bios

; cf constants
cf_data	=	0x10 ; data
cf_feat	=	0x11 ; feature
cf_err	=	0x11 ; error
cf_scnt	=	0x12 ; sector count
cf_sect	=	0x13 ; sector
cf_cylo	=	0x14 ; cyl low
cf_cyhi	=	0x15 ; cyl high
cf_head	=	0x16 ; head
cf_stat	=	0x17 ; status
cf_cmd	=	0x17 ; command
cf_lba0	=	0x13 ; lba 0
cf_lba1	=	0x14 ; lba 1
cf_lba2	=	0x15 ; lba 2
cf_lba3	=	0x16 ; lba 3

cf_8bit	=	0x01 ; 8 bit mode
cf_dcac	=	0x82 ; disable cache

cf_read	=	0x20 ; read command
cf_writ	=	0x30 ; write command
cf_setf	=	0xef ; set feature

.text

; rccf init routine
.globl cfinit
cfinit:

	; set cf to be 8 bit and 
	; no cache
	ld	a,cf_8bit
	call	0f
	
	ld	a,cf_dcac
	call	cfwait
0:	out	(cf_feat),a
	ld	a,cf_setf
	out	(cf_cmd),a
	ret

; rccf strategy call
; used to link in a new buffer
; for the driver to fullfil
; ix = buffer to attach
;
; uses: all
.globl cfstrat
cfstrat:
	; reset transferred sector counter
	xor	a
	ld	(ix+buf_t.scount),a

	; attach buf to devtab
	ld	hl,cftab.io_head
	call	ixlink
	
	; start if not active
	ld	a,(cftab.active)
	or	a
	jr	z,cfstart
	ret
	
	
	
; rccf hd activity start
; this just blocks for now, will change
; when interrupts get added
;
; uses: all
cfstart:
	; return if nothing to do
	ld	ix,cftab.io_head
	call	ixnext
	ret	z
	
	; set activity flag
	ld	a,1
	ld	(cftab.active),a
	
	; do stuff here
	
	; set block count
	ld	a,1
	out	(cf_scnt),a
	
	; set target block
	call	cfwait
	ld	a,(ix+buf_t.blkno.low)
	out	(cf_lba0),a
	ld	a,(ix+buf_t.blkno.high)
	out	(cf_lba1),a
	ld	a,(ix+buf_t.dev.low)
	out	(cf_lba2),a
	ld	a,0xe0
	out	(cf_lba3),a
	
	; issue command
	bit	b_read,(ix+buf_t.flag)
	jr	nz,0f
	
	; write operation
	call	cfwait
	ld	a,cf_writ
	out	(cf_cmd),a
	
	; write out of buffer
	call	cfwait
	call	hlbuff
	ld	bc,cf_data
	otir
	otir
	
	jr	9f
	
0:	; read operation
	call	cfwait
	ld	a,cf_read
	out	(cf_cmd),a
	
	; read into buffer
	call	cfwait
	call	hlbuff
	ld	bc,cf_data
	inir
	inir
	
	; reset activity flag
9:	xor	a
	ld	(cftab.active),a
	
	; unlink block from device
	ld	hl,cftab.io_head
	call	ixunlink
	
	; todo: call iodone

	; continue if there is another block to grab
	jr	nz,cfstart

	ret

; waits for the cf card to be read
; this should replaced with irq code
; down the line
;
; uses: none
cfwait:
	; save af
	push	af
	
	; read cf status and test busy
0:	in	a,(cf_stat)
	bit	7,a
	jr	nz,0b
	
	; read cf status and test ready
1:	in	a,(cf_stat)
	bit	6,a
	jr	z,1b
	
	; pop af and return
	pop	af
	ret
	

.bss

.globl cftab
.defl devtab_t cftab	0