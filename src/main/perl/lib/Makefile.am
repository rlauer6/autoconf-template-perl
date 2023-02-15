#-*- mode: makefile-gmake; -*-
SUBDIRS = .

include $(top_srcdir)/includes/directories.inc
include $(top_srcdir)/includes/perl-modules.inc
include $(top_srcdir)/includes/perlcritic.inc

test: $(GALLMODULES)
	prove $(PERLINCLUDE) -v t/

all:

CLEANFILES = \
    $(GALLMODULES) \
    $(GPERLCRITIC_PM)

.PHONY: clean-local
clean-local:
	$(MAKE) clean-generated-man-pages
	find . -name '*.log' -exec rm {} \; || true

.PHONY: clean-generated-man-pages
clean-generated-man-pages:
	for mpath in $(G1MANPAGES); do \
	echo "$${mpath}"; \
	rm -f "$${mpath}" ;\
	test $$? -eq 0 || exit 1 ;\
	done

if DISTCHECK_HACK
else
endif

if RPM_BUILD_MODE
else
install-data-hook:
endif
