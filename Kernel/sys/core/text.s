; text.s
; user core management

; profile execute
; this function will overlay a core
; image stored in the passed open inode
; onto the current profile.
; ix = image to overlay
;
; saves: af, bc, de
.globl pexec
pexec:
	call	svnhl
	ret