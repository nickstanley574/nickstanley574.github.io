---
layout: book
---

# The Pragmatic Programmer 

By: Andrew Hunt, David Thomas - ISBN:  978-0201616224 - Published On: 1999

# Preface

Programming is a craft. At its simplest, it comes down to getting a computer to do what you want it to do (or what your user wants it to do). As a programmer, you are part listener, part advisor, part interpreter, and part dictator.

There are many people offering you help. Tool vendors tout the miracles their products perform. Methodology gurus promise that their techniques guarantee results. Everyone claims that their programming language is the best, and every operating system is the answer to all
conceivable ills.

<mark>Of course, none of this is true. There are no easy answers. There is no such thing as a best solution, be it a tool, a language, or an operating system. There can only be systems that are more appropriate in a particular set of circumstances.</mark>

Theory and practice combine to make you strong.

## What Makes a Pragmatic Programmer?

* **Early adopter/fast adapter** -- You have an instinct for technologies and techniques, and you love trying things out. When given something new, you can grasp it quickly and integrate it with the rest of your knowledge. Your confidence is born of experience.
* **Inquisitive** -- You tend to ask questions. That’s neat—how did you do that? You are a pack rat for little facts, each of which may affect some decision years from now.
* **Critical thinker** -- You rarely take things as given without first getting the facts. When colleagues say “because that’s the way it’s done,” or a vendor promises the solution to all your problems, you smell a challenge.
* **Realistic** -- You try to understand the underlying nature of each problem you face. This realism gives you a good feel for how difficult things are, and how long things will take. 
* **Jack of all trades.** -- You try hard to be familiar with a broad range of technologies and environments, and you work to keep abreast of new developments. 

We’ve left the most basic characteristics until last. All Pragmatic Programmers share them. They’re basic enough to state as tips:

**TIP 1:** Care About Your Craft

**TIP 2:** Think! About Your Work

This isn’t a one-time audit of current practices—it’s an ongoing critical appraisal of every decision you make, every day, and on every development. Never run on auto-pilot. 

## Individual Pragmatists, Large Teams

The construction of software should be an engineering discipline. However, this doesn’t preclude individual craftsmanship. Within the overall structure of a project there is always room for individuality and craftsmanship.

## It’s a Continuous Process

*A tourist visiting England’s Eton College asked the gardener how he got the lawns so perfect. “That’s easy,” he replied, “You just brush off the dew every morning, mow them every other day, and roll them once a week.”* 

*“Is that all?” asked the tourist.*

*“Absolutely,” replied the gardener. “Do that for 500 years and you’ll have a nice lawn, too.”*

# Chapter 1 - A Pragmatic Philosophy

Being responsible, Pragmatic Programmers won’t sit idly by and watch their projects fall apart through neglect.

## 1 The Cat Ate My Source Code

*The greatest of all weaknesses is the fear of appearing weak.* - J. B. Bossuet, Politics from Holy Writ, 1709

A Pragmatic Programmer takes charge of his or her own career, and isn’t afraid to admit ignorance or error.

Despite thorough testing, good documentation, and solid automation, things go wrong.

We can be proud of our abilities, but we must be honest about our shortcomings—our ignorance as well as our mistakes.

### Take Responsibility

Don’t blame someone or something else, or make up an excuse. Don’t blame all the problems on a vendor, a programming language, management, or your coworkers. Any and all of these may play a role, but it is up to you to provide solutions, not excuses.

**TIP 3:** Provide Options, Don’t Make Lame Excuses

## 2 Software Entropy 

Entropy is a term from physics that refers to the amount of “disorder” in a system. Unfortunately, the laws of thermodynamics guarantee that the entropy in the universe tends toward a maximum. When disorder increases in software, programmers call it “software rot.”

Researchers in the field of crime and urban decay discovered a fascinating trigger mechanism, one that very quickly turns a clean, intact, inhabited building into a smashed and abandoned derelict. One broken window, left unrepaired for any substantial length of time, instills in the inhabitants of the building a sense of abandonment a sense that the powers that be don’t care about the building.

**TIP 4: Don’t Live with Broken Windows**

Don’t leave “broken windows” (bad designs, wrong decisions, or poor code) unrepaired. Fix each one as soon as it is discovered. If there is insufficient time to fix it properly, then board it up. Perhaps you can comment out the offending code, or display a "Not Implemented" mes- sage, or substitute dummy data instead. Take some action to prevent further damage and to show that you’re on top of the situation.

