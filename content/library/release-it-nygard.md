---
layout: default
build:
  list: false
---

<h2 class="book-title">Release It! Second Edition</h2> 
<h3 class="book-sub ">Design and Deploy Production Ready Software</h3>
<h4 class="book-sub ">Michael T. Nygard</h4>
<p class="book-sub">ISBN: 978-1680502398 Published On: 2018-08-01</p>

<h2>
    <div class="separator">Part I Create Stability</div>
</h2>

## Chapter 1 Living in Production 

### Aiming for the Right Target

Most software is designed for the development lab or the testers in the Quality Assurance (QA) department. It aims to survive the artificial realm of QA, not the real world of production.

Do you want car that looks good but spends more time in the shop than on the road? Not! You want a car for the real world. 

### A Million Dollars Here, A Million Dollars There 

You can easily make decisions that optimize development cost at the expense of the operational cost. This only makes sense for fixed when aiming for budget and delivery dates. Its a bad choice. Systems spend more opf their life in production than in development. 

Image a system that need 5m of downtime every release. Assume a 5 year lifespan with monthly releases. The computed cost of downtime is $3,000 per minute. 300m of downtime would result in $1,000,000 lost in the expected lifespan of a the system. Instead, suppose you spend $50,000 to create a pipeline that avoids downtime during a release. Most CFOs would not mind authorizing a expenditure that returns 2,000% ROI.

### Use the Force

Your early decisions make the biggest impact on the eventual shape of your system. The earliest decisions you make can be the hardest ones to reverse later.

### Pragmatic Architecture 

If you’ve ever gritted your teeth while coding something according to the “company standards” that would be ten times easier with some other technology, then you’ve been the victim of an ivory-tower architect. I guarantee that an architect who doesn’t bother to listen to the coders on the team doesn’t bother listening to the users either.

Another breed of architect rubs shoulders with the coders and might even be one. This kind of architect does not hesitate to peel back the lid on an abstraction or to jettison one if it does not fit.

The ivory-tower architect most enjoys an end-state vision of ringing crystal perfection, but the pragmatic architect constantly thinks about the dynamics of change.

<mark>Software delivers value in Production. The development, testing, and planning...everything before is prelude.</mark> 

## Chapter 2 Case Study: The Exception That Grounded an Airline

(Story about Airline booking system outage)

### Postmortem

In operations, “post hoc, ergo propter hoc” turns out to be a good starting point most of the time. It’s not always right, but it certainly provides a place to begin looking. 

post hoc, ergo propter hoc” - Literally “after this, therefore because of this.” It refers to the common logical fallacy of attributing causation based on close timing. Also known as “you touched it last.”)

### The Smoking Gun

When I asked our account executive how we could get access to the source code, he was reluctant to take that step.You can imagine that there was plenty of blame floating in the air looking for someone to land on. With no legitimate access to the source code, I did the only thing I could do. I took the binaries from production and decompiled them.

The entire globe-spanning, multibillion dollar airline with its hundreds of aircraft and tens of thousands of employees was grounded by one programmer’s rookie error: a single uncaught SQLException.

### An Ounce of Prevention?

The natural response is to say, “This must never happen again.” It is fantasy to expect every single bug like this one to be driven out. Bugs will happen. They cannot be eliminated, so they must be survived instead.

A better question to ask is, “How do we prevent bugs in one system from affecting everything else?” Inside every enterprise today is a mesh of interconnected, interdependent systems. They cannot—must not—allow bugs to cause a chain of failures.

## Chapter 3 Stabilize Your System

Cynical software expects bad things to happen and is never surprised when they do. Cynical software doesn’t even trust itself, so it puts up internal barriers to protect itself from failures.

### Defining Stability

To talk about stability, I need to define some terms. 

A **transaction** is an abstract unit of work processed by the system. This is not the same as a database transaction. A single unit of work might encompass many database transactions. In an ecommerce site, for example, one common type of transaction is “Customer Places Order.”

A **mixed workload** is a combination of different transaction types processed by a system.

The word **system**, is the complete, interdependent set of hardware, applications, and services required to process transactions for users. 

A robust system keeps processing transactions, even when there are transient impulses, persistent stresses, or component failures disrupting normal processing. This is **stability**. It’s not just that your individual servers or applications stay up and running but rather that the user can still get work done.

An **impulse** is a rapid shock to the system. An impulse to the system is when something whacks it with a hammer. 

A **stress** to the system is a force applied to the system over an extended period.


### Extending Your Life Span 

Following Murphy's Law, whatever you do not test against will happen. 

The trouble is that apps never run long in pre-prods to reval longevity bugs. The only way you can catch longevity bug is to run your own longevity tests. Set a side a machine and keep it running for a long time. Don't hit it hard, but keep hitting it. Also, make sure you simulate slow periods to catch connection pool and firewall issues.

If not prod becomes your longevity testing env. 

### Failure Modes 

Denying the inevitability of failures robs you of your power to control and contain them. Once you accept that failures will happen, you have the ability to design your system’s reaction to specific failures. Just as auto engineers create crumple zones designed to protect passengers by failing first—you can create safe failure modes that contain the damage and protect the rest of the system.

