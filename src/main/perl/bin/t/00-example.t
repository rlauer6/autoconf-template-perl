#!/bin/env perl

use strict;
use warnings;

use Test::More tests => 3;
use Test::Output;

sub help {
  example::get_options('', '--help');
}

require_ok 'example.pl';

stdout_like(sub { example::get_options('', '--help') }, qr '^Usage.*', 'help');

stdout_like(sub { example::main('', '--help') }, qr '^Usage.*', 'help');
