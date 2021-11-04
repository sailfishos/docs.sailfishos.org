---
title: Usage of packaging formats
permalink: Develop/Platform/Usage_of_packaging_formats/
has_children: true
parent: Platform
layout: default
nav_order: 100
---

# Upstream git with submodules

Submodules are usually sufficient in cases where we don't patch upstream a lot. Such packaging will usually contain a submodule named the same as the package **Name:** in .spec file, e.g. <https://github.com/sailfishos/crda/tree/master>

## Creation/migration to submodules packaging

If you are packaging a new upstream project (e.g. converting from dumb packaging or from scratch):
```nosh
mkdir rpm/
# Move .patch and .spec files to rpm/ from old packaging
# Ensure it does %autosetup -p1 -n %{name}-%{version}/%{name}

# Create upstream submodule, <subdir name> should match package "Name:" in .spec file
git submodule add <upstream git> <subdir name>
cd <subdir name>
git checkout <specific upstream tag or revision> # e.g. 0.1
cd ..
git add -A ; git commit -a -m "[packaging] based on upstream version 0.1"
git push # create a PR
```

## Updating to new upstream

When upstream has a version you desire to update to:

```nosh
cd <subdir name>
git fetch origin
git reset --hard 0.2 # or whichever upstream's tag you want to have
git add -A # etc.
```

  - Pros
      - only git is needed
      - easy to see and track upstream
      - separate history of own changes and packaging from upstream history
  - Cons
      - Need to modify .spec file to do building in subdir
      - Can't apply patches to upstream tree, they live as separate patches in rpm/
      - Gets easily out-of-hand as number of patches increases

# Upstream git with subtrees

Useful where there are many modifications to the upstream that are not accepted as part of the upstream (at least not yet), when it eventually becomes very tedious to version control many .patch files.

You can recognise such packaging when the submodule is called **upstream** as well as directory matching the value of **Name:** in .spec, e.g. <https://github.com/sailfishos/connman/tree/master>

## Creating subtrees packaging

When connman was packaged with subtrees, we did:
```nosh
mkdir connman; cd connman; git init
git submodule add git://git.kernel.org/pub/scm/network/connman/connman.git upstream
cd upstream

# Create a new branch based on the release tag or revision we want to package
# Using HEAD might work too if closely following upstream
git checkout 1.2 -B reference-branch
cd ..

# Commit the submodule change. This serves as a record for others as well
git commit -a -m "[import] initial import of version 1.2"

# Add the upstream submodule as a remote called upstream for easy referencing later
# Fetch it (-f) so that we can reference revisions inside it, but without tags so as not to pollute own repo
git remote add -f --no-tags upstream upstream

git branch -b reference-branch upstream/reference-branch

mkdir rpm/
cp /somewhere/with/packaging/connman.spec rpm/
# Ensure it does %autosetup -p1 -n %{name}-%{version}/%{name}

# subtree-merge the contents of the remote to a prefix, with squashing the commits
# --prefix should match package "Name:" of our .spec file
git subtree add --squash --prefix=connman upstream reference-branch

# Apply old .patch files within the subtree prefix directory (e.g. connman/)
# Commit each patch individually with nice descriptive messages as usual
# You can then delete *.patch files for good

git add -A ; git commit -a -m "[packaging] based on upstream version 1.2 and own patches"

# Add your git remote as origin

# Push it to the server for others to see
git push origin master
```

## Updating to new upstream

Can be done by updating the submodule and merging from it, to the subtree:
```nosh
cd connman/upstream
git checkout master
git pull origin master

# If the reference-branch still exists from previous operations
# it will be reset to point at the specified tag / revision.
# Using HEAD might work too if closely following upstream
git checkout -B reference-branch 1.23
cd ..

# Commit the submodule change
git commit -a -m "[packaging] update to upstream version 1.23"

# We still have a reference to our upstream remote (pointing at the upstream submodule)
git fetch -n upstream

# Merge in the changes
git subtree pull --squash --prefix=connman upstream reference-branch

# Business as usual
git push origin master
```

Our own patches in the subtree will be preserved and rebased upon; if conflicts occur user can fix them as usual.

## Split subtree and extract patches
```nosh
# Split out the subtree (--prefix=connman subdirectory) with our patches to a new branch
# Annotate is optional and can help identify own patches in the new branch when rebasing
git subtree split --prefix=connman --annotate='(sailfishos) ' -b patch-queue

# Patch-queue branch now has our patches mixed with merge commits of upstream
# Interactive rebasing can help us reorder the patches and extract them
git checkout patch-queue
git rebase -i 1.23

# Extract a nice patch list
git format-patch --no-signoff --zero-commit -N 1.23

# Diff a subtree to upstream
# git diff <upstream treeish> <branch>:<subtree prefix>
git diff reference-branch master:connman
```

Probably needs a convenience wrapper to make this stuff less typing.

  - Pros
      - Bash script, can be easily distributed modified and extended
      - All the pros of submodules +
      - Can manage patches to upstream with git
      - Patched code is in tree, is what you compile and run
      - changes are one easy pull request, nice to review
      - (to be confirmed) Can track other scm , for example svn ?
  - Cons
      - Could be annoying to have two checked out copies of the code if it is big ( but when cloning submodules are not checked out automatically and there is no need to do so unless you need the upstream tree for updating etc .. )
      - Would require modifications OBS-side to create tarball of only the patched copy and exclude the submodule (useless to have two trees in the tarball)
  - Additional info
      - Primer: <http://blogs.atlassian.com/2013/05/alternatives-to-git-submodule-git-subtree/>
      - Apparently git subtree is a bash script <https://github.com/git/git/blob/master/contrib/subtree/git-subtree.sh> and therefore can be easily modified and backported
      - Basically it is a convenience wrapper around subtree merge startegy
      - They don't track remotes by default, but can be augmented by submodules to do so
      - The upstream todo list has "to-submodule" and "from-submodule" subcommands
      - <https://hpc.uni.lu/blog/2014/understanding-git-subtree/>
