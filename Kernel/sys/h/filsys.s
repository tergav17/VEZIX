; filsys.s
; file system header

; in core mount device
; ties a device to a super block
; and mounted inode
.type mount_t {
	word_t	dev, 	; mount device
	word_t	buf, 	; super block
	word_t	ino	; mount inode
}

; on disk inode for fuzix file system
; this structure is 64 bytes long, so
; 8 inodes can fit in a disk block
.type dino_t {
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
.type cino_t {
	; on-disk inode
	dino_t node,
	
	; inode flags
	byte	flag,
	
	; device and inumber
	word_t	dev,
	word_t	num,
	
	; reference count
	byte	count
}


; flags
i_lock	=	1
i_drty	=	2
i_acc	=	3
i_mnt	= 	4
i_want	=	5


; constants
rootino	=	1