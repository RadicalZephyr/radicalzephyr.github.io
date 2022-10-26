+++
layout = "post"
title = "The Importance of Focusing Small with TDD"
comments = "true"
categories = ["TDD"]
+++

Since I've been an apprentice at 8th Light, I've been focusing on
really trying to _get_ TDD as a practice and a discipline. As part of
that I've done a lot of reading and reflecting on past reading's about
TDD. One thing that jumped out at me about the way that Martin Fowler
and Kent Beck all talk about TDD: they all tend to say mildly
self-deprecating things like: "I'm just not smart enough to hold all
that complexity in my head.  TDD helps me get away with not seeing the
big picture." But I think this statement is fundamentally misleading.

<!--more-->

I was always a little confused when I read statements like that,
because to me the clarity of their writing and thoughts indicate to me
that they are in fact pretty smart. Another way they say it is that
"you don't have to be super smart to do TDD." I think this is a
genuine statement, but it's about marketing TDD than about explaining
how to do it.

When I was writing Tic-Tac-Toe in Ruby during the first month of my
apprenticeship though, I was trying to rigorously test-drive all of
the development in a very intentional way for the first time in my
coding career. As I got into the swing of things, I started noticing
that I was focusing on smaller portions of the code.

Normally when I'm programming, I have something close to
[this experience][dont-interrupt]. I try and build up an understanding
and mental structure of as much of the program as I can hold in my
head at once. I do this largely because if I have the structure of the
whole program in my head then I know that when I make changes, they're
going to be good ones, and remain consistent with the rest of the
program.

[dont-interrupt]: http://heeris.id.au/2013/this-is-why-you-shouldnt-interrupt-a-programmer/

One of the benefits of TDD is that you end up with a
comprehensive test suite for your program as you build it. So instead
of having to build a huge mental model of the software as you are
programming, you can simply make a change and then run the test
suite. This will tell you, with far greater accuracy, whether the
change is consistent with the state of the actual program. There's no
layer of indirection through a potentially inconsistent mental model.

So, having tests allows you not to have a large mental model of the
program you're building. Another (desirable!) consequence of rigorous
test-driving is a well-factored design. If the components in your
system have small, well-defined responsibilities and interact with
other components in reasonable and well-defined ways the system is
simpler.  When the system is simpler you can get away with having only
a local view of the code when making changes, so you don't have to be
"as smart."

But here's the thing, these are reasons why you can still program
without a comprehensive understanding of the codebase when practicing
TDD. But the revelation that I had, what caused me to say that Martin
Fowler and company are being misleading, is that I think TDD is actually
_easier_ to do when you let go of trying to build a comprehensive mental
model of the code. This is more true the more of that context you can
hold in your head.

I had a friend in college who was arguably a genius. Assignments that
the rest of our class would take a week to do, he would churn out in a
12-hour Mountain Dew-fueled frenzy of coding. He would intentionally
seek to make assignments more challenging - for example doing a simple
assembly language project, he developed an Object Oriented style of
assembly programming because it would have been boring to him
otherwise.

I ended up working with him on a number of projects though, and I
discovered something. I thought that I had a tendency to overengineer
solutions, but my proclivities in that regard were nothing compared to
my friend's.

One summer we decided to create an AI to play the video game StarCraft
and enter it in a contest at the end of the summer.  When we were
planning the architecture of the AI , he immediately started
describing this incredibly elaborate structure, with pluggable modules
that would allow swapping out of different components of the AI, and a
tiered architecture of decision making that would separate the low
level movements of units from the tactical and strategic
decision-making required to win the game.

This structure was impressive and compelling, and we spent weeks
talking about it and sketching diagrams and class hierarchies on the
whiteboard. It would have been helpful to have such a modular
architecture if we had a large team of people working on it, and the
initial meeting seemed to indicate there was a lot of interest. But
after a few weeks, interest in the project waned and most people
drifted away and that grand architecture was never needed and never
built.


From what I've seen, most of the best programmers that I know have
this tendency to over-engineer solutions. From what I've read, this is
not an isolated phenomenon in my social circle.

This type of pure thought design work is actually very similar to
building a mental model of how a piece of software works. It's really
just a change in tense: over-engineering is just building a mental
model of how a piece of software _will_ work, in the future. I'm sure
there is some fascinating psychology behind why this is such a common
tendency. I think what focusing on TDD in this intensive way taught me
is that the smaller your mental model of a piece of software is, the
more restricted your focus is, and the easier it is to refrain from
attempting to over-engineer it.
