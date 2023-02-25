SUBDIRS = . src resources templates

ACLOCAL_AMFLAGS = -I autotools

@do_subst_command@

dist_noinst_DATA =  \
    README.md \
    README.md.in \
    perlcriticrc \
    ChangeLog

README.md: README.md.in
	$(MARKDOWN_UTILS) $< > $@

install-data-hook:

CLEANFILES = 

all:

autoconf-template-perl.pl:

$(PACKAGE)-$(VERSION).tar.gz:
	$(MAKE) dist

clean-local:
	rm -f *.tar.gz || true

DISTCHECK_CONFIGURE_FLAGS = --disable-perlcritic-mode
