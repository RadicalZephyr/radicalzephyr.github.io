---
layout: post
title: "Ping-Push-Pong Pairing"
date: 2015-04-20 15:40:31 -0500
comments: true
categories:
---

<!--more-->

One possibility is using more tools to overcome some of the
difficulties with pairing. Specifically, using a lightweight version
control system (like git) and a free code hosting site (like, say,
Github) you can arrange a style of pairing where two people work on
the same code, but each using their own device and tools and
setup. Pairing is the same during the actual coding process with
whatever Driver/Navigator dynamic you want to use. The difference
comes when you swap. Instead of simply sliding the keyboard across to
your partner, you commit, and push to your central repository. Your
partner then pulls down the latest code and starts working on their
machine.

This is certainly more of a hassle than just moving a keyboard, but it
has some benefits too. First, it requires that you be using version
control, even at the earliest stages or on a trivial pairing
exercise. I've been doing this for a while, and the feeling of
security it gives me is like a nice fuzzy blanket. I actually get
physically uncomfortable when I don't have a project under version
control.

The other benefit is that it means you have to be able to reproduce
the dev environment for a project on at least one other computer than
the one where it was started. This goes a long way towards ensuring
that you have [repeatable builds][repbuild] (or runs). Also, it helps
facilitate transfer of the non-code related knowledge. One of the
first stumbling for any new language is how to go about setting up a
new project. If one developer in the pair is more experienced with
this process for the language at hand and their computer is used
exclusively then the other dev never gets a chance to see what setting
up that languages environment looks like.

[repbuild]: http://www.sicpers.info/2011/02/on-repeatable-builds/
