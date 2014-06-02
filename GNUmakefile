VSN = $(shell cat vsn)
MAJOR = $(word 1,$(subst ., ,$(VSN)))
MINOR = $(word 2,$(subst ., ,$(VSN)))

GEN_SCRIPTS = netif.tcl pkgIndex.tcl
SCRIPTS = $(GEN_SCRIPTS) $(wildcard netif-*.tcl)

DESTDIR ?= /usr/local/share/tcltk
PREFIX = $(DESTDIR)/netif$(MAJOR).$(MINOR)

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
