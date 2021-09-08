# -*- mode: makefile; -*-
# This is a Makefile rule use tabs!
	test -d "$$(dirname "$@")" || $(INSTALL) -d "$$(dirname "$@")"
	$(do_subst) $< > $@
	$(perlwc) -wc $(PERLINCLUDE) -M$$(echo $@ | $(perlwc) -np -e 's/\//\:\:/g; s/\.pm$$//;') -e 1 || { rm $@ && exit 1; }