By the same token, if you find yourself on a team and a project where the code is pristinely beautiful—cleanly written, well designed, and elegant you will likely take extra special care not to mess it up, just like the firefighters. Even if there’s a fire raging (deadline, release date, trade show demo, etc.), you don’t want to be the first one to make a mess.

## 3 Stone Soup and Boiled Frogs

You may be in a situation where you know exactly what needs doing and how to do it. The entire system just appears before your eyes you know it’s right. But ask permission to tackle the whole thing and you’ll be met with delays and blank stares. People will form committees, budgets will need approval, and things will get complicated. Everyone will guard their own resources. Sometimes this is called “start-up fatigue.”

Work out what you can reasonably ask for. Develop it well. Once you’ve got it, show people, and let them marvel. Then say “of course, it would be better if we added .” Pretend it’s not important. Sit back and wait for them to start asking you to add the functionality you originally wanted. People find it easier to join an ongoing success.

**TIP 5** Be a Catalyst for Change

Most software disasters start out too small to notice, and most project overruns happen a day at a time. Systems drift from their
specifications feature by feature, while patch after patch gets added to a piece of code until there’s nothing of the original left. It’s often the accumulation of small things that breaks morale and teams.

**TIP 6** Remember the Big Picture 

## 4 Good-Enough Software

<mark>The real world just won’t let us produce much that’s truly perfect, particularly not bug-free software. Time, technology, and temperament all conspire against us. Discipline yourself to write software that’s good enough—good enough for your users, for future maintainers, for your own peace of mind. </mark>

The phrase “good enough” does not imply sloppy or poorly produced code. All systems must meet their users’ requirements to be successful. We are simply advocating that users be given an opportunity to participate in the process of deciding when what you’ve produced is good enough.

### Involve Your Users in the Trade-Off

Normally you’re writing software for other people. How often do you ask them how good they want their software to be? Sometimes there’ll be no choice. If you’re working on pacemakers. However, if you’re working on a brand new product, you’ll have different constraints. The marketing people will have promises to keep, the eventual end users
may have made plans based on a delivery schedule, and your company will certainly have cash-flow constraints. **It would be unprofessional to ignore these users’ requirements simply to add new features to the program, or to polish up the code just one more time.** 

**TIP 7** Make Quality a Requirements Issue

### Know When to Stop 

Programming is like painting. You start with a blank canvas and materials. You use science, art, and craft to determine what to do with them. You sketch out an overall shape, paint the underlying environment, then fill in the details. You constantly step back with a critical eye to view what you’ve done. Every now and then you’ll throw a canvas away and start again.

But artists will tell you that all the hard work is ruined if you don’t know when to stop. If you add layer upon layer, detail over detail, the painting becomes lost in the paint.

## 5 Your Knowledge Portfolio

Your knowledge becomes out of date as new techniques, languages, and environments are developed. Your knowledge is a <mark>they’re expiring asset.</mark>

Managing a knowledge portfolio is very similar to managing a financial portfolio:

1. Serious investors invest regularly—as a habit.
2. Diversification is the key to long-term success.
3. Smart investors balance their portfolios between conservative and high-risk, high-reward investments.
4. Investors try to buy low and sell high for maximum return.
5. Portfolios should be reviewed and rebalanced periodically.

**TIP 8** Invest Regularly in Your Knowledge Portfolio

### Goals
1. Learn at least one new language every year. 
2. Read a technical book each quarter.
3. Read nontechnical books, too.
4. Take classes. 
5. Participate in local user groups. 
6. Experiment with different environments. 
7. Stay current.
8. Get wired.

## Critical Thinking 

You need to ensure that the knowledge in your portfolio is accurate and unswayed by either vendor or media hype. Never underestimate the power of commercialism. Just because a Web search engine lists a hit first doesn’t mean that it’s the best match. 

**TIP 9** Critically Analyze What You Read and Hear

There are very few simple answers.

## 6 Communicate!

### Know What You Want to Say

Plan what you want to say. Write an outline. Then ask yourself, “Does this get across whatever I’m trying to say?” Refine it until it does. 

<mark>This approach is not just applicable to writing documents. When you’re faced with an important meeting or a phone call with a major client, jot down the ideas you want to communicate, and plan a couple of strategies for getting them across.</mark>

### Know Your Audience

