; vezix configuration header

; all low.s and top.s stuff is extern by default
.extern t_base, b_base, svnhl

; memory format stuff
c_utop = 	t_base	; user space top
c_ubase =	0x0000  ; user space base