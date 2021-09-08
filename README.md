# README

This is the README  for the `autoconf-template-perl` project.  It
contains, among other things a collection of useful tools for creating
autoconfiscated Perl based projects.  If you are on a system that uses
the Redhat Package Manager, you can also use the `.spec` file in
this project to create rpms.

See `ChangeLog` for a listing of files that have changed since the
last release.

Send questions or bugs to Rob Lauer <rclauer@gmail.com>

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

This project presents a template for using the toolchain for building
Perl applications without necessarily having to do a deep dive to learn
the intricacies (and wonders) of autotools.

## Why Autoconfiscate

The term
[`autoconfisicate`[(https://www.webster-dictionary.org/definition/autoconfiscate)
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
environment for your application.  Coupling that the use of the
Redhat Package Manager and you are on your way to automated builds
that organized, extensible and scalable.

# Getting Started

After installing and configuring the template, you have the framework
for a sane build environment for your Perl based project.

# Using the Template

`autoconf-template-perl` is a template.  It is not meant to be
configured and installed itself.

You use this template as a starting point for autoconfisicating Perl
projects.  To do this, you might do something like:

```
wget https://github.com/rlauer6/autoconf-template-perl/archive/refs/master.zip
gunzip master.zip
mv autoconf-template-perl my-awesome-project 
```

At this point you will have the template in your
project directory and you can begin adding to or removing
parts of the project as necessary.

## Building Your Perl Scripts

TBD

## Building Your Perl Modules

TBD

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

1. Why do I have to use a .in extension for my Perl scripts and
   modules?

1. Whys is `make distcheck` failing?

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