We’ve all sat in meetings where a development geek glazes over the eyes of the vice president of marketing with a long monologue on the merits of some arcane technology.  **This isn’t communicating: it’s just talking, and it’s annoying.**

```
# The WISDOM acrostic—understanding an audience

                    What do you want them to learn?
      What is their Interest in what you’ve got to say?
                How Sophisticated are they?
           How much Detail do they want?
Whom do you want to Own the information?
        How can you Motivate them to listen to you?

What
Interest
Sophisticated
Detail
Own
Motivate
```

### Choose Your Moment

It’s six o’clock on Friday afternoon, following a week when the auditors have been in.and your boss’s youngest is in the hospital. probably isn’t a good time to ask her for a memory upgrade for your PC.

### Choose a Style

Adjust the style of your delivery to suit your audience. 

### Make It Look Good

Your ideas are important. They deserve a good-looking vehicle to convey them to your audience. <mark>Any chef will tell you that you can slave in the kitchen for hours only
to ruin your efforts with poor presentation.</mark>

!!! Check the spelling and basic grammar !!! 

### Involve Your audience

Involve your readers with early drafts of your document. Get their feedback, and pick their brains. 

### Be a Listener

<mark>There’s one technique that you must use if you want people to listen to you: listen to them.</mark> 

Even if this is a situation where you have all the information, even if this is a formal meeting with you standing in front of 20 suits—if you don’t listen to them, they won’t listen to you.

### Get Back to people

Always respond to e-mails and voice mails, even if the response is simply “I’ll get back to you later.” Keeping people informed makes them far more forgiving of the occasional slip, and makes them feel that you haven’t forgotten them.

**TIP 10** It’s Both What You Say and the Way You Say It

# Chapter 2 A Pragmatic Approach

## 7 The Evils of Duplication

Most people assume that maintenance begins when an application is released, that maintenance means fixing bugs and enhancing features. We think these people are wrong. Programmers are constantly in maintenance mode. Our understanding changes day by day.

We feel that the only way to develop software reliably, and to make our developments easier to understand and maintain, is to follow what we call the DRY principle:

EVERY PIECE OF KNOWLEDGE MUST HAVE A SINGLE, UNAMBIGUOUS, AUTHORITATIVE REPRESENTATION WITHIN A SYSTEM,

**TIP 11** DRY — Don’t Repeat Yourself

### How Does Duplication Arise?

- **Imposed duplication.** Developers feel they have no choice—the environment seems to require duplication.
- **Inadvertent duplication.** Developers don’t realize that they are duplicating information.
- **Impatient duplication.** Developers get lazy and duplicate because it seems easier.
- **Interdeveloper duplication.** Multiple people on a team (or on different teams) duplicate a piece of information

**TIP 12** Make It Easy to Reuse

## 8 Orthogonality

“Orthogonality” is a term borrowed from geometry. Two lines are orthogonal if they meet at right angles, such as the axes on a graph. 

In computing, the term has come to signify a kind of independence or decoupling. Two or more things are orthogonal if changes in one do not affect any of the others. In a well-designed system, the database code will be orthogonal to the user interface: you can change the interface without affecting the database, and swap databases without changing the interface.

### A Nonorthogonal System 

Helicopter controls are decidedly not orthogonal. Your hands and feet are constantly moving, trying to balance all the interacting forces.

Nonorthogonal systems are inherently more complex to change and control.

### Benefits of Orthogonality

**TIP 13** Eliminate Effects Between Unrelated Things

You get two major benefits if you write orthogonal systems: increased productivity and reduced risk.

Most developers are familiar with the need to design orthogonal systems, although they may use words such as modular, component-based, and layered to describe the process. Systems should be composed of a set of cooperating modules, each of which implements functionality independent of the others.

There is an easy test for orthogonal design. Once you have your components mapped out, ask yourself: If I dramatically change the requirements behind a particular function, how many modules are affected? In an orthogonal system, the answer should be “one.” In reality, this is naive. Unless you are remarkably lucky, most real-world requirements changes will affect multiple functions in the system. However, if you analyze the change in terms of functions, each functional change should still ideally affect just one module.

### Toolkits and Libraries 

Be careful to preserve the orthogonality of your system as you introduce third-party toolkits and libraries. Choose your technologies wisely.

When you bring in a toolkit (or even a library from other members of your team), ask yourself whether it imposes changes on your code that shouldn’t be there.

