#!/bin/env perl
# -*- mode: perl; -*-

use strict;
use warnings;

use Getopt::Long;

__PACKAGE_->main() unless caller();

sub usage {
  print <<eot;
Usage: $0 --project=your-project-name --email=your-email-address --name=your-name

Script to customize your autoconfisication template for use.

       Example: $0 ---project=foo \\
                   --email=rclauer\@gmail.com \\
                   --name="Rob Lauer"

If you have the environment variables FULLNAME and EMAIL set then
these will be used.

eot
  return;
}

sub main {

  my $INSTALL =<<eot;
Basic Installation
==================

These are generic installation instructions for the
'%s' project. The generic configuration and
installation instructions follow immediately; these should already be
familar to people who are familiar with using the GNU autotools
('./configure' and friends...). See the section titled "Customizing
the Installation" for information regarding special options for this
package.

The `configure' shell script attempts to guess correct values for
various system-dependent variables used during compilation.  It uses
those values to create a `Makefile' in each directory of the package.
It may also create one or more `.h' files containing system-dependent
definitions.  Finally, it creates a shell script `config.status' that
you can run in the future to recreate the current configuration, and a
file `config.log' containing compiler output (useful mainly for
debugging `configure').

It can also use an optional file (typically called `config.cache'
and enabled with `--cache-file=config.cache' or simply `-C') that
saves the results of its tests to speed up reconfiguring.  (Caching is
disabled by default to prevent problems with accidental use of stale
cache files.)

If you need to do unusual things to compile the package, please try
to figure out how `configure' could check whether to do them, and mail
diffs or instructions to the address given in the `README' so they can
be considered for the next release.  If you are using the cache, and
at some point `config.cache' contains results you don't want to keep,
you may remove or edit it.

The file `configure.ac' (or `configure.in') is used to create
`configure' by a program called `autoconf'.  You only need
`configure.ac' if you want to change it or regenerate `configure'
using a newer version of `autoconf'.

The simplest way to compile this package is:

1. `cd' to the directory containing the package's source code and type
`./configure' to configure the package for your system.  If you're
using `csh' on an old version of System V, you might need to type
`sh ./configure' instead to prevent `csh' from trying to execute
`configure' itself.

Running `configure' takes awhile.  While running, it prints some
messages telling which features it is checking for.

2. Type `make' to compile the package.

3. Optionally, type `make check' to run any self-tests that come with
the package.

4. Type `make install' to install the programs and any data files and
documentation.

5. You can remove the program binaries and object files from the
source code directory by typing `make clean'.  To also remove the
files that `configure' created (so you can compile the package for
a different kind of computer), type `make distclean'.  There is
also a `make maintainer-clean' target, but that is intended mainly
for the package's developers.  If you use it, you may have to get
all sorts of other programs in order to regenerate files that came
with the distribution.

Compilers and Options
=====================

Some systems require unusual options for compilation or linking that the
`configure' script does not know about.  Run `./configure --help' for
details on some of the pertinent environment variables.

You can give `configure' initial values for configuration parameters
by setting variables in the command line or in the environment.  Here
is an example:

./configure CC=c89 CFLAGS=-O2 LIBS=-lposix

*Note Defining Variables::, for more details.

Compiling For Multiple Architectures
====================================

You can compile the package for more than one kind of computer at the
same time, by placing the object files for each architecture in their
own directory.  To do this, you must use a version of `make' that
supports the `VPATH' variable, such as GNU `make'.  `cd' to the
directory where you want the object files and executables to go and run
the `configure' script.  `configure' automatically checks for the
source code in the directory that `configure' is in and in `..'.

If you have to use a `make' that does not support the `VPATH'
variable, you have to compile the package for one architecture at a
time in the source code directory.  After you have installed the
package for one architecture, use `make distclean' before reconfiguring
for another architecture.

Installation Names
==================

By default, `make install' installs the package's commands under
`/usr/local/bin', include files under `/usr/local/include', etc.  You
can specify an installation prefix other than `/usr/local' by giving
`configure' the option `--prefix=PREFIX'.

You can specify separate installation prefixes for
architecture-specific files and architecture-independent files.  If you
pass the option `--exec-prefix=PREFIX' to `configure', the package uses
PREFIX as the prefix for installing programs and libraries.
Documentation and other data files still use the regular prefix.

