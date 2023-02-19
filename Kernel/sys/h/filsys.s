; filsys.s
; file system header

; in core mount device
; ties a device to a super block
; and mounted inode
.type mount_t {
	word_t	dev, 	; mount device
	word_t	buf, 	; super block
	word_t	inode 	; mount inode
}

; on disk inode for fuzix file system
; this structure is 64 bytes long, so
; 8 inodes can fit in a disk block
.type dinode_t {
	; file mode
	word_t	mode,
	
	; number of links
	word_t	nlink,
	
	; user and group ids
	word_t	uid,
	word_t	gid,
	
	; size of file
	long_t	size,
	
	; timing stuff
	long_t	atime,
	long_t	mtime,
	long_t	ctime,
	
	; blocks used by inode
	word_t[20] addr
}

; in core inode structure
; superset of dinode
.type cinode_t {
	; on-disk inode
	dinode_t node,
	
	; inode flags
	byte	flag,
	
	; device and inumber
	word_t	dev,
	word_t	number,
	
	; reference count
	byte	count
}