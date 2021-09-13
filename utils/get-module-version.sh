#!/bin/bash
# -*- mode: sh; -*-
# add module version to requirements.txt
# format for cpanm consumption ('Module@Version'
)
trap "test -e \"$tmpfile\" && rm $tmpfile" EXIT ERR

tmpfile=$(mktemp)

if test -e requirements.txt; then
    for a in $(cat requirements.txt|awk '{print $1}'); do
        VERSION=$(perl -M$a -e 'print "'\$$a'::VERSION";')
        
        if test -n "$VERSION"; then
            echo "$a@$VERSION" >>$tmpfile
        else
            echo "$a" >>$tmpfile
        fi
    done    
else
    echo "requirements.txt" not found
fi

if test -s "$tmpfile"; then
    mv $tmpfile requirements.txt
fi