In addition, if you use an unusual directory layout you can give
options like `--bindir=DIR' to specify different values for particular
kinds of files.  Run `configure --help' for a list of the directories
you can set and what kinds of files go in them.

If the package supports it, you can cause programs to be installed
with an extra prefix or suffix on their names by giving `configure' the
option `--program-prefix=PREFIX' or `--program-suffix=SUFFIX'.

Optional Features
=================

Some packages pay attention to `--enable-FEATURE' options to
`configure', where FEATURE indicates an optional part of the package.
They may also pay attention to `--with-PACKAGE' options, where PACKAGE
is something like `gnu-as' or `x' (for the X Window System).  The
`README' should mention any `--enable-' and `--with-' options that the
package recognizes.

For packages that use the X Window System, `configure' can usually
find the X include and library files automatically, but if it doesn't,
you can use the `configure' options `--x-includes=DIR' and
`--x-libraries=DIR' to specify their locations.

Specifying the System Type
==========================

There may be some features `configure' cannot figure out automatically,
but needs to determine by the type of machine the package will run on.
Usually, assuming the package is built to be run on the _same_
architectures, `configure' can figure that out, but if it prints a
message saying it cannot guess the machine type, give it the
`--build=TYPE' option.  TYPE can either be a short name for the system
type, such as `sun4', or a canonical name which has the form:

CPU-COMPANY-SYSTEM

where SYSTEM can have one of these forms:

OS KERNEL-OS

See the file `config.sub' for the possible values of each field.  If
`config.sub' isn't included in this package, then this package doesn't
need to know the machine type.

If you are _building_ compiler tools for cross-compiling, you should
use the option `--target=TYPE' to select the type of system they will
produce code for.

If you want to _use_ a cross compiler, that generates code for a
platform different from the build platform, you should specify the
"host" platform (i.e., that on which the generated programs will
eventually be run) with `--host=TYPE'.

Sharing Defaults
================

If you want to set default values for `configure' scripts to share, you
can create a site shell script called `config.site' that gives default
values for variables like `CC', `cache_file', and `prefix'.
`configure' looks for `PREFIX/share/config.site' if it exists, then
`PREFIX/etc/config.site' if it exists.  Or, you can set the
`CONFIG_SITE' environment variable to the location of the site script.
A warning: not all `configure' scripts look for a site script.

Defining Variables
==================

Variables not defined in a site shell script can be set in the
environment passed to `configure'.  However, some packages may run
configure again during the build, and the customized values of these
variables may be lost.  In order to avoid this problem, you should set
them in the `configure' command line, using `VAR=value'.  For example:

./configure CC=/usr/local2/bin/gcc

causes the specified `gcc' to be used as the C compiler (unless it is
overridden in the site shell script).  Here is a another example:

/bin/bash ./configure CONFIG_SHELL=/bin/bash

Here the `CONFIG_SHELL=/bin/bash' operand causes subsequent
configuration-related scripts to be executed by `/bin/bash'.

`configure' Invocation
======================

`configure' recognizes the following options to control how it operates.

`--help'
`-h'
Print a summary of the options to `configure', and exit.

`--version'
`-V'
Print the version of Autoconf used to generate the `configure'
script, and exit.

`--cache-file=FILE'
Enable the cache: use and save the results of the tests in FILE,
traditionally `config.cache'.  FILE defaults to `/dev/null' to
disable caching.

`--config-cache'
`-C'
Alias for `--cache-file=config.cache'.

`--quiet'
`--silent'
`-q'
Do not print messages saying which checks are being made.  To
suppress all normal output, redirect it to `/dev/null' (any error
messages will still be shown).

`--srcdir=DIR'
Look for the package's source code in directory DIR.  Usually
`configure' can determine that directory automatically.

`configure' also accepts some other, not widely useful, options.  Run
`configure --help' for more details.


Customizing the Installation
============================

`--with-perl5libdir=DIR'
Where to put perl modules if the project builds any (defaults to \$perl5libdir)

