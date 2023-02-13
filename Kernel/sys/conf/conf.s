; conf.s
; vezix device configuration

.extern shdstrat, shdinit, shdtab

; device init bus
; called on kernel init
; buffers will already be init at this
; point, but nothing else
;
; uses: all
.globl dinit
dinit:
	call shdinit
	ret


; block device switch
; this is where block device drivers
; are added to the kernel
.globl bdevsw
.defl bdev_t[c_nbdev] bdevsw {
	shdstrat,
	shdtab
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
	nodevr
}

; used to indicate no device routine
nodevr:
	ret