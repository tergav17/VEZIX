CC=gcc
CCOPTS=-O2 -g -Wall -pedantic -Wno-char-subscripts -Wno-deprecated-declarations

TARGETS=mkfs ucp

all:	$(TARGETS)

clean:
	rm -f $(TARGETS) *.o *~

mkfs:	mkfs.o util.o
	$(CC) $(CCOPTS) -o $@ $< util.o

fsck:	fsck.o util.o
	$(CC) $(CCOPTS) -o $@ $< util.o

ucp:	ucp.o util.o
	$(CC) $(CCOPTS) -o $@ $< util.o

%.o:	%.c
	$(CC) $(CCOPTS) -c -o $@ $<
