VSN = $(shell cat vsn)
MAJOR = $(word 1,$(subst ., ,$(VSN)))
MINOR = $(word 2,$(subst ., ,$(VSN)))

DESTDIR ?= /usr/local/share/tcltk
PREFIX = $(DESTDIR)/netif$(MAJOR).$(MINOR)

.PHONY: all clean install
.SUFFIXES: .tcl .tcl.in

all: netif.tcl netif-linux.tcl pkgIndex.tcl

clean:
	rm -f netif.tcl pkgIndex.tcl

install: all
	install -d $(PREFIX)
	install -m 664 netif.tcl $(PREFIX)/netif.tcl
	install -m 664 netif-linux.tcl $(PREFIX)/netif-linux.tcl
	install -m 664 pkgIndex.tcl $(PREFIX)/pkgIndex.tcl

pkgIndex.tcl: netif.tcl netif-linux.tcl
	echo 'pkg_mkIndex .' | tclsh

.tcl.in.tcl:
	sed -e 's,<<VSN>>,$(VSN),g' $< > $@
