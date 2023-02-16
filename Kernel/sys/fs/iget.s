; iget.s
; manages inodes in core and disk

; look up and inode depending on device
; and inumber. inode may be in core or
; on the physical disk
.globl iget
iget:
	ret