#!/bin/env perl
# -*- mode: perl -*-

use strict;
use warnings;

use Carp qw/croak/;
use Data::Dumper;
use Getopt::Long;
use YAML qw/LoadFile/;

our $VERSION = "0.1";

__PACKAGE__->main() unless caller();

=pod

=head1 NAME
perl-deps.pl

=head1 SYNOPSIS

perl-deps.pl -d deps.yaml

=head1 DESCRIPTION

Creates a snippet for a Makefile.am file that contains the Perl module
dependencies and build rules for the project.

=cut

sub print_header {
  my $text = shift;
  my $len = shift;
  
  my $padding_len = $len - (length($text) + 6);  
  
  $text = $text . " " x $padding_len;
  my @out;
    
  push @out, sprintf("# +%s+", "-" x ($len-4));
  push @out, sprintf("# | %s |", $text);
  push @out, sprintf("# +%s+", "-" x ($len-4));
  
  return @out;
}

sub get_subdirs {
  my $path = shift;
  my $dirs = shift;
  
  opendir(my $fh, "$path") or croak "could not open directory: $!";

  while (my $file = readdir($fh))  {

    next if $file =~/^[t\.]\.?$/;
    
    if (-d "$path/$file") {
      $dirs->{"$path/$file"} = [];
      $dirs = get_subdirs("$path/$file", $dirs);
    }
    else {
      if ($file =~/\.pm\.in$/) {
        push @{$dirs->{$path}}, $file;
      }
    }
  }

  closedir $fh;

  return $dirs;
}

sub main {
  my $help;
  my $version;
  my $depfile = "";
  my $root_dir = "src/main/perl/lib";
  
  GetOptions( 
             "help",    \$help,
             "version", \$version,
             "dependencies=s", \$depfile,
             "root-dir=s", \$root_dir
            );

  defined $help || defined $version && do {
    
    printf("%s v%s\n", $0, $VERSION);
    return 0;
  };

  my $dirs = get_subdirs($root_dir, { $root_dir => [] });
  if (! -e $depfile) {
    printf("no dependency file. $0 -d deps.yaml\n");
    return 0;
  }
  
  my $all_dependencies = LoadFile($depfile);
  $all_dependencies = $all_dependencies->{modules};
  my @module_list = ("\$(PERLMODULES)");
  
  for my $d (keys $dirs) {
    my $sub_dir = $d;
    $sub_dir =~s|$root_dir\/?||;
    if (! $sub_dir ) {
      printf("PERLMODULES = \\\n    ");
      printf("%s\n", join(" \\\n    ", @{$dirs->{$d}}));
      printf("\nGPERLMODULES = \$(PERLMODULES:.pm.in=.pm)\n");
      printf("\nperl5lib_DATA = \$(GPERLMODULES)\n");
    
      foreach my $f (@{$dirs->{$d}}) {
        my $dependencies = [ map { s/\.in$//; $_ } @{$all_dependencies->{$f} || []} ];
        my $pm = $f;
        $pm =~s/\.in$//;
        printf("\n%s: %% : %%.in %s\n", $pm, join(" ", @$dependencies));
        printf("include \$(top_srcdir)/includes/perl-build.inc\n");
      }
    
    }
    else {
      my $modules = uc($sub_dir);
      $modules =~s/\///g;
      push @module_list, "\$(${modules}MODULES)";
      printf("\n%s\n", join("\n", print_header($sub_dir, 48)));

      if (@{$dirs->{$d}}) {
        printf("%sMODULES = \\\n    ", $modules);
        printf("%s\n", join(" \\\n    ", map { $sub_dir . "/$_" } @{$dirs->{$d}}));
      }
      else {
        printf("%sMODULES = \n    ", $modules);
      }
      printf("\nG%sMODULES = \$(%sMODULES:.pm.in=.pm)\n", $modules, $modules);
      printf("\nperl5lib_%sdir = \$(perl5libdir)/%s", lc($modules), $sub_dir);
      printf("\nperl5lib_%s_DATA = \$(G%sMODULES)\n", lc($modules), $modules);
    
      foreach my $f (@{$dirs->{$d}}) {
        my $dependencies = [ map { s/\.in$//; $_ } @{$all_dependencies->{$sub_dir . "/" . $f} || []} ];
        printf("\n%s\n", join("\n", print_header(sprintf("build rule for %s/%s", $sub_dir, $f), 48)));
        my $pm = $f;
        $pm =~s/\.in$//;
        printf("%s/%s: %% : %%.in %s\n", $sub_dir, $pm, join(" ", @$dependencies));
        printf("include \$(top_srcdir)/includes/perl-build.inc\n");
      }
    }
  }
  printf("\nALLMODULES = \\\n    %s\n", join(" \\\n    ", @module_list));
}
