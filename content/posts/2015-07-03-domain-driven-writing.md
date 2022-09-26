+++
layout = "post"
title = "Domain Driven Writing"
comments = "true"
categories = []
+++

I've been reading _Domain Driven Design_ by Eric Evans for the past
month or so, and thinking about the ideas and concepts in it has been
consuming a lot of my mental space and time. One thing in particular
that I've found to be really interesting is his concept of developing
a __Ubiquitous Language__ for the project.

At a very high level, the idea of having a Ubiquitous Language for a
project just means that there is specific vocabulary and jargon that
is used to describe certain key concepts about the domain of the
project and the particular implementation that the team is
developing. Or to put it even more simply, that when someone on the
team uses a word or a phrase, everyone else knows what they are
talking about.

<!--more-->

This is actually something that people do constantly. You build up a
common language with the people you are closest to: your family,
friends, teammates at work. I know that my group of close friends has
a very particular way of speaking with one another, that probably
sounds somewhat odd to "outsiders."

Sometimes it happens organically over a long period of time, and
sometimes we do it intentionally. My favorite example of this second
category are the talks that Rich Hickey gives. Some of them at least
have followed a particular format. He starts with the definition of a
word, possibly two. He defines them precisely, and he defines the
context that he is talking within. He then builds on this definition
to talk about some fundamental idea in programming, or some insight
that this rigorous definition gave him.

The key part though, is that a good portion of his talk is given to
building up a sort of basic common language so that he is confident
that when he uses a word, we understand as well as we possibly can
what he intended by saying it.

A good friend of mine often has a very hard time with this. I have had
many conversations with him about interesting and deep topics that
have turned into arguments, largely about what a particular word
means. The problem is often that he has a deeper context and specific
meaning that he intends when he says something. But because I haven't
studied the same things or shared the same experiences, I don't
realize he means something different than usual.

I wish I had a concrete example that I could talk about, because this
sounds very wish-washy.


### A Slight Digression

I'm strangely reminded of the final program from Mark Pilgrim's
excellent - though sorely out-dated - _Dive Into Greasemonkey_. He
spends the first several tens of lines of code writing some facilities
that will make programming Javascript more reminiscent of programming
in Python because he's so familiar with Python.

One thing that Eric Evans returns to throughout _DDD_ is leaning on
the _Ubiquitous Language_ of the project to suss out design issues
early. He emphasizes that we should try and engage all of our ways of
communicating and understanding the ideas of the project: with
language, with diagrams, and with code.

Uncle Bob has written at length about how (good) tests are really
specifications for how a program works. They should clearly
communicate the intent of the system.

Gerald Sussman and Hal Abelson write in the preface to their classic
_Structure and Interpretation of Computer Programs_ that they believe
that programming is not just an activity concerned with causing
computers to enact computations. It is much more importantly "a novel
formal medium for expressing ideas about process."

These two ideas, tests as specifications, and computer languages as
formal language describing processes have started to seem intimately
connected to me.


### Automation and Communication

Several years ago I was working on a project to build a video game AI
with several other students at my university. Another student and I
were pioneering the project, and in particular I took on the task of
figuring out how to get the development environment working on the
Computer Science lab machines.

This setup was non-trivial. It involved setting environment variables,
setting compatibility flags on the game executable, and installing
plugins into the game's binary directory. On top of that, but because
of the way the lab machines were setup, there was additional setup
that needed to be done at the start of *every development session*.

Once I had gotten everything working through a long process of trial
and error, I then set about attempting to duplicate my success from a
clean profile. As I figured out the minimal set of setup steps, I
wrote them down. I then proceeded to test the quality of these
instructions by handing them off to another student to replicate with
me watching over his shoulder.

You will of course be shocked to learn that he had almost no success
in following the steps I had written down. This is because I had
written them in enough detail for me to understand and remember
what needed to be done, but there was still a huge amount of context
for those instructions that resided only in my own head. Context that
I head gained by the laborious trial, error and troubleshooting
process of setting the environment up initially.

I iterated on the instructions several more times, each time finding
some new guinea pig to test them on. Until eventually, I came to the
conclusion that I would actually need pictures of the GUI dialogs and
full nearly click-by-click instructions in order to get a set of
instructions that other students could follow without making mistakes.

At that moment, I realized that I would be far less work, both
up-front and continuing to simply figure out how to write code to
automate the development environment setup.

This seems like a no-brainer. Write two scripts one time, spend a few
hours figuring out the nuances of scripting Windows and then tell
people "Download those two scripts. Run this one once, then run that
one every time you want to work on the project." Done.

The problem for me is the same problem that a math tutor has with
simply telling the student the formula they need to use to calculate
the answer. There is a *lot* of important context that is missing.

My setup script was incredibly effective. Not only did it flawlessly
setup up the dev environment, but it was at least an order of
magnitude faster than for a human to accomplish the same tasks.

That small script I wrote, expressed the idea of how to setup that
development environment incredibly precisely. But there was now
something missing. There was no context for that process to fit in
to. The why of it was lost, and all that was left was for people to
run it.

Even reading the contents of the script, it was possible to determine
what it did, but the *why* was completely missing.

I think testing, at it's very best, can start to supplement this
deficiency in code. It can help to answer the question "Yes, it
works. But why does it do it *that* way?"

#### p.s.

Some interesting papers that are somewhat related to this post:

- [Notation as a Tool of Thought](https://www.recurse.com/blog/58-paper-of-the-week-notation-as-a-tool-of-thought)
- [Growing A Language](https://www.recurse.com/blog/41-introducing-paper-of-the-week)
