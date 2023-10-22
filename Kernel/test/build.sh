# build disk image

cd ../../Applications

# build user space
cd core

printf "\n\tbuilding utils...\n"
as_r -v init.s
mv a.out bin/init

cd ../../Utility/FuzixFS

# create empty disk image
./mkfs ../../Kernel/test/root.dsk 64 4096
./ucp ../../Kernel/test/root.dsk "mkdir etc"
./ucp ../../Kernel/test/root.dsk "mkdir usr"
./ucp ../../Kernel/test/root.dsk "get ../../Applications/core/bin/init /etc/init"
./ucp ../../Kernel/test/root.dsk "get test.txt /usr/test.txt"

# populate disk image with test binaries

# build system components
cd ../../Kernel/sys
cd core
printf "\n\tbuilding core...\n"
as_r -v ../header.s h/core.s main.s prf.s
echo -n "core size: "
size_r a.out
mv a.out ../conf/obj/core.o

printf "\n\tbuilding blkio..\n."
as_r -v ../header.s h/blkio.s bio.s
echo -n "blkio size: "
size_r a.out
mv a.out ../conf/obj/blkio.o

printf "\n\tbuilding fs...\n"
as_r -v ../header.s h/fs.s alloc.s iget.s subr.s rdwri.s
echo -n "fs size: "
size_r a.out
mv a.out ../conf/obj/fs.o

printf "\n\tbuilding proc...\n"
as_r -v ../header.s h/proc.s text.s page.s
echo -n "proc size: "
size_r a.out
mv a.out ../conf/obj/proc.o

printf "\n\tbuilding dev and linking...\n"

# build devices
cd ../dev
as_r ../header.s shd.s ; mv a.out ../conf/obj/shd.o

# build special components
cd ../conf
as_r low.s
mv a.out obj/low.o
as_r top.s
mv a.out obj/top.o

# link components and device drivers
as_r ../header.s conf.s
mv a.out obj/conf.o
cd obj
ld_r -v low.o core.o blkio.o fs.o proc.o conf.o shd.o top.o
mv a.out ../out/vezix.o

# post process
cd ../out
echo -n "total size: "
size_r vezix.o
cp vezix.o vezix
reloc_r -n vezix 0xC000
z80dasm -l -g 0xC000 -o vezix.asm vezix
