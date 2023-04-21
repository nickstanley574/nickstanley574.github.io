The question of governance is a intreating one. How do we design a system the works the best for most case.


A solution that is 90% affective, but only done correctly 80% if the times. Is worst then a solutions that is 80% affective, but done correctly 90% of the time. 



All branches must follow have a ticket number.

The person assigned to the ticket is a the lead, other people may contribute to the branch, but the assigned ticket is responsible for the overall implementation and code. 

Merge into Protected Branches

Protected Branches -- 

All automatic test suits must have passed.

Must be approved by 1 team members that did not contribute commits. These remembers must be SME in the code base.

1 of the approvals must be done during a code review the the assigned lead. This should be done in person via a call.  During this call they should review the ticket, review the code and functionality, review design decisions, review the documentation for anything laking, review comments. Ask what other impact could happen to the system and if any other teams should be made aware of this change.  

After approval the MR openers can merge the code. The MR can not be more then 24 hours old. After 24 hours the branch is considered stale and must be re-approved. 


Emergency Merging.


