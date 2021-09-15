#!/bin/bash
# -*- mode: sh; -*-
# create list of non-core required Perl modules


function usage() {
    cat <<EOF
usage: find-perl-requires OPTIONS
    
EOF
}

# +-------------------------+
# | MAIN SCRIPT STARTS HERE |
# +-------------------------+

OPTS=$(getopt -o r:dae:h -- "$@")

ROOTDIR="."
EXT=""
AUTOTOOLS=""

if [ $? -ne 0 ]; then
    echo "could not parse options"
    exit -1
fi

eval set -- "$OPTS"

while [ $# -gt 0 ]; do
    case "$1" in
        -d)
            set -x;
            DEBUG="1";
            shift;
            ;;
        -r)
            shift;
            ROOTDIR="$1";
            shift;
            ;;
        -e)
            shift;
            EXT="$1";
            shift;
            ;;
        -h)
            usage;
            shift;
            ;;
        -a)
            AUTOTOOLS="1";
            shift;
            ;;
        --)
            break;
            ;;
        *)
            echo "unknown option $1";
            exit -1;
    esac
done
        
command="$1";

if test -n "$DEBUG"; then
    test -n "ROOTDIR" && echo "ROOTDIR: $ROOTDIR"
    test -n "AUTOTOOLS" && echo "ROOTDIR: $AUTOTOOLS"
    test -n "EXT" && echo "EXT: $EXT"
fi

if ! test -x "/usr/lib/rpm/perl.req"; then
    echo "/usr/lib/rpm/perl.req not found.  Install the rpm-build package."
    exit -1
fi

# cleanup temp files
trap 'for a in files_to_check modules perl_requires AX_REQUIRED_PERL_MODULES; do eval "test -e \"\$$a\" && rm \"\$$a\""; done' EXIT ERR 

perl_requires=$(mktemp)
modules=$(mktemp)
files_to_check=$(mktemp)

# see what the Perl scripts and modules require
find $ROOTDIR -name '*\.p[ml]'$EXT >$files_to_check
find $ROOTDIR -name '*\.cgi'$EXT >>$files_to_check

if ! test -s $files_to_check; then
    echo "no files to check"
    exit 1;
fi

test -n "$DEBUG" && cat $files_to_check

for a in $(cat $files_to_check); do
    /usr/lib/rpm/perl.req $a | perl -npe 's/^perl\((.*?)\)$/$1/;' >>$perl_requires
done

if ! test -s "$perl_requires"; then
   echo "no requirements"
   exit 0;
fi

test -n "$DEBUG" && cat $perl_requires

rm -f requirements-core.txt || true

# create module list, filter out core junk
sort -u $perl_requires | perl -MModule::CoreList -ne 'chomp; s/^perl\((.*)\)\s*$/$1/; if ( Module::CoreList->first_release($_) ) { print STDERR "$_\n" } else { print "$_\n"; } ' 2>requirements-core.txt  >$modules

test -n "$DEBUG" && cat $modules
test -n "$DEBUG" && cat requirements-core.txt

if test -n "$AUTOTOOLS"; then
    # only output what we don't provide
    AX_REQUIRED_PERL_MODULES=$(mktemp)
    
    cat >$AX_REQUIRED_PERL_MODULES <<EOF
AC_DEFUN([AX_REQUIRED_PERL_MODULES], [
  ads_PERL_MODULE(Getopt::Long)
EOF
fi

test -e "requirements.txt" && unlink "requirements.txt"

test -n "$DEBUG" && cat $modules

for a in $(cat $modules); do
    test -n "$DEBUG" && echo "looking for $a...";
    if ! grep -rq "package $a" $ROOTDIR; then
        echo $a >>requirements.txt
        test -n "$AUTOTOOLS" && echo "  ads_PERL_MODULE([$a])" >>$AX_REQUIRED_PERL_MODULES
    fi
done

if test -n "$AUTOTOOLS"; then
    echo "])" >>$AX_REQUIRED_PERL_MODULES
    cat $AX_REQUIRED_PERL_MODULES
fi
