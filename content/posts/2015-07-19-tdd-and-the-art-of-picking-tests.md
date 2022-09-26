+++
layout = "post"
title = "TDD and the Art of Picking Tests"
comments = "true"
categories = ["Testing", "TDD"]
+++

> The first [problem] is stuckness, a mental stuckness that
> accompanies the physical stuckness of whatever it is you're working
> on. A screw sticks, for example, on a side cover assembly. You check
> the manual to see if there might be any special cause for this screw
> to come off so hard, but all it says is "Remove side cover plate" in
> that wonderful terse technical style that never tells you what you
> want to know. There's no earlier procedure left undone that might
> cause the cover screws to stick.
>
> If you're experienced you'd probably apply a penetrating liquid and
> an impact driver at this point. But suppose you're inexperienced and
> you attach a self-locking plier wrench to the shank of your
> screwdriver and really twist it hard, a procedure you've had success
> with in the past, but which this time succeeds only in tearing the
> slot of the screw.
>
> Your mind was already thinking ahead to what you would do when the
> cover plate was off, and so it takes a little time to realize that
> this irritating minor annoyance of a torn screw slot isn't just
> irritating and minor. You're stuck. Stopped. Terminated. It's
> absolutely stopped you from fixing the motorcycle.
>
> -Robert Pirsig, _Zen and the Art of Motorcycle Maintenance_

There is so much interesting material here it could take a while to
dig into all of it.

<!--more-->

## Mental Stuckness

Despite it's total lack of physical tangibility software can get stuck
too, and as software developers when our software gets stuck, so do
we. The canonical example of stuck software is when we need to add a
new feature to our application, but it can't be done without breaking
everything else. Usually we arrive in this situation because we don't
have tests, and so we can't refactor our code. We can only make
changes and then hope that everything still works.

There is another kind of stuckness though that is less specific to
software. The stuckness of a blank page. This is what Pirsig is
talking about in the above quote. Even when you're rigorously
practicing TDD, this kind of stuckness can still affect you. It's most
obvious when starting a new project from scratch. Then it really is
"blank page." But I've noticed a similar feeling when I'm adding a new
_type_ of functionality to an application.



### Cuttings

Pirsig spends the remainder of the chapter examining in detail what
stuckness means, and how to deal with it. Many of the

He describes it as the point at which what you think you know about
something has boxed you into a place where you can't conceive of a way
to move forward.
