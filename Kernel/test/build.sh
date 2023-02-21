cd ../sys/conf

# build system components
cd ../core
echo "\tbuilding core..."
as_r -v ../conf/header.s ../h/buf.s ../h/filsys.s core.s main.s prf.s
echo -n "core size: "
size_r a.out
mv a.out ../conf/obj/core.o

cd ../blkio
echo "\tbuilding blkio..."
as_r -v ../conf/header.s ../h/buf.s ../h/dev.s blkio.s bio.s
echo -n "blkio size: "
size_r a.out
mv a.out ../conf/obj/blkio.o

cd ../fs
echo "\tbuilding fs..."
as_r -v ../conf/header.s ../h/buf.s ../h/filsys.s fs.s alloc.s iget.s subr.s
echo -n "fs size: "
size_r a.out
mv a.out ../conf/obj/fs.o

# build devices
cd ../dev
as_r ../conf/header.s ../h/buf.s shd.s ; mv a.out ../conf/obj/shd.o

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
ld_r -v low.o core.o blkio.o fs.o conf.o shd.o top.o
mv a.out ../out/vezix.o

# post process
cd ../out
echo -n "total size: "
size_r vezix.o
cp vezix.o vezix
reloc_r -n vezix 0xC000
z80dasm -l -g 0xC000 -o vezix.asm vezix
