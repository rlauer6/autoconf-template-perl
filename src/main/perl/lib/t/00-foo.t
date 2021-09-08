#!/bin/env perl
# -*- mode: perl; -*-

use strict;
use warnings;

use Test::More tests => 4;

require_ok('Foo::Bar');
require_ok('Foo');

my $foo = Foo->new();
isa_ok($foo, 'Foo') or BAIL_OUT "Can't create a Foo";

my $foo_bar = Foo::Bar->new();
isa_ok($foo_bar, 'Foo::Bar') or BAIL_OUT "Can't create a Foo::Bar";


