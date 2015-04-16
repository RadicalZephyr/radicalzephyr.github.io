---
layout: post
title: "Learning TDD"
date: 2015-04-14 14:37:34 -0500
comments: true
categories: [Testing, TDD, 8thLight]
---

This is my first week at 8th Light and I've been working on writing an
object-oriented Tic Tac Toe program.  This would be no big deal for
typically, even though I'm doing it in a language I'm unfamiliar with.

Except! I'm trying to very rigorously drive the development with
tests.

<!--more-->

This is a fairly new experience for me. I mean, sure, when I first
read about TDD a while ago, I got really interested and excited about
it. I played with it a little bit, and tried to do some small stuff in
it. But I quickly got overwhelmed with the difficulty of "How do you
even get started?"

Monday, I made very minimal progress. I felt stuck not really sure
where to begin, and what to do. I ended up by basically writing tests
for a simple Board data class where I could make marks, and then see
that the marks were actually set. This felt highly unimpressive as the
output of my first day.

Tuesday and Wednesday I made some more progress. The thing that helped
for most was certainly reaching out for guidance from my mentors. I
had a good conversation with Brian. Despite it's somewhat brief and
vague nature it actually was very helpful. And I did some pairing with
Zach that really helped on the Ruby comfortability front. Just seeing
how someone who knows how to use Ruby approaches things made me feel
more confident and grounded in the language.

I also did quite a bit of Googling and reading about Ruby concepts and
paradigms. There wasn't anything really specific that I was looking
for, I was just trying to absorb some of the context of the community
by seeing what is talked about and the sorts of code snippets that are
out there. To an outside observer this probably seemed mostly like
procrastinating. To be fair, I sort of judged it that way myself.

The thing is though, in all my professional software development work,
I've noticed that whenever I end up procrastinating and sort of
"working around" a difficulty I'm having a peculiar thing happens. If
I try to force myself to face it head on and work at it, nothing
really good comes out of it. Often I just end up feeling stuck and
then I'm really unproductive, just staring at the keyboard.

But I find if I just relax into the procrastination, and try to stay
working on related things, that eventually everything sort of gels in
my mind, and then when I come back to the "hard" thing I'm usually
able to make some useful headway.

Today was that day for TDD in Ruby; I felt like everything sort of
came together. I came into work determined not to "procrastinate" like
I did for much of yesterday. I started off by starting to test drive a
Console or display class. But I quickly realized that this would just
be a thin wrapper on top of the IO class that already exists in Ruby!
So I went back to implementing my game class, and used mocks to
replace an instance of an IO class.

From there I got into a very nice flow. Even the tricky nature of
testing the main game loop didn't seem overly difficult in my mind. By
the end of the day I had gotten to the point where I couldn't really
think of any more functionality that would be needed to play an actual
game at the command line.

When I wired up the class to finally actually test it from end to end
and try to play a game, there were some unexpected problems. But the
basic logical structure of the game was pretty much entirely
correct. And I knew it would be, because of the tests that I wrote.

Very cool.
