SUBDIRS = . src resources templates

ACLOCAL_AMFLAGS = -I autotools

@do_subst_command@

dist_noinst_DATA =  \
    README.md \
    perlcriticrc \
    ChangeLog

install-data-hook:

CLEANFILES = 

all:

autoconf-template-perl.pl:

$(PACKAGE)-$(VERSION).tar.gz:
	$(MAKE) dist

clean-local:
	rm -f *.tar.gz || true

DISTCHECK_CONFIGURE_FLAGS = --disable-perlcritic-mode
