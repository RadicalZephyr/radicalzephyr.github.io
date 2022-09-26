+++
layout = "post"
title = "Estimating is Hard"
comments = "true"
categories = ["Estimating"]
+++

I'm coming up on the end of my first iteration at 8th Light where I
was asked to estimate how long each of my stories was going to
take. For the three stories that make up the majority of converting my
rack Tic-Tac-Toe from a multi-page vanilla HTML/CSS app, to a SPA
(Single Page App) that uses AJAX to communicate with the server I came
up with a total of about 11 points. Given that at 8th Light we want to
be nominally doing about 9 points per week that meant that I estimated
it would take me just a touch over one iteration to complete that
transformation. But looking at it right now, I don't think I'm on
track to meet that goal.

<!--more-->

Estimating is acknowledged to be hard.  The advice from _The Pragmatic
Programmer_ acknowledges that and says that basically the only way to
get better at it is to try and estimate things and then track how
(in)accurate your estimates are. Beyond that general acknowledgement
though, I think I have some personal habits/quirks that make my
estimates less than good.

First, I have a tendency to want to seem like I know what I'm doing,
even when I don't. This is obviously problematic for estimation since
in it's simplest form it might make me underestimate how long I think
something will take so I look more proficient. There's a more
insidious way that this attitude causes me problems though. It means I
have a tendency not to ask questions, and I probably tend to bang my
head against things that aren't working for too long before I ask for
help.

The second problem I have is reading things and ensuring I actually am
comprehending them. This is sort of related to the first problem since
I think it comes from a similar place. But at this point it's more of
a mental habit than an explicit choice. For instance, even though I
didn't have a short time limit to figure out my estimates, I still did
them fairly quickly and without really having a clear picture of what
work I would have to do for each story. As soon as I started
trying to implement the stories, I realized this.

### The Takeaway

I need a more systematic approach to the way I come up with
estimates. First off, I'm going to go re-read the article on it from
_The Pragmatic Programmer_. As I recall it has some excellent advice
that I don't remember half well enough. Second, I think I'm going to
try to partially adopt a strategy that my co-mentor Zach suggested
when I was reviewing a code-base's "viability for extension." His
advice was to walk through the code while considering what it would
take to make some sort of reasonable change.

This is quite nebulous for a large code-base, since I first have to
decide what "a reasonable change" might be. But as a tool for reifying
the goals that I'm trying to estimate it should work very
nicely. Basically, all that this means is that I will actually
seriously try to think through what I would do to implement the story
I'm trying to estimate instead of just throwing a number out from my
gut feeling.
