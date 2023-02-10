; header.s
; vezix master header
; contains general system configuration

; top and bottom of core
.extern d_top, b_top, t_base, b_base

; memory map config
c_utop 	=	t_base	; uspace top
c_ubase =	0x0000  ; uspace base

; buffer config
c_nbuf	=	6	; # of buffers

; device config constants
c_nbdev	=	1	; # of blk devs
c_ncdev	=	1	; # of chr devs

; common data structures

.type word_t {
	byte	low,
	byte	high
}