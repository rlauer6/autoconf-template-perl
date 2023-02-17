# README

This is the README  for the `autoconf-template-perl` project.  It
contains, among other things a collection of useful tools for creating
autoconfiscated Perl based projects.  If you are on a system that uses
the Redhat Package Manager, you can also use the `.spec` file in
this project to create rpms.

See `ChangeLog` for a listing of files that have changed since the
last release.

[I have some familiarity with Autotools...skip ahead](#quick-start)

# Overview

<img
src="https://upload.wikimedia.org/wikipedia/en/2/22/Heckert_GNU_white.svg"
width="25%" height="25%">

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

This project will create the scaffolding for an
[__autoconfiscated__](#why-autoconfiscate) Perl application without
requiring you to perform the tedious task of setting up your own build
tree and `configure.ac`.  Using the autotools toolchain you can create
*build rules* and specify *deployment targets* for all of your built
artifacts.  Even if you are not familiar with the intricacies (and
wonders) of autotools, you will be able to create a fairly
sophisticated build environment for your application using this
utility.

If you've ever wondered how software gets installed on a Linux system,
then you'll want to learn more about autoconfiscated
projects. Hopefully though, there is enough documentation here so you
can use this framework effectively.

[Ok, I get it skip ahead to the Quick Start](#quick-start)

## Configuring Your Project

Again, the goal of this utility is to create a build and deploy system
based on GNU Autotools (`autoconf`, `automake`, and `make`).

* `configure` helps us configure the build and specify installation targets
* `make` helps us build and install the artifacts that make up our
application

When you run `./configure --help` you'll see a comprehensive guide to
configuring your project.

```
...
By default, `make install' will install all the files in
`/usr/local/bin', `/usr/local/lib' etc.  You can specify
an installation prefix other than `/usr/local' using `--prefix',
for instance `--prefix=$HOME'.

For better control, use the options below.

Fine tuning of the installation directories:
  --bindir=DIR            user executables [EPREFIX/bin]
  --sbindir=DIR           system admin executables [EPREFIX/sbin]
  --libexecdir=DIR        program executables [EPREFIX/libexec]
  --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
  --sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
  --localstatedir=DIR     modifiable single-machine data [PREFIX/var]
  --runstatedir=DIR       modifiable per-process data [LOCALSTATEDIR/run]
  --libdir=DIR            object code libraries [EPREFIX/lib]
  --includedir=DIR        C header files [PREFIX/include]
  --oldincludedir=DIR     C header files for non-gcc [/usr/include]
  --datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
  --datadir=DIR           read-only architecture-independent data [DATAROOTDIR]
  --infodir=DIR           info documentation [DATAROOTDIR/info]
  --localedir=DIR         locale-dependent data [DATAROOTDIR/locale]
  --mandir=DIR            man documentation [DATAROOTDIR/man]
  --docdir=DIR            documentation root [DATAROOTDIR/doc/my-project]
  --htmldir=DIR           html documentation [DOCDIR]
  --dvidir=DIR            dvi documentation [DOCDIR]
  --pdfdir=DIR            pdf documentation [DOCDIR]
  --psdir=DIR             ps documentation [DOCDIR]
...
```
In addition to the snippet of the guide
above, there other options of `configure` that will allow you to
control the behavior of the build and installation phases, making the
build system particularly powerful and flexible.

```
Optional Features:
  --disable-option-checking  ignore unrecognized --enable/--with options
  --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
  --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
  --enable-silent-rules   less verbose build output (undo: "make V=1")
  --disable-silent-rules  verbose build output (undo: "make V=0")
  --enable-distcheck-hack enable distcheck hack
  --disable-deps don't abort if dependencies missing
  --disable-perldeps don't abort if dependencies missing
  --enable-rpm-build-mode       configure RPM build mode (disables certain checks), default: disabled
  --enable-perlcritic-mode       configure mode (disables certain checks), default: true

Optional Packages:
  --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
  --with-perl5libdir (defaults to DATAROOTDIR/perl5)
  --with-perl-includes=DIR[:DIR:...]
                          prepend DIRs to Perl's @INC
  --with-apache-vhost-domain=name
  --with-apache-vhost-dir=DIR
  --with-apache-vhost-confdir=DIR, where Apache looks for virtual host configuration files
  --with-apache-vhost-server=name, default: localhost
  --with-apache-user=USER          user id that should own the web pages
  --with-apache-group=GROUP        group that should own the web pages
  --with-perlcritic-severity=severity
  --with-license (defaults to GNU Public License)
  --with-architecture (defaults to noarch)
```

Using the options you provide to `configure` you can install your
artifacts anywhere you'd like. The `autoconf-template-perl` utility,
by convention, will install your artifacts as shown below:

| Artifact | Source Directory | Installation Directory |
| -------- | ---------------- | ---------------------- |
| Perl script (`.pl`) | `src/main/perl/bin` | `bindir` |
| Perl modules (`.pm`) | `src/main/perl/lib` | `perl5libdir` | 
| Perl CGI scripts (`.cgi`) | `src/main/perl/cgi-bin` | `apache-vhostdir/cgi-bin` | 
| Bash scripts (`.sh`) | `src/main/bash/bin` | `bindir` | 
| HTML files (`.html`) | `src/main/html/htdocs` | `apache-vhostdir/htdocs` |
| CSS files (`.css`) | `src/main/css/htdocs` | `apache-vhostdir/htdocs/css` |
| Image files (`.png`, etc) | `src/main/html/htdocs/images` | `apache-vhostdir/htdocs/img` |
| Javascript files (`.js`) | `src/main/html/javascript` | `apache-vhostdir/htdocs/` |

> Note: `perl5libdir` defaults to `datadir/perl5`. To install your
> Perl modules in Perl's path use `--with-perl5libdir` without
> specifying a path
 
# Why Autoconfiscate?

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

# Quick Start

1. Install this project from GitHub or CPAN (__Hint:__  _unless you want to
   dive into the gory details of this utility is built, install from CPAN_)
1. Create a `manifest.yaml` file that describes the project and the
   assets you want to include (they don't actually have to exist)
   ```
   project: foobar
   description: The FooBar Project
   author: Fred Flintstone
   email: fred@openbedrock.org
   perl:
     bin:
       - foo.pl
       - bar.pl
     lib:
       - Foo.pm
       - Foo/Bar.pm
   ```
1. run the `autoconf-template-perl` utility
   ```
   autoconf-template-perl -d .
   ```
1. initialize the build system
   ```
   ./bootstrap
   ```
1. configure the project
   ```
   ./configure --localstatedir=/var --prefix=/usr --sysconfdir=/etc/
   ```
1. build the project
   ```
   make
   ```
1. install the project to `/tmp` or somewhere of your choosing
   ```
   make install DESTDIR=/tmp
   ```

> As noted above, none of the assests listed above actually need to exist. The utility
> will create stubs for you. [Perl scripts](#templates/stub.pl.tt) and
> [module stubs](#templates/stubs.pm.tt)  will be
> built from templates.

If all goes well, you have installed a sample project that looks
something like this:

```
/tmp
|-- usr
|   |-- bin
|   |   |-- bar.pl
|   |   `-- foo.pl
|   `-- share
|       |-- man
|       |   |-- man1
|       |   |   |-- bar.1man
|       |   |   `-- foo.1man
|       |   `-- man3
|       |       |-- Foo.3man
|       |       `-- Foo::Bar.3man
|       `-- perl5
|           |-- Foo
|           |   `-- Bar.pm
|           `-- Foo.pm
`-- var
    `-- www
        |-- htdocs
        |   |-- css
        |   |-- img
        |   `-- javascript
        |-- log
        |-- session
        `-- spool
```

Next steps...take a look at the source tree created for you. First
remove all of the built artifacts and files created by `configure`.

```
make distclean
```

```
tree foobar/ | less
```

The source tree will contain all of your artifacts and a few extra
goodies:

* Stub unit test files will be created in `src/main/perl/bin/t`,
  `src/main/perl/cgi-bin/t` and `src/main/perl/lib/t`.
* `.gitignore` file has been added to your project that will filter out
files and directories you probably don't want to put under source
control.
* a `.git` directory has been created with your name and email in the
`config` file

If you are using `git` for source control, now's a good time to
initialize your repository and commit the Big Bang!

```
git init
git add .
git commit -m 'Big Bang!'
```

# Features of the `autoconf-template-perl` Utility

* Organizes your application into an easily recognizable and navigable
  tree structure
* Creation of __deployment tarballs__ or __RPMs__
* __Syntactic checking__ of Perl scripts and modules ( `make` )
* __Best practice__ checking using `perlcritic` (`make check`)
* Automatic creation of all target directories during deployment
* Identification of __Perl module dependencies__
* Automatic creation of __unit test stubs__ for scripts and modules
* Variable substitution during builds from `configure` options
* Creation of __man pages__ from your module or script POD
* Creation of stub _modules_, _scripts_, _html files_, etc from
  templates

# Requirements

* `autoconf`
* `automake`
* `make`
* Perl modules (in addition to core modules)
  ```
  Date::Format
  JSON
  Log::Log4perl'
  Module::ScanDeps::Static
  Readonly
  Template
  YAML
  ```
* ...and various other standard Linux utilities

# Getting Started

`autoconf-template-perl` started out life as a simple template that
required that you _fill in the blanks_ yourself.  It has since morphed
into a set of utilities for automatically creating the scaffolding of an
_autoconfiscated_ Perl application. The resulting scaffolding is a
__working__ starting point for your Perl application.  That's
right...you should be able to build a deployment tarball for your
application after running the utilities that create the project build
tree.

In order to create an _autoconfiscated_ project you will need to first install
this project from the GitHub repository or from CPAN.

After installing this project, you should identify the artifacts needed
by your project. Typically, this means you might have:

* Perl modules (`.pm`)
* Perl scripts (`.pl`)
* CGI scripts (`.pl` or `.cgi`)
* Configuration files (`.cfg`, `.json`, `.ini`, `.yaml`, etc)
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
  bin:
    - {list of .pl files}
  lib:
    - { list of .pm files }
  cgi-bin:
    - {list of .pl files that will be installed as .cgi files}
resources:
  - {list of files of any type}}
html:
  css:
    - {list of .css files}
  htdocs:
    - { list of .html files }
  javascript:
    - { list of .js files}
  images:
    - { list of image files of any type}
```

* Files should be listed using their fully qualified pathname or a path
relative to the directory in which you run the
`autoconf-template-perl` utility
* None of the sections are required
* If you your file begins with `~` (tilde) then the file path will be
  prepended with the `$HOME` environment variable (if it exists).
* if you list a file that does not exist, that's ok...the utility will
  create the file from a set of stubs that were included with the
  utility. Stubs exist for `.pm`, `.pl`, `.html`, `.cfg` and `.js`
  files. These stubs are templates of the `Template::Toolkit` ilk. If
  a stub does not exist for the file you listed, an empty file is
  created.

Perl modules, scripts and CGI scripts will be written to their target
directories with and extension of `.pm.in` for modules and `.pl.in` for
scripts. (See [Building from `.in` Files](#building-from-in-files) to
understand why the framework uses `.in` files as source.)

Bash scripts will be written as `.sh.in` files.

| Type | Extension in Build Tree | Extension Installed | 
| ---- | ----------------------- | ------------------- |
| Perl modules | `.pm.in` | `.pm` |
| Perl scripts | `.pl.in` | `.pl` | 
| Perl CGI scripts | `.pl.in` | `.cgi` |
| Bash scripts | `.sh.in` | `.sh` |

Your source files can have any extension when listed in the
manifest. The extension will be replaced using the convention describe
above.

> Reminder: if the file in the manifest does not exist, the utility
> will try to find a template for the type of file you listed using
> the extension of your source file. If your extensions do not look
> like those in the table and you are trying to introduce a
> non-existent file to the project, it will be created as an empty
> file.

CGI scripts will also be copied to their target directory as
`.pl.in` files, but will have an extension of `.cgi` when
installed.

Once you have created a manifest file, run the
`autoconf-template-perl` utility to create your build tree.

```
autoconf-template-perl --destdir=/tmp --manifest=manifest.yaml`
```

* `destdir` is the root of the target directory for your build
  tree. This is a required argument.
* `manifest` is the name of a YAML file that contains the manifest

By default, `autoconf-template-perl` will look for a file name
`manifest.yaml`. Try `autoconf-template-perl -h` to see all the
available options.

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

# Project Structure

Your Perl application project is laid out in a specific, organized
manner to create a standard layout that all of your team can navigate
easily. It __does not__ reflect the way a project is eventually installed in
the target environment. See [Deploying Your
Project](#deploying-your-project) for details regarding where
artifacts are installed.

## Root Directory

The root of the project will contain your `configure.ac` file which is
used by `autoconf` to create your `configure` script.  The `configure`
script is then used to create the `Makefile` in all of your
subdirectories from the `Makefile.am` created automatically for you by
`autoconf-template-perl`.

The root also contains a stub `ChangeLog`, `README.md` and other files
you can customize.

## `autotools` Directory

The `autotools` directory contains m4 macros used during the configure
phase. These should be considered source files under source control (if
you are using a source control system).

## `config` Directory

This directory should contain your configuration files. Typically
configuration files might by `.ini`, `.cfg`, `yaml` or `.json` files
that contain values your program needs for proper operation. When you
specify these files in your manifest, the `autoconf-template-perl`
utility will rename them with a `.in` extension. See [Building From
`.in` Files](#building-from-in-files).

To add new configuration files after the initial project creation see
[Adding Artifacts to Your Project](#adding-artifacts-to-your-project).

## `resources` Directory

This directory contains files in your project that will be installed
to `@datadir@/@PACKAGE_NAME@`. For example, if your project name is
`foobar` and you configure your project like this:

```
./configure --prefix=/opt --sysconfdir=/etc/ --localstatedir=/var
```
...then your resources will be installed to `/opt/share/foobar`

New resources can be added to the project at any time by dropping the
file in the resources directory and running the
`autoconf-template-perl` utility with the `--refresh` option.

## `src` Directory

The `src` directory and all of the sub-directories  under `src` contain
the source files for the build. You may or may not have
all of these directories in your build tree depending on what you
included in the manifest.

```
 src
 `-- main
     |-- bash
     |   `-- bin
     |-- html
     |   |-- css
     |   |-- htdocs
     |   |-- images
     |   `-- javascript
     `-- perl
         |-- bin
         |   `-- t
         |-- cgi-bin
         `-- lib
             `-- t
```

## Building From `.in` Files

When you specify configuration files, scripts and Perl modules in your
manifest, they are installed in their target source directories with a
`.in` extension.  This is done because the various `Makefile.am` files
specify the file without the extension as the build target and use the `.in`
file as the source.

For example, a `.pl` file is built from a `.pl.in` file (similarly for
other types of files with a `.in` extension). Depending on the file
type, the build recipe may be as simple as:

```
$(GCONFIG):
    $(do_subst) $< > $@
```

...which simply takes your source file (`.cfg.in`) and uses `sed` to
substitute values in your source that are associated with `automake`
variables.  These `automake` variables are the ones that are created
by your `configure` script when you say something like `./configure
--with-foobar=bar`. You can use them in your source files (`.in`)
using the convention `@variable-name@`.

So, for example, to specify the system configuration directory in one of
your configuration files (`my-app.cfg.in`), you might include something like this:

```
db_config = @sysconfdir@/my-app/db-config.cfg
log_dir   = @localstatedir@/log/my-app.log
```

During the build, those variables surrounded by the `@` symbol will be
replaced by the `automake` variable's value.

```
db_config = /etc/my-app/db-config.cfg
log_dir   = /var/log/my-app.log
```

Why not just hard-code those paths? Well, as described in the
[Overview](#overview), the beauty of using `autoconf` and
`automake` is their ability to easily re-configure your project so that
it can be installed anywhere.

```
./configure --prefix=/usr --localstatedir=/var --sysconfdir=/etc
make
make install DESTDIR=/tmp/foo
```

The above statements would direct the install process to prefix your
configured directories with `/tmp/foo` during the intallation phase
(`make install`). In this manner, you can alter the installation paths
for different environments or for simply examining the deployment
structure without actually deploying to the intended targets.

See [Creating Your Own Configuration
Options](#creating-your-own-configuration-options)

## Building Your Perl Modules

The build recipes for Perl scripts and modules does a little bit more
than just substitute `automake` variables for occurences of words
surrounded by `@`. When you build a Perl module or script from a
`.pl.in` or `.pm.in` file, the build recipe will first perform any
required substitutions using `$(do_subst)` and then run `perl -wc`
against the result. If the syntax checking fails, the build will stop.

When the build recipe runs `perl -wc` it also includes additional Perl
paths that might be needed to syntax check your script.  All files in the
`src/main/perl/lib` directory are built first, __in an order that
guarantees that even modules contained in the project that are
dependencies of other modules in the project are built before the
dependent module__.

The order of the build is determined by the `SUBDIRS` variable in
`src/main/perl/Makefile.am`.

```
SUBDIRS = . lib bin cgi-bin 
```

Note that files in `lib` and `bin` are built prior to `cgi-bin`
scripts. This is done presumably because scripts in `bin` may depend
on modules you build in `lib` and CGI scripts may depend on both Perl
modules and scripts.

If you have additional paths, other than those configured by Perl or
the build recipe, you can add them when you configure the project.

```
./configure --with-perl-includes=$HOME/lib/perl5
```


Laying out your build tree is not a mindless task and you should
consider the intradependencies of the components within the project
when making those decisions.   Of course, it's not rocket science
either. ;-)
 

# Adding Resources to Your Project

Adding resources to your project is as simple as dropping a new file
in the `resources/` directory and refreshing the project.

```
cp foo.txt my-project/resources/
cd my-project
autoconf-template-perl -r
```

# Creating Your Own Configuration Options

Once you've created your project and `autoconf-template-perl` has
created your `configure.ac` file, executing `./configure --help` will
present you with the options available.

If you want to create your own `automake` variables you can edit the
`configure.ac` and add the necessary `autoconf` incantations to create
new variable:

```
AC_ARG_WITH(
  [foo-bar],[  --with-foo-bar=[foo bar stuff]],
  [foo_bar=$withval],
  [foo_bar=[foo]]
)

AC_SUBST([foo_bar])
```
...and update the `do_subst_command` in `configure.ac` by adding
another `sed` command.

```
  -e '"'"'s,[@]foo[@],$(foo),g'"'"' \
```

By adding these snippets you will create an `automake` variable you
can use in various ways. Most notably, you can use this is any source
file (`.in`) as `@variable-name@` and it will be resolved during the
build phase.

...but wait! There is an __easier__ way!

```
autoconf-ax-extra-opts -m variable-name -d description -D default-value
```

This utility will add a new option to an m4 macro (`ax-extra-opts.m4`)
and update the `configure.ac` automagically.  After executing this
utility execute `./configure --help` and you will your new option!

# Building an RPM

In general, RPM building is done on RedHat flavored systems, however
it is possible to build RPMs on Debian systems if you install the
`rpm` package and other necessary utilities. Where you may get tripped
up is if your `.spec` file includes a `BuildRequires` argument (which
your generated `.spec` from `autoconf-template-perl` in fact does). In
this case you can build RPMs without `rpmbuild` exiting by including
the `--nodeps` option.


## Quick Start

Get the `rpm-build` package.

```
sudo yum install -y rpm-build
```
...or

```
sudo apt-get install rpm
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
   modules? (See [Building from `.in` Files](#building-from-in-files)).
1. Why is `make distcheck` failing?
   * `distcheck` can fail for various reasons, the most common reason
     being the tarball is missing an artifact required for building
     the distribution. `autoconf-template-perl` __should__ account for
     all of the artifacts it knows about when you created your project
     or used the `--refresh` option. If you've added new artifacts
     manually, you'll need to make sure they are included in the
     distribution. See [Adding Artifacts to Your
     Project](#adding-artifacts-to-your-project)
  * It's also possible that `distcheck` will fail if built artifacts
    are not cleaned up proplery during the `make clean` phase of the
    check. In this case you may have failed to include some generated
    files in the list of files to be removed (`CLEANFILES`). Again,
    `autoconf-template-perl` __should__ account for all files that are
    targets of a build rule.
  * Lastly, there are situations where you may want to configure your
    project in some way to avoid a situation that will cause `make
    distcheck` to fail. You can add an `automake` variable to the
    `Makefile.am` in the root of your project to pass configuration
    options during `make distcheck`.  These will be passed to the
    `configure` script.
    ```
    DISTCHECK_CONFIGURE_FLAGS = 
    ```
 

# Additional Hints

## Adding Artifacts to Your Project

* If you want to add files to be included in your distribution but are __not__
supposed to be installed, add this `automake` variable to the
`Makefile.am` in the root of your project.

```
dist_noinst_DATA = \
   README.md \
   NEWS.md \
   README-BUILD.md \
   ChangeLog
```

* To add files that require building (`.pl`, `.pm`, `.sh`, and possibly
configuration files) the easy way, follow these steps:

1. Drop the file with a `.in` extension into the appropriate directory
   ```
   cp foo.pl src/main/perl/bin/foo.pl.in
   cp foo.cfg.in config/foo.cfg.in
   ```
2. Re-run `autoconf-template-perl` in the root of the project using
   the `--refresh` option.
   ```
   autoconf-template-perl -r
   ```

Note that if your new Perl script or module introduced new Perl module
dependencies, those will be identified and added to the m4 macro
`autotools/ax_requirements_check.m4` so that `configure` will verify
their existence in the target environment during the build..

## Disabling Dependency Checking

