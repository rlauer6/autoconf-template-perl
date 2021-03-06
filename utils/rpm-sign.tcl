#!/usr/bin/expect -f
# -*- mode: tcl; -*-
# rpm-sign : expect powered rpm signing command

proc usage {} {
    send_user "Usage: rpm-sign gpgname passphrase rpmfile\n\n"
    exit
}

if {[llength $argv]!=3} usage

set gpgname [lindex $argv 0]
set passphrase [lindex $argv 1]
set rpmfile [lindex $argv 2]

spawn rpm --addsign -D "\"_signature gpg\"" -D "\"_gpg_name $gpgname\"" $rpmfile
expect -exact "Enter pass phrase: "
send -- "$passphrase\r"
expect eof
