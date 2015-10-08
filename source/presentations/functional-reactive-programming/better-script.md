# FRP's

## What is it?

At an extremely high-level, Functional Reactive Programming is about
datatypes that represent a value 'over time'.

This is diametrically opposed to how we deal with time in imperative
or object oriented languages, which is typically with mutation of
state, or creation of new values that are only conceptually related to
the old values.

That's sort of abstract though. Let's dive into it a little bit
deeper.

From one perspective it's just a concatenation of two other types of
programming: Functional Programming, and Reactive Programming. So
let's talk about those two first.

First, functional programming. According to wikipedia Functional
programming is a style of programming that "treats computation as the
evaluation of mathematical functions and avoids changing-state and
mutable data."

Now the second half, Reactive Programming.  Broadly speaking, Reactive
programming is when a system is

1) event based
2) acts in response to input
3) flow of data (data flow) instead of flow of control.

Or as the wikipedia page says: "a programming paradigm oriented around
data flows and propagation of change"

Intuitively, the most intuitively accessible form of a reactive
program is a spreadsheet with formulas. Formulas can depend on the
values of other cells, which can in turn contain formulas dependent on
other cells.  These eventually depend on cells containing data, and
change is propagated in "natural order" as that data is updated.

Quick Detour: What is "natural order"? Basically, it means to update
everything that a cell depends on before you update that cell. (draw diagram)

Functional Reactive Programming then is simply the combination of
these two paradigms.  As Blackheath and Jones put it:

> (FRP is) A specific method of reactive programming that enforces the
> rules of functional programming.


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

More recently, FRP has been gaining a broader audience with libraries
to implement it in a wide variety of languages, from Java and C++ to
Javascript. In addition, in 2012 a new programming language called Elm
was introduced that has Functional Reactive Programming as the basis
for the entire language.

## History

### Classical FRP

The original formulation of FRP described in Elliott and Hudak's 1997
paper is sometimes referred to as *Classical FRP*.

They introduced new types of values which they called *behaviors* and
*events*.

Behaviors are modeled as a function from a time to a value.

Events represent a sequence of discrete events as a time stamped list
of values.

Work on discrete vs continuous.

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

However, it seems like RT-FRP and E-FRP fell by the wayside.

### Arrowized FRP

> Arrowized FRP [28] aims to maintain the full expressiveness of
> Classical FRP without the difficult-to-spot space and time leaks.
- Elm thesis

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

So another goal of Elm was to make an easily accessible implementation
of FRP.

(25 minutes, generously)

Examples:
