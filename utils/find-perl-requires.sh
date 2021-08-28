#!/bin/bash
# -*- mode: sh; -*-

# create list of non-core required Perl modules

if ! test -x "/usr/lib/rpm/perl.req"; then
    echo "/usr/lib/rpm/perl.req not found.  Install the rpm-build package."
    echo "sudo yum install -y rpm-build"
    exit -1
fi

# cleanup temp files
trap 'for a in modules perl_requires AX_REQUIRED_PERL_MODULES; do eval "test -e \"\$$a\" && rm \"\$$a\""; done' EXIT ERR 

perl_requires=$(mktemp)
modules=$(mktemp)

# see what the Perl scripts and modules require
for a in $(find ./src/main/perl -name '*\.p[ml]\.in'); do 
    /usr/lib/rpm/perl.req $a | perl -npe 's/^perl\((.*?)\)$/$1/;' >>$perl_requires
done

test -s "$perl_requires" || exit 0;

# create module list, filter out core junk
sort -u $perl_requires | grep -v "^perl " | perl utils/is-core.pl 2>requirements-core.txt >$modules

# only output what we don't provide
AX_REQUIRED_PERL_MODULES=$(mktemp)

cat >$AX_REQUIRED_PERL_MODULES <<EOF
AC_DEFUN([AX_REQUIRED_PERL_MODULES], [
  ads_PERL_MODULE(Getopt::Long)
EOF

test -e "requirements.txt" && unlink "requirements.txt"

test -n "$DEBUG" && cat $modules

for a in $(cat $modules); do
    file="./src/main/perl/lib/$(echo $a | perl -pe 's/::/\//g; s/\..*$//;').pm.in"
    test -n "$DEBUG" && echo "looking for $file...";
    test -n "$DEBUG" && find . -wholename "'"$file"'"
    find_cmd="find . -wholename '"$file"'"
    found=$(eval $find_cmd)
    
    if test -z "$found"; then
        echo $a >>requirements.txt
        echo "  ads_PERL_MODULE([$a])" >>$AX_REQUIRED_PERL_MODULES
    fi
done
echo "])" >>$AX_REQUIRED_PERL_MODULES

cat $AX_REQUIRED_PERL_MODULES
