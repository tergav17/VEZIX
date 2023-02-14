; buf.s
; vezix buffer header

; the buf_t data structure acts as a
; header for a single 512 buffer. if a
; buffer does not have the 'busy' flag
; set, it is treated as available and
; may be reused
.type buf_t {
	; next must be first element
	word_t	next,	; next buf

	byte	flag,	; buffer flags
	byte	serial,
	byte	scount,	; sector count
	byte	age,	; buffer age
	word_t	addr,	; buf core addr
	word_t	blkno,	; blk # on dev
	word_t	dev,	; device number
	byte	error	; error #
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
b_read	=	0x00	; set if read
b_done	=	0x01	; op done 
b_error	=	0x02	; op aborted
b_busy	=	0x03	; buf is busy
b_delwr	=	0x04	; write on use

; nodev
nodev	=	0xFFFF