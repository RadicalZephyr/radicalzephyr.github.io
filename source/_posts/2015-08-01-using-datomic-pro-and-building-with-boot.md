---
layout: post
title: "Using Datomic Pro and Building with Boot"
date: 2015-08-01 20:14:20 -0500
comments: true
categories: [Clojure, Boot, Datomic]
---

I first heard about [Datomic][datomic] shortly after it was initially
released. I think I almost immediately went and read all of the
documents that ~~[Relevance][relevance]~~ [Cognitect][cognitect] released about
it's architecture. I was duly impressed, and really interested in
using it. In particular, the potential for
[time-travelling][datomic-time-travel] was really interesting and
exciting to me.

[relevance]: http://thinkrelevance.com/
[cognitect]: http://cognitect.com/
[datomic]: http://www.datomic.com/
[datomic-time-travel]: http://www.datomic.com/benefits.html

At the time I had been tasked with writing some code to determine
usage metrics for our system. One of my boss's hopes was that we could
generate usage data from some time ago as well to compare with our
current levels. Because we were using traditional relations databases
and hadn't planned for this use case, that turned out to be
impossible. However, if we had been using Datomic, that back-dated
query would have been absolutely trivial.

<!--more-->

At the time I was overwhelmed by the intensity and scarcity of the
documentation on Datomic. Also, my general inexperience meant that I
wasn't prepared to be an early adopter of this technology. This
statement from a [tutorial blog about Datomic][datomic-tut] that I
recently ran across really resonated with my experiences:

[datomic-tut]: http://ben.vandgrift.com/2014/04/24/a-clojure-datomic-web-app-tutorial.html

> My problem with the vast majority [of Datomic tutorials] is that
> they seem to be written for people who don't need a tutorial, and by
> and large all have the stench of "read the code and you'll
> understand," quickly coupled with "and if you don't, you're not smart
> enough to use this technology anyway."

So nothing much came of my first attempt to learn Datomic. Recently
though, my interest was piqued again by a talk by a co-worker at my
current job at [8th Light][8l]. At the same time, I've been inspired
recently to pick up again a project I started around the time I was
first interested in Datomic, [Rotateam][rotateam]. But given my recent
love affair/obsession with Clojure, and in particular the
[Boot][boot-git] project for creating Clojure [build tooling][boot], I
obviously wanted to rebuild the project using a
Boot/Clojure/Clojurescript stack. And what better database technology
to use than Datomic!

[8l]: http://8thlight.com/
[rotateam]: https://github.com/RadicalZephyr/rotateam
[boot-git]: https://github.com/boot-clj/boot
[boot]: http://boot-clj.com/