### Coding 

There are several techniques you can use to maintain orthogonality:
* Keep your code decoupled. 
* Avoid global data
* Avoid similar functions.

## 9 Reversibility

Engineers prefer simple, single solutions to problems. Management tends to agree with the engineers: single, easy answers fit nicely on spreadsheets and project plans. If only the real world would cooperate!

There is always more than one way to implement something, and there is usually more than one vendor available to provide a third-party product. 

If you go into a project hampered by the myopic notion that there is only one way to do it, you may be in for an unpleasant surprise. 

*“But you said we’d use database XYZ! We are 85% done coding the project, we can’t change now!” the programmer protested. “Sorry, but our company decided to standardize on database PDQ instead—for all projects. It’s out of my hands. We’ll just have to recode. All of you will be working weekends until further notice.”*

Suppose you decide, early in the project, to use a relational database from vendor A. Much later, during performance testing, you discover that the database is simply too slow, but that the object database from vendor B is faster. With most conventional projects, you’d be out of luck. Most of the time, calls to third-party products are entangled throughout the code. But if you really abstracted the idea of a database out to the point where it simply provides persistence as a service then you have the flexibility to change horses in midstream.

**TIP 14** There Are No Final Decisions

## 10 Tracer Bullets

*Ready, fire, aim...*

Tracer bullets are loaded at intervals on the ammo belt alongside regular ammunition. When they’re fired, their phosphorus ignites and leaves a pyrotechnic trail from the gun to whatever they hit. If the tracers are hitting the target, then so are the regular bullets.

### Code That Glows in the Dark

**TIP 15** Use Tracer Bullets to Find the Target

To get the same effect in code, we’re looking for something that gets us from a requirement to some aspect of the final system quickly, visibly, and repeatably.

<mark>Tracer code is not disposable: you write it for keeps. It contains all the error checking, structuring, documentation, and self-checking that any piece of production code has. It simply is not fully functional.</mark> However, once you have achieved an end-to-end connection among the components of your system, you can check how close to the target you are, adjusting if necessary. Once you’re on target, adding functionality is easy.

The tracer code approach has many advantages:
- Users get to see something working early.
- Developers build a structure to work in.
- You have an integration platform.
- You have something to demonstrate. 
- You have a better feel for progress.

### Tracer Bullets Don’t Always Hit Their Target

You use the technique in situations where you’re not 100% certain of where you’re going. You shouldn’t be surprised if your first couple of attempts miss: the user says “that’s not what I meant,” or data you need isn’t available when you need it, or performance problems seem likely. <mark>Work out how to change what you’ve got to bring it nearer the target, and be thankful that you’ve used a lean development methodology.</mark>

### Tracer Code versus Prototyping 

With a prototype, you’re aiming to explore specific aspects of the final system.

<mark>With a true prototype, you will throw away whatever you lashed together when trying out the concept, and recode it properly using the lessons you’ve learned.</mark>

The tracer code approach addresses a different problem. You need to know how the application as a whole hangs together. You want to show your users how the interactions will work in practice, and you want to give your developers an architectural skeleton on which to hang code.

## 11 Prototypes and Post-it Notes

We build software prototypes to analyze and expose risk, and to offer chances for correction at a greatly reduced cost. Like the car makers, we can target a prototype to test one or more specific aspects of a project.

Prototypes are designed to answer just a few questions, so they are much cheaper and faster to develop than applications that go into production. The code can ignore unimportant details—unimportant to you at the moment, but probably very important to the user later on. If you are prototyping a GUI, for instance, you can get away with incorrect results or data. 

### Things to Prototype 

- Architecture
- New functionality in an existing system
- Structure or contents of external data
- Third-party tools or components
- Performance issues
- User interface design

**TIP 16** Prototype to Learn

### How Not to Use Prototypes

<mark>Before you embark on any code-based prototyping, make sure that everyone understands that you are writing disposable code.</mark>Prototypes can be deceptively attractive to people who don’t know that they are just prototypes. You must make it very clear that this code is disposable, incomplete, and unable to be completed.

## 12 Domain Languages

Languages influence how you think about a problem, and how you think about communicating. 

**TIP 17** Program Close to the Problem Domain

## 13 Estimating

**TIP 18** Estimate to Avoid Surprises

### How Accurate Is Accurate Enough? 

One of the interesting things about estimating is that the units you use make a difference in the interpretation of the result.

