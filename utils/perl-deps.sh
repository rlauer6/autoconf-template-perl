#!/bin/bash
# -*- mode: sh; -*-
# script to create a .yaml file with Perl modules and dependencies
# this file is used as input to perl-deps.pl
#
# format of the .yaml file:

# modules:
#   Foo.pm.in:
#     - Foo/Bar.pm.in
#   Foo/Bar.pm.in:
#     - Foo/Bar/Baz.pm.in
#   Foo/Bar/Baz.pm.in:

# Explanation:
#   Each entry under 'modules' is a module in your project
#   Each entry under the module (e.g. Foo/Bar.pm.in) is a list of dependencies
SOURCEDIR="$1"
SOURCEDIR=${SOURCEDIR:-src/main/perl/lib}

function is_local {
    module="$1"
    
    file="$SOURCEDIR/$(echo $1 | perl -pe 's/perl\((.*)\)/$1/; s/::/\//g; s/\..*$//;').pm.in"
    if ls $file >/dev/null 2>&1; then
        echo $file
    else
        echo ""
    fi
}

function perl_file {
    echo $1 | perl -pe "s|$SOURCEDIR\/||;"
}


yaml=$(mktemp)
echo "modules:"

trap 'test -n "$yaml;" && rm -f $yaml' EXIT ERR

for a in $(find src/main/perl -name '*.pm.in'); do
    echo "  $(perl_file $(echo $a | utils/is-core.pl 2>/dev/null)):"
    for m in $(/usr/lib/rpm/perl.req $a); do
        is_core=$(echo $m | utils/is-core.pl 2>/dev/null)
        if test -n "$is_core"; then
            file=$(is_local $m)
            test -n "$file" && echo "    - $(perl_file $file)"
        fi
    done
done

cat $yaml
