---
layout: post
title: Thoughts on the Recent FAA Software Outage 
asset: /assets/posts/thoughts-on-the-recent-faa-software-outage
---

<div style="text-align: center;">
    <img style="max-width: 50%;" src="{{ page.asset }}/faa-outage-news-post.png">
</div>

{{ page.excerpt }}

### Quick Background

The system that went down provided "Notices to Air Missions", NOTAMs these are simple text information about conditions at airports such as constructions, closed running, landing obstructions, and more. NOTAMs are used during the route planning of a flight. Once a flight airborne the NOTAMs system is not needed to complete the flight.

### Swish Cheese

There is a big difference between "who's caused it?" and "who's at fault? ". The individual's actions caused the issue they are not necessarily at fault because there is normally a chain of events that lead to a issue like this. Just like aviation disasters. There might be environment factors, cultural factors, improper procedures, wrong assumes or external factors that are at fault that lead to the incident occurring. Doctor Reason's Swiss Cheese Model illustrates this concept.

<div style="text-align: center;">
    <img style="max-width: 55%;" src="{{ page.asset }}/swiss-cheese-model.png">
    <div class="container-center">
        <p>
        Swiss cheese model by James Reason published in 2000. Source: <a href="https://openi.nlm.nih.gov/detailedresult.php?img=PMC1298298_1472-6963-5-71-1&amp;req=4" rel="nofollow">https://openi.nlm.nih.gov/detailedresult.php?img=PMC1298298_1472-6963-5-71-1&amp;req=4</a>, open-access, CC Attribution 2.0 Generic
        </p>
    </div>
</div>

Here are the questions I have to better understand and identify where the holes in the swiss cheese happened for this incident.

- Why was file change done manually? Why wasn't it automated? 
- Is there a test/stage environment for testing changes?
    - Is the environment maintained in a similar way to prod?
    - Is the environment enough like Prod?
    - Was the action tested in the environment? 
        - Yes. Why did it work in a pre-prod before prod? or  Why did the change move forward in prod?
        - No. It was not tested 
            - Was the technician rushed? 
            - Was it deemed a simple change a testing not need? 
            - Was this a "common" task that happened often? 
 - If there is no prod like test environment them:
    - How can do you test changes? 
    - Why is there no test environment, is it related to costs?
    - Was there one in the past?
- If failed, why was the backup that was restored a day old?
    - Was is the backup cadence?
    - How often is the restore process verified?
- Were proper procedures followed?
    - Yes. What needs to be added to the procedure for this doesn't happen again?
    - No, they were not.
        - How many times was this type of work done not following proper procedure  without issue?
        - How many other individuals have not followed procedures in the past without issue? 
        - Is there a culture of **[Normalized Deviance](https://en.wikipedia.org/wiki/Normalization_of_deviance)** that lead to the individual think this action was normal? 

### NOTAM's Approximate Uptime

The NOTAM system was first introduced in 1993 and I can only find 1 instance of the system wide outage going down, the most recent one. After reading a numbers of articles there are many quotes like the one below indicating NOTAM outages are rare. 

> "I don't ever remember the NOTAM system going down like this. I've been flying 53 years," said John Cox, a former airline pilot and now an aviation-safety consultant. -- [www.cbsnews.com - Irina Ivanova](https://www.cbsnews.com/dfw/news/faa-notam-definition-outage-notice-to-air-missions/)

While the software outage started at 8:30PM ET the FAA backup phone system continued to allow departures until 7:30AM ET the next day. At this point the phone system was overwhelmed by the volume and the FAA ordered a ground stop at 7:30AM until the software system was restored at 9:30 AM ET. 

The are 262,968 hours in 30 years and if we count the backup process as part of the overall NOTAM system there was about 2.5 hours of downtime. 

```
uptime = (262,968 - 2.5) / 262,968 * 100 = 99.999049314%
```

Look at that five-nines.


That not to say we should brush off the outage. What happen was unacceptable and improvements need to be made to help mitigate something like this from happening again. However the reality is it will happen again. It like plane accidents, we can investigates, find the root cause, put in place fixed and mitigations, but another accident will happen It is the reality of human systems, they are flawed.


### A Humbling Reminder of Centralized Systems

This event is a humbling reminder that shows into today's modern age of software dependencies. A single person actions, heck a single keystroke, can affect millions. It reminds me that I am in a position where I could affect clients using the sofware systems I develop and support.