Chiles calls these protections crackstoppers. 

### Chain of Failure 

Underneath every system outage, there is a chain of events like this. One small thing leads to another, which leads to another. 

* **Fault** - A condition that creates an incorrect internal state in the software.
* **Error** - Visibly incorrect behavior.
* **Failure** - An unresponsive system. 

Triggering a fault opens the crack. Faults become errors, and errors provoke failures. That's how the cracks propagate.

## Chapter 4 Stability Antipatterns

As we integrate the world, tightly coupled systems are the rule rather than the exception. Big systems serve more users by commanding more resources; but, in many failure modes, big systems fail faster than small systems.

Highly interactive complexity arises when systems have enough moving parts and hidden, internal dependencies that most operators’ mental models are either incomplete or just plain wrong. In a system exhibiting highly interactive complexity, the operator’s (<mark>With the best of intentions.</mark>) actions will have results ranging from ineffective to actively harmful. 

### Integration Points

Integration points are the number-one killer of systems. Every single one of those feeds presents a stability risk.

### Vendor API Libraries

It would be nice to think that software vendors must have hardened their software against bugs, just because they’ve sold it and deployed it for lots of clients. These libraries are just code, coming from regular developers.

### ↶ Remember This ↷

* **Beware this necessary evil** - Every integration point will eventually fail in some way, and you need to be prepared for that failure.
* **Prepare for the many forms of failure**
* **Know when to open up abstractions** - Failures are often difficult to debug at the application layer, because most of them violate the high-level protocols.
* **Failures propagate quickly** 
* **Apply patterns to avert Integration Points problems**

### Chain Reactions

**Horizontal scaling** refers to adding capacity by adding servers.

**Vertical scaling**, means building bigger and bigger server.

If your system scales horizontally, then you will have load-balanced clusters. The multiplicity of machines provides you redundancy. However, they can exhibit a load related failure mode. When one node fails, the other nodes must pick up the slack. If the first server failed because of some load-related condition, the surviving nodes become more likely to fail with each additional server that goes dark.

### ↶ Remember This ↷

* **One server down jeopardizes the rest**
* **Hunt for resource leaks**
* **Hunt for obscure timing bugs**
* **Use Autoscaling (Cloud)**
* **Defend with Bulkheads**

### Cascading Failures

A cascading failure occurs when a crack in one layer triggers a crack in a calling layer. Cascading failures require some mechanism to transmit the failure from one layer to another. The failure “jumps the gap”. An example is a database failure. If an database cluster goes dark, then any application that calls the database is going to experience problems.

### ↶ Remember This ↷
* **Stop cracks from jumping the gap**
* **Scrutinize resource pools**
* **Defend with Timeouts and Circuit Breaker**

## Users

Human users have a gift for doing exactly the worst possible thing at the worst possible time.

### Traffic

As traffic grows, it will eventually surpass your capacity. **Capacity** is the max throughput your system can sustain under a given workload while maintaining acceptable performance. Passing those limits makes cracks in the system, and cracks always propagate faster under stress.

### Heap Memory

When memory gets short, a large number of very surprising things can happen. Your best bet is to keep as little in the session as possible. For example, it’s a bad idea to keep an entire set of search results in the session for pagination.

### Off-Heap Memory, Off-Host Memory 

Instead, of keeping it inside that the heap move it to some other process. Memcached or Redis for example.

Any approach as trade-offs between total addressable memory size and latency to access it. The notion of **memory hierarchy** is ranked by size and distance. Resister are faster and closet to the CPU. On the overhand networks are fast enoughs that "someone else's memory" can be faster to access than local disk. On the other hand local memory is still faster than remote memory. There is no one-size-fits-all.

### Expensive to Serve

Some users are way more demanding than others. Ironically, these are usually the ones you want more of. There is no effective defense against expensive users. The best thing you can do about expensive users is test aggressively. Identify whatever your most expensive transactions are, and double or
triple the proportion of those transactions. 

### Unwanted Users 

There is an entire parasitic industry that exists by consuming resources from other companies’ websites. These outfits leech data out of your system one web page at a time.

Keeping out legitimate robots is fairly easy through the use of the robots.txt file. The robots.txt is nothing but a request from your site to the incoming robot. So, the robots most likely to respect robots.txt are the ones that might actually generate traffic (and revenue) for you, while the leeches will ignore it completely.

### Malicious Users

The final group of undesirable users are the truly malicious. These bottom-feeding mouth breathers just live to kill your baby. A robust approach to security is beyond the scope of this book. I will restrict my discussion to the intersection of security as it pertains to system architecture. 

The primary risk to stability is the now-classic distributed denial-of-service (DDoS) attack. The attacker causes many computers, widely distributed across the Net, to start generating load on your site. 

### ↶ Remember This ↷
* **Users consume memory**
* **Users do weird, random things**
* **Malicious users are out there**
* **Users will gang up on you** 

## Blocked Threads

