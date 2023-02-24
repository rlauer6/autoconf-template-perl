# README

Last Updated: 02/24/23

<p align="center">
<img src="https://upload.wikimedia.org/wikipedia/en/2/22/Heckert_GNU_white.svg"
width="25%" height="25%">

Aurelio A. Heckert, CC BY-SA 2.0
[https://creativecommons.org/licenses/by-sa/2.0], via Wikimedia
Commons
</p>

---

This is the README for the `autoconf-template-perl` project.  It
contains, among other things a collection of useful tools for creating
_autoconfiscated_ Perl based projects.  If you are on a system that uses
the Redhat Package Manager, you can also use the `.spec` file in
this project to create rpms.

> I guess the fancy word I learned working with one of my employers for frameworks
> like this is __accelerator__.

See [`ChangeLog`](ChangeLog) for a listing of files that have changed since the
last release.

See [`NEWS`](NEWS.md) for the lastest news on releases.

---

# TODO for Version Next

* [x] add web assets to RPM
* [x] index for documentation
* [ ] `make cpan` for tarball distributions

# Table of Contents

* [Overview](#overview)
* [Features of the `autoconf-template-perl` Utility](#features-of-the-autoconf-template-perl-utility)
  * [Configuring Your Build](#configuring-your-build)
  * [Why Autoconfiscate?](#why-autoconfiscate?)
* [Quick Start](#quick-start)
* [Requirements](#requirements)
* [Getting Started](#getting-started)
  * [Automatically Creating A Manifest File](#automatically-creating-a-manifest-file)
  * [Configuring `autoconf-template-perl`](#configuring-autoconf-template-perl)
  * [`autoconf-template-perl` Options](#autoconf-template-perl-options)
* [Project Source Tree](#project-source-tree)
  * [Root Directory](#root-directory)
  * [`autotools` Directory](#autotools-directory)
  * [`config` Directory](#config-directory)
  * [`resources` Directory](#resources-directory)
  * [`src` Directory](#src-directory)
* [Building and Deploying Your Application](#building-and-deploying-your-application)
  * [Building Your Application](#building-your-application)
  * [Checking Your Project Distribution](#checking-your-project-distribution)
  * [Deploying Your Application](#deploying-your-application)
  * [RPMs](#rpms)
  * [Tarballs](#tarballs)
  * [Standard Deployment Tree](#standard-deployment-tree)
* [Adding Artifacts to Your Project](#adding-artifacts-to-your-project)
* [Building From `.in` Files](#building-from-.in-files)
  * [Automake Configuration Variables](#automake-configuration-variables)
* [Building Perl Modules](#building-perl-modules)
* [Building an RPM](#building-an-rpm)
  * [Quick Start](#quick-start)
  * [Building RPMs from CPAN Modules](#building-rpms-from-cpan-modules)
  * [Signing an RPM](#signing-an-rpm)
* [Unit Tests](#unit-tests)
* [Advanced Topics](#advanced-topics)
  * [Creating Your Own Configuration Options](#creating-your-own-configuration-options)
  * [Customizing Your Stub Files](#customizing-your-stub-files)
  * [Adding Files to the Distribution](#adding-files-to-the-distribution)
  * [`configure` Options](#configure-options)
  * [Perl Modules and RPMs](#perl-modules-and-rpms)
* [FAQs](#faqs)

# Overview

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
sudo make install
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

[Back to Table of Contents](#table-of-contents)

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

[Back to Table of Contents](#table-of-contents) 

## Configuring Your Build

Again, the goal of this utility is to create a build and deploy system
based on GNU Autotools (`autoconf`, `automake`, and `make`). Reminders:

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
| Image files (`.png`, etc) | `src/main/html/htdocs/image` | `apache-vhostdir/htdocs/img` |
| Javascript files (`.js`) | `src/main/html/javascript` | `apache-vhostdir/htdocs/` |

> Note: `perl5libdir` defaults to `datadir/perl5`. To install your
> Perl modules in Perl's path use `--with-perl5libdir` without
> specifying a path

[Back to Table of Contents](#table-of-contents) 

## Why Autoconfiscate?

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

[Back to Table of Contents](#table-of-contents) 

# Quick Start

1. Install this project from GitHub or CPAN (_Hint:_  _unless you want to
   dive into the gory details of how this utility is built, install from [CPAN](https://metacpan.org/pod/Autoconf::Template)_)
1. Create a `manifest.yaml` file that describes the project and the
   assets you want to include (_they don't actually have to
   exist!_). You can also use the utility to [_automagically_ create a
   `manifest.yaml`](#automatically-creating-a-manifest-file) file from your project directory.
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

[Back to Table of Contents](#table-of-contents) 


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

[Back to Table of Contents](#table-of-contents) 

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
  image:
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

> You can customize or use your stubs. See [Configuring
> `autoconf-template-perl`](#configuring-autoconf-template-perl)

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
manifest. The extension will be replaced using the convention described
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
autoconf-template-perl --destdir=/tmp --manifest=manifest.yaml
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
./configure
make
```

...if that succeeds, try installing the project and examine the
deployment tree structure:

```
make install DESTDIR=/tmp/my-project
tree /tmp/my-project | less
```

## Automatically Creating A Manifest File

To create a `manifest.yaml` that contains your project assets, you use
the `--create-manifest` option of `autoconf-template-perl`. Assuming
your are in a directory that contains Perl scripts, modules and other
assets you want to include in your project, creating a manifest is as
easy as:

```
autoconf-template-perl --create-manifest --source-dir . > manifest.yaml
```

`autoconf-template-perl` will look for these files:

| File Type | Extension |
| --------- | --------- |
| Perl scripts and module | `.pm`, `.pl` |
| Bash scripts | `.sh` |
|  Web application artifacts | `.html`, `.css`, `.js`, `.png`, `.jpeg`, `.jpg` |
| Configuration files | `.json`, `.yaml`, `.cfg`, `.ini` |

Any other files in your source directory will be added to the
`resources:` section of the manifest.

Now edit the manifest and add paths to other artifacts or otherwise
customize the manifest for your project. You can customize the
manifest by adding some options (the default `--source-dir` is the
current directory):

```
autoconf-template-perl --create-manifest \
  --project 'slate-industries-inventory' \
  --author 'Fred Flintstone' \
  --email 'fred@openbedrock.org' \
  --description 'quarry inventory app' > manifest.yaml
```

Remember that your paths in the manifest can be absolute or relative
to the directory where you will be running `autoconf-template-perl` to
create your project.

You can also add the names of scripts or modules that do not exist but
you _plan_ to create. Use just the relative path for those...for
example if I _plan_ to create a `Slate::Config` module, then list the
file in the manifest like this:

```
perl:
  lib:
    - Slate/Config.pm
```

`autoconf-template-perl` will then create a stub module for you from the stub
template for Perl modules.


[Back to Table of Contents](#table-of-contents) 

## Configuring `autoconf-template-perl`

`autoconf-template-perl` can create a valid project with no options.
All you need to provide is a `manifest.yaml` file.  You can create
your own manifest or let `autoconf-template-perl` generate one for
you.

```
autoconf-template-perl --create-manifest --source-dir .
```

## `autoconf-template-perl` Options

| Option | Description |
| ------ | ----------- |
| `h, --help`| help |
| `a, --author name`|  author's name (default: "anonymouse")
| `b, --bash`| build bash directories (default: true) |
| `c, --create-missing`|  create any files in manifest that do not exist (default: false) |
| `C, --create-manifest`| create a manifest file from the current directory |
| `S, --create-stub`| filename  create a stub file |
| `d, --destdir`| directory root for project directory |
| `e, --email email`| author's email (default: rlauer6@comcast.net || anonymouse@example.com) |
| `f, --force`| force overwrite of project directory |
| `h, --html` | build html directories (default: true) |
| `l, --log-level level`| logging level, error, warn, info, debug, trace  (default: error) |
| `L, --list-stubs`| lists the stub templates available |
| `m, --manifest` |  filename  name of the YAML manifest file |
| `p, --project name` | project name (default: "noname") |
| `r, --refresh`| refresh after  addition of script or module |
| `R, --rpm-build`| enable or disable RPM spec file |
| `s, --source-dir`| directory source directory for files in manifest or when creating manifest |
|   | (default: pwd) |
| `u, --unit-tests`| create unit test stubs (default: true) |
| `v, --version` | report script version |

These options default to true, use `-no-{option}` to disable

```
--bash
--html
--rpm-build
--unit-tests
```

[Back to Table of Contents](#table-of-contents)

# Project Source Tree

Your Perl application project is laid out in a _specific_, _organized
hierarchy_ to create a standard layout that all of your team can navigate
easily. It __does not__ reflect the way a project is eventually installed in
the target environment. See [Deploying Your
Project](#deploying-your-project) for details regarding where
artifacts are installed.

The source tree hierarchy is based on common patterns and best
practices you'll see in many open source projects. Those practices
have been adapted for packaging Perl applications. Many of the
applications I have been written or maintained have included web
components. `autoconf-template-perl` recognizes the needs of those
types of applications by creating directories and build instructions
for web applications as well.

## Root Directory

The root of the project will contain your `configure.ac` file which is
used by `autoconf` to create your `configure` script.  The `configure`
script is then used to create the `Makefile` in all of your
subdirectories from the `Makefile.am` created automatically for you by
`autoconf-template-perl`.

The root also contains a stub `ChangeLog`, `README.md` and other files
you can customize you might typically see on the _first page_ of your
`git` repository..

## `autotools` Directory

The `autotools` directory contains [`m4`
macros](https://en.wikipedia.org/wiki/M4_(computer_language)) used
during the configure phase. These should be considered source files
under source control (if you are using a source control system). You
don't need to know much about `m4` to use this utility. The project
contains and will create `m4` macros behind the curtains that do the
things needed to configure and build your project.

## `config` Directory

This directory should contain the configuration files containing magic
values (but hopefully not __secrets__) required by your
application. Typically configuration files might be `.ini`, `.cfg`,
`yaml` or `.json` files. When you specify these files in your manifest, the
`autoconf-template-perl` utility will rename them with a `.in`
extension. See [Building From `.in`
Files](#building-from-in-files). It does this so that you can include
values in the files that are populated when you configure the project
for a build by running `./configure` in the project root.

You can add new configuration files to your project at any time. To
add new configuration files after the initial project creation see
[Adding Artifacts to Your Project](#adding-artifacts-to-your-project).

Configuration files are deployed to _`$(sysconfdir)/@PACKAGE@`_, defined when
you configure the project (typically `/etc/@PACKAGE@`).

## `resources` Directory

This directory contains files in your project that will be installed
to `$(datadir)/@PACKAGE@`. For example, if your project name is
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
     |   |-- image
     |   `-- javascript
     `-- perl
         |-- bin
         |   `-- t
         |-- cgi-bin
         `-- lib
             `-- t
```

# Building and Deploying Your Application

## Building Your Application

In general, the recipe for building your application looks like this:

1. Configure the build with the options that determine the
   installation location and other parameters that determine your
   application or build environment
   ```
   ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
       --with-perl5libdir --with-my-custom-option=foo
   ```
1. Run `make` to syntax check your Perl scripts and modules and create
   your deployment files from your `.in` files
1. Run `make check` if you want to run unit tests
1. Run `make dist` to create distribution tarball for your application

You can also build an RPM after creating your distribution
tarball. [Building RPMs](#building-an-rpm) is a more complicated subject that is discussed
later in this documenation.

## Checking Your Project Distribution

Checking the project distribution before deployment involves several
steps, depending on how you have configured the project. By default
the distribution will go through the checks listed below when you run
`make distcheck`

* A tarball will be created from your project artifacts (`make dist`)
* A [VPATH
  build](https://www.gnu.org/software/automake/manual/html_node/VPATH-Builds.html)
  will be initiated (`make`).
  * building first proceeds with the substitution of Automake
  variables for those files in the source tree with the `.in`
  extension. The `.in` suffix is removed and a deployment file is
  create (`.pl`, `.pm`, etc).
  * Perl scripts and libraries will be syntax checked using `perl -wc`
* Verification tests if any will be run (`make check`).
  * unit tests found in the `t/` sub-directories of `perl/bin`, `perl/lib`
    and `perl/cgi-bin`
  * `perlcritic` at the severity level defined in your `Makefile.am`
    specified in the `DISTCHECK_CONFIGURE_FLAGS` variable.
* Installation of the project is done in a temporary (`make
  install`)
* The project will be uninstalled and build artifacts will be removed (`make
  uninstall`, `make clean`)

If all of those steps succeed, your project is ready for
deployment. If it fails any of these steps you should check the FAQs
regarding `distcheck` failures and correct the problem before
deployement. When `distcheck` fails, it is likely that taking your
tarball to the target system and attempting an installation will be
_first order broke_.

Passing, does not mean your project will be successfully
deploy in any environment.  It simply indicates that, at least
in your build environment, the package is complete and passes the tests
defined by the build system.  That includes whatever checks have been
done when you ran `./configure` which, tests for things like Perl modules
and other Linux utilities (`prove`, `pod2man`, etc.). 

If you have additional requirements for your application you can
modify the `configure.ac` file and use this example as a guide...

```
AC_PATH_PROG([POD2MAN],
	[pod2man])

if test -z "$POD2MAN" ; then 
  AC_MSG_ERROR([pod2man found?])
fi
```

In the example above your `configure` script will check for the
`pod2man` utility required for building man pages and create an
Automake variable (`@POD2MAN`) you can use in your `.in` files.

Failure to find the `pod2man` utility will abort the
configuration. If the item you are checking for is optional, you can
use `AC_MSG_WARN` instead of `AC_MSG_ERROR`.

Much more advanced checks are possible but require much more advanced
knowledge of `autoconf`. Learn more about [writing
tests](https://www.gnu.org/software/autoconf/manual/autoconf-2.60/html_node/Writing-Tests.html#Writing-Tests)
for your `configure.ac` file by visiting the Autoconf website.

## Deploying Your Application

How you deploy your application depends on how you have packaged it.
If you have opted to use an RPM, deployment is done using `yum` or
`rpm`. 

## RPMs

The entire deployed application has been laid out within the
RPM, so deployment is essentially done by `rpm` by copying the
contents of the RPM to the target system.  Some additional steps might
be performed in the `%post` section of the RPM if you are building
Perl module dependencies at deployment time.

## Tarballs

If you are deploying to a target system from the distribution tarball,
you will need to _configure_, _build_ and _install_ the application. This is
done using the standard recipe shown below.

```
tar xfvz my-app-1.0.0.tar.gz
cd my-app-1.0.0
./configure
make
sudo make install
```

You might want to pass configuration options to `configure` instead of
using the defaults to control where all of your artifacts are
deployed.

Try `./configure --help` to see a listing of all configuration
options.

## Standard Deployment Tree

Using the configuration options show below will result in your
application being installed in the locations shown in the table.

```
./configure --prefix=/usr --localstatedir=/var/ --sysconfdir=/etc
```

| Artifact | Source Location | Deployment Location | Config Option |
| --------- | -------------- | ------------------- | ------------- |
| Bash scripts | src/main/bash/bin/ | /usr/bin | `--bindir` |
| Perl scripts | src/main/perl/bin/ | /usr/bin | `--bindir` |
| Perl modules | src/main/perl/lib/ | `$Config{installsitelib}` | `--perl5libdir` |
| Configuration files | config/ | /etc/@PACKAGE@ | `--sysconfdir`
| Resource files | resources/ | /usr/share/@PACKAGE@/ | `--datadir` |
| HTML files | src/main/html/htdocs | /var/www/htdocs | `--apache-vhostdir` |
| CSS files | src/main/html/css | /var/www/htdocs/css | `--apache-vhostdir` |
| Javscript files | src/main/html/javascript | /var/www/htdocs/javascript | `--apache-vhostdir` |
| Image files | src/main/html/image | /var/www/htdocs/img | `--apache-vhostdir` |

> * @PACKAGE@ is the name of your project
> * `$Config{installsitelib}` is Perl's module site directory
> * Web application artifacts are all installed under `${apache_vhostdir}/htdocs`

[Back to Table of Contents](#table-of-contents)

# Adding Artifacts to Your Project

Adding additional files and resources to your project can be done by 
dropping a new file in the target directory and refreshing the
project. You can also use the `--create-stub` to add files that have
stub templates (`.pl`, `.pm`, `.cgi`, etc).

```
cp foo.txt my-project/resources/
cd $PROJECT_HOME
autoconf-template-perl --refresh
```

```
autoconf-template-perl --create-stub foo.pl
```

When you use the `--create-stub` option, `autoconf-template-perl` will
automatically do a refresh.

If you already have script or module and are not using the
`--create-stub`option, copy the source file to the target
directory as a `.in` file and then manually refresh the project.

```
cp foo.pl $PROJECT_HOME/src/main/perl/bin/foo.pl.in
cd $PROJECT_HOME
autoconf-template-perl --refresh
```

Performing a refresh operation will regenerate the
`Makefile.am` files to enable your new artifact to be built and
installed when the project is deployed. Refreshing will also scan your
Perl modules and scripts for new dependencies and regenerate files
that contain those dependencies.

[Back to Table of Contents](#table-of-contents) 

# Building From `.in` Files

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

## Automake Configuration Variables

Here's a list of some of the `automake` configuration variables you
can use in any file that is built using `$(do_subst)` (config files,
scripts, modules).

| Variable Name | Description |
| ------------- | ----------- |
| `@ARCHITECTURE@` | architecture (noarch or X86_64) |
| `@BUILD_DATE@` | build date |
| `@LICENSE@` | license |
| `@PACKAGE_DESCRIPTION@` | package description |
| `@PACKAGE_NAME@` | package name |
| `@PACKAGE_VERSION@` | package version |

* Apache Site Directories

These directories are rooted by the configuration value
(`--with-apache-vhostdir=`) made available by the `m4` macro
[`autotools/apache_config.m4`](autotools/apache_config.m4).

Without modification, the directories below
are set relative to the value you provided for `apache-vhostdir`. These
directories are defined in `includes/apache-directories.inc`. Feel free to
modify them based on your needs.

These directories contain web application artifacts or are used by the
web application in some way. Note that descriptions are how these
directories are _typcially_ used, however you can use or not use them
as you please. Only a subsert of these directories are actualy created
for you when your web application is installed.

| Variable Name | Description |
| ------------- | ----------- |
| `@apache_site_cachedir@` | cached assets |
| `@apache_site_cgibindir@` | CGI scripts |
| `@apache_site_configdir@` | configuration files |
| `@apache_site_cssdir@` | CSS files |
| `@apache_site_htdocsdir@` | HTML files|
| `@apache_site_imgdir@` | Image files |
| `@apache_site_javascriptdir@` | Javascript files |
| `@apache_site_logdir@` | Log files |
| `@apache_site_perl5libdir@` | Perl modules |
| `@apache_site_reportsdir@` | Report files |
| `@apache_site_sessiondir@` | Session files |
| `@apache_site_spooldir@` | Spool files |
| `@apache_site_workdir@` | A work dir? |
| `@apache_sitedir@` | Same as `@apache_vhostdir@` ||
| `@apache_vhostdir@` | root directory for web application |

* Apache Domain and Virtual Server

You can potentially use these values in the table below to alter
the directories in the table above so that you might, for example
support multiple applications in different virtual hosts or domains on
the same platform. In the default setup, defined in
`includes/apache-directories.inc`, these values are not used. However
if for example, you wanted to support a virtual host configuration you
might alter `apache_sitedir` in the `includes/apache-directories.inc`
file.

```
 # Apache Virtual Host site directories
 apache_vhostdir           = @apache_vhostdir@
 apache_sitedir            = $(apache_vhostdir)/@apache_vhost_server@
```

...and then configure the project thusly...

```
./configure --with-apache-vhost-server=www.foobar.com --with-apache-vhostdir=/var/www/vhosts
```
...so that your web application might be installed in `/var/www/vhosts/www.foobar.com`

| Variable Name | Description |
| ------------- | ----------- |
| `@apache_vhost_alias@` | possibly used for _ServerAlias_ directive in a _VirtualHost_ section of an Apache configuration file |
| @apache_vhost_confdir@  | the directory where all the virtaul host configuration files reside
|                         | examples: /etc/httpd/conf.d, /etc/apache2/sites-available, /usr/local/bin/conf/conf.d |
| @apache_vhost_domain@  | the domain name of the website |
|                         | examples: example.com | 
| @apache_vhost_server@ | the fully qualified domain name (including subdomain) of the website |
|                     | examples: www.example.com, api.example.com |

* Apache User/Group 

These variable can be set when you configure the application or the m4
macro will create defaults based on the system flavor (RedHat vs
Debian) you are building on.

| Variable Name | Description |
| ------------- | ----------- |
| `@apache_user@` | the user that runs the apache server |
|                 | examples: www-data, apache, nobody |
| `@apache_group@` | the group the user that runs apache belongs to |
|                  | examples: www-data, apache, nobody |

* Miscellaneous Files

| Variable Name | Description |
| ------------- | ----------- |
| `@bashrun@` | bash executable path |
| `@bindir@` | scripts and binaries |
| `@configure_input@` | the input to `configure` script |
| `@datadir@` | data files |
| `@libexecdir@` | scripts not meant for user consumption |
| `@localstatedir@` | stateful files (typcially  `/var`) |
| `@perl5libdir@` | Perl modules |
| `@perlrun@` | Perl executable path |
| `@prefix@` | prefix for file system hierarch (typicall `/usr/`) |
| `@sysconfdir@` | Configuration files |

*TODO:* _Provide templates for virtual host and Apache configurations_

[Back to Table of Contents](#table-of-contents) 

# Building Perl Modules

Perl is an interpretted language and thus Perl scripts do not need to
be built in the same ways C or C++ files require compilation and
linking to become executable. Perl scripts are compiled _on the fly_
when you invoke the Perl interpretter either directly as in:

```
perl -I $HOME/lib/perl5 my-app.pl
```
...or implictly using the she-bang as the first line of your script to
tell the shell how to run your script.

```
#!/usr/bin/env perl
```

So what does _Building Perl Modules_ mean?

In the context of `autoconf-template-perl` building a Perl module
does a few things:

1. Replaces and `automake` variables (`@variable-name@`) found in the
   source files with their values that were set by `configure`
1. Runs `perl -wc` on the module or script to check the syntax.
1. Creates man pages from the pod contained in the module or script.

When you build a Perl module or script from a `.pl.in` or `.pm.in`
file, the build recipe will first perform any required substitution of
`automake` variables using `$(do_subst)` and then will run `perl -wc`
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

[Back to Table of Contents](#table-of-contents) 

# Building an RPM

This section contains details regarding packaging your application as
an RPM. This is a _potentially_ good way to package your Perl
applications on RedHat systems.  It is probably *not* a good strategy if
you do not plan on using the _system_ provided `perl` (assuming the
target environment even has such a thing).

> Recent versions of the Amazon Linux 2 Docker container have
> removed `perl` :-(

While it is possible to use a vendored version of Perl and package
your application as an RPM, you are likely to run into dependency
issues if you do not prevent the `rpmbuild` process from trying to
find your Perl dependencies. You may also find it a particularly
frustrating experience if your application uses Perl modules that do
not have RPM packages readily available (See [Building RPMs from
CPAN Modules](#building-rpms-from-cpan-modules)).

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

## Building RPMs from CPAN Modules

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

[Back to Table of Contents](#table-of-contents) 

# Unit Tests

`autoconf-template-perl` will create unit test stubs for you by
default. Unit test stubs are just very simple Perl scripts that
incorporate `Test::More`. You can disable their create using the
`--no-unit-tests` option.  Unit test stubs are created for `.pl`,
`.pm`, and `.cgi` files. These stubs look something like this for
`.pl` and `.cgi` files.

```
#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 1;

subtest 'debug' => sub {
  ok(1);
};

__END__
```
...and something like this for `.pm` files:

```
 package [% module_name %];
 # autogenerated from [% generator %] v[% version %] on [% timestamp %]
 # template: [% template_name %]
 
 use strict;
 use warnings;
 
 use Carp;
 use Data::Dumper;
 use English qw(-no_match_vars);
 use Log::Log4perl qw(:easy);
 
 use parent qw(Exporter Class::Accessor::Fast);
 
 __PACKAGE__->follow_best_practice;
 __PACKAGE__->mk_accessors(
   qw(
    debug
   )
 );
 
 our $VERSION = '@PACKAGE_VERSION@'; ## no critic (RequireInterpolation)
 
 ########################################################################
 sub new {
 ########################################################################
   my ( $class, @args ) = @_;
 
   my %options = ref $args[0] ? %{ $args[0] } : @args;
 
   my $self = $class->SUPER::new( \%options );
 
   return $self;
 }
 
 1;
 
 ## no critic (RequirePodSections)
 
 __END__
 
 =pod
 
 =head1 NAME
 
 =head1 SYNOPSIS
 
 =head1 DESCRIPTION
 
 =head1 METHODS AND SUBROUTINES
 
 =head1 SEE ALSO
 
 =head1 AUTHOR
 
 [% author %] - [% email %]
 
 =cut

```

Unit tests are run by executing `make check` which is also run
whenever you run `make distcheck` (See [Checking Your Project
Distribution](#checking-your-project-distribution)).  All of the unit
tests must pass for the distribution to be considered _working_.

[Back to Table of Contents](#table-of-contents)

# Advanced Topics

## Creating Your Own Configuration Options

Once you've created your project and `autoconf-template-perl` has
created your `configure.ac` file, executing `./configure --help` will
present you with the options available.

Adding your own `configure` options to create
`automake` variables you can use in source files is done manually by adding
some `m4` incantations to create in your `configure.ac` (the
_automagic_ way is discussed a litle later).

```
AC_ARG_WITH(
  [foo-bar],[  --with-foo-bar=[foo bar stuff]],
  [foo_bar=$withval],
  [foo_bar=[foo]]
)

AC_SUBST([foo_bar])
```
...and updating the `do_subst_command` in `configure.ac` by adding
another `sed` command.

```
  -e '"'"'s,[@]foo[@],$(foo),g'"'"' \
```

By adding these snippets you will create an `automake` variable you
can use in various ways. Most notably, you can use this is any source
file (`.in`) as `@variable-name@` and it will be resolved during the
build phase.

...but wait! There IS an __easier__ way!

Use the `autoconf-ax-extra-opts` utility to add a new option. It will
automatically update an `m4` macro (`ax-extra-opts.m4`) and
`configure.ac` for you.

```
autoconf-ax-extra-opts -o s3-bucket-name \
      -t "bucket name" \
      -d "The bucket used store stuff" \
      -D my-private-bucket-name
```
...then

```
./configure -h | grep s3
--with-s3-bucket-name=bucket-name The bucket to store stuff in (default: my-private-bucket-name)
```

To use this a configuration file for example:

```
[s3]
bucket_name = @s3_bucket_name@
```

## Customizing Your Stub Files

When files do not exist in your manifest or you want to use the
`--create-stub` option to create a new script of module,
`autoconf-template-perl` will create new files for you using a _stub_
template. You can create your own templates that
`autoconf-template-perl` will use to create these stubs instead of the
ones that are provided in this distribution.

An `.autoconf-template-perlrc` file was created in you project
directory when you created the project. Edit the file and replace the
paths for the stub files you wish to customize.

```
[stubs]

cgi  = /usr/local/share/perl/5.32.1/auto/share/Autoconf-Template/templates/stub.cgi
pm   = /usr/local/share/perl/5.32.1/auto/share/Autoconf-Template/templates/stub.pm
pl   = /usr/local/share/perl/5.32.1/auto/share/Autoconf-Template/templates/stub.pl
cfg  = /usr/local/share/perl/5.32.1/auto/share/Autoconf-Template/templates/stub.cfg
js   = /usr/local/share/perl/5.32.1/auto/share/Autoconf-Template/templates/stub.js
html = /usr/local/share/perl/5.32.1/auto/share/Autoconf-Template/templates/stub.html
```

Some other options you can set in the configuration file include your
_name_, _email address_ and _flags that determine whether certain source
directories will be created for you_.  `autoconf-template-perl` will
look for this file in your home directory (`$HOME`) and the current
working directory, so for future project creations, you'll want to
move this to your `$HOME` directory after customization.

```
[global]

author = "Rob Lauer"
email  = rlauer6@comcast.net

create-missing = true

html           = true
bash           = true
perl_bin       = true
perl_lib       = true
perl_cgi       = true
```

[Back to Table of Contents](#table-of-contents) 

## Adding Files to the Distribution

* If you want to add files to be included in your distribution that
should __not__ be installed, add this snippet to `Makefile.am` in the
root of your project.

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
   cp foo.pl $PROJECT_HOME/src/main/perl/bin/foo.pl.in
   cp foo.cfg.in $PROJECT_HOME/config/foo.cfg.in
   ```
2. Re-run `autoconf-template-perl` in the root of the project using
   the `--refresh` option.
   ```
   autoconf-template-perl --refresh
   ```

* Whenver you introduce new Perl module dependencies to the project,
make sure you run `autoconf-template-perl --refresh`. New dependencies
will be identified and added to the `m4` macro
`autotools/ax_requirements_check.m4` so that `configure` will verify
their existence in the target environment during the build.

## `configure` Options

Along with the standard `configure` options that allow you to alter the
install paths there are additonal options specific to
`autoconf-template-perl` that control the building of your project.

| Option | Description |
| `--enable-distcheck-hack` | enables flag that use the `DISTCHECK_CONFIGURE_FLAGS`  you might have set in your project root `Makefile.am` (see [FAQs](#faqs)) |
| `--disable-deps` | don't abort if dependencies are missing, just warn |
| `--enable-rpm-build-mode` |  disables dependency checking and other behaviors that are only relevant outside of an RPM build |'
| `--disable-perldeps` | don't abort if Perl module dependencies are missing |
| `--enable-perlcritic-mode` | run `perlcritic` during `make check` | 
| `--with-perlcritic-severity` | sets the severify level (1-5) that will break the build |
| `--with-perl5libdir` | where to install Perl modules, default: `$Config{installib}` |
|  `--with-perl-includes` | additional Perl module paths that will prepended to `@INC` |

* Apache Configuration Options

| Option | Description |
| `--with-apache-vhost-domain=name` | domain name used to set `@apache_vhost_domain@` |
| `--with-apache-vhostdir=DIR` | root directory for web application |
| `--with-apache-vhost-confdir=DIR` |  where Apache looks for virtual host configuration files (_not currently used_) |
| `--with-apache-vhost-server=name` | fully qualified HTTP server name (_not currently_used) |
| `--with-apache-user=USER`  |       user id that should own the web pages |
| `--with-apache-group=GROUP`        group that should own the web pages |
| `--with-license` | default: GNU Public License |
| `--with-architecture` | architecture (`noarch`, `x86_64`) (default: noarch |

[Back to Table of Contents](#table-of-contents) 

[Back to Table of Contents](#table-of-contents)

## Perl Modules and RPMs

A reminder that our goal is to package a Perl application for
deployment and ensure that dependencies are satisfied one way or
another when the package is installed in the target environment.

There are several strategies available to ensure dependencies are
available when your application runs.

> Spoiler alert: `autoconf-template-perl` employs strategy #1.iii

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
| 1.i | easy, no effort | RPM packages may not be available for all dependencies |
| 1.ii | easy, no effort | requires support from SysAdmins or another step in deployment | 
| 1.iii | easy, some effort | may fail if building modules at time of deployment requires additional libraries or special installtion instructions for CPAN modules |
| 2.i | complete RPM ready for deployment | not supported by this utilty, lot's of effort, must be built in same environment as target |

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
strategy #1.iii. `autoconf-template-perl` prevents `rpmbuild` from
including those dependencies by removing them when they are found by
`rpmbuild`'s scanner. The spec file then includes a `%post` section
that executes the [`install-from-cpan`](install-from-cpan.in) script
that will install the required modules directly from CPAN using
`cpanm`.  `autoconf-template-perl` identifies dependencies when your
project is being configured and then creates several files that list
those dependencies.

| Dependency File | Description |
| --------------- | ----------- |
| `autotools/ax_requirements_check.m4` | `m4` macro that checks for  required modules |
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

1. Add the requirements to the list of those already in the spec file:
   ```
   Requires: gcc make
   ```
   ...or you can automatically add dependencies to your spec file when you
   create your project using the `--rpm-requires` option.
   ```
   autoconf-template-perl -d . --rpm-requires libxml2 --rpm-requires libxml2-devel
   ```
1. _prevent dependency checking_ altogether and revert to (Strategy
   #1), letting `yum` try resolve to the dependencies for your Perl
   modules. This strategy will work if you know that all of your Perl
   module dependencies can be satisfied from a `yum` repository you
   have enabled.
   
   To employ this strategy and prevent the specfile from
   blocking dependency checking (_the default_) use the
   `--no-rpm-install-from-cpan` option when you build your project
   with `autoconf-template-perl`. `rpmbuild` will then add the
   dependencies to the package so that `yum` will attempt to satisfy
   those dependencies from enabled repositories at install time.

Strategy #1.ii usually takes the form of handing your dependency list
to the _SysAdmins_ and asking them to add these dependencies using
whatever tools they use to install Perl modules.

Another technique I have used in the past when creating Docker
containers, is to create a base image that contains the required
dependencies. In this manner, I separate the two resposibilities;
__building the depdendencies__ and __building the application__.  Over
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
#1.ii. I've kicked the can down the road, delegating the responsibility
of dependency resolution to a different process.

Strategy #2 _can_ work if you keep in mind a few things.

First, you have to prevent `rpmbuild` from identifying Perl
dependencies so that it does include the `Requires:` statements that
will cause `yum` to attempt resolution.

Second, you need to be aware that you are building what should be a
_binary compatible RPM_ that will be deployed in your target
environment. In other words, *your build environment must reflect your
target environment*. You can't build your Perl modules on a system
using `perl` 5.36 and expect it work on a system that contains `perl`
5.18. You _might_ have some luck building modules and RPMs on one
platorm and deploying on another _if you those modules do not require
any binary library bindings_. Likewise you _might_ have some luck
building vanilla RPMs on Debian systems and deploying them to a RedHat
flavored operating system. In general however, you are probably better
off not attempting that trick.

The best strategy I have come up with these days is to create Docker
containers that contain my Perl applications.  When building
containers you can control all of the parameters and dependencies
required for the build...and you can still couple a containerized
build with the use of RPMs.

[Back to Table of Contents](#table-of-contents) 

# FAQs

1. Do I need to be an Autotools expert to use this package?
   * No, but it helps if you understand the basic concepts of
     _autoconfiscation_, building open software using Autotools and
     Linux utilities. If you can' run this script and create a project
     that can create a distribution tarball that
     [_works_](#checking-your-project-distribution), then please
     report the issue - that's a bug.
1. Why did you create this project when there are already a few very
   good Perl packaging applications (`carton`, `Dist::Zilla`)?
   * Those tools only solve a portion of the problems associated with
     packaging an entire application. An application is usually
     composed of more than just Perl modules. Artifacts for
     applications must be inventoried, packaged and deployed in their
     appropriate locations on the target environment. I was tutored
     early on to respect the [Unix/Linux FSH File System Hierarchy](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)
     as much as possible and there is no better tool (IMHO) than the
     Autotools for helping to adhere to that advice.
     
     Over the years I have built project after project using my
     template for creating Perl applications. The template was a good
     accelerator starting a new project but I wanted something that
     would get me going even faster.  The template still required a
     lot of manual editing, cut 'n paste and revisitations to the
     Automake documentation.  It was time to put my years of
     experience using Autotools to the test and create a truly
     automated way to create a new _autoconfiscated_ project that
     worked immediately after the project was
     created. `autoconf-template-perl` is the culmination of my
     experience with Autotools and my experience writing Perl scripts
     and modules.
     
     `autoconf-template-perl` is still a WIP, but should be usable to
     get you started using Autotools without having to understand it completely.
1. Why do I have to use a `.in` extension for my Perl scripts and
   modules? (See [Building from `.in` Files](#building-from-in-files)).
1. Why is `make distcheck` failing?
   * [`make
     distcheck`](https://www.gnu.org/software/automake/manual/html_node/Checking-the-Distribution.html)
     should be run after you create a distribution to
     ensure that the distribution actually works (See [Checking the
     Project Distribution](#checking-your-project-distribution) for
     more details).
     
     `distcheck` can fail for various reasons, the most common reason
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
1. What if I have other types of files I need to build (C/C++, e.g.)?
   * `autconf-tempalte-perl` was built specifically for Perl
     applications but could be expanded to include building other
     types of applications (Python, C/C+). In fact, the original Perl
     template for _autoconfiscation_ was based on an _autoconfiscated_
     C application. Personally, I have not written a C program in over
     20 years and don't intend on expanding this to building binaries
     or libraries.  Python applications might be a target at some
     point however (PRs welcome).
1. I don't want  my RPM packages to install modules from CPAN, I have RPMs
   for all my dependencies. How do I prevent the RPM from installing
   dependencies from CPAN?
   * When you create the project you can use the
   `--no-rpm-install-from-cpan` option to disable installation of
   dependencies in the `%post` section of the RPM spec file. If you
   forgot to do that initially and later decide to disable that
   feature, just refresh the project with that option.
   ```
   make distclean
   autoconf-template-perl --no-rpm-install-from-cpan --refresh'
   ./configure
   make dist
   rpmbuild -tb my-project-0.0.1.tar.gz
   ```
