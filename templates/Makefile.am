# -*- mode: makefile-gmake; -*-
# This is a Makefile rule use tabs!
SUBDIRS = .

templatesdir = @perl5sharedir@/templates

templates_perldir        = $(templatesdir)/perl
templates_perl_bindir    = $(templates_perldir)/bin
templates_perl_libdir    = $(templates_perldir)/lib
templates_perl_cgibindir = $(templates_perldir)/cgi-bin

templates_bashdir     = $(templatesdir)/bash
templates_bash_bindir = $(templates_bashdir)/bin

templates_resourcesdir = $(templatesdir)/resources
templates_configdir    = $(templatesdir)/config
templates_htmldir      = $(templatesdir)/html

TEMPLATES = \
    00-module.t.tt \
    00-script.t.tt \
    ax_perlcritic_config.m4.tt \
    COPYRIGHT.tt \
    ChangeLog.tt \
    INSTALL.tt \
    Makefile.am.tt \
    Makefile.tt \
    README.md.tt \
    ax-extra-opts.m4.tt \
    build-rules.tt \
    configure.ac.tt \
    git-config.tt \
    manifest.yaml.tt \
    spec.in.tt \
    stub.cfg.tt \
    stub.cgi.tt \
    stub.html.tt \
    stub.js.tt \
    stub.pl.tt \
    stub.pm.tt \
    unit-tests.tt

TEMPLATES_PERL_BIN = \
    perl/bin/Makefile.am.tt \
    perl/bin/perl-bin.inc.tt

TEMPLATES_PERL_CGIBIN = \
    perl/cgi-bin/Makefile.am.tt \
    perl/cgi-bin/perl-cgi-bin.inc.tt

TEMPLATES_BASH_BIN = \
    bash/bin/Makefile.am.tt \
    bash/bin/bash-bin.inc.tt

TEMPLATES_PERL_LIB = \
    perl/lib/perl-modules.inc.tt \
    perl/lib/Makefile.am.tt

TEMPLATES_RESOURCES = \
   resources/Makefile.am.tt

TEMPLATES_CONFIG = \
   config/Makefile.am.tt

TEMPLATES_HTML = \
   html/Makefile.am.tt

extra-files: $(ALLTEMPLATES)
	set -ex; templates=$$(mktemp); \
	find $(abs_srcdir) -name '*.tt' | sort -u > $$templates; \
	cat $$templates | perl -ne  'chomp; s/^.*\/templates/templates/; print "$$_ "; s/^templates/share/; print "$$_\n";' > $@; \
	rm $$templates

dist_noinst_DATA = extra-files

ALLTEMPLATES = \
    $(TEMPLATES) \
    $(TEMPLATES_PERL_BIN) \
    $(TEMPLATES_PERL_CGIBIN) \
    $(TEMPLATES_PERL_LIB) \
    $(TEMPLATES_BASH_BIN) \
    $(TEMPLATES_RESOURCES) \
    $(TEMPLATES_CONFIG) \
    $(TEMPLATES_HTML)

templates_DATA             = $(TEMPLATES)
templates_perl_bin_DATA    = $(TEMPLATES_PERL_BIN)
templates_perl_cgibin_DATA = $(TEMPLATES_PERL_CGIBIN)
templates_perl_lib_DATA    = $(TEMPLATES_PERL_LIB)
templates_bash_bin_DATA    = $(TEMPLATES_BASH_BIN)
templates_resources_DATA   = $(TEMPLATES_RESOURCES)
templates_config_DATA      = $(TEMPLATES_CONFIG)
templates_html_DATA        = $(TEMPLATES_HTML)