Blocked threads can happen anytime you check resources out of a connection pool, deal with caches or object registries, or make calls to external systems. If the code is structured properly, a thread will occasionally block whenever two (or more) threads try to access the same section at the same time. This is normal. Assuming that the code was written by someone sufficiently skilled in multithreaded, then you can guarantee that the threads will unblock and continue. If this describes you, then you are in a highly skilled minority.

The problem has four parts:

* Error conditions and exceptions create too many permutations to test exhaustively.
* Unexpected interactions can introduce problems in previously safe code.
* Timing is crucial. The probability that the app will hang goes up with the number of concurrent requests.
* Developers never hit their application with 10,000 concurrent requests.

### Libraries

Libraries are notorious sources of blocking threads. If the library breaks easily, you need to protect your request-handling threads. If the library allows you to set timeouts, use them. If not, you might have to resort to some complex structure.

### ↶ Remember This ↷
* **Recall that the Blocked Threads antipattern is the proximate cause of most failures**
* **Scrutinize resource pools**
* **Use proven primitives**
* **Defend with Timeouts** 
* **Beware the code you cannot see** 

## Self-Denial Attacks 

<mark>A self-denial attack describes any situation in which the system or the extended system that includes humans—conspires against itself.</mark>

The classic example of a self-denial attack is the email from marketing that contains some privileged information or offer. The community of networked bargain hunters can detect and share a reusable coupon code in milliseconds.

You can avoid machine-induced self-denial by building a “shared-nothing” architecture. (Not really applicable today.)

Autoscaling can help when the traffic surge does arrive, but watch out for the startup lag time. 

### ↶ Remember This ↷
* **Keep the lines of communication open** - Make sure nobody sends mass emails with deep links. 
* **Protect shared resources** 
* **Expect rapid redistribution of any cool or valuable offer** 

## Scaling Effects

Anytime you have a “many-to-one” or “many-to-few” relationship, you can be hit by scaling effects
when one side increases. For instance, a database server that holds up just fine when two application servers call it might crash when you add the next eight application servers.

## Point-to-Point Communications

With point-to-point connections, each instance has to talk directly to every other instance. The total number of connections goes up as the square of the number of instances. Scale that up to a hundred, and the O(n∧2) scaling becomes painful. 

As the number of servers grows, then a different communication strategy is needed. Depending on your infrastructure, you can replace point-to-point communication with the following:
* UDP broadcasts
* TCP or UDP multicast
* Publish/subscribe messaging
* Message queues

### Shared Resources

Another scaling effect that can jeopardize stability is the “shared resource” effect. The shared resource is some facility that all members of a horizontally scalable layer need to use. When the shared resource gets overloaded, it will become a bottleneck limiting capacity.

The most scalable architecture is a "Shared-nothing architecture". Each server operates independently, without centralized services. Capacity scales linearly with the number of servers. It it might scale better at the cost of failover. 

### ↶ Remember This ↷
* **Examine production versus QA environments to spot Scaling Effects**
* **Watch out for point-to-point communication**
* **Watch out for shared resources** 

## Unbalanced Capacities

If you can’t build the scheduling system large enough to meet the potentially overwhelming demand from the front end, then you must build both the front and back ends to be resilient in the face of a tsunami of requests.

### ↶ Remember This ↷
* **Examine server and thread counts**
* **Observe near scaling effects and users**
* **Virtualize QA and scale it up** 
* **Stress both sides of the interface** 

## Dogpile 

When a bunch of server impose trans3ent load all at once, it's called a **dogpile**. A dogpile can occur in several different situations: 
* When booting up several servers, such as after a upgrade and restart. 
* When a cron job triggers all at the same time. 
* When the configuration management system pushes out a change
* Some external phenomenon causes a synchronized "pulse" of traffic. 

backoff period - When a collision occurs, both the devices wait for a random amount of time before retransmitting the signal again, they keep on trying until the data is transferred successfully.

### ↶ Remember This ↷
* **Dogpiles force you to spend too much to handle peak demand**
* **Use random clock slew to diffuse the demand** - Don't set all your tasks/jobs for on-the-hour time. Mix them up to spread the load out. 
* **Use increasing backoff times to avoid pulsing** - A fixed retry internal will concentrate demand from callers on that period. Use a backoff algorithm so diff callers will be a t different point in their backoff period. 

## Force Multiplier 

Like a lever, automation allows administrators to make large movement with less effort. Its a force multiplier.  

### ↶ Remember This ↷
* **Ask for help before causing havoc** - Management tools can make very large impacts very quickly. Build limiters and safeguards into them so they won't destroy you system at ounce.
* **Beware of lag time and momentum** - Actions take time. That time is usually longer than a monitoring interval, so make sure to account for some deploy in the system's response to action.
* **Beware of illusions and superstitions** - Control system sense the env, but they can be fooled. They compute an expected state and a "belief" about the current state. Either can be mistaken.

## Slow Responses

Slow responses usually result from excessive demand.  They can also happen as a symptom of some underlying problem. Memory leaks often manifest via Slow Responses, as a machine works harder to reclaim enough space.

