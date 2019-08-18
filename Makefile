PROG=ministat
PREFIX?=/usr/local
CFLAGS+=	-pipe -O2 -Wall -g
OBJS=	ministat.c
CC?=	cc
TARGETS=	ministat

all: $(TARGETS)

ministat:	$(OBJS)
	$(CC) -o $@ $(OBJS) $(CFLAGS)

install:
	[ -d $(PREFIX)/bin ] || mkdir -p $(PREFIX)/bin
	cp ministat $(PREFIX)/bin
	[ -d $(PREFIX)/share/man/man1/ ] || mkdir -p $(PREFIX)/share/man/man1/
	cp ministat.1 $(PREFIX)/share/man/man1/

deinstall:
	rm -f $(PREFIX)/share/man/man1/ministat.1.gz
	rm -f $(PREFIX)/bin/ministat

clean:
	rm -rf ministat ministat.dSYM

test:	${PROG}
	./${PROG} < tests/chameleon
	./${PROG} tests/chameleon
	./${PROG} tests/iguana tests/chameleon
	./${PROG} -c 80 tests/iguana tests/chameleon
	./${PROG} -s -c 80 tests/chameleon tests/iguana
	./${PROG} -s -c 80 tests/chameleon tests/iguana tests/iguana
