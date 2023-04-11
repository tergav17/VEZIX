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
	word_t[18] addr,
	word_t	sindr,
	word_t	dindr
}

; in core inode structure
; superset of dinode
.type cino_t {
	; on-disk inode
	dino_t	node,
	
	; inode flags
	byte	flag,
	
	; device and inumber
	word_t	dev,
	word_t	num,
	
	; reference count
	byte	count
}


; flags
i_lock	=	0
i_drty	=	1
i_acc	=	2
i_mnt	= 	3
i_want	=	4

; modes
m_oex	=	0
m_owr	=	1
m_ord	=	2
m_gex	=	3
m_gwr	=	4
m_grd	=	5
m_uex	=	6
m_uwr	=	7

m_urd	=	0
m_gid	=	1
m_uid	=	2
m_dev	=	4
m_dir	=	5