### ↶ Remember This ↷
* **Slow Responses triggers Cascading Failures**
* **For websites, Slow Responses causes more traffic**
* **Consider Fail Fast**
* **Hunt for memory leaks or resource contention**

## Unbounded Result Sets

A common structure in the code goes like this: send a query to the database, and then loop over the result set, processing each row. What happens when the database suddenly returns five million rows instead of the usual hundred or so? 

In the abstract, an unbounded result set occurs when the caller allows the other system to dictate terms.

There is no standard SQL syntax to specify result set limits. ORM tools support query parameters that can limit results returned from a query but do not usually limit results when following an association.

### ↶ Remember This ↷

* **Use realistic data volumes** - Typical development and test data sets are too small to exhibit this problem. You need production-sized data sets to see what happens when your query returns a million rows that you turn into objects.
* **Paginate at the front end** - The request should include a parameter for the first item and the count. 
* **Don’t rely on the data producers**
* **Put limits into other application-level protocols**

## Chapter 5 Stability Patterns

### Timeouts 

The timeout is a simple mechanism allowing you to stop waiting for an answer once you think it will not come.

Well-placed timeouts provide fault isolation; a problem in some other system, subsystem, or device does not have to become your problem.

<mark>It is essential that any resource pool that blocks threads must have a timeout to ensure threads are eventually unblocked whether resources become available or not.</mark>

Timeouts are often observed together with retries. Under the philosophy of “best effort,” the software attempts to repeat an operation that timed out. Immediately retrying an operation after a failure has a number of consequences, but only some of them are beneficial. If the operation failed because of any significant problem, it is likely to fail again if retried immediately. Fast retries are very likely to fail again.

### ↶ Remember This ↷
* **Apply to Integration Points, Blocked Threads, and Slow Responses**
* **Apply to recover from unexpected failures**
* **Consider delayed retries**

### Circuit Breaker

Circuit breakers protect from burning houses down. The principle: detect excess usage, fail, and open the circuit. Abstractly, the circuit breaker exists to allow one subsystem (an electrical circuit) to fail (excessive current draw,) without destroying the system (the house). Once the danger has passed, the circuit breaker can be reset.

In the normal “closed” state, the circuit breaker executes operations as usual. If it fails, however, the circuit breaker makes a note of the failure. Once the number of failures (or frequency of failures, in more sophisticated cases) exceeds a threshold, the circuit breaker trips and “opens” the circuit. 

After a amount of time, the circuit breaker goes into the “half-open” state. In this state, the next call to the circuit breaker is allowed to execute the dangerous operation. Should the call succeed, the circuit breaker resets and returns to the “closed” state. If this trial call fails, the circuit breaker returns to the “open” state until another timeout elapses.

When the circuit breaker is open, all calls will immediately fail. Circuit breakers are a way to automatically degrade functionality when the system is under stress. Popping a Circuit Breaker always indicates there is a serious problem. It should be reported, recorded, trended, and correlated.

#### ↶ Remember This ↷
* **Don’t do it if it hurts**
* **Use together with Timeouts**
* **Expose, track, and report state changes**

### Bulkheads

In a ship, bulkheads are metal partitions that can be sealed to divide the ship into separate, watertight compartments. The bulkhead enforces a principle of damage containment.

Physical redundancy is the most common form of bulkheads. If there are four independent servers, then a hardware failure in one can’t affect the others. 

In the cloud run instances across zones and regions. There are very large-grained chunks with strong partitioning between them. 

#### ↶ Remember This ↷

* **Save part of the ship**
* **Decide whether to accept less efficient use of resources** - When the system is not in jeopardy, partitioning the servers means each partition needs more reserve capacity. If all servers are pooled, then less total reserve capacity is needed.
* **Pick a useful granularity**

### Steady State

Every time a human touches a server is a opportunity for unforced errors. It's best to keep people of severs especially production systems.

If the system needs a lot of hand-holding to keep running, then administrators develop the habit of staying logged in all the time. This indicates that the servers are "pets" rater than "cattle". 

#### Data Purging

The most obvious symptom of data growth will be steadily increasing I/O rates on the database servers. You may also see increasing latency at constant loads

Data purging is nasty, detail-oriented work. It can be very difficult to cleanly remove obsolete data without leaving orphaned rows. The other half of the battle is ensuring that applications still work once the data is gone.

#### Log Files

On log file is like one pile of cow dung, not very valuable, and you'd rather no dig thought it. Collect tons of cow dung and it becomes "fertilizer". Likewise, if you collect enough log files you can discover value. 

It’s always better to avoid filling up the filesystem. Log file rotation requires just a few minutes of configuration. Log files also have a terrible signal-to-noise ratio. Its best to get them off the hosts quickly and into a centralized logging server. 

#### In-Memory Caching

When building any sort of cache, it’s vital to ask two questions: Is the space of possible keys finite or infinite? Do the cached items ever change?

If there is no upper bound on the number of possible keys, then cache size limits must be enforced. Unless the key space is finite and the items are static, then the cache needs some form of cache invalidation.

#### ↶ Remember This ↷

