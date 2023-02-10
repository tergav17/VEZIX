; conf.s
; vezix device configuration


; block device switch
; this is where block device drivers
; are added to the kernel
.globl bdevsw
.defl bdev_t[c_nbdev] bdevsw {
	nobdev,
	0
}

; character device switch
; this is where char device drivers
; are added to the kernel
.globl cdevsw
.defl cdev_t[c_ncdev] cdevsw {
	nocdev,
	nocdev,
	nocdev,
	nocdev,
	nocdev
}

; used to indicate no block device
nobdev:
	ret
	
; used to indicate no char device
nocdev:
	ret