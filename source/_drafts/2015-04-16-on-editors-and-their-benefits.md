---
layout: post
title: "On Editors and their Benefits"
date: 2015-04-16 00:58:26 -0500
comments: true
categories: [Emacs, Vim, Social, Brains]
---

I've been using Emacs for about as long as I've been programming.

So that makes it nearly eight years now. I like to think that I've
gotten reasonably competent with it, and somewhat more importantly, I
have customized my emacs to fit my mind like a glove.

I also touch type. But, I use the Dvorak key layout. These two things
combine with the training I've done to make it so that I can write
programs at a speed close to how fast I can conceive it. This is
important, not because it means I can code faster than other people,
but because it means I can get the thoughts out of my head fast enough
that they don't slip away.

This was brought into sharp relief for me a few days ago when I did
some pairing with my mentor Zach. Zach uses the standard QWERTY
layout, and he also uses Vim.

<!--more-->

It seems that the accepted wisdom about pair programming is that it
works best when two people share the same computer, and swap control
of the keyboard back and forth. Some sources even recommend having to
sets of keyboard/mouse to even further lower the barrier to
switching. In the spirit of being open to trying new things I
acquiesced to Zach's implicit expectation that I would use his
computer with QWERTY and Vim.

It's been a long time since I've seriously attempted to use
QWERTY. When I first taught myself to touch-type in Dvorak I tried to
maintain some of proficiency with QWERTY since it is ubiquitous. But I
soon discovered that it was hard to keep both locations for keys in
muscle memory at the same time. And that's really where efficient
touch typing requires that knowledge to reside. When you have to
consult your memory for the location of key, you've already lost a lot
of your speed.

Luckily for me, I could keep on typing QWERTY as I always had; that
is, by looking at the keyboard constantly and lifting my fingers high
enough off the keyboard that I could see the letters.

Muscle memory is important to my usage of Emacs too, and it builds
heavily on my Dvorak muscle memory. Emacs has a (deserved) reputation
for having a somewhat absurd number of key bindings. Trying to
remember them directly would be a monumental task. Instead, the most
commonly used key bindings migrate quickly from the realm of conscious
thought to muscle memory. I didn't even notice this happening until I
started trying to teach a friend of mine to use Emacs. Some of the
commands that I use I know only by their location on the
keyboard. Given that I type in Dvorak and the keys are labeled in
QWERTY this means that the actual character I'm pressing is pretty
opaque.

I have a couple of questions that I want to explore in this post. One
of those is this: When is proficiency/familiarity with a tool more
important than other considerations?

First let's look a bit at what those other considerations might
be. The first one that comes to mind is that using the same tools as
the team you're working on can be pretty important. Or maybe there is
another tool that has much more powerful or focused facilities for the
task/language/domain. Or to reverse that, possibly your tool of choice
simply lacks something that a lot of other tools support. Finally, I
think a really important consideration is simply whether you are
holding on to your tool of choice out of habit and the comfort it
provides. Let's look at some examples of each of these.

A few years ago I was hired as an intern at Sage Bionetworks, a small
tech/biology start-up in Seattle. They happen to be an all Java shop,
and the standard editing environment there is Eclipse. At the time, I
was much less familiar with Emacs, I had never even opened Eclipse and
I didn't know any Java.

I spent my first few days getting through the administrative details
of starting a new job. But pretty quickly I got to the point where I
needed to setup my new computer for doing development on the Sage web
platform. They had a wiki, with several different pages on the
bootstrapping process for the various different aspects of the
process. A significant portion of it was focused on getting your
Eclipse installation setup correctly, with all the right plugins and
such.

Being totally in love with Emacs at that time, I determined that I was
going to figure out how to setup Emacs as a kick-ass Java editing
environment. My mentor was grudgingly amenable to this plan of
action. I struggled with that problem for a few days, until my mentor
came back and strongly suggested that I use Eclipse. His rationale was
essentially that this was the tool that the whole team had
standardized on. Since no one else really used the command line tools
to build or test the product I would be largely on my own in getting
things to work.

I gave in, and learned to use Eclipse. I made it bearable by
installing a plugin that simulated Emacs key bindings. I learned there
were some nice things about Eclipse - the automatic versioning, the
Java refactoring tools. But I also found it to generally be a vastly
inferior tool. While Eclipse has an extensive ecosystem of plugins and
add-ons, installing them is a nightmare of clicking through GUI menus
and needing to restart possibly several times. It is also highly
customizable, with good support for key maps and visual
modifications. However, neither your personally installed add-ins nor
your configurations can be saved in a reasonable way, and there is (as
far as I know) no way to automate the setup process. So every time you
move to a new development machine, you need to go through the same
process. Or, more likely, go through a very *similar* process, and
end up with a subtly different dev environment.

But I did get the benefit of being able to get the advice of the other
devs on the team when something wasn't working with my build. This
turned out to be critical since the process of getting a working (and
repeatable) build of their software was a highly non-trivial one.


Stuff and things. About the struggle of liking emacs and things,
Dvorak being really hard.  Being excited about 8th Light,
etc. but having an issue reconciling the two. Curiosity about
learning Vim's interface.

Worried about how trying to learn another set of keybindings will
affect my mastery of emacs keybindings. Also worried about adding
more things to my already seemingly significant workload of
learning at 8th Light. Is it the best time to learn these new
tools, or the worst?

When is proficiency in a tool more important than other
considerations like compatibility with teammates, or using the
"best" tool.  This relates well to Phil Nelson's usage of CVS and
his entrenchedness in it. In many ways I feel the same about
emacs and git and the tools that I know. But I also think that
they're better.

Ultimately, I think that the answer most of the time is that the
tools you know best and are most comfortable with are the best
ones to use. Unless they are obviously inappropriate for the job.

Disliking the hostility of Vim user's towards emacs. I think
there's an important lesson in that about having awareness of
your own prejudices. Often we think of these things only in the
more "important" matters of race, gender, and sexuality
discrimination but prejudices are prejudices and if we're blind
to some of our own prejudices, the chances that we're blind to
others seems high. On the other hand, developing the habit of
watching and introspecting ourselves about our potential
prejudices seems like the way to avoiding being prejudiced in all
things. Sometimes it's easier to start with the relatively
inconsequential thing.

connect with Brett victor's preciousness and fragility of ideas.
Maybe, proficiency in a tool becomes more important when it
enables you to nurture and bring to fruition more and fragiler
ideas.  Or maybe when it simply enables ideas, and thinking more
deeply.

My experience of trying to code in vim, typing in QWERTY was
illustrative of this. I approached it differently in thinking,
and I had to devote so much mental energy to thinking about how
to type the code in, that there's no way that I could hold the
same amount of complexity in my head that I do when I'm coding in
emacs.

this may be a blessing and a curse. For trying to think in a new
paradigm, the way that I need to with TDD it might be
fundamentally easier to do when I'm not in the familiar
environment of Emacs and Dvorak. Mental ruts are definitely a
real phenomenon.


This is also all related to humility. Specifically, the humility of
being a beginner. But it's not just humility that you get out of being
a beginner, you also get the chance to be the one who doesn't
know. This is hard for me. Really hard. I've spent most of my life
avoiding situations where I didn't know things, and when I found
myself in them despite my efforts, I usually resort to not saying
anything as a way of hiding the fact that I don't know.

It was, in a lot of ways, a big thing for me to pair program with Zach
on his computer, using a QWERTY layout and vim as the editor. One of
the hardest parts about it though, was that it was unacknowledged that
this was hard. And that I have a belief, however valid or not, that
most vim users would not be willing to do the same thing.
