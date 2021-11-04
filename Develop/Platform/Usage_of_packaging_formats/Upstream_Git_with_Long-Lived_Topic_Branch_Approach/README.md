---
title: Upstream Git with Long-Lived Topic Branch Approach
permalink: Develop/Platform/Usage_of_packaging_formats/Upstream_Git_with_Long-Lived_Topic_Branch_Approach/
parent: Usage of packaging formats
grand_parent: Platform
layout: default
nav_order: 100
---

**Attention: Page status: DRAFT**

**tl;dr:** Simply keep our own *changes and packaging files in one topic branch* - here the topic is "Packaging for Sailfish OS". Use *common techniques* for maintaining *long-lived topic branches* in Git to synchronize with upstream.

**Pros**

  - Only Git is needed
  - Compatible with GitHub-like workflows - effective use, review friendly
  - Easy to see and track upstream
  - Separate history of own changes and packaging from upstream history
  - Can manage patches to/from upstream with Git
  - Easy to tell which changes has been cherry-picked to/from upstream
  - Clean and minimal history of own changes can be managed, similar to maintaining a set of patches, but with proper history context
  - Patched code is in tree, is what you compile and run

**Cons**

  - *Be the first to write one*

### Setting up

Start by cloning the upstream repository, using the name `upstream` to track it under Git. Add `sailfish` remote repository and set up `master` branch to track `master` branch from the `sailfish` remote repository. (Assuming `master` is the default branch.)
```nosh
git remote rename origin upstream
git remote add sailfish SAILFISH_PACKAGING_URL
git branch --set-upstream-to=sailfish/master master
```

Pick a good upstream release and push to our repository initially (still without packaging).
```nosh
git reset --hard v4.2
git push sailfish master
```

Add our packaging files, modify code, ..., push it for review.
```nosh
git checkout -b jb424242
mkdir rpm
vim rpm/PACKAGE.spec
vim src/...
git add rpm/PACKAGE.spec
git commit -m 'Add initial packaging for Sailfish OS'
git add -u src
git commit -m 'Fix this and that'
git push sailfish -u jb424242
```

Create a pull request and fill in the description in a way suitable for change log autogeneration! Example:

| Set                | To                                                                                                                                                  |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| Source branch      | jb424242                                                                                                                                            |
| Destination branch | master                                                                                                                                              |
| Title              | Add initial packaging for Sailfish OS                                                                                                               |
| Description        | Lorem ipsum dolor sit amet.<br/> <br/> [sailfish] Added initial packaging for Sailfish OS. JB#424242<br/> [sailfish] Fixed this and that. JB#424242 |

When the pull request is merged, tag it.
```nosh
git tag sailfish/4.2+git1
```

Notice the use of the `sailfish` *token* in change log entry headers and as a tag prefix to distinguish them from upstream tags and change log entries. Use the same token later when setting up a webhook for automated build trigerring!

