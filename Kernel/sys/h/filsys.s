; filsys.s
; file system header

.type mount_t {
	word_t	dev, 	; mount device
	word_t	buf, 	; super block
	word_t	inode 	; mount inode
}