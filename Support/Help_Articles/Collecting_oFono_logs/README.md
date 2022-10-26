---
title: Collecting oFono logs
permalink: Support/Help_Articles/Collecting_oFono_logs/
parent: Help Articles
layout: default
nav_order: 20
---

oFono is the SailfishOS component communicating with the cellular modem of the phone. oFono provides the SailfishOS applications with the cellular services. If there are problems in getting access to the Internet over a mobile data connection, for instance, it may be good to collect some oFono logs.

Collecting oFono logs is helpful for many bugs related to voice calls, SMS and mobile data. You can use the **oFono Logger** app for collecting the logs.

1. Install **oFono Logger** from Jolla Store.
2. Launch the app.
3. Swipe left to get to the options.
4. Pull down to enable all categories to log, or select individual ones by tapping them in the list. Swipe right.
5. Run your test case (reproduce the issue you want to get logs from).
6. Return to oFono Log app. You can see the log on the display. Scroll to the top of it.
7. Pull down "Pack and Send" and select how to send. With email your log goes easily to the predefined address (telephony expert @Jolla).
8. Instead of or in addition to step 7, pull down and use "Save to Documents": the log file is saved to $HOME/Documents . Attach the ofono_*.tar.gz file to your error report.
9. Swipe right and then left to get to the category list. Pull down to disable all.
10. Close the app. Consider removing it if you will not need it.
11. If possible, enable the developer mode and collect the journal log, too (covering what happened during step 5):
```
devel-su; journalctl -a -b --no-tail --no-pager > journal.txt
```
Note that oFono Logger can also be used for **[fixing the settings of mobile data](https://jolla.zendesk.com/hc/en-us/articles/115011240387)**.