If you say that something will take about 130 working days, then people will be expecting it to come in pretty close.

If you say "about six months" then they know to look for it any time between five and seven months from now.

| Duration     | Quote     |
|--------------|-----------|
| 1–15 days    | days      |
| 3–8 weeks    | weeks     |
| 8-30 weeks   | months    |
| 30+ weeks    | think hard before giving an estimate     |

### Where Do Estimates Come From? 

**Understand What’s Being Asked** - The first part of any estimation exercise is building an understanding of what’s being asked. As well as the accuracy issues discussed above, you need to have a grasp of the scope of the domain.

**Build a Model of the System** - From your understanding of the question being asked, build a rough and ready bare-bones mental model. If you’re estimating response times, your model may involve a server and some kind of arriving traffic. 

**Break the Model into Components** - Once you have a model, you can decompose it into components. You’ll need to discover the mathematical rules that describe how these components interact.

**Give Each Parameter a Value** - Once you have the parameters broken out, you can go through and assign each one a value. You expect to introduce some errors in this
step. The trick is to work out which parameters have the most impact on the result, and concentrate on getting them about right. 

### Keep Track of Your Estimating Prowess

We think it’s a great idea to record your estimates so you can see how close you were. If an overall estimate involved calculating sub estimates, keep track of these as well. Often you’ll find your estimates are pretty good—in fact, after a while, you’ll come to expect this.

### Estimating Project Schedules 

The normal rules of estimating can break down in the face of the complexities and vagaries of a sizable application development. 

**TIP 19** Iterate the Schedule with the Code

This may not be popular with management, who typically want a single, hard-and-fast number before the project even starts. You’ll have to help them understand that the team, their productivity, and the environment will determine the schedule. By formalizing this, and refining the schedule as part of each iteration, you’ll be giving them the most accurate scheduling estimates you can.

### What to Say When Asked for an Estimate 

You say "I’ll get back to you."

# Chapter 3 The Basic Tools

Every craftsman starts his or her journey with a basic set of good quality tools. Each tool will have its own personality and quirks, and will need its own special handling. Tools amplify your talent. The better your tools, and the better you know how to use them, the more productive you can be. 

Like the craftsman, expect to add to your toolbox regularly. Always be on the lookout for better ways of doing things.

## 14 The Power of Plain Text

Plain text is made up of printable characters in a form that can be read and understood directly by people.

Plain text doesn’t mean that the text is unstructured; XML, SGML, and HTML are great examples of plain text that has a well-defined structure.

**TIP 20** Keep Knowledge in Plain Text

### Insurance Against Obsolescence

Human-readable forms of data, and self-describing data, will outlive all other forms of data and the applications that created them. Period.

Virtually every tool in the computing universe, from source code management systems to compiler environments to editors and stand-alone filters, can operate on plain text.

## 15 Shell Games

Every woodworker needs a good, solid, reliable workbench, for a programmer manipulating files of text, that workbench is the command shell. From the shell prompt, you can invoke your full repertoire of tools, using pipes to combine them in ways never dreamt of by their original developers. 

**TIP 21** Use the Power of Command Shells

## 16 Power Editing

You need to be able to manipulate text as effortlessly as possible, because text is the basic raw material of programming.

### One Editor 

We think it is better to know one editor very well, and use it for all editing tasks code, documentation, memos, system administration, and so on.

**TIP 22** Use a Single Editor Well

## 17 Source Code Control

**TIP 23** Always Use Source Code Control

Always. Even if you are a single-person team on a one-week project. Even if it’s a “throw-away” prototype. Even if the stuff you’re working on isn’t source code. Make sure that everything is under source code control—documentation, phone number lists, memos to vendors, makefiles, build and release procedures, that little shell script that burns the CD master—everything. We routinely use source code control on just about everything we type (including the text of this book). Even if we’re not working on a project, our day-to-day work is secure in a repository.


<mark>There is a tremendous hidden benefit in having an entire project under the umbrella of a source code control system: you can have product builds that are automatic and repeatable.</mark>

## 18 Debugging

No one writes perfect software, so it’s a given that debugging will take up a major portion of your day. 

### Psychology of Debugging 

Debugging itself is a sensitive, emotional subject for many developers. Instead of attacking it as a puzzle to be solved.

**TIP 24** Fix the Problem, Not the Blame

### A Debugging Mindset 

