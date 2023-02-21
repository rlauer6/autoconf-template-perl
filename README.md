# README

This is the README for the `autoconf-template-perl` project.  It
contains, among other things a collection of useful tools for creating
_autoconfiscated_ Perl based projects.  If you are on a system that uses
the Redhat Package Manager, you can also use the `.spec` file in
this project to create rpms.

See [`ChangeLog`](ChangeLog) for a listing of files that have changed since the
last release.

See [`NEWS`](NEWS.md) for the lastest news on releases.

# TODO

* [x] add web assets to RPM
* [ ] make cpan for tarball distributions
* [ ]

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
   dive into the gory details of how this utility is built, install from CPAN_)
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

...and now inspect the source tree

```
tree foobar/ | less
```

The source tree will contain all of your artifacts and a few extra
goodies:

* Stub unit test files will be created in:
  * `src/main/perl/bin/t`
  * `src/main/perl/cgi-bin/t`
  * `src/main/perl/lib/t`.
* `.gitignore` file has been added to your project that will filter out
files and directories you probably don't want to put under source
control.
* a `.git` directory has been created with your name and email in the
`config` file

If you are using `git` for source control, now is a good time to
initialize your repository and commit the Big Bang!

```
git init
git add .
git commit -m 'Big Bang!'
```

# Features of the `autoconf-template-perl` Utility

* Organizes your applications and scripts into an __easily recognizable and navigable
  tree structure__
  * Perl modules
  * Perl scripts
  * CGI scripts
  * Web application assets (`.html`, `.js`, `.css`, etc)
* Creation of __deployment tarballs__ or __RPMs__
* __Syntactic checking__ of Perl scripts and modules ( `make` )
* __Best practice__ checking using `perlcritic` (`make check`)
* Automatic __creation of all target directories__ during deployment
* Identification of __Perl module dependencies__
* Automatic creation of __unit test stubs__ for scripts and modules
* __Variable substitution during builds__ from `configure` options
* Creation of __man pages__ from your module or script POD
* Creation of stub _modules_, _scripts_, _html files_, etc from
  templates
* Creation of an __RPM file__ for deployment on RedHat flavored systems

# Requirements

