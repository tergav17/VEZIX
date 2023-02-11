; hdsk88.s
; altair 88-hdsk driver

.text

; 88-hdsk strategy call
; used to link in a new buffer
; for the driver to fullfil
hd8strat:
	ret
	
	
	
; 88-hdsk activity start
; this just blocks for now, will change
; when interrupts get added
hd8start:
	ret

.bss

.defl devtab_t[1] hd8tab