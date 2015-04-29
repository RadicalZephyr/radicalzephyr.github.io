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

On Tuesday I spent most of the day test driving my way to a perfect
AI. This was an interesting experience since it was the first time
I've had a really clear idea of where I wanted to go with the code
while doing TDD. For the most part I've been trying to stick to the
letter of the acronym and let the tests lead me to the code
organization they want.

But the [minimax] algorithm is well known and an established way to do
the game state-space search that is required for a perfect Tic-Tac-Toe
AI. So how does one test drive that? Apparently I am most definitely
not alone in asking this question as both my mentors were expecting
it, and my fellow apprentice working on Tic-Tac-Toe (Ari) also spent
time last week puzzling over it.

[minimax]: https://en.wikipedia.org/wiki/Minimax

I worried about it briefly at the start of the day, but then I quickly
adopted the outlook that I've found to be most successful with TDD;
don't think too much about the future. Instead, I focused on the
fundamentals. What's the simplest case an AI needs to deal with. I
turned to the Wikipedia page on Tic-Tac-Toe and it's bullet list of
how to be a perfect player. The most important rule is that an AI
should win immediately when it can. If that's not possible it should
block an opponent from winning.

These two situations are very easy to detect. It only takes a slight
modification to the code pattern used for detecting if someone has
already won, and no future board states need to be taken into
account. This approach got me moving forwards, which is often the
hardest part.

Once I had some momentum I kept going by then considering simple fork
creation, the next most important move type. After pondering how this
might work, I hit upon a simple solution. A fork is just a move that
results in a board where you have two possible ways to win! This was
attractive to me for several reasons. First, it was a (relatively
small) step towards searching the state-space of the game. By looking
one move ahead I felt I was moving in the direction of minimax. And it
was simple enough that it felt doable in a single TDD step.

This worked shockingly well. Not only did my very simple fork
look-ahead detect most forks that it could create, somehow it actually
was able to produce the correct fork-blocking behavior in the first
four cases that I came up with.

I was suspicious though, and so I crafted some devious fork tests that
were designed to expose the flaw in my simple algorithm. Eventually I
did that and it became clear that something more powerful was
needed. At this point, thinking about the simplest way to do things
produced no clear results. I was already doing a minimal look-ahead
and the analysis was insufficient. It seemed that the next step would
have to be going to a minimax algorithm. Here's basically what my
simple algorithm was at this point:

```ruby
      def score(node)
        get_wins(node.indexed_attack_sets).count
      end

      def find_forks(board)
        scores = board.empty_spaces.map do |index|
          node = board.speculative_move("X", index)
          [index, score(node)]
        end

        scores.max_by { |i, s| s }.first
      end

      def get_move(board)
        attacks = board.indexed_attack_sets
        win   = get_wins(attacks).first
        block = get_blocks(attacks).first

        win or block or find_forks(board)
      end
```

I tried to do get to minimax in several ways. First off, I actually
ended up using the [negamax] algorithm because it's simpler to code
because it takes advantage of the zero-sum property of
Tic-Tac-Toe. Initially, I tried to replace my whole algorithm with
negamax right off the bat. This did not work out well. Things got
complicated and many tests were failing. So I backed out and treated
negamax as a small refactoring. Specifically I treated it as a
refactoring of the `find_forks` function. This worked quite well, and
suddenly all of the forks tests were passing. I then incrementally
expanded it until negamax was the only thing being used for deciding
which moves to make.

[negamax]: https://en.wikipedia.org/wiki/Negamax


## Clojure TDD

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
