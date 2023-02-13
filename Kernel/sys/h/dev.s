; dev.s
; vezix device header

; block device entry
.type bdev_t {
	word_t	strat,	; dev strategy
	word_t	init	; dev init
}

; character device entry
.type cdev_t {
	word_t	init,	; device init
	word_t	open,	; open cdev
	word_t	close,	; close cdev
	word_t	read,	; read cdev
	word_t	write,	; write cdev
	word_t	ioctl	; io control
}