---
title: Collaborate
permalink: Develop/Collaborate/
has_children: true
layout: default
nav_order: 500
---

Sailfish OS is mainly open source and almost all development on the platform itself happens in the open on public systems. There are many ways to contribute to Sailfish OS, by reporting bugs, fixing them, implementing new features, adding new unit tests and improving documentation (on this Wiki and for programming APIs). This document will focus on providing information related to software contributions, by listing a few common development tasks, and describing in detail how to work through some scenarios.

Before starting you should familiarize with Sailfish OS [Platform Development](/Develop/Platform), which guides you through the required tools. If you are planning to develop a substantial feature it is good to contact Sailfish OS maintainers so they can review architecture and design early enough to reduce risk of uncovering fundamental issues late in review phase.

### Reporting issues

Sailfish OS has a community forum at <https://forum.sailfishos.org/> that is used to discuss on different things. On the forum we have a [separate category](https://forum.sailfishos.org/c/bug-reports/13) for bug reports.

When filing an issue, it is vital that the report contains all of the information required to reproduce the issue. A reported issue should contain only one issue. Examples of an issue reports can be found from [Issue_Report_Example](/Develop/Collaborate/Issue_Report_Example)

### Finding The Code

Please refer to [Sailfish OS Source](/Services/Development/Sailfish_OS_Source) where to find the code and what is the contribution policy.

### Building The Code And Testing Changes

You can read more information about [building a package](/Tools/Sailfish_SDK/Building_packages) and [deploying it](/Tools/Sailfish_SDK/Deploying_packages) from respective subpages. Every change must be [tested](/Develop/Apps/Testing) carefully and unit tests should be added so that the quality of the code can be easily checked and verified.

### Contributing The Change

After having a local fix for an issue, one creates a merge request and asks for a review. This section explains each of the steps in that process, and describes some potential reasons why a particular contribution may not be accepted.

#### Commit policies

There are a few policies which support the QA and integration process in Sailfish OS. Please read more about [changelog generation](/Tools/Sailfish_SDK/Building_packages#changelog-generation).

#### Creating A Merge Request

Once the contributor has finished fixing an issue, and they have tested it on their own device, they should commit their changes and push it to their personal fork or branch of the upstream repository (See contribution policy from [Sailfish OS Source](/Services/Development/Sailfish_OS_Source)), adhering to the commit policies described above.

Next one should submit a pull/merge request to the upstream repository. At this point, one should add as much information to the original bug report as possible (including a link to the merge request) so that interested people can review the change. After creating a merge request, one should contact a maintainer of the component, as the merge request might otherwise go unnoticed. See [Communicating with Developers](/Develop/Collaborate#communicating-with-developers) for hints on how to contact the maintainer.

At times one is not sure if the direction of the change is not correct and you want to get some early feedback on your changes. In such cases one should always add `WIP:` in the merge request Title so that people know that this merge request should not be handled as a final one but is an early version of it. It is a good practice to list any known issues and missing details with the implementation that can be used as check that all issues have been solved before merging the feature.

Try to avoid big merge requests. A merge request should cover one feature or a bug fix, not many. If you are new to Sailfish OS development it is anyhow better to start with small contributions like bug fixes before taking on substantial feature tasks. Also if you are planning to introduce a big change it is good to contact Jolla senior developers on IRC, through developer mailing list or raise the topic in the community collaboration meetings early to reduce risk uncovering fundamental issues late in the code review phase when much of the work has already been completed.

#### Review Feedback

Reviewers will comment on the created merge request. Common issues include:

  - code-style violations, see [coding conventions](/Develop/Apps/Coding_Conventions)
  - violating the component architecture
  - missing documentation
  - missing unit tests
  - performance regression
  - edge-case logic errors
  - missing or outdated [qmltypes files](https://doc.qt.io/qtcreator/creator-qml-modules-with-plugins.html#generating-qmltypes-files)

Every contributor and reviewer shall be polite and considerate to each other when reviewing contributions and discussing those changes, and ask contributors to understand that review comments are not intended to be a sign of lack of appreciation for the work they have done, but rather are intended to further improve the contribution by helping the original contributor in their goal of improving Sailfish OS.

Sometimes disagreement may occur between various people about what the correct behaviour should be. In those cases, the area maintainer will make a decision, after consulting the various stakeholders including community members and other contributors. In some rare cases, the maintainer may choose not to accept a contribution, either on technical (e.g., code quality) or design (e.g., user experience issues) grounds. We ask that all parties respect the decisions of the maintainers if that occurs.

When developing user-facing features, please try to follow the user interface [definition of done](/Develop/Apps/UI/Definition_of_Done) checklist. Following the checklist will make it easier for the maintainer to review the contribution, which in turn makes it faster to get it accepted. Maintainer will also contact a designer to review the contributions from the design perspective. If the contribution is based on a design, always provide a link to the design and mention the name of the designer.

#### Updating The Contribution

Usually the maintainer will want to merge the contribution after some fixes (e.g., addressing code path not covered by the original contribution) are made. Bigger feature contributions regularly go through multiple review rounds before getting accepted. To update the request the contributor should make the change and amend the original commit where possible (to avoid filling the commit history with small commits), and then update their personal fork with the amended commit. The merge request should automatically be updated, and at this point, a developer or other community member with write access to the upstream repository will be able to merge the change.

When updating the merge request clearly describe the changes that were done, for example which review findings were addressed.

### Releasing The Change

At this point, the code or documentation change have been applied to the upstream Sailfish OS repository via an accepted merge request. It will not, however, be included in a release, until a package is generated from the repository. For that to occur, the maintainer will tag the repository with the new package version tag, and a [webhook](/Services/Development/Webhooks) will automatically inform the Continuous Integration (CI) system that it needs to pull the new code, build the package, run the automated tests on it, and promote it. At that point, the original bug report should be updated with the package version which should contain the fix, future reference.

The contribution is included to the next branched release after merging the request, there is no solid ETA that can be given when the release with the contribution is released to the public.

## Contribution Example

For this example, we will consider a hypothetical bug which affects the Sailfish Browser and the contribution example is documented at [Contribution_Example](/Develop/Collaborate/Contribution_Example)

## Communicating with Developers

Developers of Sailfish OS can generally be contacted in following ways:

  - #sailfishos via oftc.net IRC
  - at <https://forum.sailfishos.org/>


Git log can be a good indication on who has been working on a component before.

## Specific Collaboration Efforts

  - [CalDAV and CardDAV Community Contributions](/Develop/Collaborate/CalDAV_and_CardDAV_Community_Contributions)
