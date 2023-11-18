SUBDIRS = .

include $(top_srcdir)/includes/directories.inc

@do_subst_command@

CONFIG = \
    autoconf-template-perlrc.in

GCONFIG = $(CONFIG:.in=)

$(GCONFIG): % : %.in
	set -x; \
	$(do_subst) $< > $@

.autoconf-template-perlrc: $(GCONFIG)
	cp $< "$@"

RESOURCES = \
    COPYING \
    VERSION \
    autotools/ads_PERL_INCLUDES.m4 \
    autotools/ads_PERL_MODULE.m4 \
    autotools/ads_PROG_PERL.m4 \
    autotools/am_build_mode.m4 \
    autotools/am_perlcritic_mode.m4 \
    autotools/ax_am_conditional_example.m4 \
    autotools/ax_requirements_check.m4 \
    autotools/ax_deps_check.m4 \
    autotools/ax_distcheck_hack.m4 \
    autotools/apache_config.m4 \
    bootstrap \
    apache-directories.inc \
    directories.inc \
    file_list.json \
    gitignore \
    install-from-cpan.in \
    perlcritic.inc \
    perlcriticrc \
    perltidyrc \
    .autoconf-template-perlrc \
    prove.sh.in

resources_DATA = \
    $(RESOURCES) \
    $(GCONFIG)

dist_noinst_DATA = \
    autoconf-template-perlrc.in

CLEANFILES = $(GCONFIG)
