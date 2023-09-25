; fs.s
; vezix fs header

; low.s / top.s
.extern svnhl, mulhe, jphl

; blkio
.extern bread, getblk, brelse, hlbuff

; core
.extern panic, u

; proc
.extern fubyte
