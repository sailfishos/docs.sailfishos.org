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

When providing logs at least [journal logs](https://jolla.zendesk.com/hc/en-us/articles/202886373) should be provided.

On some areas journal logs are not enough to reveal the root cause and therefore additional logs might be needed.
More information about logs below:

# Collecting debug information
[This content is copied from forum](https://forum.sailfishos.org/t/wiki-collecting-debug-information/12751)

## Basics

* Enable developer mode
* Show failed services: `systemctl list-units --failed`
* Collect logs for a specific systemd unit `journalctl -u <unitname>`
* Follow actions of out of memory killer: `dmesg -w | egrep "lowmemorykiller|oom_reaper|^ {19}.*|Out of memory"`
* `collect-logs.zip` from [Collecting basic logs from a Sailfish device](https://jolla.zendesk.com/hc/en-us/articles/360013910599-Collecting-basic-logs-from-a-Sailfish-device) 

## Audio
* `systemctl status pulseaudio` and `journalctl -u pulseaudio`

## Bluetooth
* `systemctl status mpris` mpris is responsible for actions (play,pause,…)
* `systemctl status bluetooth` and `journalctl -u bluetooth`

## Android
* `systemctl status aliendalvik` and `journalctl -u aliendalvik`

## Android apps
* `/system/bin/logcat`
* `devel-su lxc-attach -n aliendalvik /system/bin/logcat`

## EMail
* [How to collect EMail logs](https://jolla.zendesk.com/hc/en-us/articles/201975906-How-to-collect-Email-logs-General-email-IMAP-POP-)

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