Note: As an alternative to creating true merges for pull requests it is possible to use annotated tags to store change log entries. (Also useful to later add change log items you forgot to store in pull request's description or when the pull request was not merged in a way that preserves its description as a merge commit message.)
```nosh
git tag -a -m "[sailfish] Added initial packaging for Sailfish OS. JB#424242" sailfish/4.2+git1
```

### Updating to newer upstream

Updating to newer upstream can be done trivially with `git-merge`.
```nosh
git merge v4.3.1 --no-ff -m "[sailfish] Updated to upstream version '4.3.1'. JB#431431"
git tag sailfish/4.3.1+git1
```

Much *cleaner overview* of our own changes can be achieved with the following approach, that has effect similar to using plain `git-rebase` while preserving ancestry relation with the replaced commits (in a way understood by Git). Both approaches may be combined in one repository, using plain merge for minor upgrades and the following approach for major upgrades.
```nosh
git checkout -b jb431431 v4.3.1
git merge --strategy ours master -m "Reset master to tag 'v4.3.1'"
git checkout master
git branch -f master-archived
git rebase -i --onto jb431431 PREVIOUS_RESET_TO_UPSTREAM_COMMIT_OR_v4.3.1_IF_DOING_THIS_THE_VERY_FIRST_TIME
git push sailfish -u jb431431
```

Create a pull request and fill in the description in a way suitable for change log autogeneration! Example:

| Set                | To                                                                                                |
| ------------------ | ------------------------------------------------------------------------------------------------- |
| Source branch      | jb431431                                                                                          |
| Destination branch | master                                                                                            |
| Title              | Update to upstream version '4.3.1'                                                                |
| Description        | Lorem ipsum dolor sit amet.<br/><br/>[sailfish] Updated to upstream version '4.3.1'. JB#431431 |

When the pull request is merged, tag it.
```nosh
git tag sailfish/4.3.1+git1
```

This combines the best of `git-merge` and `git-rebase`:

1.  It automatically discards commits cherry-picked to/from upstream, resulting in a shortest possible branch tracking our own changes,
2.  It allows to manually discard/replace obsolete commits, and yet
3.  It keeps full history of our own changes much like normal `git-merge` does.

Note again that this approach can be also used as supplementary to the basic merge approach, executed every now and then, to clean up our packaging branch when it gets bloated with unnecessary commits.

### Examining history

Commands marked with **(\*)** do not work when the basic merge approach was used most recently.

See our own commits, including "archived" commits:
```nosh
gitk upstream/master..master
```

See our own commits **(\*)**:
```nosh
gitk --ancestry-path --right-only upstream/master...master
```

See our own commits where upstream does not merge everything to master:
```nosh
gitk master --not --remotes=upstream
```

See our own commits, marking those cherry-picked to/from upstream (`git-cherry` replacement) **(\*)**:
```nosh
git log --oneline --graph --ancestry-path --cherry upstream/master...master
```

See how upstream diverged, marking cherry-picked commits on both sides **(\*)**:
```nosh
git log --oneline --graph --ancestry-path --cherry-mark --boundary upstream/master...master
```

See our own commits - compared to the above command this works also when the basic merge approach was used most recently
```nosh
gitk upstream/master..master ^master^{/^Reset}
```

Example projects to try with:

  - <https://github.com/sailfish-sdk/qmllive>, branch "master"; upstream: <https://code.qt.io/qt-apps/qmllive.git>, branch "5.8"
  - <https://github.com/mer-tools/osc.git>, branch "jb36175"; upstream: <https://github.com/openSUSE/osc.git>, branch "master"
  - <https://github.com/sailfishos/pulseaudio>, branch "master"; upstream: <http://cgit.freedesktop.org/pulseaudio/pulseaudio/>, branch "master"
  - <https://github.com/sailfishos/sailfish-qtcreator>, more info on its wiki <https://github.com/sailfishos/sailfish-qtcreator/wiki>

### Rules good to follow

  - Never store messages for change log autogeneration in regular commits. Use annotated tags (ideal) and/or pull request descriptions (practical) to store these messages. There is at least one crucial and two beneficial reasons to do so:
    1.  Messages in regular commits would be duplicated in the autogenerated change log whenever updating to newer upstream with the approach described above. (Crucial)
    2.  Not putting these messages into regular commits leaves them clean for cherry-picking upstream.
    3.  Commit log and change log have different requirements:
          - Change log items are *past tense*, forming a *high level* description of *what* has been done. The target audience is *users*.
          - Commit summary messages are *present tense, imperative* style, forming a *low level* description of *how* it has been done. The target audience is *developers*.
  - Never mix in single commit changes with and without potential to be accepted by upstream.

### Annotated tags versus true merges for change log entries

  - Annotated tags
      - **Pros**
          - Can be added/amended anytime
      - **Cons**
          - Not easy to prepare them beforehand, need manual handling when merging pull requests
  - True merges
      - **Pros**
          - Work well with the workflow of GitHub and similar services
      - **Cons**
          - Cannot be amended

### Further reading

  - <https://die-antwort.eu/techblog/2016-08-git-tricks-for-maintaining-a-long-lived-fork/>