You need to turn off many of the defenses you use each day to protect your ego, tune out any project pressures you may be under, and get yourself comfortable. Above all, remember the first rule of debugging: Don't Panic!

**TIP 25** Don't Panic

### Where to Start 

Before you start to look at the bug, make sure that you are work ing on code that compiled cleanly—without warnings. 

You may need to interview the user who reported the bug in order to gather more data than you were initially given.

Artificial tests (such as the programmer’s single brush stroke from bottom to top) don’t exercise enough of an application. You must brutally test both boundary conditions and realistic end-user usage patterns. 

<mark>The best way to start fixing a bug is to make it reproducible. After all, if you can’t reproduce it, how will you know if it is ever fixed?</mark>

### Tracing

Debuggers generally focus on the state of the program now. Sometimes you need more—you need to watch the state of a program or a data structure over time.

Tracing statements are those little diagnostic messages you print to the screen or to a file that say things such as “got here” and “value of x = 2.” It’s a primitive technique compared with IDE-style debuggers, but it is peculiarly effective at diagnosing several classes of errors that debuggers can’t.

### Rubber Ducking 

A very simple but particularly useful technique for finding the cause of a problem is simply to explain it to someone else. The other person should look over your shoulder at the screen, and nod his or her head constantly (like a rubber duck bobbing up and down in a bathtub). They do not need to say a word; the simple act of explaining, step by step, what the code is supposed to do often causes the problem to leap off the screen and announce itself.

### Process of Elimination

**TIP 26** “select” Isn’t Broken

### The Element of Surprise

When you find yourself surprised by a bug (perhaps even muttering “that’s impossible” under your breath where we can’t hear you), you must reevaluate truths you hold dear.

**TIP 27** Don't Assume It - Prove IT

## 19 Text Manipulation

Pragmatic Programmers manipulate text the same way woodworkers shape wood. Text manipulation languages are to programming what routers. Here router means the tool that spins cutting blades very, very fast, not a device for interconnecting networks. They are noisy, messy, and somewhat brute force. Make mistakes with them, and entire pieces can be ruined

**TIP 28** Learn a Text Manipulation Language

## 20 Code Generators

**TIP 29** Write Code That Writes Code

### Passive Code Generators

Passive code generators save typing. They are basically parameterized templates, generating a given output from a set of inputs. Once the result is produced, it becomes a full-fledged source file in the project; it will be edited, compiled, and placed under source control just like any other file. Its origins will be forgotten.

### Active Code Generators 

With an active code generator, you can take a single representation of some piece of knowledge and convert it into all the forms your application needs. This is not duplication, because the derived forms are disposable, and are generated as needed by the code generator (hence the word active).

# Chapter 4 Pragmatic Paranoia

**TIP 30** You Can’t Write Perfect Software

Everyone knows that they personally are the only good driver on Earth. The rest of the world is out there to get them. So we drive defensively. We look out for trouble before it  happens and anticipate the unexpected.

We are constantly interfacing with other people’s code—code that might not live up to our high standards—and dealing with inputs that may or may not be valid. So we are taught to code defensively.

Pragmatic Programmers take this a step further. They don’t trust themselves, either. Knowing that no one writes perfect code, including themselves, Pragmatic Programmers code in defenses against their own mistakes.

## 21 Design by Contract

A contract defines your rights and responsibilities, as well as those of the other party. In addition, there is an agreement concerning repercussions if either party fails to abide by the contract.

Design by Contract (DBC, for short).

Every function and method in a software system does something. Before it starts that something, the routine may have some expectation of the state of the world, and it may be able to make a statement about the state of the world when it concludes. Meyer describes these expectations and claims as follows:
- Preconditions - What must be true in order for the routine to be
called.
- Postconditions - What the routine is guaranteed to do.
- class invariants - A class ensures that this condition is always
true from the perspective of a caller.

*If all the routine’s preconditions are met by the caller, the routine shall guarantee that all postconditions and invariants will be true when it completes.*

**TIP 31** Design with Contracts

## 22 Dead Programs Tell No Lies

It’s easy to fall into the “it can’t happen” mentality. Most of us have written code that didn’t check that a file closed successfully, or that a trace statement got written as we expected. And all things being equal, it’s likely that we didn’t need to—the code in question wouldn’t fail under any normal conditions. But we’re coding defensively.

All errors give you information. You could convince yourself that the error can’t happen, and choose to ignore it. Instead, Pragmatic Programmers tell themselves that if there is an error, something very, very bad has happened.

