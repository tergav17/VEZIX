; core.s
; vezix core header

; low.s / top.s
.extern svnhl

; blkio
.extern binit, dinit, getblk, brelse, bread

; fs
.extern iinit, iget, bmap