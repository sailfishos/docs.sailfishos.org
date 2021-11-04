---
title: CalDAV and CardDAV Community Contributions
permalink: Develop/Collaborate/CalDAV_and_CardDAV_Community_Contributions/
parent: Collaborate
layout: default
nav_order: 200
---

During the Sailfish OS weekly community meeting on 5th September 2016, Chris Adams raised CalDAV/CardDAV contribution as a topic for the community. The response to that was fantastic, so this page was created to provide interested community members with the information they need to start contributing!

## Contribution Types

Contribution can take many forms, including:

  - providing logs of failed syncs from which bug reports can be created
  - triaging issues on [Sailfish OS Forum](https://forum.sailfishos.org/) and creating bug reports on the [forum](https://forum.sailfishos.org/)
  - providing or administering test servers which we can use in testing
  - performing ad-hoc manual testing against those test servers after each code change, to detect regressions
  - providing XML test data for unit tests (e.g., known server responses to various requests)
  - writing scripts to perform simple system tests
  - writing C++ unit tests
  - writing C++ to fix bugs
  - writing C++ to add features

### Sync Logs

The most common form of contribution is when a community member can provide detailed logs of a failed sync cycle, from which a bug report can be created and then investigated, hopefully leading to a bug-fix solution. To collect logs, follow these steps:

1.  Enable developer mode on your device
2.  Open an SSH terminal to your device, and check that `/etc/systemd/journald.conf` contains `RateLimitBurst=9000` and `RateLimitInterval=5s` to ensure that journal logs don't get truncated. If those values are different, or if those keys are commented out (prefixed by hash or semi-colon), edit the file as root (via `devel-su vi /etc/systemd/journald.conf`), save it, and then reboot your device and open an SSH terminal to it again once it has booted.
3.  Stop the sync daemon so that it can later be restarted with extra logging enabled, via `systemctl --user stop msyncd` followed by `killall msyncd`.
4.  Start the sync daemon with extra debug logging enabled, via `QTCONTACTS_SQLITE_TWCSA_TRACE=1 QTCONTACTS_SQLITE_TRACE=1 MSYNCD_LOGGING_LEVEL=8 devel-su -p msyncd`
5.  Trigger a sync cycle by opening up Settings -\> Accounts -\> Long-press the CalDAV/CardDAV account -\> Sync.
6.  Wait for 30 seconds or until the sync cycle has completed. The logs collected from the msyncd terminal (including verbose output from the CalDAV or CardDAV plugin) will be useful to track down the cause of the problem.

Logs can be sent to chris dot adams at jolla dot com or you can create a bug report about the issue on the [Sailfish OS Forum](https://forum.sailfishos.org/). Please ensure that you redact any personal information (usernames, passwords, phone numbers, addresses, or other sensitive personal information) before sending the logs or posting them to the [Sailfish OS Forum](https://forum.sailfishos.org/).

### Quality Assurance Improvements

The single most important step to progressing the CalDAV and CardDAV plugins beyond "experimental" stage is improved quality assurance capability.

This includes getting access to servers running different CalDAV/CardDAV services against which we can run tests, adding unit tests to test specific aspects of the plugins (especially the code which parses the responses received from the remote server), and adding system test automation for end-to-end sanity checking.

#### Test Servers

Internally, we only regularly test against Fruux, Memotoo and Yahoo CalDAV/CardDAV accounts.

We would like to expand this to include OwnCloud, Synology, COZY, Baikal, and Radicale, plus any other services which can be hosted in the Sailfish OS infrastructure. (We want to host the services in the Sailfish OS infrastructure so that we have full control over the availability and provisioning of the services, and so that we can in the future include the services into the automated continuous integration / quality gating processes.)

Update: we now have a variety of test servers hosted on a VM in the Sailfish OS infra - more details about these test server instances can be found in an upcoming section!

If you are willing to add more test services to the Sailfish OS infra, please read the section below on adding new test servers, and get in contact with us :-)

#### Unit Test Improvements

Currently, unit tests are limited or non-existent for the CalDAV and CardDAV plugins.

Note that unit tests for parsing iCal/vCard data do exist, but are separate to the plugins.

iCal parsing is done via KCal's iCalFormat, and vCard parsing is done via QtPIM's QtVersitReader.

Some high-value code to unit test includes the ReplyParser class' functions in the CardDAV plugin. See <https://github.com/sailfishos/buteo-sync-plugin-carddav/blob/master/src/replyparser.cpp> Those functions are const, and basically we should be able to easily test that each function produces the expected output for each case in a given set of inputs (XML data).

The CalDAV plugin unfortunately isn't as nicely separated or functional as the CardDAV plugin, so unit testing it will be trickier unless someone refactors the code somewhat. Most of the work is done in NotebookSyncAgent::processETags(), perhaps this can be split into multiple functions which are more amenable to unit testing? See <https://github.com/sailfishos/buteo-sync-plugin-caldav/blob/master/src/notebooksyncagent.cpp#L362>

#### Unit Test Data

To implement the unit tests, we need a variety of test data from different servers, which we can then add to the unit tests.

E.g., the XML response returned by an OwnCloud/Radicale/Synology/etc server to the REPORT request, or to a successful POST upsync, etc.

Once we have a variety of these XML blobs, then we can write unit tests to ensure that the plugin code will parse them correctly and produce the correct output.

#### System Test Improvements

Currently, our system tests are manual system tests, and consist of:

1.  testing that an account of each type can be added
2.  testing that a variety of sync functionality works (including: retrieving remote data; modifying data both remotely and locally and ensuring that the changes are synchronised; deleting data both remotely and locally and ensuring that those changes are syncrhonised)
3.  testing that when the account is removed, the associated data is removed from the device

It would be good if we could automate (2) with any test servers which we get access to as part of this effort.

Some of the simpler system tests can be done via pure scripting (e.g., ensure simple down-sync works via: rm -rf Calendar database, trigger downsync via dbus-send, compare icalconverter output to expected output), while others might require writing some C++ code (to test modification upsync/downsync results).

### Bug Fixes and Feature Contributions

There are a variety of known issues which are negatively impacting users. These can be seen by looking at:

  - <https://bugs.merproject.org/buglist.cgi?quicksearch=caldav>
  - <https://bugs.merproject.org/buglist.cgi?quicksearch=carddav>

Many of these are relatively simple, and have clear pathway for resolution. For example, MER#1647 and MER#1625 are good examples of this type of straightforward task.

Some of these are more complex, and may require more thought and considerable work to fix properly. For example, MER#1569 is one such issue which may not have any simple fix.

Aside from bug-fixes, there are several features which would be nice to support, including adding calendar discovery to CalDAV (currently, that is done at account creation time, by code from jolla-settings-accounts, rather than by the CalDAV plugin), and falling back to per-event synchronisation if the mass-sync cycle fails for some reason isolated to an individual event.

## Contribution Process

The process for contribution will depend on the type of contribution being made. If the contribution is something which should be added to the source-code repository (including test data, unit tests, source code modifications, packaging fixes etc), then we will follow the [Collaborative Development](/Develop/Collaborate) process. In summary, that involves:

  - Creating a bug report on [Sailfish OS Forum](https://forum.sailfishos.org/) against the buteo-sync-plugins-caldav or buteo-sync-plugins-carddav component, if one doesn't exist for the task
  - Commenting on it to say that you are working on the task
  - Create a fork of the repository on the Sailfish OS GitHub
  - Modify the code in a local clone of your forked repository, create a commit locally, push to your forked repository (note, commit title should be: `[buteo-sync-plugin-caldav] This commit adds feature ABC. Contributes to MER#XYZ`)
  - Create a merge request from your fork to the mainline master branch
  - Add a comment on the bug report pointing to the merge request
  - Ping chriadam in IRC to request review or feedback

For other forms of contribution (e.g., administering the test server instances) we will need to discuss how to arrange that, perhaps in a meeting on IRC since synchronous discussion would be helpful.

## Communication Channels

Most communication should occur on the [Sailfish OS Forum](https://forum.sailfishos.org/) and [Sailfish OS GitHub](https://github.com/sailfishos).

If you are working on a bug, please comment on it to say that you're investigating. If you subsequently stop working on the bug (e.g. because you don't have enough free time) please comment on the bug so that someone else might be more likely to take it.

If you have a WIP patch, please add a comment to the bug which links to your branch which contains the patch, so that other community members can test it and provide feedback.

Feel free to email chris dot adams at jolla dot com if you have any questions or would like some help, or ping chriadam in the #sailfishos channel on oftc.net IRC.

### Meetings

Because these meetings are likely to be detail-oriented and maybe time consuming with lengthy discussion of specific tasks, we will have a monthly meeting which is separate to the Sailfish OS Community Meeting (but Chris will give a quick status update / summary to each Sailfish OS Community Meeting, also).

The current plan is to meet on the second Monday of each month, at 0900 UTC. The first meeting will be on Monday 12th September 2016, then on Monday 10th October 2016, and so forth. The meetings will be held in #sailfishos-meeting on oftc.net IRC, and chaired by chriadam, who will attach minutes from each meeting here. If you have any specific agenda items to add to a meeting, please ping or email Chris.

#### 12/09/2016 Meeting

Agenda:

  - Introductions
  - Test Servers - The Plan
  - Simple System Test Scripts - Any Volunteers?
  - Any Volunteers For MER#1623 ?
  - Any Volunteers For MER#1647 ?
  - SDK Issues - Roadmap For Better Platform SDK (October)

Minutes / Log:

  - <http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-09-12-09.04.html>
  - <http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-09-12-09.04.log.html>

Summary:

  - Early next week (tentatively 20th September) will have discussion on IRC with lbt/chriadam/occirol/dr_gogeta86 regarding test server instances
  - Goal is that by the end of September we will have the first test server instance (OwnCloud or NextCloud) set up, with more to follow after that
  - elfio will write a simple system test script to automate basic sanity check (does downsync work) once the test server instance is available
  - dcaliste will take MER#1623
  - William___ will take MER#1647
  - An update Platform SDK is in the works, but the Application SDK can also be used for development. Instructions will be in this page soon!
  - chriadam to write a basic unit (QtTest) test for CardDAV which will allow community members to extend / add self-contained unit tests easily

Once we have the test server instances set up, we will have more concrete tasks for people who are willing to contribute. Hopefully we can assign those tasks during the next meeting (on the 10th of October).

#### 19/09/2016 Test Server Meeting

One of the tracks started from the first meeting was the action to set up test server instances. This involves collaboration between community members occirol and dr_gogeta86 and Mer infrastructure engineers lbt and LarstiQ. Weekly meetings have been organised to track this activity and ensure it progresses. The bug to track this activity is [MER#1659](https://bugs.merproject.org/show_bug.cgi?id=1659). The kickoff meeting for this activity was on 19/09/2016.

  - Minutes for this meeting can be found [here](http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-09-19-09.00.log.html).

#### 26/09/2016 Test Server Meeting

LarstiQ is working on access enablers (VPN etc) and has something working. Next step is to spin up an actual VM, and allow community members to access it via the VPN. Goal is to have that up by the next meeting on the 3rd of October.

  - Minutes for this meeting can be found [here](http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-09-26-09.01.log.html).

#### 03/10/2016 Test Server Meeting

David has a created a test server VM (called tstsrv) on the Mer Infra. It's not yet exposed to external connections, that the next step. LarstiQ suggested that dr_gogeta86 look into <https://github.com/docker-library/owncloud> before next meeting.

  - No MerBot meeting minutes since Chris completely forgot to attend the meeting, due to public holiday in Australia.

#### 10/10/2016 Meeting

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting (Progress on CardDAV unit test framework (chriadam), Progress on MER#1623 and MER#1646 (dcaliste), Progress on MER#1647 (William___), Other bugs in-progress / resolved since last meeting (MER#1664, MER#1665, MER#1657))
  - Test Servers - Current Status and Tasks
  - Manual Testing - Any Volunteers ?
  - Triaging TJC + creating MER# bug reports - Any Volunteers?
  - Any Volunteers For MER#1606 ? <https://bugs.merproject.org/show_bug.cgi?id=1606>
  - Any Volunteers For MER#1625 ? <https://bugs.merproject.org/show_bug.cgi?id=1625>

Log of the meeting can be found here:

  - [Meeting log](http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-10-10-09.01.log.html)

#### 17/10/2016 Test Server Meeting

A VM has been set up in the infra, and there exists some LDAP integration now. Next step is to set up the firewall rules / isolation, and then the VM will be able to be logged into by community-admins (once they ask lbt to create them an account). Plan is to have the firewall done, so that community members dr_gogeta and occirol can work with lbt to create accounts next Monday. After that, they can install the docker image which provides the CalDAV/CardDAV service.

  - Minutes for this meeting can be found [here](http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-10-17-09.06.log.html).

#### 24/10/2016 Test Server Meeting

A VM has been set up in the infra, and there exists some LDAP integration, the firewall rules / isolation has been completed, and then the VM is able to be logged into by community-admins (once they ask lbt to create them an account). dr_gogeta has created a docker-compose environment which includes a variety of popular CalDAV and CardDAV services, and he will bring that one up on the VM this week. If you wish to help with the effort (e.g., to add more services to the VM image) please create a Mer account (e.g., bugs.merproject.org) and then send a Mer-specific SSH key to lbt (for details, please see the log below)!

  - Minutes for this meeting can be found [here](http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-10-24-09.23.log.html).

#### 30/10/2016 Test Server Meeting

A docker compose environment has been set up on the VM in the Mer infrastructure which has a variety of CalDAV and CardDAV services installed on it. There is currently an issue with DNS and firewall config which still needs to be resolved, before they can be used for testing. In the meantime, Chris will create a script to delete all data from a given server, to allow automating test cycles. We also need clear step-by-step instructions on how to add new services to the docker environment (and how to expose it externally so that it may be tested against) from dr_gogeta86 and larstiq.

  - Minutes for this meeting can be found [here](http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-10-31-10.05.log.html).

This was the final test-server meeting, as during the next week all remaining issues were resolved, and the test services became available for use and testing! Subsequent information about the test servers and provisioning will be discussed at the normal monthly meetings. Huge thanks to lbt, larstiq, and dr_gogeta86 for their fantastic work to get the services running!

#### 07/11/2016 Meeting

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - Test Servers - Current Status And Tasks
  - Script to clean the server content via curl PROPFIND+DELETE
  - Manual Testing - Any Volunteers?
  - Any Volunteers For MER#1625 ? <https://bugs.merproject.org/show_bug.cgi?id=1625>
  - Any Volunteers For MER#1689 ? <https://bugs.merproject.org/show_bug.cgi?id=1689>
  - Any Volunteers For MER#1569 ? <https://bugs.merproject.org/show_bug.cgi?id=1569>
  - Any Volunteers For MER#1568 ? <https://bugs.merproject.org/show_bug.cgi?id=1568>
  - Any Volunteers For MER#1647 ? <https://bugs.merproject.org/show_bug.cgi?id=1647>

Minutes and Meeting Log:

  - [Minutes](http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-11-07-09.01.html)
  - [Log](http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-11-07-09.01.log.html)

#### 05/12/2016 Meeting

This meeting will be held at 0830 UTC instead of 0900 UTC as the Sailfish OS Community Meeting will be held at 0900.

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - Manual Testing + Test Scripts - Any Volunteers?
  - Any Volunteers For MER#1711 - multiple BDAY fields in vCard can cause sync to fail
  - Any Volunteers For MER#1606 - incorrect formatted BDAY field in vCard can cause sync to fail
  - Any Volunteers For MER#1714 - phone number fields have ISDN type appended during CardDAV sync
  - Any Volunteers For MER#1689 - captive portal (wifi gateway) can cause failure reported as authentication issue
  - Any Volunteers For MER#1500 - double percent-encoding issues with caldav calendar resources
  - Any Volunteers For MER#1569 - event occurrences shared between calendars don't work if parent series not also shared
  - Discussion about MER#1646 - dcaliste has a unit test which I believe shows this problem, and he had some proposed solutions
  - Discussion about WebCal subscriptions (iOS feature?)
  - Any Other Business?

Minutes and Meeting Log:

  - [Minutes](http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-12-05-08.31.html)
  - [Log](http://merproject.org/meetings/mer-meeting/2016/mer-meeting.2016-12-05-08.31.log.html)

Next meeting will be held on the 6th of February 2017 at 0900 UTC, since chriadam is on holidays during first half of January.

#### 06/02/2017 Meeting

The first Sailfish OS CalDAV and CardDAV Contributors Meeting of 2017 will be held at 0900 on Monday the 6th of February!

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - Manual Testing + Test Scripts - Any Volunteers?
  - Any Volunteers For MER#1714 - phone number fields have ISDN type appended during CardDAV sync
  - Any Volunteers For MER#1689 - captive portal (wifi gateway) can cause failure reported as authentication issue
  - Any Volunteers For MER#1624 - fall back to fully-specified calendar path without discovery support
  - Any Volunteers For MER#1719 - provide information about WebCAL subscription requirements
  - Any Other Business?

Minutes and Meeting Log:

  - [Minutes](http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-02-06-09.00.html)
  - [Log](http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-02-06-09.00.log.html)

Next meeting will be held on the 13th of March 2017 at 0900 UTC.

#### 13/03/2017 Meeting

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - Outstanding reviews and next steps
  - Current high-priority tasks
  - Any Other Business?

Minutes and Meeting Log:

  - Minutes: <http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-03-13-09.01.html>
  - Log: <http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-03-13-09.01.log.html>

Summary:

1.  Reviews appreciated on the three outstanding PRs (MER#1751, MER#1727, MER#1646). chriadam will merge the first two soon.
2.  dcaliste to look into adding a unit test for MER#1646. chriadam to build a package based on (rebased) 1646 PR, and ask on TJC for testers to help test.
3.  chriadam to look into nginx filter rules to allow reproing MER#1624 (but may not get a chance for a couple of weeks, probably)
4.  Raise TODOs and other feature support investigations at the next meeting
5.  New contributors: MER#1751 has a couple of open issues remaining, and one of those would be very suitable for a new contributor to investigate - ping me if you would like to get involved with development :-)
6.  Ijo to continue triaging TJC especially once 2.1.0 is released with the fix for for the "upsync fails" issue which was partially tracked by MER#1699.
7.  See if dcaliste can reproduce the original "calendars lost" issue from MER#1699 again after patch and report.

Next meeting to be held at 0900 UTC on either the 3rd or 10th of April (TBA).

#### 03/04/2017 Meeting

Date and time to be finalised yet, depending on when the Sailfish OS Community Meeting is held, either 3rd April 0900 UTC or 10th April 0900 UTC.

As agreed during last meeting, we should raise the topic of new features (TODOs etc) investigation.

Update: Cancelled due to lack of time on my behalf.

#### 08/05/2017 Meeting

Meeting will be 08/05/2017 (previously advertised as 01/05/2017 but that is Vappu / May Day holiday, so postponing until the 8th at 0900 UTC).

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - MER#1751 - based on testing from community members, will merge this one ASAP
  - MER#1714 - isdn field added to phone numbers on upsync (investigation required)
  - MER#1773 - upsynced all-day event can change time (investigation required)
  - Any Other Business?

Minutes and Meeting Log:

  - [Log](http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-05-08-09.00.log.html)

Summary:

  - The fixes for the various CalDAV issues were merged and released for upgrade-2.1.0 seem to have resolved most issues! Thanks Damien!
  - Chris will merge the fix for the first part of MER#1751. Help testing the packages would be greatly appreciated.
  - The remaining issues in MER#1751 are not yet addressed; good task for new community contributor.
  - Community help to investigate MER#1714 and MER#1773 would be appreciated.
  - Next meeting planned for Monday June 5th at 0900 UTC.

#### 05/06/2017 Meeting

Meeting will be on Monday the 5th of June at 0900 UTC.

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - JB#38601 - CalDAV plugin fails during sync of some "broken" events, resulting in duplications.
  - MER#1714 - isdn field added to phone numbers on upsync (investigation required)
  - MER#1751 - main issue resolved, but some minor tasks here remain.
  - Any Other Business?

Minutes and meeting log:

  - [Log](http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-06-05-09.00.log.html)

Summary:

  - Major issue outstanding: JB#38601 - Chris to continue investigation with abranson and guhl
  - Open tasks: MER#1751 and MER#1714 - please get in touch if you'd like to help investigate these

#### 03/07/2017 Meeting

Meeting will be on Monday the 3rd of July at 0900 UTC.

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - JB#38601 - CalDAV plugin fails during sync of some "broken" events, resulting in duplications.
  - MER#1796 - local modification being reported erroneously to calendar events
  - MER#1714 - isdn field added to phone numbers on upsync (investigation required)
  - MER#1751 - main issue resolved, but some minor tasks here remain.
  - Any Other Business?

Minutes and meeting log:

  - [Log](http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-07-03-09.01.log.html)

Summary:

  - chriadam will merge the PR for JB#38601 and attempt to get it released in upgrade-2.1.1
  - chriadam will investigate MER#1796 over the next couple of weeks when time permits
  - There are a couple of tasks open which are suitable for new contributors - please get in touch if you'd like to help!

Next meeting is tentatively planned for Monday the 7th of August at 0900 UTC.

#### 07/08/2017 Meeting

Meeting will be on Monday the 7th of August at 0900 UTC.

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - MER#1796 - local modification being reported erroneously to calendar events
  - MER#1714 - isdn field added to phone numbers on upsync (investigation required)
  - MER#1751 - main issue resolved, but some minor tasks here remain.
  - Any Other Business?

Minutes and meeting log:

  - [Log](http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-08-07-09.00.log.html)

Summary:

  - chriadam hasn't been able to spend much time on CalDAV/CardDAV during last month unfortunately
  - dcaliste has some changes to make to icalconverter, and will investigate alarm/reminders if he gets time
  - there are a couple of low-priority, simple tasks which are open, good for new contributors to help with if anyone is interested!

Next meeting is tentatively planned for Monday the 4th of September at 0900 UTC.

#### 04/09/2017 Meeting

Meeting will be on Monday the 4th of September at 0900 UTC.

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - MER#1699/MER#1805 - clean sync causing unavailable data
  - MER#1796 - local modification being reported erroneously to calendar events
  - MER#1714 - isdn field added to phone numbers on upsync (investigation required)
  - MER#1751 - main issue resolved, but some minor tasks here remain.
  - Any Other Business?

Minutes and meeting log:

  - [Log](http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-09-04-09.00.log.html)

Summary:

  - chriadam hasn't been able to spend much time on CalDAV/CardDAV during last month unfortunately
  - there are a couple of low-priority, simple tasks which are open, good for new contributors to help with if anyone is interested!
  - dcaliste has done a lot of good work and there are a variety of PRs open which Chris needs to test/review/merge/tag [editor's note: PRs lost during git migration]:

<!-- end list -->

1.  git.sailfishos.org/mer-core/nemo-qml-plugin-calendar/merge_requests/16
2.  git.sailfishos.org/mer-core/buteo-syncfw/merge_requests/16/diffs
3.  git.sailfishos.org/mer-core/buteo-sync-plugin-caldav/merge_requests/21/diffs
4.  (Pending some review fixes) git.sailfishos.org/mer-core/buteo-sync-plugin-caldav/merge_requests/22/diffs

Next meeting is tentatively planned for Monday the 2nd of October at 0900 UTC.

#### 02/10/2017 Meeting

Meeting will be on Monday the 2nd of October at 0900 UTC.

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - Support for Todo instances (storage + sync + UI), discussion
  - MER#1714 - isdn field added to phone numbers on upsync (investigation required)
  - MER#1751 - main issue resolved, but some minor tasks here remain.
  - Any Other Business?

Minutes and meeting log:

  - [Log](http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-10-02-09.00.log.html)

Summary:

  - dcaliste has a variety of MRs which need to be reviewed, tested, merged.
  - pvuorela to review those two MRs #25 and #23
  - chriadam to merge those, produce test packages, ask for help testing on TJC
  - chriadam and dcaliste to review rubdos' MR on n-q-p-c
  - dcaliste will investigate caldav plugin sync support for VTODO incidences
  - chriadam and pvuorela to review the other MER#1796 exdate + alarm PRs in caldav+kcalcore
  - chriadam to discuss the buteo success/failure log issue with design. Translated strings from plugins = either need to dynamically load plugin-provided translation catalogues, or allow non-translated strings in log (UI?), or?

The next meeting will be held on Monday the 13th of November at 0900 UTC.

#### 13/11/2017 Meeting

This meeting was originally planned for Monday the 6th of November however had to be postponed since Chris is unavailable then. So, new meeting time is 0900 UTC on Monday the 13th of November.

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - MER#1836 - Reminders/alarms for synced all-day events don't work
  - MER#1827 - Thunderbird reminders are triggered again after upsync
  - MER#1714 - isdn field added to phone numbers on upsync (investigation required)
  - MER#1751 - main issue resolved, but some minor tasks here remain.
  - Any Other Business?

Minutes and meeting log:

  - [Log](http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-11-13-09.00.log.html)

Summary:

  - CI/Infra issues recently, chriadam needs to check what got promoted and potentially retrigger builds
  - A variety of PRs from dcaliste need to be reviewed and merged
  - chriadam to investigate MER#1822

Next meeting will be held on Monday the 4th of December at 0900 UTC.

#### 11/12/2017 Meeting

This meeting was originally planned to be held at 0900 UTC on Monday the 4th of December, but was postponed until Monday the 11th of December due to Chris being unavailable on the 4th.

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - WebDAV sync discussion and next steps (mer:contrib OBS)
  - Any Other Business?

Minutes and meeting log:

  - [Log](http://merproject.org/meetings/mer-meeting/2017/mer-meeting.2017-12-11-09.00.log.html)

Summary:

  - chriadam still struggling with ongoing connectivity issues due to ISP infrastructure problems...
  - chriadam to merge dcaliste's 2 PRs in caldav once they've been rebased
  - chriadam to merge dcaliste's PR in mkcal if pvuorela has no comments on it
  - chriadam to check if dcaliste's buteo-syncfw change (removing API) causes issues with internal code
  - chriadam to create test .rpms from caldav + mkcal + buteo-syncfw, and post to TJC
  - abranson to ask IT to create a mer:contrib OBS project, and give abranson admin rights
  - abranson to create a buteo-sync-plugin-webdav package within that mer:contrib project to build that one
  - once that's building, chriadam to add appropriate UI side code in accounts settings (ETA: next year)

Next meeting: 0800 UTC on the first Monday in February (not January, due to vacations).

#### 05/02/2018 Meeting

This meeting will be held at 0800 UTC on Monday the 5th of February, 2018

Agenda:

  - Introductions
  - Follow-up Agenda Items From Last Meeting
  - Open MER bugs
  - Issues noted from TJC (birthday format, double slash in path, ...)
  - Is the workaround still required to build with the Application SDK (martyone said it should be fixed / no longer necessary)
  - Any Other Business?

Minutes and meeting log:

  - [Log](http://merproject.org/meetings/mer-meeting/2018/mer-meeting.2018-02-05-08.00.log.html)

Summary:

  - chriadam to create bugs for the two TJC issues mentioned in the log
  - chriadam or a new contributor to fix those two issues (see hints in the log)
  - dcaliste will investigate the mailfence caldav log from TJC
  - chriadam to take a look at the webdav sync stuff from dcaliste from mer:contrib, begin implementing UI bits
  - dcaliste will test the application SDK build artifact permission bits, chriadam to update this page if workaround is no longer required
  - abranson will consider the email chriadam sent and come up with plan for community contribution to QtContacts upgrade task
  - dcaliste continue work on refactoring caldav ICS handling and plugin cleanup
  - dcaliste to make PR for fix regarding issue sending modifications to a recurring event

#### 05/03/2018 Meeting

This meeting will be held at 0800 UTC on Monday the 5th of March, 2018.

This meeting was cancelled due to Chris being ill, and not having progressed tasks yet.

The next meeting will be held on Tuesday the 10th of April of 2018 at 0800 UTC.

#### 10/04/2018 Meeting

This meeting will be held at 0800 UTC on Tuesday the 10th of April, 2018.

This meeting was cancelled due to Chris not having progressed tasks yet.

The next meeting will be held on Monday the 7th of May of 2018 at 0800 UTC.

#### 07/05/2018 Meeting

This meeting will be held at 0800 UTC on Monday the 7th of May, 2018.

This meeting was cancelled due to public holiday in Australia on this date, and Chris not having progressed tasks yet.

The next meeting will be held on Monday the 4th of June of 2018 at 0800 UTC.

#### 04/06/2018 Meeting

Meetings have been suspended as there are currently no internal resources (development time) able to be spent on this domain. Meetings will resume once internal prioritisation changes to allow work to continue on this domain. Huge thanks to everyone (especially dcaliste) for their help and contributions so far, and I look forward to continuing to work closely with everyone into the future, once the resourcing situation changes.

## CalDAV/CardDAV Test Services

Thanks to dr_gogeta86, lbt and larstiq, we have test server instances! Currently, a variety of versions of OwnCloud are included, and also COZY. The plan is to add more services over time. If you are able to help in this regard, that would be greatly appreciated!

To play with the test services at home, grab [editor's note: user's repo unavailable after gitlab->github migration] git.sailfishos.org/dr_gogeta86/caldav-test-farm and run "docker-compose up"!

### Adding A New Service

  - locally clone the [editor's note: user's repo unavailable after gitlab->github migration] git.sailfishos.org/dr_gogeta86/caldav-test-farm docker environment
  - find the target on docker hub (e.g., for radicale, <https://hub.docker.com/r/sherter/radicale/>)
  - the docker file will be located within that repository (e.g., <https://hub.docker.com/r/sherter/radicale/~/dockerfile/>)
  - that file declares what needs to be installed into the docker container, and how to expose the service on a given port (e.g. EXPOSE "5232")
  - add it into the main caldav-test-farm docker file by adding a new service whose image points to that image on docker hub
  - test the new service works on your local host, by doing "docker-compose up" and interacting with the containerised service on your local machine
  - once it works, submit a Merge Request on Sailfish OS github so that it can be included

So, for example, see the COZY service declared at [editor's note: user's repo unavailable after gitlab->github migration] git.sailfishos.org/dr_gogeta86/caldav-test-farm/blob/master/docker-compose.yml#L52 - it has an "image: cozy/full" declaration, which is a reference to "<https://hub.docker.com/r/cozy/full/>" docker image.

### Performing Manual Tests With The Test Services

1.  Before running a series of manual tests, ensure that the service against which you're testing isn't currently being used for testing by someone else, by pinging on OFTC IRC in #mer or #sailfishos channels, otherwise your tests may conflict (e.g. if both people add a single calendar event, and then read the data back from the server, each person will get two events returned).
2.  Reset the service back to its original state using the reset script (note: chriadam is writing this script, currently unavailable)
3.  If your manual test requires a specific starting-state, run the appropriate provisioning script for your test
4.  Run your set of manual tests.

For example, one such set of manual tests might be:

  - add the account on your device
  - add a calendar event
  - trigger a sync
  - check that the event was upsynced to the server via the web-ui
  - modify that event on the server via the web-ui and then add a new event on the server via the web-ui
  - trigger a sync,
  - check that the remote modification + addition was downsynced to the device
  - delete an event on the device
  - delete an event on the server via the web-ui
  - trigger a sync
  - check that the both events are deleted from both the server and the client

The username and password for all test services are testuser/testpass, and currently available services include:

  - OwnCloud 8.1 @ <http://8.1.tst.merproject.org>
  - OwnCloud 8.2 @ <http://8.2.tst.merproject.org>
  - OwnCloud 9.0 @ <http://9.0.tst.merproject.org>
  - OwnCloud 9.1 @ <http://9.1.tst.merproject.org>

### Performing Automatic System Tests With The Test Services

elfio is currently writing a simple system test script to automate some simple manual test sets. The goal is to eventually be able to simply run the script to perform a simple, repeatable acceptance test for a given change. More information about this to come.

### Test Tools

chriadam has written a test tool which can automate a variety of simple tasks. It is called cdavtool and it is located in the carddav repository: <https://github.com/sailfishos/buteo-sync-plugin-carddav/tree/master/tools/cdavtool>

Aside from that you can use curl to perform a variety of simple tests. Some examples include:
```nosh
// get all contact etags for the addressbook
curl -X PROPFIND -u "testuser:testpass" -H "Content-Type: text/xml" -H "Depth: 1" --data "<d:propfind xmlns:d=\"DAV:\"><d:prop><d:getetag /></d:prop></d:propfind>" "http://9.1.tst.merproject.org/remote.php/dav/addressbooks/users/testuser/contacts/" --insecure --verbose

// get all contact data for the specified contact
curl -X REPORT -u "testuser:testpass" -H "Content-Type: text/xml" -H "Depth: 1" --data "<card:addressbook-multiget xmlns:d=\"DAV:\" xmlns:card=\"urn:ietf:params:xml:ns:carddav\"><d:prop><d:getetag /><card:address-data /></d:prop><d:href>/remote.php/dav/addressbooks/users/testuser/contacts/476a1388-598b-4abb-af39-3cff913bb127.vcf</d:href></card:addressbook-multiget>" "http://9.1.tst.merproject.org/remote.php/dav/addressbooks/users/testuser/contacts/" --insecure --verbose

// update the contact directly but updating its vCard data
curl -X PUT -u "testuser:testpass" -H "Content-Type: text/vcard; charset=utf-8" -H "If-Match: current_etag_value" --data-binary @updated_vcard.vcf "http://9.1.tst.merproject.org/remote.php/dav/addressbooks/users/testuser/contacts/476a1388-598b-4abb-af39-3cff913bb127.vcf" --insecure --verbose
```

## Development With The Sailfish SDK

Huge thanks to Damien Caliste for providing the following instructions!

### Building The Plugin

This is a step by step procedure to compile the CalDAV Buteo plugin using the Sailfish SDK. In the following procedure, the local copy of the code to compile is assumed to to be located in $HOME/development/, and the SDK is installed in $HOME/SailfishSDK/.

  - clone the git repository locally
```nosh
cd $HOME/development
git clone https://github.com/sailfishos/buteo-sync-plugin-caldav
```

  - build the plugin with:
```nosh
cd ~/share/development/buteo-sync-plugin-caldav/
sfdk config target=SailfishOS-2.1.3.7-armv7hl
sfdk build
```

The version of the SDK target will change as the SDK is upgraded (use `sfdk tools list` to see the versions installed under your SDK). The `sfdk` tool will automatically download any required dependencies to build the package. The build is done for deployment on the device (hence the armv7hl target). For an installation in the virtual machine itself, if necessary, an i486 target should be used instead. You can also use the `--enable-debug` flag after `build` to generate debuginfo packages.

At the end of the build step, there is an RPM package available as said in the output of the build command. The cp and build procedures can be repeated as many times as required when developing.

### Testing Modifications

  - Open the source code in your host computer using your favourite text editor
  - Once you are happy with your changes, follow the "build" steps above to generate a new RPM
  - Choose the device to work with (register the device within the Sailfish IDE first):
```nosh
sfdk device list
sfdk config device="my device name"
```

  - Transfer the RPMs from the desktop to the device:
```nosh
sfdk deploy --manual
```

  - Open device shell, and then install this RPM with root privileges:
```nosh
sfdk device exec
devel-su zypper --plus-repo RPMS dup --from ~plus-repo
```

  - Restart the Buteo sync daemon with extra debugging enabled:
```nosh
systemctl --user stop msyncd
MSYNCD_LOGGING_LEVEL=8 devel-su -p msyncd
```

  - Leave that running, and open a new device shell to inspect the debug log output:
```nosh
devel-su journalctl -af | grep --line-buffered caldav
```

  - Trigger a sync via Settings -\> Accounts -\> Long-press on CalDAV account -\> Sync.

## Resources

  - Mer Bugtracker: <https://bugs.merproject.org/>
  - Sailfish OS GitHub: <https://github.com/sailfishos>
  - CalDAV Plugin: <https://github.com/sailfishos/buteo-sync-plugin-caldav>
  - CardDAV Plugin: <https://github.com/sailfishos/buteo-sync-plugin-carddav>
  - Sailfish OS Calendar info: [Calendar](/Reference/Core_Areas_and_APIs/Apps_and_MW/Calendar)
  - Sailfish OS Contacts info: [Contacts](/Reference/Core_Areas_and_APIs/Apps_and_MW/Contacts)