**TIP 32** Crash Early

### Crash, Don’t Trash

Many times, crashing your program is the best thing you can do. The alternative may be to continue, writing corrupted data to some vital database or commanding the washing machine into its twentieth consecutive spin cycle. <mark>A dead program normally does a lot less damage than a crippled one.</mark>

## 23 Assertive Programming

It seems that there’s a mantra that every programmer must memorize early in his or her career. "THIS CAN NEVER HAPPEN..." "This code won’t be used 30 years from now, so two-digit dates are fine." "This application will never be used abroad, so why internationalize it?" "count can’t be negative." "This printf can’t fail."

> **TIP 33** -- If It Can’t Happen, Use Assertions to Ensure That It Won’t

Don’t use assertions in place of real error handling. Assertions check for things that should never happen.

### Leave Assertions Turned On

There is a common misunderstanding about assertions, promulgated by the people who write compilers and language environments:

"Assertions add some overhead to code. Because they check for things that should never happen, they’ll get triggered only by a bug in the code. Once the code has been tested and shipped, they are no longer needed, and should be turned off to make the code run faster. Assertions are a debugging facility."

There are two patently wrong assumptions here.
* First, they assume that testing finds all the bugs. In reality, for any complex program you are unlikely to test even a miniscule percentage of the permutations
your code will be put through.
* Second, the optimists are forgetting that your program runs in a dangerous world. During testing, rats probably won’t gnaw through a communications cable, someone playing a game won’t exhaust memory, and log files won’t fill the hard drive. These things might happen when your program runs in a production environment. Your first line of defense is checking for any possible error, and your second is using assertions to try to detect those you’ve missed.

Turning off assertions when you deliver a program to production is like crossing a high wire without a net because you once made it across in practice. There’s dramatic value, but it’s hard to get life insurance.

## 24 When to Use Exceptions

We believe that exceptions should rarely be used as part of a program’s normal flow; <mark> exceptions should be reserved for unexpected events.</mark>

Assume that an uncaught exception will terminate your program and ask yourself, “Will this code still run if I remove all the exception handlers?” If the answer is "no," then maybe exceptions are being used in non-exceptional circumstances.

For example, if your code tries to open a file for reading and that file does not exist, should an exception be raised? 

Our answer is, **"It depends."**

* If the file _should_ have been there, then an exception **is** warranted. Something unexpected happened. A file you were expecting to exist disappeared. 
* If you have no idea whether the file should exist or not, then it doesn’t seem exceptional if you can’t find it, and an error return is appropriate.

> **TIP 34** -- Use Exceptions for Exceptional Problems

Programs that use exceptions as part of their normal processing suffer from all the readability and maintainability problems
of classic spaghetti code.

### Error Handlers Are an Alternative

An error handler is a routine that is called when an error is detected.

You can register a routine to handle a specific category of errors. 

There are times when you may want to use error handlers, either in-stead of or alongside exceptions.

Clearly, if you are using a language such as C, which does not support exceptions, this is one of your few other options. However, sometimes
error handlers can be used even in languages (such as Java) that have
a good exception handling scheme built in.

## 25 How to Balance Resources

We all manage resources whenever we code: memory, transactions, threads, files, timers—all kinds of things with limited availability.

> **TIP 35** -- Finish What You Start

It simply means that the routine or object that allocates a resource should be responsible for deallocating it. 


### Nest Allocations

The basic pattern for resource allocation can be extended for routines that need more than one resource at a time. There are just two more suggestions:

1. <mark>Deallocate resources in the opposite order to that in which you allocate them. That way you won’t orphan resources if one resource contains references to another.</mark>
2. When allocating the same set of resources in different places in your code, always allocate them in the same order. This will reduce the possibility of deadlock. 

### Objects and exceptions

If you are programming in an object-oriented language, you may find it useful to encapsulate resources in classes. Each time you need a particular resource type, you instantiate an object of that class. When the object goes out of scope, or is reclaimed by the garbage collector, the object’s destructor then deallocates the wrapped resource.

### Balancing and Exceptions 

If an exception is thrown, how do you guarantee that everything allocated prior to the exception is tidied up? **The answer depends to some extent on the language.**

# Chapter 5 - Bend, or Break

