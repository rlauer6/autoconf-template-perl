# README

This is the README  for the `autoconf-template-perl` project.  It
contains, among other things a collection of useful tools for creating
autoconfiscated Perl based projects.  If you are on a system that uses
the Redhat Package Manager, you can also use the `.spec` file in
this project to create rpms.

See `ChangeLog` for a listing of files that have changed since the
last release.

# Overview

![GNU
Autotools](https://upload.wikimedia.org/wikipedia/en/2/22/Heckert_GNU_white.svg)

Aurelio A. Heckert, CC BY-SA 2.0
[https://creativecommons.org/licenses/by-sa/2.0], via Wikimedia
Commons

Building and packaging software is an important step in the software
development process.  Writing good software can be a challenge but
it's harder without good tools for building, packaging and deploying
your applications. One way to build, package and deploy software is
through the use of a suite of tools known as the [GNU
Autotools](https://en.wikipedia.org/wiki/GNU_Autotools).

Using this toolchain you can create a build and deploy mechanism based
on GNU `make`.  Building and deploying are then accomplished like
this:

```
./configure
make
make install
```

This project will create the scaffolding for an autoconfiscated Perl
application without requiring you to perform the tedious task of
setting up your own build tree and `configure.ac`.  Using the
autotools toolchain you can create *build rules* and specify
*deployment targets* for all of your built artifacts.  Even if you are
not familiar with the intricacies (and wonders) of autotools, you will
be able to create a fairly sophisticated build environment for your
application using this utility. If you've ever wondered how software
gets installed on a Linux system, then you'll want to learn more about
autoconfiscated projects.

## Why Autoconfiscate

The term
[`autoconfisicate`](https://www.webster-dictionary.org/definition/autoconfiscate)
is attributed to [Noah
Friedman](https://savannah.gnu.org/users/friedman) to describe the
process of setting up a build system that uses the GNU Autotools.

> There are a few reasons to autoconfiscate a package. You might be
porting your package to a new platform for the first time, or you
might have outstripped the capabilities of an ad hoc system. Or, you
might be assuming maintenance of a package and you want to make it fit
in with other packages that use the GNU Autotools. - https://www.oreilly.com/library/view/gnu-autoconf-automake/1578701902/1578701902_ch23lev1sec1.html

Although you might not need to create a portable Perl application, GNU
Autotools provide the framework of a complete build and packaging
environment for your application.  Coupling that with the use of the
Redhat Package Manager and you are on your way to automated builds
that are _organized_, _extensible_ and _scalable_.

## Features of the `autoconf-template-perl` Utility

* Organizes your application into an easily recognizable and navigable
  tree structure
* Creation of __deployment tarballs__ or __RPMs__
* __Syntactic checking__ of Perl scripts and modules ( `make` )
* Best practice checking using `perlcritic` (`make check`)
* Automatic creation of all target directories during deployment
* Identification of __Perl module dependencies__
* Automatic creation of __unit test stubs__ for scripts and modules
* Variable substitution during builds from configured variables
* Creation of __man pages__ from your module or script POD

# Requirements

* `autoconf`
* `automake`
* `make`
* ..and various other standard Linux utilities

# Getting Started

`autoconf-template-perl` started out life as a simple template that
required that you _fill in the blanks_ yourself.  It has since morphed
into a set of utilities for automatically creating the scaffolding of an
autoconfiscated Perl application. The resulting scaffolding is a
__working__ starting point for your Perl application.  That's
right...you should be able to build a deployment tarball for your
application after running the utilities that create the project build
tree.

In order to create an autoconfiscated project you will need to first install
this project from the GitHub repository or from CPAN.

After installing this project, you should identify the artifacts needed
by your project. Typically, this means you might have:

* Perl modules (`.pm`)
* Perl scripts (`.pl`)
* CGI scripts (`.pl` or `.cgi`)
* Configuration files (`.cfg`, `.json`, `.ini`, etc)
* Resources - additional files you might need to install somewhere
* Web application artifacts (`.html`, `.js`, `.css`, `.png`, etc)

Once you have identified all of the artifacts that you'd like to include
in your project, create a `manifest.yaml` file that looks something
like this:

```
project: {project name}
description: {description}
author: {author's name}
email: {author's email address}
perl:
  bin: {list of .pl files}
  lib: { list of .pm files }
  cgi-bin: {list of .pl files that will be installed as .cgi files}
resources: {list of files of any type}}
html:
  css: {list of .css files}
  htdocs: { list of .html files }
  javascript: { list of .js files}
  images: { list of image files of any type}
```

Files should be listed using their fully qualified pathname or a path
relative to the directory in which you run the
`autoconf-template-perl` utility. None of the file
lists are required elements to run the utility.

Once you have the manifest the `manifest.yaml` file, run the
`autoconf-template-perl` utility to create your build tree.

```
autoconf-template-perl --dest-dir=/tmp`
```

* `dest-dir` is the root of the target directory for your build tree

After running the utility, depending on what you have included in your
manifest, your build tree will look something like this:

```
|-- autom4te.cache
|-- autotools
|-- config
|-- includes
|-- resources
`-- src
    `-- main
        |-- bash
        |   `-- bin
        |-- html
        |   |-- css
        |   |-- htdocs
        |   `-- javascript
        `-- perl
            |-- bin
            |   `-- t
            |-- cgi-bin
            `-- lib
                `-- t
```

...and if all goes well, you can try your first build:

```
./bootstrap
./configure
make
```

...if that succeeds, try installing the project and examine the
deployment tree structure:

```
make install DESTDIR=/tmp/my-project
tree /tmp/my-project | less
```

## Project Structure

Perl projects using this template are laid out as follows:

## Root of the Project

The root of the project will contain your `configure.ac` file which is
used by `autoconf` to create your `configure` script. The `configure`
script is then use do to create the `Makefile` in all of your
subdirectories.

The root also contains a stub `ChangeLog`, `README.md` and other files
you can customize.

## `config` Directory

This directory should contain your configuration files. Typically
configuration files might by `.ini`, `.cfg`, or `.json` files that
contain values your program needs for proper operation. When you
specify these files in your manifest, the `autoconf-template-perl`
utility will rename them with a `.in` extension. See [Building From
`.in` File](#building-from-in-files#).


* `autom4te.cache` - automatically created by autoconf
* `autotools` - contains m4 macros
* `config` - configuration files
* `includes` - Makefile includes
* `resources` - artifacts to be installed
* `src/perl/bin` - Perl scripts
* `src/perl/bin/t` - test scripts for Perl scripts
* `src/perl/lib` - Perl modules
* `src/perl/lib/t` - test scripts for Perl modules
* `utils` - project utilities

## Building From `.in` Files

When you specifiy configuration, scripts and Perl module files in your
manifest, they will be installed in the project directories with a
`.in` extension.  This is done because the various `Makefiles` create
a target of the file without the extension.  In other words, a `.pl`
file is built from a `.pl.in` file (similarly for the other types of
files). Depending on the file type, the build recipe may be as simple
as:

```
$(GCONFIG):
    $(do_subst) $< > $@
```

...which simply takes your source file (`.cfg.in`) and uses `sed` to
substitute values in your source that associated with `automake`
variables.  These `automake` variables are the ones that are created
by your `configure` script. The take the form of `@variable-name@`.

For example, to specify the system configuration directory in one of
your configuration files, you might include something like this in the
`my-app.cfg.in` file.

```
db_config = @sysconfdir@/my-app/db-config.cfg
log_dir   = @localstatedir@/log/my-app.log
```

During the build, those variables surrounded by the `@` symbol will be
replace by the `automake` variable's value.

```
db_config = /etc/my-app/db-config.cfg
log_dir   = /var/log/my-app.log
```

Why not just hard-code those paths? The beauty of using `autoconf` and
`automake` is their ability to easily re-configure your project so that
it can be installed anywhere.

```
./configure --prefix=/usr --localstatedir=/var --sysconfdir=/etc
make
make install DESTDIR=/tmp/foo
```

The above statements will cause the install process to prefix your
configured directories with `/tmp/foo` so that you can alter the
installation paths for different environments or for just examining
the deployment structure without actually deploying to the intended
targets.

## Building Your Perl Modules

The build recipes for Perl scripts and modules does a little bit more
than just substitute `automake` variables for occurences words
surrounded by `@`. When you build a Perl module or script from a
`.pl.in` or `.pm.in` file, the build recipe will first perform any
required substitutions using `$(do_subst)` and then run `perl -wc`
against the result. If the syntax checking fails, the build will stop.

When the build recipe runs `perl -wc` it also includes additional Perl
paths that might be needed to check your script.  All files in the
`src/main/perl/lib` directory are built first, in an order that
guarantees that even modules contained in the project that are
dependencies of other modules in the project are built first.

If you have additional paths, other than those configured by Perl or
the build recipe, you can add them when you configure the project.

```
./configure --with-perl-includes=$HOME/lib/perl5
```

## Adding Resources to Your Project

TBD

## Adding Configuration Files to Your Project

TBD

# Building an RPM

## Quick Start

Get the `rpm-build` package.

```
sudo yum install -y rpm-build
```

Create build directory and create a `.rpmmacros` file.

```
test -d "$HOME/rpmbuild"  || mkdir $HOME/rpmbuild
echo -e "%_topdir $HOME/rpmbuild" >$HOME/.rpmmacros
```

Build the tarball from your project directory.

```
make dist
```

Build the rpm.

```
rpmbuild -tb $(ls -1t *.tar.gz | head -1)
```

## The rpm .spec file

## Signing an rpm

Optionally sign the rpm. Make sure you have set `%_gpg_name` in your
`.rpmmacros` file.


```
rpmbuild -tb $(ls -1t *.tar.gz | head -1) --sign
```

# FAQs

1. Why do I have to use a `.in` extension for my Perl scripts and
   modules? (See []()).

1. Why is `make distcheck` failing?

* paths you are installing into based on configure time options need
  to be set properly.  This is because if you do not give them a value
  and your configure.ac does not provide a default, '' is assumed
  during distcheck

* try giving some defaults to use when doing a distcheck. You do this
  by setting

  DISTCHECK_CONFIGURE_FLAGS = 

  An example of this situation is when you are installing some files outside 
  the standard 'prefix' based locations - like a web-site

  DISTCHECK_CONFIGURE_FLAGS = --with-apache-vhostdir=/tmp
 

# Hints

* Add files that you want to include in your distribution that aren't
  necessarily being installed

  dist_noinst_DATA = README NEWS ...



#

# A NOTE ABOUT `PERLINCLUDE'

In most cases you'll want to use a -I "somepath" when compiling the
Perl script (perl -wc $@) to make sure the Perl scripts or modules
you are building can find the necessary modules you are using in the
script. You'll note below that this template includes 3 default
include paths.

YMMV, depending upon your build tree and other factors, however you
should not be tricked into assuming your build is working when you
are in fact using include paths OUTSIDE your build tree and you have
previously installed the package you are building!

Additionally, you should be aware of the difference between
$(srcdir) and $(builddir) as they relate to VPATH builds when doing

`make distcheck`

You will also note that $(perl5libdir) is LAST in this order to
further insulate you from being duped into thinking that you are
using the newly built Perl modules when in fact you might be
using those already installed.

Note further that $(builddir)../lib is included as a Perl include path on the
assumption that your project most likely (but not always) builds
perl modules as well.

Lastly, the order of the build is therefore important.  You'll want
to build the src/main/perl/lib first, so these perl modules are
available to you as you build your perl scripts.  Accordingly,
src/main/perl/Makefile.am is told to recurse the directories as
follows:

```
SUBDIRS = . lib bin
```

Laying out your build tree is not a mindless task and you should
consider the intradependencies of the components within the project
when making those decisions.   Of course, it's not rocket science
either. ;-)
 
