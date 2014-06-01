VSN = $(shell cat vsn)

.PHONY: all clean
.SUFFIXES: .tcl .tcl.in

all: netif.tcl netif-linux.tcl pkgIndex.tcl

clean:
	rm -f netif.tcl pkgIndex.tcl

pkgIndex.tcl: netif.tcl netif-linux.tcl
	echo 'pkg_mkIndex .' | tclsh

.tcl.in.tcl:
	sed -e 's,<<VSN>>,$(VSN),g' $< > $@