* **Avoid fiddling** - Eliminate the need for recurring human intervention
* **Purge data with application logic** - DBAs can create scripts to purge data, but they don’t always know how the application behaves when data is removed. Maintaining logical integrity, especially if you use an ORM tool, requires the application to purge its own data.
* **Limit caching**
* **Roll the logs**

### Fail Fast

If slow responses are worse than no response, the worst must surely be a slow failure response. If the system can determine in advance that it will fail at an operation, it’s better to fail fast. That way, the caller doesn’t have to tie up any of its capacity waiting.

#### ↶ Remember This ↷

* **Avoid Slow Responses and Fail Fast**
* **Reserve resources, verify Integration Points early**
* **Use for input validation** - Do basic user input validation even before you reserve resources Don’t bother checking out a database connection just to find out that a required parameter wasn’t entered.

### Let it Crash

The cleanest state your program can ever have is right after startup. The "let it crash" approach says that error recovery is difficult and unreliable, so our goal should be to get back into the clean startup as rapidly as possible. 

For "let it crash" to work, a few things have to be true in our system. 

* **Limited Granularity** - We want to crash a component in isolation. The rest of the system must be protect itself from a cascading failure. 
* **Fast Replacement** - We must be able to get back into that clean state and resume operations as quick as possible. 
* **Supervision** - When we crash a process, how does a new one get started? If you simply have a loop start something that is crash and the problem persists across restarts, you basically fork-bomb the server. Actor systems use a hierarchial tree of supervisors to manage the restarts. The supervisor monitors the workers and can decide o restart. The design of the supervision tree is integral to the system design. The Supervisor is NOT the service consumer. Managing the workers is different than requesting work. Supervisors need to keep close track of how often they restart workers. 

#### ↶ Remember This ↷

* **Crash components to save systems**
* **Restart fast and reintegrate**
* **Isolate components to crash independently**
* **Don't crash monoliths**

### Handshaking

Handshaking refers to signaling between devices that regulate communication between them. Handshaking is ubiquitous in low-level communications protocols but is almost nonexistent at the application level. Handshaking is all about letting the server protect itself by throttling its own workload. Instead of being victim to whatever demands are made upon it, the server should have a way to reject incoming work.

The server can provide a “health check” query for use by clients. The client would then check the health of the server before making a request. This provides good handshaking at the expense of doubling the number of connections and requests the server must process.

Overall, handshaking is an underused technique that could be applied to great advantage in application-layer protocols. It is an effective way to stop cracks from jumping layers, as in the case of a cascading failure

#### ↶ Remember This ↷

* **Create cooperative demand control**
* **Consider health checks**
* **Build Handshaking into your own low-level protocols**

### Test Harness

Integration testing presents problems of its own. What version should we test against? For greatest assurance, we’d like to test against the versions of our dependencies that will be current when we release our system. I could construct a mathematical proof, using set theory, that shows this approach constrains the entire company to testing only one new piece of software at a time. the 

<mark>Interdependencies of today’s systems create such an interlocking web of systems that the integration testing environment really becomes unitary—one global integration test that shadows the real production systems of the entire enterprise. Such a unitary environment would need change control just as rigorous—or perhaps more so—than the actual production environments.</mark>

<mark>A better approach to integration testing would allow you to test most or all of these failure modes. It should preserve or enhance system isolation to avoid the version-locking problem and allow testing in many locations instead of the unitary enterprise-wide integration testing environment I described earlier.</mark>

To do that, you can create test harnesses to emulate the remote system on the other end of each integration point. A good test harness should be devious. It should be as nasty and vicious as real-world systems will be. The test harness should leave scars on the system under test. Its job is to make the system under test cynical.

A test harness “knows” that it is meant for testing; it has no other role to play. 

#### Why Not Mock Objects? 

A test harnesses differs from mock objects, in that a mock object can be trained to produce behavior that conforms only to the defined interface. A test harnesses runs as a separate server, so it is not obliged to conform to any interface. It can provoke network errors, protocol errors, or application-level errors. If all low-level errors were guaranteed to be recognized, caught, and thrown as the right type of exception, there would be no need for test harnesses.

#### ↶ Remember This ↷

* **Emulate out-of-spec failures**
* **Stress the caller**
* **Leverage shared harnesses for common failures**
* **Supplement, don’t replace, other testing methods**

### Decoupling Middleware

Middleware is a graceless name (Rebranded as enterprise application integration) for tools that inhabit a singularly messy space—integrating systems that were never meant to work together. It is the connective tissue that bridges gaps between different islands of automation. 

Often described as “plumbing” with all the connotations middleware will always remain inherently messy, since it must work with different business processes, different technologies, and even different definitions of the same logical concept.

Done well, middleware simultaneously integrates and decouples systems. It integrates them by passing data and events back and forth between the systems. It decouples them by letting the participating
systems removing specific knowledge of and calls to the other systems.

#### ↶ Remember This ↷

* **Decide at the last responsible moment**
* **Avoid many failure modes through total decoupling**
* **Learn many architectures, and choose among them**

### Shed Load 

