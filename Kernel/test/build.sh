# build disk image
pushd ../sys/conf

cd ../../Applications

# build user space
cd core
as_r -v init.s

cd ../../Utility/FuzixFS

# create empty disk imag 
./mkfs ../../Kernel/test/root.dsk 64 4096

# populate disk image with test binaries

popd
# build system components
cd ../core
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
