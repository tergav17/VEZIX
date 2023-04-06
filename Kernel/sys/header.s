; header.s
; vezix master header
; contains general system configuration

; top and bottom of core
.extern d_top, b_top, t_base, b_base

; memory map config
c_utop 	=	t_base	; uspace top
c_ubase =	0x0000  ; uspace base
c_ksize	=	64	; kstack size

; data structure config
c_nbuf	=	6	; # of buffers
c_nmnt	=	4	; # of mounts
c_nino	=	20	; # of inodes

; boot config
c_rootd	=	0x0000	; root device

; device config constants
c_nbdev	=	1	; # of blk devs
c_ncdev	=	1	; # of chr devs

; debugging
c_hdump	=	1	; allow hex dumps



; --- end of user configuration ---

; common data structures
.type word_t {
	byte	low,
	byte	high
}

.type long_t {
	word_t	low,
	word_t	high
}


; constants (do not modify)
rootino	=	1