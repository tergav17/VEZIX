; core.s
; vezix core header

; low.s / top.s
.extern svnhl

; blkio
.extern binit, dinit, getblk, brelse, bread, bwrite

; fs
.extern iinit, iget, bmap, namei, schar

; proc
.extern pexec, sret, suword