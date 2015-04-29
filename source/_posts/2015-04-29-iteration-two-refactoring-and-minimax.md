---
layout: post
title: "Iteration Two: Refactoring and Minimax"
date: 2015-04-29 09:50:55 -0500
comments: true
categories: Apprenticeship
---

I'm just about finished with my second iteration as an apprentice at
8th Light. Where my first iteration centered a lot around reading and
learning how TDD and Ruby work, this week I focused more on coding. I
spent most of my time just implementing the several stories of my
iteration: some minor (but important!) output tweaks, implementing a
play again loop, and adding two AI's to the game. I also did quite a
bit of refactoring and general code cleanup.

<!--more-->

I spent several hours figuring out the mechanics of doing an extract
class refactoring, and then realizing that I had extracted the class
the wrong way and so the "container" class was the one being held by
it's containee.  It turned out to be very awkward to try to invert
this relationship so I backed out the change and extracted the other
class so that the container/containee relationship was correct. I
consulted Martin Fowler's *Refactoring* book heavily here. It's really
neat how the mechanical steps he describes are actually an incredibly
useful guide.

I noticed an interesting thing while I was refactoring. I was changing
the code so much that I started losing track of what was actually
going on. At some point, my brain just sort of gave up on trying to
hold the whole application in my head. This was an interesting
experience because usually I can hold more complexity in my head than
this Tic Tac Toe game currently has. I think this is part of the trend
I noticed that in general, when doing TDD I feel less need to hold a
lot of the complexity in my mind at once.

The slightly scary flip-side of that was that because I was doing
extract class refactorings and moving methods and such, I also ended
up moving tests around and modifying the tests a lot to keep them
working. Mucking around with them seriously decreased my confidence in
them, and thus in my confidence in the system as a whole. Clearly I
need to think more about how the test modification process goes along
with refactoring.

Another piece of functionality that took me surprisingly long to
implement was the play again functionality. The interesting part of
that process was that I wrote tests, and then wrote an implementation
that I thought was correct. The tests failed in a confusing manner and
so I assumed that the tests were incorrect. After poking around for
quite a while, firing up the debugger ([Pry][pry] and [byebug] are
awesome!) I eventually discovered that the test was correct, and it
was even failing exactly correctly. I had simply forgotten to take
into account that once a game has been completed, one can't just start
playing it again from the beginning. So I had to write a reset method.

[pry]: http://pryrepl.org/
[byebug]: https://github.com/deivid-rodriguez/pry-byebug

I also spent some time pairing with both Emmanuel and Kristen on some
Clojure katas, the bowling game and coin changer respectively. This
was really fascinating for a couple of reasons. I consider myself
reasonably competent with Clojure. But I am almost totally unfamiliar
with trying to do TDD in Clojure.

The pairing that I did with both my fellow apprentices was in the
Ping-Pong style (mostly), where one of us wrote a test and the other
tried to make it pass. What was fascinating to me was that the
incremental development approach that this enforces pushed me towards
writing very non-idiomatic, highly stateful Clojure code.

After attempting the coin changer with Kristen, I was starting to
doubt my Clojure-chops and so I tried to TDD it out on my own. I ended
up arriving at a more satisfactory solution that used a stream model
of discrete state transformations. So a cleaner stateful solution.

I ended up talking about this with Emmanuel after our pairing session,
and he showed me a blog post and a screencast about doing the bowling
kata in Clojure. Both people ended up with similar solutions, which
basically involved the insight that a frame in bowling is only two
rolls when no strikes or spares are involved. In retrospect, this
seems sort of obvious, since a frame can't be scored until all of it's
rolls have occurred. But combining this with actually duplicating some
of the numbers from the stream of pin-counts is what leads to an
elegant Clojure solution.

Besides this key realization, I think I was also missing a critical
tool in my Clojure toolbox: custom lazy sequences. Both solutions
Emmanuel had found on the web ended up constructing a function that
produced a custom lazy sequence. This was necessary because of the
need to repeat certain elements from the stream.

But what I'm realizing now is that I think it's difficult to test
drive recursive solutions.
