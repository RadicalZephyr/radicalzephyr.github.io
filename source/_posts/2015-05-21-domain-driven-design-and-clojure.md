---
layout: post
title: "Domain Driven Design and Clojure"
date: 2015-05-21 10:41:29 -0500
comments: true
categories: [Clojure]
---

I've been reading an excellent book recently: _Domain Driven Design_
by Eric Evans. I just finished the section on Entities and Value
Objects, and it's caused me to start thinking about Clojure and the
"sane state management model" that language advocates/enforces.

<!--more-->

The model of Clojure state bears some strong similarities to what
Evans talks about when discussing the needs and uses for Entities and
Value Objects. Entities he says should be used to represent things
where their continuity of identity is more important than their
current value. Value Objects are the opposite, the important part of a
Value Object is the data it holds or represents, to the extent that
Value Objects with the same value are totally interchangeable.

He goes on to talk about the benefits immutability and subsequently
safe arbitrary sharing that this interchangeability can give
you. Specifically, the fact that the relative looseness of the
constraints on Value Objects gives you as an engineer more freedom to
implement the Value Objects in your system in a way that has extra
benefits, such as increased performance or memory efficiency.

I'm just going to pull some quotes directly from
[the page on clojure.org about state][clj-state].

[clj-state]: http://clojure.org/state

First, some words about identity:

> While some programs are merely large functions, e.g. compilers or
> theorem provers, many others are not - they are more like working
> models, and as such need to support what I'll refer to in this
> discussion as identity. By identity I mean a stable logical entity
> associated with a series of different values over time. Models need
> identity for the same reasons humans need identity - to represent
> the world. How could it work if identities like 'today' or 'America'
> had to represent a single constant value for all time?

And now, values:

> So, for this discussion, an identity is an entity that has a state,
> which is its value at a point in time. And a value is something that
> doesn't change. 42 doesn't change. June 29th 2008 doesn't
> change. Points don't move, dates don't change, no matter what some
> bad class libraries may cause you to believe. Even aggregates are
> values. The set of my favorite foods doesn't change, i.e. if I
> prefer different foods in the future, that will be a different set.

Clearly Rich Hickey was thinking along the same lines as Eric
Evans. In fact, I would say that Clojure is a programming language
that is built on a firm conceptual model of the domain of
programming. I think this is one of the things that makes Clojure such
a joy to program in. Especially once you're familiar with the
language, the standard idioms and the general layout of it's
libraries. Everything is highly conceptually consistent. There have
been very few points where I learned something new about Clojure and
thought "Well that doesn't really make sense..." More often when I
learn something new it fits smoothly into the mental model that I
already have about how the language works.

I guess this Domain Driven Design stuff might really work...
