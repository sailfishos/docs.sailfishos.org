---
title: Packaging Software on OBS
permalink: Services/Development/Open_Build_Service/Packaging_for_OBS
parent: Open Build Service
layout: default
nav_order: 400
---

This page deals specifically with building packages using the [Open Build Service](/Services/Development/Open_Build_Service) instance.

This requires the user to create a home project, and then create a package
under that project, with the appropriate `_service` file to specify how the
project should be built and packaged. Once the build has been triggered, OBS
will attempt to pull in the required dependencies and build the package.

You can interact with the OBS either on the web interface at [https://build.sailfishos.org](https://build.sailfishos.org), or use the command-line tool, [osc](https://en.opensuse.org/openSUSE:OSC)

**A note about terminology**

*Some terms, like  "repository", "source", "package", have different meanings
depending on context. For example "repo" can mean either a build environment
configuration on OBS, or it's corresponding published RPM repository. But it
can also refer to a git repository.*

## Setting up the (Home) Project and creating a Package

To create an account on OBS, follow the instructions on [the Chum help page](https://github.com/sailfishos-chum/main#user-content-submitting-actively-maintained-software).

After creating a user account you are automatically the owner of the so-called "Home Project" named `home:$username`.
You can create various packages in that project and also create sub-projects.

See the official OBS [Beginnerʼs Guide](https://openbuildservice.org/help/manuals/obs-user-guide/art-obs-bg) for an introduction to OBS in general.

Click "Create Package" in your project if using the Web Interface, or `osc mkpac mypackage` if using `osc` to get started.

## Adding the sources

There are about three common "packaging formats" used in Sailfish OS development, which are described under [Packaging Formats](https://docs.sailfishos.org/Tools/Sailfish_SDK/Building_packages/#packaging-formats):

 - Plain Tarball
 - "Application Repository": `tar_git` with source code repository
 - "Packaging Repository": `tar_git` with upstream submodule

A packaging repository is a git repository which contains just the build
instructions and some other files (like patches) to package software for
Sailfish OS, with the actual source code living in a git submodule of this
repository.  
An "Application Repository" contains the source code itself, e.g. because you wrote it or cloned a third-party git repository.

### Plain Tarball sources

Usually, nothing special needs to be done if you want to build software from a source tarball.

You just populate the OBS package source like this:

```
application.spec
application-1.2.3.tar.gz
```

OBS will pick up both and run the build. No `_service` file is necessary in this case.

To get the source information into OBS, either upload them using the Web Interface, or use the `osc` tool:

```
cd my:project:mypackage
cp /path/to/mypackage.tar.bz2 .
cp /path/to/mypackage.spec .
osc add *
osc commit
```

*Note: Using a plain tarball is an convenient and quick way to package software
on OBS. Still, you are encouraged to move to a "Packaging Repo" approach for
various reasons, including better revision control and history, easier forking
by others, and backup/restore considerations.*

### `tar_git` sources

`tar_git` is a OBS Service which clones a repository from a public git hoster,
creates a tarball from it, extracts the build information, and places all those
files into the OBS Package source location.

You may look at its [source code](https://github.com/MeeGoIntegration/obs-service-tar-git) detailed information.

To get the service configured on OBS, create a file called `_service` with the following content:
```
<services>
  <service name="tar_git">
  <param name="url">https://github.com/orgname/reponame.git</param>
  <param name="branch"></param>
  <param name="revision"></param>
  <param name="token"/>
  <param name="debian">N</param>
  <param name="dumb">N</param>
</service>
</services>
```

and then either upload them using the Web Interface, or use the `osc` tool:
```
cd my:project:mypackage
cp /path/to/_service .
osc add _service
osc commit
```

#### Understanding version mangling performed by `tar_git`

Before starting the build process, OBS will perform certain changes to the
cloned .spec file. This mainly affects the contents of the `%{version}` and
`%{revision}` macros.

For some examples, see below.

`%specialversion` will consist of:
 - if a tag parameter was specified in the `_service`, it will be used as the version
 - if a branch parameter was specified in the `_service`, it will be appended to the name, along with the hash of the git ref, prepended by the letter "g".
 - if no tag parameter was specified in the `_service`, but a branch name was, it will contain the value of the *latest* tag in the branch, and the branch name, timestamp, and git ref hash appended to it.

`%specialrevision` will have the format X.Y.Z where:
 - X is always 1
 - Y is a counter that roughly corresponds to the number of revisions of the OBS package source.
 - Z is a counter starting at 1 and increasing each time OBS decides to automatically rebuild the package (usually because a dependency was rebuilt or newly published)

These auto-generated revision and version parameters will replace the
`%version` and `%revision` macros in the spec file throughout the OBS build
process. So you cannot use literal version or revision contents in your build
setup. If you need those, you should parse `%version` and `%revision`.

(*Note: `%specialversion` and `%specialrevision` are not real macros, they are used here as examples only*)

**About tagging**

It is common practice to leverage the rules above and use git tags as version
specifiers. This is especially true for "Packaging Repositories", where tags
like `X.Y.Z+gitN` signify version `X.Y.Z` of the upstream software, and N the
iteration in the packaging repository.

Be aware though that the parser above is not perfect. Also, some characters are
disallowed to appear in RPM version strings. So be conservative in the naming
of your tags.

#### Understanding the source structure and tarballs generated by `tar_git`

The tarball produced by the service has the following properties:

 - it will be named `_service:tar_git:%{name}-%{specialversion}-%{specialrevision}.tar.bz2` (see above about the `special` variables)
 - it will contain a directory `%{name}-%{specialversion}-%{specialrevision}`
 - the directory will:
   - contain the content of the repository, but will not include the `.git` directory (so any git calls in your build process will not function).
   - contain clones of all submodules (usually the "upstream" submodule), also without `.git`
   - the same applies to submodules within submodules.

The service will also extract `rpm` sub-directory from the source repo and place its contents in the OBS package root.
So the root may end up looking like this:

```
  _service
  _service:tar_git:foo-1.2+git3.tar.bz2
  _service:tar_git:foo.spec
  _service:tar_git:foo.changes
  _service:tar_git:foo-patchbar.diff
```

**A note about "dumb" packages:**
*You notice there is a "dumb" parameter in the service configuration. Setting
this to true switches the behaviour of the service to assume a very flat source
structure, and not generate a tarball. 
You may use this if your sources are very simple, for example contain only a
single source code file and a Makefile, without any directory structure.*


**Some Examples**

     - url: https://github.com/orgname/foo.git
     - branch: development
     - revision: *empty*

`_service:tar_git:foo-2.1+development.20240215221650.74.g0773230.tar.bz2` if the development branch contains a tag called 2.1

     - url: https://github.com/orgname/foo.git
     - branch: development
     - revision: 2.2

`_service:tar_git:foo-2.2+development.20240215221650.74.g0773230.tar.bz2`

     - url: https://github.com/orgname/foo.git
     - branch: *empty*
     - revision: 2.2+git3

`_service:tar_git:foo-2.2+git3.tar.bz2`


#### Adjust the %setup macro parameters and other paths

The name of the tarball must be the first `Source:` line in the .spec file.

You should name it
```
Source: %{name}-%{version}.tar.bz2
```

You can choose a literal string as the name, but you must use the `%{version}` macro.

(Note that `tar_git` will pick up the compression format you want to use from the extension, and will create the tarball accordingly.)

**If you are building a "Packaging Repository"**

Because of the structure of the tarball explained above, usually the `%prep`
section of .spec files will have to be adjusted to use the submodule directory
as the main source.

So if the upstream submodule is called "upstream", the line should look like

```
%prep
%setup -q -n %{name}-%{version}/upstream
```
You can choose a literal string as the name, but you must use the `%{version}` macro.

Similarly, if you change working directories in the build process, be aware of where the actual source code is located relative to `%{_builddir}`:

`%{_builddir}/%{name}-%{version}/upstream`

On the other hand, the contents of the `rpm` sub-directory will be in the
package root, not under `rpm` or `%_topdir/SOURCES` during the build. Usually,
this does not affect you though, as OBS sets the internal source path
accordingly, so things like `%SOURCE2` will work as expected.

#### Adjust the build requirements (BuildRequires).

The building service runner setup used on OBS is more bare-bones than the one
used in the Sailfish SDK, also with regard to the pre-installed packages.  If
you are adapting a .spec file coming from a project developed in the SDK, it is
likely you are missing some build requirements even though the package compiled
fine under the SDK.

Typically this involves the Qt dependencies, so you will need to add lines like the following:

```
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5Widgets)
BuildRequires:  pkgconfig(Qt5Xml)
```

====

## Common errors

To retry after fixong an error, run either `osc service rr` from the locally
checked out OBS package, or "Trigger Services" from the Web Interface.

**ERROR: no packaging in this git clone**

Your project does not contain a spec file in the `rpm` directory.

**ERROR: couldn't clone foo**

Check the `url` parameter in the `_service` file.
Also, check the settings on your git host. The repository may be set to private.
And be sure to use a clone URL, not a web view of the repo (like git-web).

```
  <param name="url">https://github.com/sailfishos-chum/qt6.git</param>
  <param name="branch">gcc</param>
```

*Note: sometimes, if you tried to run the service against a non-public git
repo, failed, and later set the repo to public and try again, the service will
still fail with the same error. You will need to seek assistance from the OBS
maintainers in that case.  
See also [this bug](https://github.com/MeeGoIntegration/obs-service-tar-git/issues/3).

**ERROR: Need single spec file in rpm**

Your project does contain a directory called `rpm`, but that directory contains more than one .spec file, so `tar_git` gets confused.

There are three possible solutions for that.

 1. delete one of the .spec files in the repo ;)
 1. name the OBS package or the spec file so their names match exactly. `tar_git` will accept a spec file that has the same name as the project.

 Note that if you actually want to build all the spec files, you can either use OBS Links (`_link`), or `_multibuild` files to achieve that.
 Either create links that correspond to the names of the other spec files or create a `_multibuild` file using the spec file names as `flavor`:

```
<multibuild>
  <flavor>foo</flavor>
  <flavor>bar</flavor>
</multibuild>
```
**ERROR: couldn't determine version from spec file**

Something is fishy about the `Version:` line in the .spec, or it is missing completely

**ERROR: Source filename in .spec must end in .tar.gz, .tgz, .tar.bz2 or .tar.xz**

The (first) `Source:` or `SourceX:` line in your .spec file is malformed. Be
sure to use one of the file extensions mentioned in the error message.

**Unresolvable: nothing Provides foo**

This is related to `BuildRequires:` in the .spec file.

Reasons include:

 - The dependency is not available in the OBS repositories you have configured in the OBS Project's `meta` configuration.
 - The dependency is available, but does not meet version requirements

If your BuildRequires: uses something like  `pkgconfig()` or `qml()`, try if
specifying the RPM package name (usually `package-devel`) helps. If it does, file an issue with the
package maintainer to include proper RPM `Provides` metadata.

**Blocked: downloading 1 dod packages**

This is a rare error which means one of the build dependencies is known to the
OBS system, but the package can not be accessed for the builder to install.  
You can not fix this yourself, you have to report this to the OBS maintainers.

## Publishing packages

Once you have successfully built your package, you may want to test it.

You can download the build results if you are logged into your account in the
Web Interface, or use `osc getbinaries`.

Another approach is to publish the RPM repository for your project. Publishing
makes all packages available in a repository that can be used by tools like
`zypper` or `pkcon`, and managed by `ssu`.  
Note however there is no access control over such published repositories, and
you can't know who will download your packages. This may or may not be what you want.

To "properly" make your package available to the world, you are encouraged to 
[submit your package to Chum](https://github.com/sailfishos-chum/main#user-content-submitting-actively-maintained-software).


To publish a package, either use the graphical tool in the Web Interface, or edit the Meta information.

Not that Meta can be set globally or a Project, and then overridden per-package.

With `osc`, the commands are: `osc meta -e prj`, and `osc meta -e pkg`


**Example Project Meta configuration:**

Support x64, arm, arm64, build for both arm and arm64, but only publish arm64:

```
<project name="home:username:devel:foo">
  <title>Foo</title>
  <description>The Foo suite of software</description>
  <person userid="username" role="bugowner"/>
  <person userid="username" role="maintainer"/>
  <build>
    <disable/>
    <enable repository="4.6_aarch64"/>
    <enable repository="4.6_armv7hl"/>
  </build>
  <publish>
    <disable/>
    <enable repository="4.6_aarch64"/>
  </publish>
  <repository name="4.6_armv7hl">
    <path project="sailfishos:4.6" repository="latest_i486"/>
    <arch>i586</arch>
  </repository>
  <repository name="4.6_armv7hl">
    <path project="sailfishos:4.6" repository="latest_armv7hl"/>
    <arch>armv8el</arch>
  </repository>
  <repository name="4.6_aarch64">
    <path project="sailfishos:4.6" repository="latest_aarch64"/>
    <arch>aarch64</arch>
  </repository>
</project>
```

## Advanced Trickery

### OBS Branches and `tar_git`

One of the drawbacks of using a `_service` file and "Packaging Repository"
setups is that the OBS feature of [branching](https://openbuildservice.org/help/manuals/obs-user-guide/art-obs-bg#sec-obsbg-uc-branchprj)
becomes less useful, because your branched package will only contain the
`_service` file, but not any sources to change.

You can of course fork the git repo specified in the `_service` file, and make
changes as usual. But you might not want to do that.

Luckily, there is a workaround:

As branches are links, and the link concept of OBS supports patching the source
files before the build process starts through the `apply` tag of the `_link`
file, we can do some changes locally, create a patch, and add that patch to the
`_link` file.

This is prettty hard to do on the Web Interface alone, so here we assume usage of `osc`.

In this example, we assume what you want to change is the .spec file, but the
same process applies to any file in the packaging repo you can use a patch to
change.

First, create a branch on OBS as usual, and check it out

```
osc branch path:to:source:project sourcepackage
osc co home:username:branches:path:to:source:project sourcepackage
```
*(Alternatively, you can just use linking instead of branching)*

Your branched package will contain just the `_service` file, which is not very
useful if you actually want to change something in the build process (the.spec
file).

Lets change to link view in the local package:

```
osc up --unexpand-link
```

The contents of the local checkout will change to a `_link` file. Edit it and configure the `apply` tag:

```
  <apply name="spec.patch" />
```

Get a local copy of the tag_git-generated .spec file:

```
mkdir a
mkdir b
osc cat _service:tar_git:myapp.spec > a/_service:tar_git:myapp.spec
cp a/_service:tar_git:myapp.spec b/_service:tar_git:myapp.spec
```

Now, apply your changes to the file `b/_service:tar_git:myapp.spec`.

When finished, do

```
diff -u a b > spec.patch
```

Now the files are in place, and the `_link` file has been edited, lets commit:


```
osc add spec.patch
osc commit
```
*(Note we add just the spec file, and no other files.)*

OBS will now:

 1. check out the sources from the upstream repos as usual
 1. apply the path `spec.patch` to these sources
 1. Comtinue the building as usual.


