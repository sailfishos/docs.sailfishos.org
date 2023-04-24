---
title: Collect Camera Logs
permalink: Support/Help_Articles/Collecting_Logs/Collect_Camera_Logs/
grand_parent: Help Articles
parent: Collecting Logs
layout: default
nav_order: 650
---

# Collecting camera logs

In case you run into a problem with camera, run the command below at the Terminal as a normal user. After that use the camera application and reproduce the problem with the camera. Once you have done that you can study the log file or send it for analysis.

```
GST_DEBUG=4 jolla-camera > camera-log.txt 2>&1
```

The logs are saved into file camera-log.txt.