`--with-perl-includes=DIR[:DIR:...]
prepend DIRs to Perl's \@INC which might be helpful when building
perl modules or perl scripts

eot

  my $README =<<eot;
# README

This is the README file for the `%s` project...

# Overview

# Author

%s  <%s>
eot

  my $COPYING =<<eot;
Copyright (C) %s %s
All rights reserved
eot

  my $CHANGELOG =<<eot;
%s  %s <%s>
eot

  use vars qw($PROJECT $EMAIL $FULLNAME $HELP);

  GetOptions(
             "project=s", \$PROJECT,
             "email=s", \$EMAIL,
             "name=s", \$FULLNAME,
             "help!", \$HELP
            );

  if ($HELP || ! $PROJECT) {
    &usage;
    return 0;
  }

  $EMAIL = $EMAIL || $ENV{EMAIL} || 'your-email@signatureinfo.com';
  $FULLNAME = $FULLNAME || $ENV{FULLNAME} || 'your-name';

  my @time_stuff = localtime;
  my $date = sprintf("%04d-%02d-%02d", $time_stuff[5]+1900, $time_stuff[4]+1, $time_stuff[3]);

  printf "=> Creating TBD...\n"; sleep(1);
  open TBD, ">TBD" or die "Cannot open TBD for writing!";
  print TBD sprintf($TBD, $PROJECT);
  close TBD;

  printf "=> Creating INSTALLS...\n"; sleep(1);
  open INSTALL, ">INSTALL" or die "Cannot open INSTALL for writing!";
  print INSTALL sprintf($INSTALL, $PROJECT);
  close INSTALL;

  printf "=> Creating README...\n"; sleep(1);
  open README, ">README.md" or die "Cannot open README for writing!";
  print README sprintf($README, $PROJECT, $FULLNAME, $EMAIL);
  close README;

  printf "=> Creating COPYING...\n"; sleep(1);
  open COPYING, ">COPYING" or die "Cannot open COPYING for writing!";
  print COPYING sprintf($COPYING, $FULLNAME);
  close COPYING;

  printf "=> Creating AUTHORS...\n"; sleep(1);
  open AUTHORS, ">AUTHORS" or die "Cannot open AUTHORS for writing!";
  print AUTHORS sprintf("%s - %s\n", $FULLNAME, $EMAIL);
  close AUTHORS;

  printf "=> Creating ChangeLog...\n"; sleep(1);
  open CHANGELOG, ">ChangeLog" or die "Cannot open ChangeLog for writing!";
  my @d = localtime;
  print CHANGELOG sprintf($CHANGELOG, sprintf("%02d-%02d-%04d", 1+$d[4], $d[3], 1900+$d[5]), $FULLNAME, $EMAIL);
  close CHANGELOG;

  printf "=> Creating Makefile.am...\n"; sleep(1);
  open (my $fd, ">Makefile.am") or die "Cannot open Makefile.am for writing!\n";
  print $fd <<eot;
SUBDIRS = . src config

ACLOCAL_AMFLAGS = -I autotools

dist_noinst_DATA = \\
ChangeLog \\
README.md \\
\${PACKAGE_NAME}.spec \\
\${PACKAGE_NAME}.spec.in
eot

  close $fd;

  printf "=> Customizing 'configure.ac'...\n"; sleep(1);

  if (-s "configure.ac") {
    rename("configure.ac","configure.ac.old");
    {
      local $/;
      open FILE, "<configure.ac.old";
      my $configure_ac = <FILE>;
      close FILE;
      my $ac_init = sprintf("AC_INIT([%s], [1.0.0], [%s])", $PROJECT, $EMAIL);
      $configure_ac =~s/^AC_INIT\(.*?\)/$ac_init/;
      open FILE, ">configure.ac";
      print FILE $configure_ac;
      close FILE;
      unlink "configure.ac.old" if -s "configure.ac";
    }
  }

  print <<eot;

Project initialization...

You probably want to perform the following steps at this point:

1. rename the current working directory to your project name

mv autoconf-template-perl-1.0.1 your-project-name

2. cp your project source files to their various destinations:

src/main/perl/bin => perl scripts
src/main/perl/lib => perl modules
config            => configuration files

* * REMEMBER TO ADD A .in EXTENSION TO YOUR YOUR FILES * *

3. edit the Makfile.am files in 

src/main/perl/bin
src/main/perl/lib
config

...as appropriate, adding your source files, etc.

4. creating a working build

autoreconf -i

./configure --prefix=/usr

make && make install

make distcheck

5. check your project into CVS

eot

  return 0;
}
