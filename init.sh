#!/bin/bash
# -*- mode: sh; -*-

# check requirements

trap 'test -z "$MISSING" || rm -f "$MISSING"' EXIT ERR

PERL_MODULES="YAML"

MISSING=$(mktemp)

if test -z "$(which cpanm 2>/dev/null)"; then
    >&2 echo "WARNING: required cpanm missing"
    echo "cpanm" >>$MISSING
fi

AUTOTOOLS="/usr/bin/make /usr/bin/automake /usr/bin/autoconf"

for a in /usr/lib/rpm/perl.req $AUTOTOOLS; do
    echo -n "Checking...$a"
    if ! test -x "$a"; then
        >&2 echo "...MISSING"
        echo "$a" >>$MISSING
    else
        echo "...found."
    fi
done

for a in ${PERL_MODULES}; do
    if ! perl -M$a -e 1 2>/dev/null; then
        >&2 echo "WARNING: required YAML module missing"
        echo $a >>$MISSING
    fi
done

if ! test -s "$MISSING"; then
    echo "Creating Perl dependency files..."

    if test -e "Makefile.perl-req"; then
        make -f Makefile.perl-req clean
        make -f Makefile.perl-req
    else
        >&2 echo "ERROR: missing Makefile.perl-req"
    fi
fi
