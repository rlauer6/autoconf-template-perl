SUBDIRS = .

if SOME_THINGY_ENABLED 
   SOME_THINGY = on
else
   SOME_THINGY = off
endif

CONFIG = \
    example.cfg.in

GCONFIG = $(CONFIG:.cfg.in=.cfg)

sysconf_DATA = $(GCONFIG)
dist_noinst_DATA = $(CONFIG)

@do_subst_command@

$(GCONFIG): % : %.in
	$(do_subst) $< > $@

all:

CLEANFILES = $(GCONFIG)

