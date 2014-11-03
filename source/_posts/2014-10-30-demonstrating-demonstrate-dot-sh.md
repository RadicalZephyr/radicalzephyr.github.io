---
layout: post
title: "Demonstrating demonstrate.sh"
date: 2014-10-30 16:33:34 -0400
comments: true
categories:
---

So, in the course of trying to prepare a presentation for this
Thursday (today!), I ended up creating a program called
`demonstrate.sh`. Basically, it lets you write a script, meant for an
interpreter (like bash, python, irb, coffee etc.) and then execute it
on demand.

<!--more-->

What do I mean by "on demand"? Well, basically it invokes the
interpreter and then reads the script file one line at a time. Then it
prints out a fake prompt based on the interpreter you specified, and
then it prints out the line of input it's processing.  When you hit
enter, the script sends that line of input to the interpreter and it
then prints its output to the screen. Oh, there's one little
caveat. When `demonstrate.sh` prints the line of output, it prints it
character by character with a small randomized delay. So it looks a
bit like you're actually typing out the command.

That's it! It's a simple script, but it allows you to create and then
run in a repeatable way a sequence of commands that you want to
_demonstrate_.

There are some improvements I'd like to add. The ability to
recursively run demonstrate scripts inside of a demonstrate script
would be awesome. Currently because I'm doing everything in the
simplest possible way, and the script is run in the background running
demonstrate inside of a demonstrate script doesn't work very well. I'm
actually not entirely sure why it doesn't work, but the results are
demonstrably not what I want.

It would also be nice to make it so that you can insert arbitrary
commands to the interpreter, instead of only being able to run the
commands in the script. This is a particularly key feature since if
you just start another interpreter to run ad-hoc commands, you don't
have the same environment. This isn't important if your script doesn't
contain any side-effectful things, but I think that a lot of scripts
will tend to.

Finally, it would be really nice if the `demonstrate.sh` didn't need
to fake the prompts for the interpreters. In an ideal world, those
prompts would be transparently printed directly to the screen. I'm
sure there's a way to do it, but it probably isn't possible/easy in
`bash`.

When I talked to [Jesse] about this, he asked the critical question.
Why not just record the output? My answer was essentially because I
wanted to eventually be able to run arbitrary commands in addition to
the script commands. This is sort of a weak answer, since it depends
on a feature I haven't yet implemented!

[Jesse]: https://github.com/doy

But there's another answer, that I discovered today when I was playing
with the classic Unix utility `script` that does exactly what Jesse
was talking about. The difference between recording an interaction
with `script` and writing a demonstrate script is this. Recording with
`script` is _still live coding_. This is especially true if you want
to use the timing feature to play it back at the same speed that it
happened at. In contrast, writing a `demonstrate` script is the same
as writing any regular script for the interpreter you're
targeting. You are totally offline, and you can write and edit the
script directly, and then run it with demonstrate to make sure it does
exactly what you want.

From what I've been told about the early days of programming, the
difference between recording an interaction with `script` and writing
a `demonstrate` script is approximately the same as the difference
between writing programs on punch cards and writing programs in a text
editor on a computer. If you mess up while punching the card, you have
to start over from the beginning (barring awesome hacks
[like this][patch]).

[patch]: https://twitter.com/francesc/status/521602168022118400

Yup, that's it. If you're interested, check it out
[on Github][demonstrate]. Pull requests welcome :)


[demonstrate]: https://github.com/RadicalZephyr/demonstrate.sh
