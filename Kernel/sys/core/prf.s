; prf.s 
; kernel print functions
;
; provides debugging i/o
; used for panic or device errors
;
; this file is device specific, and
; needs porting to different hardware 

prf_csr =	0x10
prf_data = 	0x11

.text

; kernel print string
; hl = pointer to string
;
; uses: hl, iy
.globl kputs
kputs:
	call	svnhl
0:
	ld	a,(hl)
	or	a
	ret	z
	ld	b,a
	call	kputc
	inc	hl
	jr	0b
	
; kernel print decimal
; hl = value to print
;
; uses: hl, iy
.globl kputd
kputd:
	call	svnhl
	ld	d,'0'
	ld	bc,0-10000
	call	0f
	ld	bc,0-1000
	call	0f
	ld	bc,0-100
	call	0f
	ld	bc,0-10
	call	0f
	ld	bc,0-1
	dec	d
0:
	ld	a,'0'-1		; get character
1:
	inc	a
	add	hl,bc
	jr	c,1b
	sbc	hl,bc
	ld	b,a
	cp	d		; check for leading zeros
	ret	z
	dec	d
	; fall throught to kputc
	

; kernel put character
; b = character to print
;
; uses: af, b
kputc:
	in	a,(prf_csr)
	and	0x02
	jr	z,kputc		; loop if not ready
	ld	a,b
	out	(prf_data),a	; write character
	ret
	
; print panic and loop
;
; uses: n/a
.globl panic
panic:
	ld	hl,str_panc
	call	kputs
	pop	hl
	call	kputd
0:
	di
	halt
	jr	0b
	

; init prf
;
; uses: af
kinit:
	ld	a,0x03
	out	(prf_csr),a	; reset i/o
	ld	a,0x15
	out	(prf_csr),a	; config i/o
	ret
	
.data

.defl byte str_panc	"panic \0"