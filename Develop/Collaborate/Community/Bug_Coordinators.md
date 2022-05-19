## Community Bug Coordination

Starting with April 2022, members of the community support Jolla with coordinating Forum Bug Reports and internal bug tracking.

### Project Goals

 - Improving transparency of internal bug handling
 - Improved communication about new bug reports
 - Improved bug report quality
 
### Lifecycle of a bug

 1. A bug report is created by the user in the "Bug Reports" category
 2. Coordinators (and other forum members) work with the reporter to achieve  "well-formed" status.
 3. Well-Formed bug reports are added to the Bug Coordination List
 4. About 10 Bug reports are picked to be presented in the Collaboration Meeting
    - a couple of days before that, the list is submitted to the Collaboration Meeting coordination topic on the Forum
    - Jolla creates internal Bug reports or updates existing ones
    - Jolla tags the Bug Report posts as "tracked"
 7. After a Sailfish OS Release which contains the fix for the bug, the Bug Report post is tagged as "fixed"
 8. The original reporter may at any time mark the Bug Report post as "Solved"
 9. The original reporter should mark the Bug Report post as "Solved"
    - after verifying a "fixed" bug is actually fixed for them
    - another explanation (e.g. not a bug, by design, ...) has been given
    - another solution (e.g. satisfying workaround) has been found
    - the report has been identified as duplicate (see below)


#### Conditions for the report to be tagged as well-formed
 * Bug report is written on the right category ("Bug Reports")
 * Important information are given (Device and Version)
 * Title is comprehensible
 * Description is provided
 * Expected result is provided
 * Step-by-step instructions for reproducing the bug are provided
 * The first post contains the most recent information (important bits are not hidden in later posts)

### Reponsibilities and Expectations

#### CBC Team
##### The Coordinator's List 

The team uses various tools and manual trawling of the forums to colloect (hopefully all) bug reports, and their well-formedness.

##### Conditions for bugs to be forwarded to Jolla

Until we have found a better heuristic, the 10 to-be-presented bugs are selected at random, with a slight bias towards new reports.

#### Jolla Team
##### Tagging 

Depending the situation, Jolla will tag as tracked, pending or fixed.

#### Reporters


**Solved** 
The original reporter should mark the Bug Report post as "Solved":
    - after verifying a "fixed" bug is actually fixed for them
    - another explanation (e.g. not a bug, by design, ...) has been given
    - another solution (e.g. satisfying workaround) has been found

**Duplicates**
If a bug report is reported twice (or more). It should ideally contains the main bug report as comment and set as solution. 
After, topic should be closed.


### Tools 

Once all these elements are checked, bug report will be tagged as Good and Jolla has only to sort bug reports to pick them and copy them to their internal bug tracker. Once this step is done, Jolla add the tracked tag.

Tagged as good is currently defined as: the first post is liked by at least one of the bug-coordinators.

After a new release and if a bug report is fixed, tag tracked is replaced with fixed.


---

<!--
%%%% COMMENTED %%%%%
Notes/Copy from: https://mensuel.framapad.org/p/bugprocess-9tl3?lang=en by pherjung

# Process to achieve step 1
## Idea 1
Each 2 weeks, Community-Bug-Coordinators start with a list of 10 bugs report.  We determine if each item has all necessary data and complete them if needed. Aim is to provide a clean list of bug report X days before community meeting so Jolla  can easily import them and help us how to fetch more logs.

## Idea 2
Instead of waiting 2 weeks, we can use a private conversation for each bug report that's complicated or provide a list of difficult bugs on community meeting and Jolla will give some hint to catch more logs.

Thigg's script will then fetch all wellformed, relevant bugs for the community meeting.
Criteria for wellformed and relevant:
    - liked by one of the bug-coordinators (thus the bug passed our wellformed check)
    - not marked as solved (relevant)
    - not tagged as tracked or solved (relevant)

%%%% COMMENTED %%%%%
-->

### Timeline

2022-03-31: "Better tracking of bug report" question raised in the [Mar 31 Collaboration Meeting](https://irclogs.sailfishos.org/meetings/sailfishos-meeting/2022/sailfishos-meeting.2022-03-31-07.00.html), @pherung steps up as coordinator  
2022-03-31: [Announcement](https://forum.sailfishos.org/t/new-role-community-bug-coordinator/10935) on the Forum  
2022-04-05: (private) [Internal Discussions](https://forum.sailfishos.org/t/re-new-role-community-bug-coordinator/11032) by the new coordinator team on how to proceed  
2022-04-xx: Various tools created to support the process  
2022-04-xx: Forum Bug Report Template improved  
2022-nn-nn: Process documented on docs.sailfishos.org  
