---
title: API Docs Contribution
permalink: Develop/Collaborate/API_Docs_Contribution/
parent: Collaborate
layout: default
nav_order: 500
---

The preferred way of writing API documentation for Qt-based APIs is with the help of the [QDoc](https://doc.qt.io/qt-5/qdoc-index.html) documentation tool. [QDoc](https://doc.qt.io/qt-5/qdoc-index.html) usage on Sailfish OS is supported with the [Sailfish QDoc template](https://sailfishos.org/develop/docs/sailfish-qdoc-template/), which comes with essential usage notes. What follows here is a collection of advanced tips, recommendations and API docs writing conventions.

### Tips on writing QDoc based documentation

#### External links to other API docs

Links to targets under other documentation projects must be realized the same way as internal links. It is not allowed to hardcode a URL to the location where the documentation is supposed to be published.

Bad example:

```
\l {https://sailfishos.org/develop/docs/foo-bar} {Foo Bar Documentation}
```

Not only that such links are not relocatable, they do not work with the offline QCH publication format.

The correct approach is to tell QDoc about the external documentation projects it should consider for link resolution. This is done with the [depends](https://doc.qt.io/qt-5/22-qdoc-configuration-generalvariables.html#depends) variable in `qdocconf`:

```
depends = foo-bar
```

After that the link can be realized simply by mentioning the target title as with internal links.

```
\l {Foo Bar Documentation}
```

If the title is not unique, it can be qualified by mentioning the other project name in square brackets.

```
\l [foo-bar] {Foo Bar Documentation}
```

It is also necessary to establish a build time dependency to the corresponding documentation package. This should go to the RPM `.spec` file:

```
BuildRequires:  foo-bar-doc
```

There is the `rpm.install.excludedocs` configuration option to `libzypp`, which is enabled by default on devices and build targets (not enabled on [OBS](/Services/Development/Open_Build_Service)). This means that when a package is built using the SDK with the default configuration, the above mentioned statement is effectively a no-op and QDoc fails to resolve external links. In order to make it more obvious, the option should be checked and warning issued on the RPM '.spec' file level. Add something like this to the `%build` section of your RPM `.spec` file:

```nosh
if grep -q '^\s*rpm.install.excludedocs\s*=\s*yes' /etc/zypp/zypp.conf; then
    echo -e "\nWARNING: rpm.install.excludedocs is set in /etc/zypp/zypp.conf" \
        "- QDoc will not be able to link foo-bar-doc!\n"
fi
```

#### External links in table of contents

Links that appear as list items on the index page are treated by QDoc as items of the table of contents. Therefore you should not list any external links as list items on the index page.

Bad example:

```
See also the related documentation:

\list
\li \l [foo-bar] {Foo Bar Documentation}
\endlist
```

Not only that listing external items in a table of contents makes little sense, there are also technical issues that makes such links unusable under the offline (QCH) documentation viewer, where the table of contents is represented as the clickable navigation tree.

#### Common issues with the QDoc configuration file (.qdocconf)

##### The 'project' variable should match the 'SAILFISH_QDOC.project' variable in the .pro file

The [project](https://doc.qt.io/qt-5/25-qdoc-configuration-derivedprojects.html#project) variable in `.qdocconf` determines the index file base name. It needs to match the output directory base name, i.e. what is assigned to the `SAILFISH_QDOC.project` qmake variable in the `.pro` file. If these two do not match, other projects are not able to refer to it with the [depends](https://doc.qt.io/qt-5/22-qdoc-configuration-generalvariables.html#depends) variable.

Provided that this is in your `.pro` file:

```
...
SAILFISH_QDOC.project = foo-bar
...
```

here is a bad example of setting `project` inside `.qdocconf`:

```
project = Foo Bar API Documentation
```

Good example:

```
project = foo-bar
```

##### The 'url' variable should point where the documentation is published

The [url](https://doc.qt.io/qt-5/25-qdoc-configuration-derivedprojects.html#url) variable is meant to point to the location where the documentation is going to be published. It is used as a base to form external links to the documentation module when it is refered by other modules.

Bad example:

```
url = https://github.com/sailfishos/foo-bar
```

Less bad example would use `https://sailfishos.org/develop/docs/foo-bar` as the URL. This would be already correct location at the time of writing this documentation, but you should also utilize the `BASE_URL` variable to enable easy relocation of the online documentation.

Good example:

```
url = $BASE_URL/foo-bar
```
