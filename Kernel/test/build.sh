cd ../sys/conf

cd ../core
echo "\tbuilding core..."
as_r -v ../conf/conf.s ../h/buf.s ../conf/core.s *.s
echo -n "core size: "
size_r a.out
mv a.out ../conf/obj/core.o

cd ../blkio
echo "\tbuilding blkio..."
as_r -v ../conf/conf.s ../h/buf.s ../conf/blkio.s *.s
echo -n "blkio size: "
size_r a.out
mv a.out ../conf/obj/blkio.o


cd ../conf
as_r low.s
mv a.out obj/low.o
as_r top.s
ld_r -s obj/low.o obj/core.o obj/blkio.o a.out
echo -n "total size: "
size_r a.out
reloc_r -n a.out 0xC000
mv a.out out/vezix