The ideal ay to define "load is too high" is for a service to monitor its own performance relative to its SLA. When requests are longer then the SLA its time to shed some load. Example: When a load balancer is used, instances can use a 503 on their health check page to tell the LB to back off for a while. 

### Create Back Pressure

If a queue is unbounded, it can consume all available memory. If the queue is bounded, we have to decided what to do when it's full and something tries to add one more thing. We only have a few options.  

* Pretend to accept the new item but actually drop it. 
* Accept the new item and drop something else. 
* Refuse the item 
* Block the producer until there is more room. 

### Governor 

Automation, when it goes wrong it tends to go wrong quickly. In the steam engine era if things runway fast bad things happened. The solutions was a governor, which limits the speed of a engine. Even if the source of power could drive it faster. 

The whole point of a governor is to slow thing down enough for humans to get involved. 

<h2>
    <div class="separator">Part II Design for Production </div>
</h2>

## Chapter 6 Case Study: Phenomenal Comic Powers, Itty-Bitty Living Space

Come Thanksgiving. By noon, customers had placed as many orders as in a typical week. The system was clearly stressed but still nominal. Black Friday... ring ring “Good morning. This is the Site Operations Center SiteScope is currently showing red."

After some debugging attention swung to the order management system. That system handles scheduling for home delivery. We immediately paged the operations team for that system. (It’s managed by a different group that does not have 24/7 support staff.)

It felt like half of forever when the support engineer dialed in. He explained that of the four servers that normally handle scheduling, two were down for maintenance, and one of the others was malfunctioning for reasons unknown. To this day, I have no idea why they would schedule maintenance for that weekend of all weekends! 

That left a huge imbalance in the sizes of the systems. And it’s going to continue until Monday. It’s the nightmare scenario. The site is down, and there’s no playbook for this situation. We have to improvise.

We saw a glimmer of hope when we looked at the code for the store. It used a subclass of the standard resource pool to manage connections to order management. In fact, it had a separate connection pool just for scheduling requests. I asked the developers what would happen if the pool started returning null instead of a connection. They replied that the code would handle that and present the user with a polite message stating that delivery scheduling was not available for the time being. Good enough.

## Chapter 7 Foundations 

Design for production include designing for people who do operations. Operators are users, too. If you system's front end is Disney world, the operators get to use the secret tunnels beneath the park. 

### Layers of Concerns
* Operations - Security, availability, capacity, status, communication
* Control Plane - System monitoring, deployment, anomaly detection
* Interconnect - Routing, load balancing, failure, traffic, management
* Instances - Service, processes, components, instance monitoring
* **Foundation - Hardware, VMs, IP addresses, Physical networks** 

### NICs and Names

One of great misunderstandings in networking is about the hostname of a machine. That's because hostname can be defined in 2 ways. First, a hostname to the operating system and the second definition pertains to the external name of the system. What other computers expect to use to connect to the target host usually using DNS. 

There's no guarantee that the machine FQDN matches the FQDN in DNS.

A single machine may have multiple NICs and each one can be on its own network with its own ipaddress. This is called **multihoming**. This can enforce security by separating admin, monitoring and production traffic to different dedicated networks. THis may also improve performance by segmenting high-volume traffic.

### Programming for Multiple Networks

<mark>By default, an app that listens on a socket will listen for connections attempts on any interface. To determine which interface to bind to, the application must be told it own name of Ip address. This is a big diff with multihomed servers.</mark>

### Physical Hosts 

Before the victory of commodity pricing and web scale, data center hardware was build for high reliability of the individual box. Now its load-balance services access enough hosts that the lost of a single host is not catastrophic. And now you want each host to be as cheap as possible. 

Design for prod hardware for most app now means building scale horizontally. 

### Virtual machines in the Data Center

Virtualizations promised a common hardware appearance across the bewildering array of physical config in a DC. On the down side, performance is much less predictable. Many VMs can be on the sme host and it rare to see VMs move host and resources can be oversubscribed. 

### Containers in the Data Center

Containers in the DC act a lot like Vms in he cloud. The most challenging part of running containers in the DNS is defining the network. A close second is making sure enough containers instances of the right type are on the right machines. 

The whole container image move from env to envs the image can't hold thing like creds you need to inject configs are start us env vars like in a 12 factor app. 

#### [The 12-Factor App](https://12factor.net/)

1. Codebase - One codebase tracked in revision control, many deploys
2. Dependencies - Explicitly declare and isolate dependencies
3. Config - Store config in the environment
5. Backing services - Treat backing services as attached resources
5. Build, release, run - Strictly separate build and run stages
6. Processes - Execute the app as one or more stateless processes
7. Port binding - Export services via port binding
8. Concurrency - Scale out via the process model
9. Disposability - Maximize robustness with fast startup and graceful shutdown
10. Dev/prod parity - Keep development, staging, and production as similar as possible
11. Logs - Treat logs as event streams
12. Admin processes - Run admin/management tasks as one-off processes

Containers image should not contain hostname or port numbers. This is b/c the settings needs to change dynamically. The links between containers are all established by the control plane. 

