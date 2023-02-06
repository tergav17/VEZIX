; buf.s
; buffer header file

; the buf_t data structure acts as a
; header for a single 512 buffer. if a
; buffer does not have the 'busy' flag
; set, it is treated as available and
; may be reused
.type buf_t {
	byte	flag,	; buffer flags
	word_t	wcount,	; transfer cnt
	word_t	addr,	; buf core addr
	word_t	blkno,	; blk # on dev
	word_t	dev,	; device number
	byte	error,
	
	word_t	next,	; next buf
}

; block devices in vezix word on a
; queue system. when work must be done
; for a specific block on a device, a
; buffer with the correct flags and
; block # is appened to the io queue.
; buffers are processed in the order
; that they are added in
.type devtab_t {
	byte	active,	; set during op
	byte	errcnt,	; err count
	word_t	io_head,; io queue head
	word_t	io_tail	; io queue tail
}

; buf_t flags
b_read	=	0x01	; set if read
b_done	=	0x02	; op done 
b_error	=	0x04	; op aborted
b_busy	=	0x08	; buf is busy
b_delwr	=	0x10	; write on use