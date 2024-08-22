---
title: Testing Advice
permalink: Develop/Platform/Testing_Advice/
has_children: false
parent: Platform
layout: default
nav_order: 200
---

# Testing in general

Main point of testing is to find bugs, in case bug is found the reporting of the bug is crucial. It is essential that bug report includes all the needed information, there fore bug report template has to be used and all the points needs to be filled:
```
REPRODUCIBILITY (% or how often the bug can be seen):
BUILD ID:
BUILD FLAVOR (devel/release):
HARDWARE (Jolla C, Xperia XA2, Xperia X10 II, ...):
DID IT WORK CORRECTLY IN THE PREVIOUS PUBLIC RELEASE:
DESCRIPTION:
PRECONDITIONS:
STEPS TO REPRODUCE:
1)
2) 
3) 
EXPECTED RESULT:
ACTUAL RESULT:
ADDITIONAL INFORMATION: (Please ALWAYS attach relevant data such as logs, screenshots, etc...)
SUMMARY OF SOLUTION: (After resolving this bug/task, please write a short summary on the design decisions taken, eventually, and how the solution helps to improve Sailfish OS in bigger picture. If you see it better to write the summary to a comment, please do so)
```

When evaluating the found bug it is important to make sure that the bug is valid, good way is to test if the bug is visible with another device (if available), also reference device testing gives valuable infromation. Naturally this depends on the bug type, since some bugs are random and can't be easily reproduced, some are clearly visible bugs which can be seen simply from the UI and so on.

In case bug can be reproduced easily then logs are not that crucial, since then the developer can easily also get those if the steps to reproduce are clear or sometimes logs are not simply needed if the bug is related to UI glitch etc. In case bug is hard to reproduce then it is very important to provide also logs since it might be that the bug simply can't be reproduced due to test environment etc. reasons. When providing logs it is also important either study the logs and highlight the related lines or at least inform on what time the bug orccurs so that it is easier to find the correct lines from the logs.

When providing logs at least the journal logs should be provided.
If you have not enabled the **[developer mode](/Support/Help_Articles/Enabling_Developer_Mode/)** do it now.
The following command collects the journal log and prints it out to the file "journal.txt".
```
devel-su; journalctl -a -b --no-tail --no-pager > journal.txt
```

On some areas journal logs are not enough to reveal the root cause and therefore additional logs might be needed.
More information about logs below:

# Collecting debug information
[This content is copied from forum](https://forum.sailfishos.org/t/wiki-collecting-debug-information/12751)

## Basics

* Enable developer mode
* Show failed services: `systemctl list-units --failed`
* Collect logs for a specific systemd unit `journalctl -u <unitname>`
* Follow actions of out of memory killer: `dmesg -w | egrep "lowmemorykiller|oom_reaper|^ {19}.*|Out of memory"`
* `collect-logs.zip` from [Collecting basic logs from a Sailfish device](/Support/Help_Articles/Collecting_Logs/Collect_Basic_Logs/) 

## Audio
* `systemctl status pulseaudio` and `journalctl -u pulseaudio`

## Bluetooth
* `systemctl status mpris` mpris is responsible for actions (play,pause,…)
* `systemctl status bluetooth` and `journalctl -u bluetooth`

## Android
* `systemctl status aliendalvik` and `journalctl -u aliendalvik`

## Android apps
* `/system/bin/logcat`
* On Sailfish OS 4.4.0:
    * `devel-su lxc-attach -n aliendalvik /system/bin/logcat`
* On Sailfish OS 4.5.0 onwards:
    * `devel-su appsupport-attach /system/bin/logcat`

## EMail
* [How to collect Email logs](/Support/Help_Articles/Collecting_Logs/Collect_Email_Logs/)

## Mobile Data / Calling / SMS
the logs may contain your personal data!
* logs `journalctl -u ofono`
* sms `devel-su journalctl --system -f | grep jolla-messages`

## Packages
* get installed package version `pkcon get-details <packagename>` (without the <>)


# Types of testing conducted, Schedule and milestones, Criteria for starting and ending of testing.

Type of the test cases is defined case-by-case with the developer, but usually we are using use case –type of test cases if possible. If the feature can’t be tested from the UI then the testing method is defined with the developer.

Schedule and milestones are also defined case-by-case since some features need much more testing than others and some features need specific testing environment which needs to be build by the tester before the testing can be started.

Testing is started as soon as the basic functionality of the feature is in place. Preferably before the code is merged to devel and testing will be continued when the code is in devel. 

Specific test cases needs to be agreed with the developer so that tester get all the necessary information about the functionality of the feature.

Once that information is received then the features/sub-features will be tested according the test plan. Primary location of test cases is Kiwi TCM, however information needs to be linked to Bugzilla in order to find the test plan / test cases when needed.

In addition to the feature specific test cases also test cases to test potential regression are needed.

Regression test cases needs to be identified on the areas which might be affected. Also other devices needs to be tested which doesn't even have the new tested functionality. For example adding of finger print functionality might cause regression to other device’s without the feature, since that will have some effects to device lock functionality.


## System Testing

Manual system test cases have been divided by the feature into 36 sub categories
Total number of manual system test cases is ~6000.
System test cases have been also categorized by the importance into 4 categories.
Level1: Test cases of level 1 are the most important and those test the core functionality of the feature.
Level2: Test cases of level 2 are very important and those test the basic functionality of the feature.
Level3: Test cases of level 3 are important and those test the basic functionality of the feature.
Level4: Test cases of level 4 are not so important and these tests test corner case functionality of the feature.


## Full system testing

Full system testing is testing with all the level 1, level 2, level 3 and level 4 test cases.
Full system testing gives the best test coverage and with that can be found also the minor bugs since also level 4 test cases are included.
Full system testing will take long time since one tester can run ~40 test cases/day so running of 6000 test cases will take 150 test days. This means that there needs to be 30 testers running the test in order to complete the testing in 1 week (5days).


## Feature testing

Feature testing is used to test specific feature with test cases specifically created to test the feature. Feature testing gives mainly information only about the functionality of the specific feature, however it is good to have also some test cases around the feature to make sure that the new feature hasn’t cause any regression to other areas. 

Number of test cases is defined case-by-case and a small sub-feature can be tested with relatively small number of test cases. On the other hand big and complex feature needs comprehensive testing which will require much more time.


## Sanity testing

Sanity testing is used to test release candidate’s basic functionality. It has ~50 selected test cases from the most important features.
Sanity testing is relatively fast way to get understanding of the quality of the release candidate.

# Collecting Endurance reports

Endurance report contains various resource usage graphs and metrics collected from a device.

## Build post processing tools

Post processing tools are intended for desktop Linux. Following instructions are for Fedora but you should be able find same packages for other Linux distributions.

```
git clone git@github.com:sailfishos/sp-endurance.git
cd sp-endurance/postproc-lib

# Install requirements
sudo dnf install perl-File-Basename  perl-List-MoreUtils perl-POSIX perl-IO  perl-Getopt-Long perl-blib perl-JSON
sudo dnf install perl-Inline-C perl-List-MoreUtils perl-IO-String
sudo dnf install gnuplot netpbm-progs

perl Makefile.PL
make
sudo make install

# This postproc directory is used later when creating a report
cd ../postproc
```

## Install crash reporter

Install `jolla-settings-crash-reporter` package to device. This package pulls in required dependencies and adds Settings app integration (*Crash reporter* entry). Prerequisite is that *Settings -> Developer* mode has remote connection enabled.

```
ssh defaultuser@192.168.2.15 # connect to device
devel-su
pkcon install jolla-settings-crash-reporter
exit
```

## Collect endurance data

Collect endurance report from the device (as root). You can execute the tool multiple times in different scenarios or just have a single set of endurance data.
```
ssh defaultuser@192.168.2.15 # connect to device
devel-su
/usr/libexec/endurance-collect
exit
```

Endurance data is stored to `/var/cache/core-dumps/endurance/`.

## Post processing on desktop

Change directory to the *postproc* directory if you're not yet there and copy endurance data from the device.

```
scp -r defaultuser@192.168.2.15:/var/cache/core-dumps/endurance/* .
./endurance-plot 000/ 001/ 002/
```

Above combines three different endurance data sets and generates *index.html* and various resource usage graphs. After post processing is done open *index.html* and start analysing.

```
xdg-open index.html
```

# Static code analysis with Coverity®

*(This section contains instructions applicable with Sailfish SDK 3.11 and newer)*

Coverity® is a static code analysis tool developed by the Synopsys company. It is also available through the service called [Coverity Scan](https://scan.coverity.com/), offered free of charge to open source projects.

This section describes how the Coverity Scan service can be used with Sailfish SDK for C/C++ code analysis.

Start by downloading the Linux32 version of the [Coverity Scan Build Tool](https://scan.coverity.com/download). Choose the Linux32 version no matter what your host or target platform is. Unpack the downloaded archive somewhere under your Sailfish SDK workspace (this defaults to your home directory).

Static analysis with Coverity Scan is essentially a two step process from its user point of view. First the Coverity Scan Build Tool is used to capture the source code in an intermediate format, accompanied with information on how it is built. The captured data are then submitted for the actual analysis by the Coverity Scan service.

The most convenient way to accomplish the first step is by using the `cov-build` tool, available from the `bin` subdirectory of the downloaded archive. Compared to the [alternative ways](https://sig-product-docs.synopsys.com/bundle/coverity-docs/page/coverity-analysis/topics/build_capture_for_compiled_languages.html), it works by intercepting calls to the compiler as it is invoked by the build system during a regular build process.

There is one issue with the `cov-build` tool though. It has the bad habit of polluting `stdout` with its informal messages, which prevents its use deeper in the build stack. Work this around by creating a wrapper script for `cov-build` and use this wrapper in next steps instead.

```
cat > path/to/cov-analysis-linux-2023.6.2/bin/cov-build.sh <<END
#!/bin/sh
real=${0%.sh}
exec "$real" 3>&1 >&2 --dir cov-int sh -c 'exec >&3 "$@"' - "$@"
END

chmod +x path/to/cov-analysis-linux-2023.6.2/bin/cov-build.sh
```

The wrapper redirects the `stdout` to `strerr` just in case of `cov-build` itself, preserving the `stdout` of the actual build command intact. For simplicity it also directly passes all required options to `cov-build`. Otherwise the arguments in `$@` would have to be processed by the script and those intended for `cov-build` separated from those intended for the actual build command. Here the arguments are `--dir cov-int`, instructing `cov-build` to store its outputs in the `cov-int` directory (this name is forced by the Coverity Scan service). You can add more arguments according to your needs.

Wrapped this way, `cov-build` can be used with Sailfish SDK as in the following example:

```
cd my-package
sfdk qmake
sfdk -c build-shell.args='../path/to/cov-analysis-linux-2023.6.2/bin/cov-build.sh' make
```

In this example a `qmake`-based package is used. The build steps are invoked separately in order to limit the parts of the build process that will be intercepted by `cov-build`. It is not desired to, e.g., capture sources that may get built during the "configure" phase. Just those `sfdk` invocations with `build-shell.args` set as in the example will have compiler calls intercepted by `cov-build`.

Not all packages have their RPM SPEC files in a shape that allows invoking the required build steps separately as in the example. Some random hints follows on what are the options to deal with those.

- Invoke build commands manually with `sfdk build-shell`, setting `build-shell.args` as in the above example only when desired.
- Change unconditional `./configure` invocations to `if [ ! -e .configured ]; then ./configure; touch .configured; fi` so that the configuration phase is skipped on subsequent `sfdk make` invocations.
- Combined with the previous hint, `sfdk qmake` can be used also with non-qmake based project as a trick to skip any `make` (without "q") invocation.
- The `COVERITY_LD_PRELOAD` environment variable can be test for its presence as a sign of `cov-build`-intercepted execution

After successful execution, the captured sources reside in the `cov-int` directory. Pack it into an archive and submit for analysis. The name of the directory is forced by the Coverity Scan service. The archive may be named arbitrarily.

```
tar -cjf my-package.tar.bz2 cov-int
```

More information can be found in the [manual page](https://sig-product-docs.synopsys.com/bundle/coverity-docs/page/commands/topics/cov-build.html) of `cov-build`, on the previously mentioned [download](https://scan.coverity.com/download) page of the Coverity Scan Build Tool or in the comprehensive [Coverity documentation](https://sig-product-docs.synopsys.com/bundle/coverity-docs/page/webhelp-files/help_center_start.html).
