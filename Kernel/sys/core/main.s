; main.s
; kernel entry and setup
;
; sets up hardware and crafts proc 0

.text
.globl main
main:
	; place stack in uspace top
	ld	sp,c_utop
	
	; init kernel debugging
	call	kinit
	ld	hl,str_vez
	call	kputs
	
	; init subsystems
	call	 binit
	
	halt
	
	
.data
.defl byte str_vez	"vezix boot\n\r\0"
	