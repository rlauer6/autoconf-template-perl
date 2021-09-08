PERLMODULES = \
    Foo.pm.in

GPERLMODULES = $(PERLMODULES:.pm.in=.pm)

perl5lib_DATA = $(GPERLMODULES)

Foo.pm: % : %.in Foo/Bar.pm
include $(top_srcdir)/includes/perl-build.inc

# +--------------------------------------------+
# | Foo                                        |
# +--------------------------------------------+
FOOMODULES = \
    Foo/Bar.pm.in

GFOOMODULES = $(FOOMODULES:.pm.in=.pm)

perl5lib_foodir = $(perl5libdir)/Foo
perl5lib_foo_DATA = $(GFOOMODULES)

# +--------------------------------------------+
# | build rule for Foo/Bar.pm.in               |
# +--------------------------------------------+
Foo/Bar.pm: % : %.in Foo/Bar/Baz.pm
include $(top_srcdir)/includes/perl-build.inc

# +--------------------------------------------+
# | Foo/Bar                                    |
# +--------------------------------------------+
FOOBARMODULES = \
    Foo/Bar/Baz.pm.in \
    Foo/Bar/Buz.pm.in

GFOOBARMODULES = $(FOOBARMODULES:.pm.in=.pm)

perl5lib_foobardir = $(perl5libdir)/Foo/Bar
perl5lib_foobar_DATA = $(GFOOBARMODULES)

# +--------------------------------------------+
# | build rule for Foo/Bar/Baz.pm.in           |
# +--------------------------------------------+
Foo/Bar/Baz.pm: % : %.in 
include $(top_srcdir)/includes/perl-build.inc

# +--------------------------------------------+
# | build rule for Foo/Bar/Buz.pm.in           |
# +--------------------------------------------+
Foo/Bar/Buz.pm: % : %.in 
include $(top_srcdir)/includes/perl-build.inc

ALLMODULES = \
    $(PERLMODULES) \
    $(FOOMODULES) \
    $(FOOBARMODULES)
