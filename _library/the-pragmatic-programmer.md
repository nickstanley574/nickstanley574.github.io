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