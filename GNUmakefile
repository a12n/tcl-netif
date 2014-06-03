VSN = $(shell cat vsn)

GEN_SCRIPTS = netif.tcl pkgIndex.tcl
SCRIPTS = $(GEN_SCRIPTS) $(wildcard netif-*.tcl)

DESTDIR ?= /usr/local/share/tcltk
PREFIX = $(DESTDIR)/netif$(VSN)

.PHONY: all clean install
.SUFFIXES: .tcl .tcl.in

all: $(SCRIPTS)

clean:
	rm -f $(GEN_SCRIPTS)

install: all
	install -d $(PREFIX)
	for SCRIPT in $(SCRIPTS); do \
		install -m 664 $$SCRIPT $(PREFIX)/$$SCRIPT; \
	done

pkgIndex.tcl: netif.tcl
	echo 'pkg_mkIndex .' | tclsh

.tcl.in.tcl:
	sed -e 's,<<VSN>>,$(VSN),g' $< > $@
