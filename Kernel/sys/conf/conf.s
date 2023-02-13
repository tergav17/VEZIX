; conf.s
; vezix device configuration

.extern fd8strat, fd8init

; block device switch
; this is where block device drivers
; are added to the kernel
.globl bdevsw
.defl bdev_t[c_nbdev] bdevsw {
	fd8strat,
	fd8init
}

; character device switch
; this is where char device drivers
; are added to the kernel
.globl cdevsw
.defl cdev_t[c_ncdev] cdevsw {
	nodevr,
	nodevr,
	nodevr,
	nodevr,
	nodevr,
	nodevr
}

; used to indicate no device routine
nodevr:
	ret