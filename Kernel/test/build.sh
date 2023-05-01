cd ../sys/conf

# build system components
cd ../core
echo "\tbuilding core..."
as_r -v ../header.s h/core.s main.s prf.s
echo -n "core size: "
size_r a.out
mv a.out ../conf/obj/core.o

echo "\tbuilding blkio..."
as_r -v ../header.s h/blkio.s bio.s
echo -n "blkio size: "
size_r a.out
mv a.out ../conf/obj/blkio.o

echo "\tbuilding fs..."
as_r -v ../header.s h/fs.s alloc.s iget.s subr.s
echo -n "fs size: "
size_r a.out
mv a.out ../conf/obj/fs.o

echo "\tbuilding proc..."
as_r -v ../header.s h/proc.s text.s
echo -n "proc size: "
size_r a.out
mv a.out ../conf/obj/proc.o


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
