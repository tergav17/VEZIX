; conf.s
; vezix config header

; memory format stuff
c_utop 	=	t_base	; uspace top
c_ubase =	0x0000  ; uspace base

; common data structures

.type word_t {
	byte	low,
	byte	high
}