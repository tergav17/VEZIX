; proc.s
; vezix procces control header

; low.s / top.s
.extern svnhl, mulhe, jphl

; blkio
.extern getblk, brelse, bread

; fs
.extern bmap, iput

; core
.extern panic, u
