# FRP's

## Who's Who?

Functional Reactive Programming, or FRP for short, was originally
introduced and formalized by Conal Elliott and Paul Hudak in a paper
titled "Functional Reactive Animation" in the late '90s.

In that paper they described a system they called Fran. An interesting
tidbit that isn't apparent from reading that fairly mathematical paper
is that Elliott's reason for creating Fran in the first place was that
he believed in the power of 2d and 3d animation, particularly
interactive animation, as an expressive medium. But he recognized that
because of the difficulty of the current tools for creating that
media, it was only accessible to specialists.

So FRP began as a way to put the power of interactive animation into
the hands of more people. This is one of the main reasons that it was
developed as a declarative language, since Elliott believed that would
be more accessible than the then-current imperative techniques.

Much of the initial research and early implementations of FRP was done
in Haskell.  That work seems to have been motivated at least partly as
a way of dealing with needs of interactive programs written in
Haskell.

More recently, FRP has been gaining broader acceptance with libraries
to implement it in a wide variety of languages, from Java and C++ to
Javascript. In addition, in 2012 a new programming language called Elm
was introduced that has Functional Reactive Programming as the basis
for the entire language.

Much of the research for this talk was drawn from the work of Evan
Czaplicki, the creator of Elm and Stephen Blackheath, the creator of a
library for Functional Reactive Programming called Sodium, and author
of a forthcoming book on FRP.

One of the reasons that FRP doesn't have a more mainstream presence is
because it came out of the Haskell community, and it is very math
heavy. If you look at the original FRP papers, especially those
written by Conal Elliot and Paul Hudak they contain quite a lot of
math, describing what they call the denotational semantics of FRP.

This can be quite daunting to a lot of people (myself included!), and
I think the popularity of FRP as a paradigm has grown in tandem with
the accessibility of the available resources.

## History

### Classical FRP

The original formulation of FRP described in Elliott and Hudak's 1997
paper is sometimes referred to as *Classical FRP*.

They introduced new types of values which they called *behaviors* and
*events*.

Behaviors are modeled as a function from a time to a value.

Events represent a sequence of discrete events as a time stamped list
of values.

One issue with classical FRP was that for a number of reasons, the
initial implementation suffered from both space and time leaks. That
is, sometimes the memory usage of the program would grow unexpectedly
(space leak) and sometimes the computations would run expectedly long
(time leak).

### Real-time FRP

In an effort to deal with some of the inefficiecies of classical FRP,
Hudak formulated Real-time FRP or RT-FRP.  It used a simple mental
model, with only one type for representing both Events and
Behaviors. This new type is typically called *Signal*.

This was somewhat less expressive than Classical FRP, especially in
regard to how the connections between signals could be defined.

### Event-driven FRP

Event-driven FRP or E-FRP introduced discrete signals. The importance
of this is that unlike in RT-FRP or Classical FRP, no changes need to
be propagated unless an event has occurred.

In the classical formulation of FRP, Behaviours are viewed as
continuous, time-varying values.

However, it seems like RT-FRP and E-FRP fell by the wayside.

### Arrowized FRP

> Arrowized FRP [28] aims to maintain the full expressiveness of
> Classical FRP without the difficult-to-spot space and time leaks.

Formulated by Henrik Nilsson, Antony Courtney and John Peterson in
2002 at Yale University, Arrowized FRP makes use of signal-functions,
that is, a function from signal to signal.

In addition signals are not directly accessible to the
programmer. Instead, the programmer works with signal-functions.

The purpose of this is largely to ensure that space and time leaks
cannot occur, at least in the implementation.

## Push-based or Event-driven FRP (i.e. Elm)

In his thesis describing the Elm system, Evan Czaplicki reviews all of
these incarnations of FRP and analyzes their attributes in some
depth. In particular, he looked closely at the kinds of inefficiencies
that each conception was prone to.

One of his conclusions was that the focus on a continuous semantics
for signals or behaviors was actually a foundational issue in all of
them.

Czaplicki set out to describe an FRP implementation that would be
push-based or event-driven.

Elm also drew inspiration from message-passing concurrency and in
particular Concurrent ML.

Interestingly, to come full circle, Czaplicki also felt that most of
the implementations of FRP to-date had been less easily accessible in
terms of "ease of installation, quality of documentation and examples
and apparent conceptual difficulty."

So another goal of his with Elm was to make a very easily accessible
FRP implementation.
