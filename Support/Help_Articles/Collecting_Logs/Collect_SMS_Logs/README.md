---
title: Collect SMS Logs
permalink: Support/Help_Articles/Collecting_Logs/Collect_SMS_Logs/
grand_parent: Help Articles
parent: Collecting Logs
layout: default
nav_order: 3000
---

# Collecting of SMS logs
In order to find out the root cause for the SMS related problems specific SMS logs might be needed, in this article taking of SMS logs is instructed.

## Preparations
Enable the [Developer mode](/Support/Help_Articles/Enabling_Developer_Mode/) and launch Terminal app, or rather use a PC and [SSH connection](/Support/Help_Articles/SSH_and_SCP/).

* Edit journald.conf to make it collect more logs than in normal conditions, below you can find the commands. In the commands also the original journald.conf is copied in order to restore that after the logs have been taken.
	
	```
	devel-su
	cd /etc/systemd/
	cp journald.conf original-journald.conf
	vi /etc/systemd/journald.conf
	```

	* Uncomment & edit Rate* values to 0.

		* Type i for insert mode
		* Use arrow keys to move to the end of the lines having Rate* values
		* Replace both Rate* values with 0  (i.e. zero)
		* Tap 'Escape' to get back to command mode
		* Type :wq to save and exit; tap 'Enter'

	* To verify the change do:
```
cat /etc/systemd/journald.conf
```

* Reboot phone to put the changes into effect.

* Install the oFono Logger application, please check [this article](/Support/Help_Articles/Collecting_Logs/Collect_oFono_Logs/) since installation process is not the same for all the devices.


## Collecting of the logs

* Read [this article](/Support/Help_Articles/Collecting_Logs/Collect_oFono_Logs/) to learn how to collect oFono logs.
	
	* Enable all options. oFono Logger starts collecting data. Leave the app open. You can visit other apps in the meanwhile.

* Start live writing a radio log to a file:
	
	```
	cd $HOME
	devel-su
	/system/bin/logcat -b radio -v time |tee logcat.txt
	```

* Reproduce your problem scenario.  Please make note on the date & time when the issue occurs. This will help when investigating the log files.

* Stop logging.

	* Use ```ctrl-C``` at the terminal to stop collecting the radio log and to close file logcat.txt.
	* Visit oFono Logger app again and save the log as instructed in this article.

* Export journal output into a file:
	
	```
	journalctl -b -a --no-tail --no-pager > journal.txt
	```
	
* Let's package the 3 log files into a container:

	```
	tar -cvf  SMS-logs.tar logcat.txt journal.txt Documents/ofono_*.tar.gz
	chown 100000:100000 SMS-logs.tar
	```
 
* If you send the file **SMS-logs.tar** for analysis mention the exact time when the problem happened.


## Cleaning up

* Restore the changes made to the journal utility:
	
	```
	devel-su
	cd /etc/systemd/
	cp original-journald.conf journald.conf
	```

* Restart the phone and after that everything is as it was before the changes.
