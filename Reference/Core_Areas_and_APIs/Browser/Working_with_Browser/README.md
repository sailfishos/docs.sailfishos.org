---
title: Working with Browser
permalink: Reference/Core_Areas_and_APIs/Browser/Working_with_Browser/
parent: Browser
grand_parent: Core Areas and APIs
layout: default
---

## Console API messages

  - EMBED_CONSOLE=1 environment variable be used to log messages to terminal / journal
  - Simply execute browser with EMBED_CONSOLE=1
```nosh
EMBED_CONSOLE=1 sailfish-browser
```

  - Errors in JavaScript etc are logged

## Logging

### Building with logging enabled

  - Logging is only available on development gecko builds. By default xulrunner builds as release for performance reasons.
  - To switch to a development build, append an 'a' to the 'milestone' define in the spec.
  - The lib directory will also gain the 'a'. If you don't want to rebuild the other packages to link against the new path, create a symlink to this from the normal path.

### Enabling module log output

  - Environment variable MOZ_LOG (esr52 onwards) can be used to enable various module logs
  - A comma separated list with verbosity
  - Verbosity levels are: 0 = Disabled, 1 = Error, 2 = Warnings, 3 = Info, 4 = Debug, 5 = Verbose
  - EmbedLite and EmbedLiteTrace are log components of embedlite
  - Grep is your friend when trying to find the correct module if you're not aware of those (LazyLogModule)
  - For instance "Layers" can be used to analyze problems related to composited layers
  - Example
```nosh
MOZ_LOG="AudioStream:5,MediaFormatReader:5,MediaSource:5" sailfish-browser youtube.com
```

## Debugging User-Agent problems

  - Current user-agent is "Mozilla/5.0 (Sailfish 4.0; Mobile; rv:60.0) Gecko/60.0 Firefox/60.0"
  - User-agent string can be overriden site specifically
  - Debug user agents with CUSTOM_UA environment variable
  - Input for the over the air updates is located in [browser's git repository](https://github.com/sailfishos/sailfish-browser/blob/next/data/ua-update.json.in)
  - There can be full user agents and replacements done with regular expression to fix user-agent strings
  - Example fix for [slashdot user-agent](https://github.com/sailfishos/sailfish-browser/commit/07e13bc7a7ce7028029c6333f98b8b60e6a99978)

## Debugging omni.ja of gecko
```nosh
mkdir /home/<user>/omni-mytest
cd /home/<user>/omni-mytest
cp /usr/lib/xulrunner-qt5-60.9.1/omni.ja .
unzip omni.ja
rm omni.ja

# Edit jsm or js file or copy over from your close

zip -qr9XD omni.ja *
devel-su mv omni.ja /usr/lib/xulrunner-qt5-60.9.1/

# If you need to revert omni changes just have a backup of your omni.ja or reinstall xulrunner package
```

## Partial builds

Gecko takes a long time to build, even if only a couple of source files have been modified. Luckily there is a way to build part of the tree and reconstruct a libxul.so with that, which can be done much more quickly. The new library can be copied over to a device and directly replace the installed version. The compiled library will be huge as it contains all the debug symbols, so run strip on it before you copy it over.

Enter the target:
```nosh
sb2
```

Build the new library
```nosh
source `pwd`/obj-build-mer-qt-xr/rpm-shared.env
make -j16 -C `pwd`/obj-build-mer-qt-xr/<path to rebuild>
make -j16 -C `pwd`/obj-build-mer-qt-xr/toolkit/library
strip obj-build-mer-qt-xr/toolkit/library/libxul.so
```

If you need to get stacktraces from gdb and don't mind a large transfer, you can skip the strip step. Then from outside the target:
```nosh
scp obj-build-mer-qt-xr/toolkit/library/libxul.so user@device:~
```

Then on your device, copy the new lib to `/usr/lib/xulrunner-<version>/` overwriting the previous version. Alternatively, replace the target libxul.so with a symlink to the new library in your home directory, to save having to copy it every time.
