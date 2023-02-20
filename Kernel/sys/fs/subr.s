; subr.s
; intermediate level
; subroutines

.text

; maps a logical inode block to a disk
; block
.globl bmap
bmap:
	ret