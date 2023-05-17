---
title: Sailfish OS Source
permalink: Services/Development/Sailfish_OS_Source/
parent: Development
layout: default
nav_order: 200
---

Please see [Sailfish OS Architecture](/Reference/Architecture) for a comprehensive list of the various components which make up the Sailfish OS stack, including links to the source repositories for those components.

Here is a table that contains the information about different code locations, how to get an account and what is the contribution policy.

| Name                                                                       | Description                                                                       | How to get an account                               | How to contribute                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| -------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Sailfish OS Repositories](https://github.com/sailfishos)                  | Sailfish OS Core source code repositories                                         | Account can be created at <https://github.com/join> | Contributions done by **forking the git tree** (https://help.github.com/en/articles/fork-a-repo) and **creating a pull request** (https://help.github.com/en/articles/creating-a-pull-request-from-a-fork). <br/><br/>**NOTE:** Only repository maintainers can do pull requests from a branch of the main git tree (https://help.github.com/en/articles/creating-a-pull-request). <br/><br/>**NOTE:** For each repository git submodules must be using https urls. |
| [Sailfish OS Adaptation Repositories](https://github.com/mer-hybris)       | Hardware adaptation related git trees                                             | <center>"</center>                                  | <center>"</center>                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| [Sailfish OS Tools Repositories](https://github.com/mer-tools)             | Some tools that are useful in development and are located in separate repository | <center>"</center>                                  | <center>"</center>                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| [Sailfish OS Quality Assurance Repositories](https://github.com/mer-qa)    | Some tools that are useful in development and are located in separate repository | <center>"</center>                                  | <center>"</center>                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| [Sailfish OS CI & Build Repositories](https://github.com/MeeGoIntegration) | Tools used in the CI and build process, like OBS.                                 | <center>"</center>                                  | <center>"</center>                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| [Sailfish OS Mirror](https://github.com/sailfishos-mirror)                 | Mirrors all upstream packages which Sailfish OS uses in git modules               | <center>-</center>                                  | Contribute directly in upstream instead                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Closed git trees                                                           | There are some closed git trees for proprietary code                              | Accounts created on case by case basis              | Contributions are done with pull requests from branches. Contributor has rights to create branch that has *contribution-* prefix or company name, i.e., *companyname-* prefix                                                                                                                                                                                                                                                                                       |

Please check [contribution guidelines](/Develop/Collaborate#contributing-the-change) and [changelog generation guidelines](/Tools/Sailfish_SDK/Building_packages#changelog-generation) before actual contribution.

Release specific sourcecode drops can be found from <http://releases.sailfishos.org/sources/>

## Finding the Source for a Package

There are a variety of ways to determine the location of the source repository for a particular package:

  - search the git trees mentioned in the table above
  - search the [Core Areas and APIs](/Reference/Core_Areas_and_APIs) documentation to find the appropriate repository
  - look hints on the device, e.g.:

If you have developer mode installed, via command line you can search for more detailed information. For example searching packages by name:
```nosh
pkcon search name browser
```

Alternatively, you can utilise the `rpm` tool, combined with `grep` to query installed packages on the device:
```nosh
rpm --query --all|grep browser
```

... and after finding the package name you can get more details:
```nosh
pkcon get-details sailfish-browser
```

or
```nosh
rpm --query --info sailfish-browser
```

Same actions can be done also with zypper (zypper not included by default, and needs to be installed, with `devel-su pkcon -p install zypper`)
```nosh
devel-su zypper se browser
devel-su zypper info sailfish-browser
```

If you want to know which package a file belongs to you can check with `rpm` the package name:
```nosh
rpm -qf /etc/gps.conf
```

The other way around, to list all files a package contains, use:
```nosh
rpm --query --list sailfish-browser
```

If all other means fail and the package name is known, the contributor can search for it on an available [OBS](/Services/Development/Open_Build_Service) instance and then examine that package's `_service` file to determine the source code repository.
