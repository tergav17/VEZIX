cd ../core
as_r *.s
echo -n "core size: "
size_r a.out
mv a.out ../conf/obj/core.o

cd ../conf
as_r low.s
ld_r -s a.out obj/core.o
echo -n "total size: "
size_r a.out
reloc_r -n a.out 0xC000
mv a.out out/vezix
