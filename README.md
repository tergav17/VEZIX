# VEZIX
VEZIX is a clone of MINI-UNIX targeting to run on the Z80. This project is by no means the first attempt to get something UNIX-y running. Many successful projects such as UZIX or FUZIX have been created, and are incredibly impressive. As to not retread ground, I have set three main design constraints for this project.

1. The system must run on 48-64kb, and be able to relocate user programs in order to deal with ROMs being statically mapped into high or low memory. This should allow it to run on most Z80 machines, especially those that run CP/M

2. The system must be somewhat modular. While I plan on making this a monolithic kernel, adding block and character devices should be a fairly straight forward process

3. The system must self-host. This means that a machine running VEZIX bust be able to build both the kernel and userspace locally

Of the three design constraints, I feel the last one is the most challenging. Any software tool must be simple enough to run on a Z80 natively. This essentially rules out using high level programming to build the kernel, and makes using C for the userspace a massive undertaking. That said, the challenge makes the project worth doing in my opinion.

# Battle Plan
- [X] Create an Z80 toolchain that can eventually run natively on VEZIX
    - [X] Write a relocatable assembler
    - [X] Write a linker
    - [X] Write a relocation tool
    - [X] Write misc tools like `strip`, `nm`, `size`
- [ ] Create the kernel
    - [X] Write simple kernel debug routines (`prf.s`)
    - [X] Get buffers and block I/O working
    - [ ] Get basic file system stuff working (Probably using the UZIX file system)
    - [ ] Simple process execution and swapping
    - [ ] Expand on file system, and implement character devices
    - [ ] Expand on processes, and start adding syscalls
    - [ ] Pipes? Not necessarily required but it would be nice
- [ ] Userland
    - [ ] Modify the Small C Plus (maybe BDS C?) compiler to produce assembly that can be built with TRASM
    - [ ] Use compiler to bring over standard utilities from Version 6 UNIX and UZIX
    - [ ] Rewrite the toolchain in assembly so it can run natively
    - [ ] Break the compiler up into multiple pieces, as to reduce the memory footprint (easier said than done!)
    - [ ] I will be genuinely surprised if I get this far
