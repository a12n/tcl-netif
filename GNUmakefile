VSN = $(shell cat vsn)

.PHONY: all clean distclean
.SUFFIXES: .tcl .tcl.in

all: netif.tcl netif-linux.tcl pkgIndex.tcl

clean:

distclean: clean
	rm -f pkgIndex.tcl

pkgIndex.tcl: netif.tcl netif-linux.tcl
	echo 'pkg_mkIndex .' | tclsh

.tcl.in.tcl:
	sed -e 's,<<VSN>>,$(VSN),g' $< > $@
