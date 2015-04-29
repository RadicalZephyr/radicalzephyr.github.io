---
layout: default
---

I'm almost finished with my second iteration as an apprentice at 8th
Light.  This week I focused more on coding. I spent most of my time
just implementing the several stories of my iteration: some minor (but
important!) output tweaks, implementing a play again loop, and adding
two AI's to the game. I also did quite a bit of refactoring and
general code cleanup.

I spent nearly a whole day on figuring out the mechanics of doing an
extract class refactoring, and then realizing that I had extracted the
class the wrong way and so the "container" class was the one being
held by it's containee.  It turned out to be very awkward to deal with
this, so I backed out the change and extracted the other class so that
the container/containee relationship was correct.


I also paired with both Emmanuel and Kristen on some Clojure katas,
the bowling game and coin changer respectively.
