; conf.s
; vezix config header

; memory map config
c_utop 	=	t_base	; uspace top
c_ubase =	0x0000  ; uspace base

; buffer config
c_nbuf	=	6	; # of buffers

; common data structures

.type word_t {
	byte	low,
	byte	high
}