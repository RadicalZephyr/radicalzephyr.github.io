---
layout: post
title: "Hacker School: Week 1 Review"
date: 2014-10-11 04:48:52 -0400
comments: true
categories: Hacker School
---

So, I can't sleep, and it's the end of my first week at
[Hacker School], so I thought I'd do some reflecting on what I did,
why I'm here and similar topics.

[Hacker School]: https://www.hackerschool.com/

<!--more-->

## Week Review

### Monday

This week has been a blur in some ways and incredibly long in others.
I started out on Monday with an interesting but ultimately abortive
attempt to pair with Alyssa Carter on her observational type system
implementation in Idris. Given that I know pretty much nothing about
either type theory or Idris, this outcome was probably somewhat
inevitable.  In retrospect, while it was interesting to get some
exposure to the ideas and concepts that she talked about, I probably
should have admitted more freely when things she was saying were going
over my head. This is something that I've always struggled with, and I
think that Hacker School is a great place to try and tackle getting
over it.

The rest of Monday I spent flailing. And not really with any code;
mostly with just getting familiarized with Zulip and the HS (physical)
environment, and turning off most notifications in Zulip.  I
discovered an interesting thing about myself that I hadn't been fully
aware of previously: when there are constant notifications happening
(like when you're highly subscribed to Zulip and desktop notifications
are turned on), I get really stressed out on a subconscious level.

It's sort of similar to how I start to feel inexplicably rushed when
my bladder is getting full, but before I actually notice the urge to
pee.

Anyhow, during my flailing I also poked a bit at my
[snake-puzzle-solver] project, and discovered that I'd left it in a
sort of broken-ish state.

[snake-puzzle-solver]: https://github.com/RadicalZephyr/snake-puzzle-solver

### Tuesday

On Tuesday I felt much calmer. I'm having a hard time remembering now
what exactly I worked on. I believe it was working through
_[Real World OCaml]_ though.  I didn't get very far, but I also spent a
bit of time helping Sammy out, and fixing up this blog with Octopress.

[Real World OCaml]: https://realworldocaml.org/

### Wednesday

Through some poor decision-making Tuesday evening (i.e. eating two
slices of pizza, and also drinking a not inconsiderable amount) I was
either very gluten-sick or very, very hungover on Wednesday. No good,
very bad feels were had all day. At the time I was fairly convinced
that it was the pizza. In retrospect, the symptoms were very
hangover-like. Perhaps I just got much drunker than I thought I did?
Hard to say.

### Thursday

On Thursday I powered through the first third or so of _Real World
OCaml_. That was awesome. OCaml is a fascinating language, and even
though it has perhaps more than it's share of syntactic quirks it's
been fun learning it. On a slightly meta-level I was sort of
dissatisfied throughout the day because of my (mostly self-imposed)
isolation. Not using Zulip much - because of how distracting it is -
makes me feel a bit cut-off from some of the social aspects of HS. And
I still haven't really found the courage to seek out somebody to pair
with. Another thing I want to work on. Also, the fact that I was doing
something so ordinary and mundane as simply reading a book made me
feel bad. Reading a book on a new language and working through the
code examples is something that I can, have, and - most likely - will
do again at home. So why am I "wasting" my time at Hacker School,
precious, precious time that it is, doing it here? Particularly since
I'm doing it alone!!

I don't really have answers to most of these dissatisfactions. Most of
them are probably just my social awkwardness manifesting, and the last
one sounds suspiciously like a strange form of Imposter Syndrome.

I stayed late in the evening though and started working on a neat
project that occurred to me when I suggested that another HS'er work
through Phil Nelson's minishell - implementing the minishell in
OCaml!! And even more importantly, I achieved a real-feeling amount of
success in the project! I was able, without any real documentation
(couldn't find accurate docs!) to utilize the OCaml Unix module well
enough to create the equivalent of the `minishell.c` that Nelson gives
out as the basis for the shell, and to complete the equivalent of
assignment 1.

### Friday

I somehow gained the impression that showing up at the space was less
expected on Friday. Now I'm really not sure where/how I got that
idea.  But I'm also totally unsure if it's actually wrong... >:(

I did however use the day to catch up on some sleep, do some errands
(digital ones anyhow) and go hang out with a friend I haven't seen in
literally years. So, overall win even if I did totally miss out on a
HS day.  But again, it makes me feel sort of disconnected to be not at
the space when others are.

## Project Ideas

Given some of my meta-dissatisfaction that I felt on Thursday
regarding what I've been working on, I thought I might try to list
some other projects that seem more "Hacker School worthy".

Looking to the [three traits of an awesome Hacker Schooler][3traits],
I started thinking about what are some challenging (strive for
greatness) problems that I could approach with rigor.

[3traits]: https://www.hackerschool.com/manual#sec-principles


- Dive into the bug in auto-fill in emacs, try to fix it
- Pursue learning more graphics stuff (since I've been sort of
  intimidated by it for a while). Project-wise, it might be
  interesting to try and discover what sort of work it would take to
  update Emacs' rendering engine.
- Try to dive into the Boomerang decompiler's source code and
  understand it


And some other random things I want to do (but might not be feasible):

- Implement a language that has lispy-prefix syntax but OCaml
  semantics; in particular that has type-inferencing
- To that end, implement the type inferencing engine that powers OCaml
  type inferences
- Port Boomerang to use the LLVM architecture

## Final Thoughts

It's frustrating how many of the things that I want to do still have
what seems like huge mounds of prerequisites in front of them. I want
to do all of these interesting language things, but I feel like I'm
blocked from doing them because I want to do them in LLVM, but I don't
know anything about actually using the LLVM.

Also, when I was reflecting on what I need to do to become a better
programmer, one of the recurring thoughts I responded with is that I
need to write/work on a larger system/project. I feel like I have
quite a bit of experience taking an small projects. But not something
like YRAS... Which, I think, is one reason that I am absolutely
terrified of starting that project.
