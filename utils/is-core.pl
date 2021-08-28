#!/bin/env perl

use strict;
use warnings;

use Module::CoreList;

=pod

=head1 NAME

is-core.pl

=head1 SYNOPSIS

 ./is-core.pl manifest.txt >requires.txt 2>requires.core

=head1 DESCRIPTION

Script that reads in a list of Perl modules and print non-core modules
to STDOUT and core modules to STDERR.  Typically used when trying to
determine the list of CPAN modules required for an application.

=cut

while (my $module = <> ) {
  chomp $module;
  $module =~s/^perl\((.*)\)\s*$/$1/;
  my $v = Module::CoreList->first_release($module);
           
  if ( $v ) {
    eval "require $module";
    if ($@) {
      print "$module\n";
    }
    else {
      print STDERR "$module\n";
    }
    
    
  }
  else {
    print "$module\n";
  }
}
