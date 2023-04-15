; user.s
; per-process user area

.type u_t {
	byte	error,
	word	dirp,
	
	; kernel stack
	byte[c_ksize] kstack
}