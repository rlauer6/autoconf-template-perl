PERLMODULES = \
    Foo.pm.in

GPERLMODULES = $(PERLMODULES:.pm.in=.pm)

Foo.pm: % : %.in Foo/Bar.pm
	$(BUILD_PERL_MODULE_RULE)

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
	$(BUILD_PERL_MODULE_RULE)


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
	$(BUILD_PERL_MODULE_RULE)


# +--------------------------------------------+
# | build rule for Foo/Bar/Buz.pm.in           |
# +--------------------------------------------+
Foo/Bar/Buz.pm: % : %.in 
	$(BUILD_PERL_MODULE_RULE)


ALLMODULES = \
    $(PERLMODULES) \
    $(FOOMODULES) \
    $(FOOBARMODULES)
