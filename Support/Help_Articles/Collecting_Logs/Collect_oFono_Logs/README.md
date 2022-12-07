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

   a) OS releases up to 4.4.0: install from Jolla Store, however, this app is not compatible with Xperia 10 II or 10 III

   b) From OS release 4.5.0 onwards: install on the command line as shown below. You will need the **[developer mode](/Support/Help_Articles/Enabling_Developer_Mode/)**.
   ```
   devel-su
   ssu ar sdk
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
9. Save also the journal log to a file with the command below. If you have not enabled the **[developer mode](/Support/Help_Articles/Enabling_Developer_Mode/)** do it now.
```
devel-su; journalctl -a -b --no-tail --no-pager > journal.txt
```
Note that oFono Logger can also be used for **[fixing the settings of mobile data](https://jolla.zendesk.com/hc/en-us/articles/115011240387)**.