* `autoconf`
* `automake`
* `make`
* Perl modules (in addition to core modules)
  ```
  Date::Format
  File::ShareDir
  JSON
  Log::Log4perl
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
* If the file path begins with `~` (tilde) then the path will be
  prepended with the `$HOME` environment variable (if it exists).
* If the file listed does not exist, _that's ok_...the utility will
  create the file from a set of stubs that were included with the
  utility. Stubs exist for `.pm`, `.pl`, `.html`, `.cfg` and `.js`
  files. These stubs are templates of the `Template::Toolkit` ilk. If
  a stub does not exist for the file you listed, an empty file is
  created (run `autoconf-template-perl --list-stubs` to see all stub
  files and their locations).

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

This section contains details regarding packaging your application as
an RPM. This is a _potentially_ good way to package your Perl
applications on RedHat systems.  It is probably not a good strategy if
you do not plan on using the _system_ provided `perl` (assuming the
target environment even has such a thing). While it is possible to use
a vendored version of Perl, and package your application as an RPM,
you are likely to run into dependency issues if you do not prevent the
`rpmbuild` process from trying to find your Perl dependencies. You may
also find it a particularly frustrating experience if your application
uses Perl modules that do not have RPM packages readily available (See
[Building RPMs from CPAN](#building-rpms-from-cpan)).

The alternatives, using the `autoconf-template-perl` system, is to use
the tarball created by `make dist` to build your application directly
on the target system or in a Docker container.

In general, RPM building is done on RedHat flavored systems, however
it is possible to build RPMs on Debian systems if you install the
`rpm` package and other necessary utilities. Where you may get tripped
up is if your `.spec` file includes a `BuildRequires` argument (which
your generated `.spec` from `autoconf-template-perl` in fact does). In
this case you can build RPMs without `rpmbuild` exiting by including
the `--nodeps` option to `rpmbuild`. See the discussion later in this
section discussing building RPMs in non-RedHat environments.

## Quick Start

> RPMs are built using the instructions in a spec file (`.spec`). The
> default `.spec` file created for you has been somewhat customized so
> that it should work _out of the box_. That is, if haven't changed the basic
> structure of your project that was defined when you ran
> `autoconf-template-perl` the first time. If you don't know anything
> about RPMs or RPM spec files, you'll want to [learn
> more](https://docs.fedoraproject.org/en-US/package-maintainers/Packaging_Tutorial_GNU_Hello/)
> about packging applications using `rpmbuild`, especially if you run into any
> difficulties or want to customize your RPMs.

Assuming you have your project in a state ready to build an RPM,
follow the quick start recipe below.

1. Get the `rpm-build` package.
   ```
   sudo yum install -y rpm-build
   ```
   ...or 
   ```
   sudo apt-get install rpm
   ```
1. Create RPM build directory and create a `.rpmmacros` file.
   ```
   test -d "$HOME/rpmbuild"  || mkdir $HOME/rpmbuild
   echo -e "%_topdir %{getenv:HOME}/rpmbuild >$HOME/.rpmmacros
   ```
1. Build the tarball from your project directory and check the
   distribution to make sure that all assets are present.
   ```
   make distcheck
   ```
1. Build the rpm.
   ```
   rpmbuild -tb $(ls -1t *.tar.gz | head -1)
   ```

## Perl Modules and RPMs

A reminder that our goal is to package a Perl application for
deployment and ensure that dependencies are satisfied one way or
another when the package is installed in the target environment.

> Spoiler alert: `autoconf-template-perl` employs strategy #1.3

There are several strategies available to ensure dependencies are
available when your application runs.

1. Don't package any dependencies, only package application artifacts.
   1. Let the `rpmbuild` process identify dependencies and hope that
     `yum` can find all the required dependencies as RPMs.
   1. Kick the can down the road and prevent `rpmbuild` from
      identifying dependencies so that `yum` does not attempt to pull
      in RPMs that do not exist. Let another process (or person) worry
      about installing Perl module dependencies in the target
      environment, but don't let `yum` end up trying to install RPMs
      that might not exist!
   1. Build dependencies at the time of _deployment_ in a `%post`
      section of the RPM package (_to be clear...in this strategy
      dependencies themselves are __NOT__ packaged, but are built from
      a manifest of required modules when the package is installed)
1. Package dependencies inside your RPM
   1. Prevent `rpmbuild` from identifying dependencies and build
      dependencies yourself at the time you build your RPM

Each of these strategies has its _pros_ and _cons_.

| Strategy | Pros | Cons | 
| -------- | ---- | ---- |
| 1.1 | easy, no effort | RPM packages may not be available for all dependencies |
| 1.2 | easy, no effort | requires support from SysAdmins or another step in deployment | 
| 1.3 | easy, some effort | may fail if building modules at time of deployment requires additional libraries or special installtion instructions for CPAN modules |
| 2.1 | complete RPM ready for deployment | not supported by this utilty, lot's of effort, must be built in same environment as target |

Strategy #1 is typically the way you build an RPM, letting `rpmbuild`
find your dependencies. In some cases you might add additional
dependencies manually when `rpmbuild` fails to find them. This happens
occassionally when your script or modules are using `require` in a way
that hides the module name from `rpmbuild`.

While packaging your application as an RPM using strategy #1 is
_easy_, you may encounter problems with missing RPMs. While all of
the core modules can be found as RPMs there are many other modules you
may require that have not been packaged yet (or will never be
packaged).  Of course, you [can build RPMs from CPAN
yourself](#building-rpms-from-cpan)  and store
them in a private `yum` repository.

By default howeer, the spec file created by this utility employs
strategy #1.3. `autoconf-template-perl` prevents `rpmbuild` from
including those dependencies by removing them when they are found by
`rpmbuild`'s scanner. The spec file then includes a `%post` section
that executes the [`install-from-cpan`](install-from-cpan.in) script
that will install the required modules directly from CPAN using
`cpanm`.  `autoconf-template-perl` identifies dependencies when your
project is being configured and then creates several files that list
those dependencies.

| Dependency File | Description |
| --------------- | ----------- |
| `autotools/ax_requirements_check.m4` | m4 macro that checks for  required modules |
| `requirements.txt` | plain text file listing requirements |
| `requiremetns.json` | requirements file in JSON format |

These files can be refreshed by running `autconf-tempalte-perl -r` in
the project's root directory.

Building dependencies in the `%post` section ensures that dependencies
are built __in the target deployment environment__. This becomes
important when you are building Perl modules that use XS (compiled
C/C++ subroutines).

In order to install a broad range of modules from CPAN a few
dependencies have been added in the `Requires:` sections of the spec
file. These additional dependences (`gcc`, `make`, etc) are commonly
required to build may Perl modules. Other utilities and libraries may
also be required to build your particular CPAN module. 

> Some common libaries required include `openssl`, `libxml2`, `expat`
> and their `-devel` development RPMs as well.

While building your modules in the `%post` section you may still run
into issues when the required Perl modules have additional
dependencies not detected or known to `rpmbuild` (typically libraries
like `libxml2`, etc).  In that case you have two alternatives;

1. Add the requirements to the list of already in the spec file:
   ```
   Requires: gcc make
   ```
   You can automatically add dependencies to your spec file when you
   create your project using the `--rpm-requires` option.
   ```
   autoconf-template-perl -d . --rpm-requires libxml2 --rpm-requires libxml2-devel
   ```
1. _prevent dependency checking_ altogether and revert to (Strategy
   #1), letting `yum` try resolve to the dependencies for your Perl
   modules. This strategy will work if you know that all of your Perl
   module dependencies can be satisfied from some `yum` repository you
   have enabled.
   
   To employ this strategy and prevent the specfile from
   blocking dependency checking (_the default_) use the
   `--no-rpm-install-from-cpan` option when you build your project
   with `autoconf-template-perl`. `rpmbuild` will then add the
   dependencies to the package so that `yum` will attempt to satisfy
   those dependencies from enabled repositories at install time.

Strategy #1.2 usually takes the form of handing your dependency list
to the _SysAdmins_ and asking them to add these dependencies using
whatever tools they use to install Perl modules.

Another technique I have used in the past when creating Docker
containers, is to create a base image that contains the required
dependencies. In this manner, I separate the two resposibilities;
__building the depdendencies_ and __building the application__.  Over
time I can refine the process of creating base images, learning from
the experience of building many CPAN modules. Here's an example of
creating a base image for some Perl modules that were required for an
application that required a specific version.

```
FROM amazonlinux:1
RUN yum install -y epel-release
RUN yum groupinstall -y --enablerepo epel 'Development Tools'
RUN yum install -y --enablerepo epel v8 v8-devel 'perl(App::cpanminus)'
RUN cpanm -v App::cpanminus
RUN cpanm -v JavaScript::V8@0.09 \
    HTTP::Server::Simple \
    Class::Accessor::Fast \
    Readonly
