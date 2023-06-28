---
title: Signing Packages
permalink: Develop/Apps/Packaging/Signing_Packages
parent: Packaging
grand_parent: Apps
layout: default
nav_order: 500
---

# Signing RPM packages

## Creating a key for signing

RPM packages are signed using GPG keys. In order to be able to sign RPM packages, a suitable key needs to be created. This can be done using standard `gpg` tool:

```
$ gpg --gen-key
```

The tool will ask all the necessary information. When unsure, select the default value.

### Passphrase file

If your gpg key is protected with a passphrase, you need to provide it to the sfdk tool via passphrase file. This is just a text file containing the passphrase. The permissions of the file should be 600, so that it’s not readable by anyone else. In the example below, we use a file called `passphrase.txt`, located in user's home directory. You can use a file/path of your own choosing instead.

```
$ echo “This is my passphrase” > $HOME/passphrase.txt
$ chmod 0600 $HOME/passphrase.txt
```

## Signing packages

The `sfdk` tool supports signing packages as part of the build process. First we need to configure the tool to use our key and passphrase file:

```
$ sfdk config package.signing.user=”Full Name” # replace Full Name with the name given when creating the signing key
$ sfdk config package.signing-passphrase-file=$HOME/passphrase.txt
```
Then we can build the package with the `--sign` parameter:
```
$ sfdk build --sign
```

This will result in a signed package created under the RPMS directory.

## Verifying the signature

Verifying package signature can be done with `rpm -K` command:

```
$ rpm -K RPMS/mypackage-0-1.noarch.rpm
```

A successful verification looks like this:

```
RPMS/mypackage-0-1.noarch.rpm: digests signatures OK
```

However, you will likely get `digests SIGNATURES NOT OK` when you first try it. This is because the key used for signing is not known to `rpm`. You must import the key to the rpm keyring first:

```
$ gpg --output keyfile.gpg --armor --export “Full Name”

$ rpm --import keyfile.gpg
```
