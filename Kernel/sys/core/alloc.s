; alloc.s
; inode allocation and init

.text

; mounts the root file system and sets
; the time depending on the super block
;
; uses: all
.globl iinit
iinit:
	; grab a buf for mounting
	ld	h,nodev
	call	getblk
	push	ix
	
	; read superblock
	ld	hl,c_rootd
	ld	bc,0x0001
	call	bread
	pop	iy
	; panic on error
	ld	a,(ix+buf_t.error)
	or	a
	call	nz,panic
	; copy block and release it
	ld	bc,512
	ld	d,(iy+buf_t.addr.high)
	ld	e,(iy+buf_t.addr.low)
	call	hlbuff
	ldir
	call	brelse
	
	; set mount entry
	ld	d,iyh
	ld	e,iyl
	ex	de,hl
	ld	(mount.buf),hl
	ld	hl,c_rootd
	ld	(mount.dev),hl
	
	; todo: set time
	ret
	
	
.bss

; mount structrues
.globl mount 
.defl mount_t[c_nmnt] mount

; core inode structure
.globl inode
.defl cino_t[c_nino] inode