```

Base image creation can be maintained and supported independently from
the application (perhaps even by different people). Ultimately
however, from my application's perspective, this is still strategy
#1.2. I've kicked the can down the road, delegating the responsibility
of dependency resolution to a different process.

Strategy #2 _can_ work if you keep in mind a few things. First, you
have to prevent `rpmbuild` from identifying Perl dependencies so that
it does include the `Requires:` statements that will cause `yum` to
attempt resolution. Second, you need to be aware that you are building
what should be a _binary compatible RPM_ that will be deployed in your
target environment. In other words, *your build environment must
reflect your target environment*. You can't build your Perl modules on
a system using Perl 5.36 and expect it work on a system that contains
Perl 5.18. You _might_ have some luck building modules and RPMs on
one platorm and deploying on another _if you those modules do not
require any binary library bindings_. Likewise you _might_ have some
luck building vanilla RPMs on Debian systems and deploying them to a
RedHat flavored operating system. In general however, you are probably
better off not attempting that trick.

The best strategy I have come up with these days is to create Docker
containers where you can control all of the parameters and
dependencies required for the buildusing Docker containers I
can still couple that with building RPMs for my applications.

## Building RPMs from CPAN

There have been multiple attempts to create scripts that package CPAN
modules as RPMs. The most recent and most robust of which appears to be `cpantorpm`.

| Script | Notes | Repo | 
| ------ | ----- | ---- |
| `cpantorpm` | loosely based on `cpan2rpm`| https://metacpan.org/dist/App-CPANtoRPM/view/bin/cpantorpm.pod |
| `cpan2rpm` | | https://github.com/ekkis/cpan2rpm |
| `cpanspec` | old and crufty | https://src.fedoraproject.org/rpms/cpanspec |

If you are going to package your application as an RPM you should
become familiar with these tools.

## Signing an RPM

Optionally sign the RPM. Make sure you have set `%_gpg_name` in your
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