### Virtual Machines in the Cloud

Any vm in the cloud has worse availability than any physical machine. If you have lon-running vms, you may have gotten a notice from AWS that the machine as to be restart or else. 

## Chapter 8 Processes on Machines

Instances - Service, processes, components, instance monitoring

* **Service** - A collection of process across machine that work together to deliver a unit of function.
* **Instance** - A installation on a single machine (container, vm or physical) out of a load-balanced array of the sme executable. 
**Executable** - An artifact that a machine can launch as a process.
**Process** - An OS process running on a machine the runtime. 
**Installation** - The exactable and any attendance dirs, configs and resources as they exist on a machine. 
**Deployment** - The act of creating an installation on a machine. 

### Code 

#### Building the Code 

Its is vital to establish a string "chain of custody" that stretches from the developer though to the production instance. It must be impossible for an unauthorized part to sneak code into your system.

Devs must be able to build the system, run tests and run portion of the system locally. 

<mark>Downloading dependencies from the internets is not safe. Its too easy for a dependency to be silent replaced or removed either maliciously or by the maintainer. Move dependencies to a private repo and only put libs into it when their digital signatures match published info from the provided.</mark>

#### Immutable and Disposable Infrastructure

The DevOps and cloud community says that is more reliable to always start from a know base image, apply a fixed set of changes and never patch or update a machine instead replace it. This is "immutable infra", machines don't change once they've been deployed.

#### Configuration Files

The configuration “starter kit” is a file or set of files the instance reads at startup.

We don’t want our instance binaries to change per environment, but we do want their properties to change. That means the code should look outside the deployment directory to find per-environment configurations.

That’s not to say you should keep configurations out of version control altogether. Just keep them in a different repository than the source code.

#### Configuration with Disposable Infrastructure

The two approaches are to inject configuration at startup or use a configuration service. Injecting configuration works by providing environment variables or a text blob. The other way to get configuration into an image is via a configuration service. In this form, the instance code reaches out to a well-known location to ask
report for its configuration.

### Transparency 

Transparency refers to the qualities that allow operators, developers, and business sponsors to gain understanding of the system’s historical trends, present conditions, instantaneous state, and future projections. Transparent systems communicate, and in communicating, they train their attendant humans. Good data enables good decision-making. In the absence of trusted data, decisions will be made for you based on somebody’s political clout, prejudices, or whoever has the best “executive style” hair.

#### Designing for Transparency

Transparency arises from deliberate design and architecture. “Adding transparency” late in development is about as effective as “adding quality".

The monitoring and reporting systems should be like an exoskeleton built around your system, not woven into it. In particular, decisions about what metrics should trigger alerts, where to set the thresholds, and how to “roll up” state variables into an overall system health status should all be left outside of the instance itself. 

#### Enabling Technologies

This section examines the most important enabling technologies that reduce the opacity of that process boundary. You can classify these as either “white-box” or “black-box” technologies.

A black-box technology sits outside the process, examining it through externally observable things. Black-box technologies can be implemented after the system is delivered, usually by operations. 

White-box technology runs inside the process. This kind of technology often looks like an agent delivered in a language-specific library.

#### Logging

Logging is white-box; it must be integrated pervasively into the source code. If you want to avoid tight coupling to a particular monitoring tool or framework, then log files are the way to go.

A logs directory under the application’s install directory is wrong. Log files can be large, grow rapidly and consume lots of I/O. It’s a good idea to keep them on a separate drive.

If you make the log file locations configurable, then administrators can just set the right property to locate the files. On UNIX systems, symlinks are the most common workaround for static log locations.

Apps running in containers usually just emit messages on standard out, since the container itself can capture or redirect that.

<mark>Above all else, log files are human-readable. That means they constitute a human-computer interface and should be examined in terms of human factors. Humans misinterpretation of status information can prolong or aggravate the problem. Ensure that log files convey clear, accurate, and actionable information. </mark>

**Voodoo Operations section is fun story go read it**

Messages should include an identifier that can be used to trace the steps of a transaction. This might be a user’s ID, a session ID, a transaction ID, or even an arbitrary number assigned when the request comes in. 

#### Instance Metrics

An ever-growing number of systems have outsourced their metrics collection to companies like New Relic and Datadog. That way you don’t have to devote time to the care and feeding of metrics infrastructure—which can be substantial. 

#### Health Checks

Health checks should be more than just “yup, it’s running.” It should report at least the following:
* The host IP address or addresses
* The version number of the runtime or interpreter (Ruby, Python, JVM,.Net, Go, and so on)
* The application version or commit ID
* Whether the instance is accepting work
* The status of connection pools, caches, and circuit breakers

## Chapter 9 Interconnect

Control Plane - System monitoring, deployment, anomaly detection

The interconnect layer covers all the mechanisms that knit a bunch of instances together into a cohesive system. That includes traffic management, load balancing, and discovery. <mark>Interconnect layer is where we can really create high availability.</mark>

### DNS

#### Load Balancing with DNS

