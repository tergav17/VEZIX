; user.s
; per-process user area

.type u_t {
	byte	error,	; current error
	word	dirp,	; dir pointer

	word	cdir,	; current ino
	word	cdev,	; dev of cdir
	word	cnum,	; num of cdir
	
	; kernel stack
	byte[c_ksize] kstack
}

; error codes
enoent	= 2
enotdir	= 20
enfile	= 23