In order to keep up with today’s near-frantic pace of change, we need to make every effort to write code that’s as loose—as flexible—as possible. In this chapter, we’ll tell you how to make reversible decisions, so your code can stay flexible and adaptable in the face of an uncertain world.

## 26 Decoupling and the Law of Demeter

Organize your code into cells (modules) and limit the interaction between them. 

What’s wrong with having modules that know about each other? Nothing in principle — we don’t need to be as paranoid as spies or dissidents. However, you do need to be careful about how many other modules you interact with and, more importantly, how you came to interact with them.


Traversing relationships between objects directly can quickly lead to a combinatorial explosion of dependency relationships. If `n` objects all know about each other, then a change to just one object can result
in the other `n -1` objects needing changes

You can see symptoms of this phenomenon in a number of ways:
* Simple changes to one module that propagate through unrelated modules in the system.
* Developers who are afraid to change code because they aren’t sure what might be affected.

Systems with many unnecessary dependencies are very hard and expensive to maintain, and tend to be highly unstable. 

### The Law of Demeter for Functions 

> **TIP 36** -- Minimize Coupling Between Modules

The Law of Demeter for functions states that any method of an object should call only methods belonging to:
1. itself
2. any parameters that were passed in to the method
3. any objects it created
4. any directly held component objects

```
class Demeter {
    private:
        A *a;
        int func();
public:
    //...
    void example(B& b);
}

void Demeter::example(B& b) { // 
    C c;
    int f = func();     // <= 1. itself
    b.invert();         // <= 2. any parameters that were passed in to the method
    a = new A();
    a->setActive();     // <= 3. any objects it created
    c.print();          // <= 4. any directly held component objects
}
```

## ► 27 Metaprogramming

Every time we have to go in and change the code to accommodate some change in business logic, or in the law, or in management’s personal tastes of the day, we run the risk of breaking the system—of introducing
a new bug. So we say “out with the details!” Get them out of the code. 

### Dynamic Configuration

> **TIP 37** -- Configure, Don’t Integrate

First, we want to make our systems highly configurable. Not just things such as screen colors, but deeply ingrained items such as the choice of algorithms, database products, middleware technology, and user-interface style. These items should be implemented as configuration options, not through integration or engineering. Use **metadata** to describe configuration options for an application: tuning parameters, user preferences, the installation directory, and so on.

We use the term in its broadest sense. Metadata is any data that describes the application—how it should run, what resources it should use, and so on. Typically, metadata is accessed and used at runtime, not at compile time.

### Metadata-Driven Applications

> **TIP 38** -- Put Abstractions in Code, Details in Metadata

There are several benefits to this approach:
* It forces you to decouple your design, which results in a more flexible and adaptable program.
* It forces you to create a more robust, abstract design by deferring details—deferring them all the way out of the program
* You can customize the application without recompiling it.
* Metadata can be expressed in a manner that’s much closer to the problem domain than a general-purpose programming language.
* You may even be able to implement several different projects using the same application engine, but with different metadata.

### Business Logic

<mark>Because business policy and rules are more likely to change than any other aspect of the project, it makes sense to maintain them in a very flexible format.</mark>

## ► 28 Temporal Coupling

We are talking about the role of time as a design element of the software itself. There are two aspects of time that are important to us:
* concurrency - things happening at the same time
* ordering - the relative positions of things in time

When people first sit down to design an architecture or write a program, things tend to be linear. That’s the way most people think do this and then always do that.

But thinking this way leads to temporal coupling: coupling in time.
* Method A must always be called before method B;
* only one report can be run at a time;
* you must wait for the screen to redraw before the button click is received.
* Tick must happen before tock.

We need to allow for concurrency and to think about decoupling any time or order dependencies

> **TIP 39** -- Analyze Workflow to Improve Concurrency

One way to do this is to capture their description of workflow using a notation such as the UML activity diagram. You can use diagrams to maximize parallelism by identifying items that could be performed in parallel.

> **TIP 40** -- Design Using Services

Instead of components, we have really created services—independent, concurrent objects behind well-defined, consistent interfaces.

### Design for Concurrency

With linear code, it’s easy to make assumptions that lead to sloppy programming. But concurrency forces you to think through things a bit more carefully—you’re not alone at the party anymore. Because things can now happen at the “same time,” you may suddenly see some time based dependencies.

To begin with, any global or static variables must be protected from concurrent access. 

> **TIP 41** -- Always Design for Concurrency

## ► It’s Just a View