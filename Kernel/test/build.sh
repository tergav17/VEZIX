cd ../sys/conf

# build system components
cd ../core
echo "\tbuilding core..."
as_r -v ../conf/header.s ../h/buf.s ../conf/core.s *.s
echo -n "core size: "
size_r a.out
mv a.out ../conf/obj/core.o

cd ../blkio
echo "\tbuilding blkio..."
as_r -v ../conf/header.s ../h/buf.s ../conf/blkio.s *.s
echo -n "blkio size: "
size_r a.out
mv a.out ../conf/obj/blkio.o

# build special components
cd ../conf
as_r low.s
mv a.out obj/low.o
as_r top.s
mv a.out obj/top.o

# link components and device drivers
as_r header.s ../h/dev.s conf.s
mv a.out obj/conf.o
cd obj
ld_r low.o core.o blkio.o conf.o top.o
mv a.out ../out/vezix.o

# post process
cd ../out
echo -n "total size: "
size_r vezix.o
cp vezix.o vezix
reloc_r -n vezix 0xC000
z80dasm -l -g 0xC000 -o vezix.asm vezix