DNS round-robin associates multiple IP addresses with a service name, allowing clients to connect to one server from a pool. However, it has limitations: servers must be directly reachable, and there is no traffic redirection if a server is down.

#### Global Server Load Balancing with DNS

DNS is particularly effective in global server load balancing (GSLB) scenarios. GSLB involves the task of directing clients to different geographic locations, which can be physical data centers or regions in a cloud infrastructure. The goal is to ensure that clients are routed to the nearest location in order to achieve the best possible performance.  Note "nearby" in terms of network routing may not always correspond to physical proximity.

#### Availability of DNS

Ensure DNS server diversity by avoiding hosting them on the same infrastructure as your production systems. Have multiple providers with servers in different locations and a separate one for your public status page. Avoid scenarios that leave you without at least one functioning DNS server.

### Load Balancing

Load balancing is all about distributing requests across a pool of instances to serve all requests correctly in the shortest feasible time. Active load balancers listen on sockets using virtual IP addresses (VIPs). A load balancer can have multiple VIPs bound to a single physical network port, and each VIP corresponds to one or more pools. A pool defines the IP addresses of the underlying instances along with a lot of policy information:
* The load-balancing algorithm to use
* What health checks to perform on the instances
* What kind of stickiness, if any, to apply to client sessions
* What to do with incoming requests when no pool members are availabl


#### Software Load Balancing

Software load balancing is a cost-effective method that utilizes an application acting as a reverse proxy server. This application listens for requests and distributes them among a pool of instances. Unlike a normal proxy server that combines multiple outgoing calls into a single source IP address, a reverse proxy server separates incoming calls from a single IP address and sends them to multiple addresses. Popular reverse proxy load balancers include Squid, HAProxy, Apache httpd, and nginx. Besides load balancing, reverse proxy servers can also be configured to reduce the load on service instances by caching responses.

#### Hardware Load Balancing

Hardware load balancers are specialized network devices designed to perform the same functions as reverse proxy servers. They possess interception and redirection capabilities similar to reverse proxy software but offer distinct advantages. Due to their closer proximity to the network, hardware load balancers provide enhanced capacity and superior throughput compared to their software counterparts.

#### Stickiness

Load balancers can direct repeated requests to the same instance, improving response time by utilizing pre-loaded resources. However, sticky sessions can lead to uneven load distribution across machines, causing some machines to become overloaded while others remain underutilized. 

#### Partitioning Request Types

Load balancers can employ "content-based routing" to route incoming requests to different pools based on elements in the URLs. For example, search requests can be directed to one set of instances, while user signup requests can be sent elsewhere.

### Demand Control 

Our daily reality is this: the world can crush our systems at any time. There’s no natural protection.

#### How Systems fails

Every failing system starts with a queue backing up somewhere.

#### Preventing Disaster

During high reject work that cannot complete on time. This is known as "load shedding". In general, we aim to shed load as early as possible to prevent resource allocation. Load balancers positioned near the network edge are the optimal location for this. <mark>By conducting a health check on the initial service tier, the load balancer can determine if response times exceed the service's SLA.</mark> Services can assess their own response time to assist in this process. They can also evaluate their operational state to ensure requests are answered promptly.

### Discovering Services

Service discovery becomes important in two cases. Firstly, when an organization has a large number of services, managing them through DNS becomes impractical. Secondly, in highly dynamic environments like container-based setups, service discovery is essential. However, these are not the only scenarios where it applies.

Service discovery consists of two parts. First, it allows instances of a service to announce themselves and start receiving a load, replacing statically configured load balancer pools with dynamic ones. This can be done with any type of load balancer, without requiring a specialized "cloud aware" balancer.

The second part is the lookup process. Callers need to know at least one IP address to contact for a specific service. The lookup process may resemble a simple DNS resolution for the caller, even if a highly dynamic service-aware server is providing the DNS service.

Service discovery itself is a separate service that can experience failures or overload. Clients should consider caching the results for a short period to mitigate these issues.


### Migratory Virtual IP Addresses

Unfortunately, the term virtual IP is overloaded. It generally refers to an IP address not tied to a specific Ethernet MAC address. In cluster servers, it is used to transfer ownership of the address among cluster members. Load balancers use virtual IPs to consolidate multiple services onto fewer physical interfaces. Sometimes, the virtual IP serves as both a service address and a migrating address.

A migratory virtual IP is an IP address that can be moved between network interfaces. In active/passive database clusters, clients connect using the DNS name associated with the virtual IP address instead of individual hostnames. This ensures consistent connectivity regardless of which node holds the IP address.


## Chapter 10 Control Plane

The control plane encompasses all the software and services that run in the background to make production load successful. One way to think about it is this: if production user data passes through it, it’s production software. If its main job is to manage other software, it’s the control plane.

### How Much Is Right for You? 

As we look at the control plane, keep in mind that every part of this is optional. You can do without every piece of it, if you’re willing to make some trade-offs. The more sophisticated your control plane becomes, the more it costs to implement and operate.

### Mechanical Advantage

“Mechanical advantage” is the multiplier on human effort that simple machines provide. 

#### System Failure, Not Human Error