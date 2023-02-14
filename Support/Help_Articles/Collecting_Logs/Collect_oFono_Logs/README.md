---
title: Collect oFono Logs
permalink: Support/Help_Articles/Collecting_Logs/Collect_oFono_Logs/
grand_parent: Help Articles
parent: Collecting Logs
layout: default
nav_order: 2000
---

oFono is the SailfishOS component communicating with the cellular modem of the phone. oFono provides the SailfishOS applications with the cellular services. If there are problems in getting access to the Internet over a mobile data connection, for instance, it may be good to collect some oFono logs.

Collecting oFono logs is helpful for many bugs related to voice calls, SMS and mobile data. You can use the **oFono Logger** app for collecting the logs.

1. Install oFono Logger
* Jolla devices, Xperia X and Xperia XA2: install the app from Jolla Store.
* Xperia 10, Xperia 10 II, and Xperia 10 III (64-bit devices): install the app on the command line as shown below. You will need to enable the **[Developer mode](/Support/Help_Articles/Enabling_Developer_Mode/)**.
```
devel-su
pkcon refresh
pkcon install sailfish-log-viewer-ofono
exit
```
2. Launch the app.
3. Swipe left to get to the options. All of them should be enabled by default. If not, use the pulley menu to enable all categories or select individual ones by tapping them in the list. Swipe right to save the changes.
4. Run your test case (reproduce the issue you want to get logs from).
5. Return to oFono Logger. The log is shown on the display. Scroll to the top of it.
6. Pull down and use "Save to Documents": the log file is saved to the folder ```$HOME/Documents```. Attach the file ```ofono_*.tar.gz``` file to your error report.
7. Swipe right and then left to get to the category list. Pull down to disable all.
8. Close the app. Consider removing it if you do not need it.
9. It is useful to collect the **journal** log, too. If you have not enabled the **[developer mode](/Support/Help_Articles/Enabling_Developer_Mode/)** do it now.
The following command collects the journal log and prints it out to the file "journal.txt".
```
devel-su; journalctl -a -b --no-tail --no-pager > journal.txt
```

