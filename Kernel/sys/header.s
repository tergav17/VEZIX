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
nodev	=	0xffff

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
	; num must come after dev
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

; modes (low byte)
m_oex	=	0
m_owr	=	1
m_ord	=	2
m_gex	=	3
m_gwr	=	4
m_grd	=	5
m_uex	=	6
m_uwr	=	7

; modes (high byte)
m_urd	=	0
; we will ignore sgid, suid, and sticky
; (for now)
m_pip	=	4
m_dev	=	5
m_dir	=	6
m_reg	=	7

; vezix device header

; block device entry
.type bdev_t {
	word_t	strat,	; dev strategy
	word_t	devtab 	; dev table
}

; character device entry
.type cdev_t {
	word_t	open,	; open cdev
	word_t	close,	; close cdev
	word_t	read,	; read cdev
	word_t	write,	; write cdev
	word_t	ioctl	; io control
}

; per-process user area

.type u_t {
	byte	error,	; current error
	word	dirp,	; dir pointer

	word	cdir,	; current ino
	word	cdev,	; dev of cdir
	word	cnum,	; num of cdir
	
	word[5] args,	; syscall args
	
	; directory entry size is
	; locked at 32 bytes. This
	; saves a decent amount of
	; bytes in namei
	;
	; changing this will require
	; modification of that routine
	; plus others
	byte[31] dbuf,	; dirbuf
	word	pfunc,	; path function
	
	; general registers in user mem
	word	gp0,	; gen reg 0
	word	gp1,	; gen reg 1
	
	byte	gpa,	; gen reg a
	
	; kernel stack
	byte[c_ksize] kstack
}

; error codes
enoent	= 2
e2big	= 7
enotdir	= 20
enfile	= 23