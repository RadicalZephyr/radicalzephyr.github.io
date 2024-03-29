+++
layout = "post"
title = "On Editors and their Benefits"
comments = "true"
categories = ["Emacs", "Vim", "Social", "Brains"]
+++

I've been using Emacs for about as long as I've been programming. So
that makes it nearly eight years now. I like to think that I've gotten
reasonably competent with it, and somewhat more importantly, I have
customized my emacs to fit my mind like a glove.

I also touch type, but I use the Dvorak keyboard layout. These two
things combine to make it so that I can write programs at a speed
close to how fast I can conceive them. This is important, not because
it means I can code faster than other people, but because it means I
can get the thoughts out of my head fast enough that they don't slip
away.

This was brought into sharp relief for me a few days ago when I did
some pairing with my mentor Zach using his computer. You see, Zach
uses the standard QWERTY layout, and he also uses Vim.

<!--more-->

It seems that the accepted wisdom about pair programming is that it
works best when two people share the same computer, and swap control
of the keyboard back and forth. Some sources even recommend having two
sets of keyboard/mouse to lower the barrier to switching even further.
In the spirit of being open to trying new things I acquiesced to
Zach's implicit expectation that I would use his computer with QWERTY
and Vim.

It's been a long time since I've seriously attempted to use
QWERTY. When I first taught myself to touch-type in Dvorak I tried to
maintain some proficiency with QWERTY since it is ubiquitous. But I
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
commands that I use, I know only by their location on the keyboard.
Given that I type in Dvorak and the keys are labeled in QWERTY this
means that the actual character I'm pressing is pretty opaque.

* * *

When is proficiency or familiarity with a tool more important than
other considerations?

First let's look a bit at what those other considerations might
be. The first one that comes to mind is that using the same tools as
the team you're working on can be pretty important. Or maybe there is
another tool that has much more powerful or focused facilities for the
task/language/domain. Or to reverse that, possibly your tool of choice
simply lacks something that a lot of other tools support. Finally, I
think a really important consideration is whether you are holding on
to your tool(s) of choice out of habit and the comfort they provide.
Let's look at some examples of each of these.

A few years ago I was hired as an intern at Sage Bionetworks, a small
bio-tech start-up in Seattle. They happen to be an all Java shop,
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

When I was working with Zach last week and ended up using Vim with
QWERTY, he said something to me that reminded of my mentor's words at
Sage. He said that a lot of people at 8th Light use Vim, and that if I
want to do a lot of pairing with people it will probably be to my
benefit to learn how to use Vim at least a little bit.

This makes more sense in an environment where pairing is actively
practiced, but the general idea behind it is basically the prospect of
being able to sit down at someone else's computer and use it for
development at a reasonable level. I'm not sure that I agree with this
philosophy though.

One place where being able to use any given computer is key is as a
sysadmin. My college's CS department started participating in a
national competition during my second year, the Collegiate Cyber
Defense Competition or CCDC. The competition itself basically places
several teams of students in the role of a new system administration
team for some large corporation. The system is potentially in disarray
after a poorly documented transition from a previous team and the
students task is to secure the systems while maintaining a given level
of availability for one or more different services (such as email,
databases, servers, etc.).

I was very interested in participating in the club that was preparing
for the competition because they were learning both defensive and
offensive computer security skills. But I found it difficult to work
in the context of system's administration because I couldn't have my
environment setup just how I wanted it. Particularly during the
competition itself, there would be no time to try and install Emacs
(which is both large in footprint and memory usage and requires a ton
of dependencies), or switch the terminal at the computer I was using
to Dvorak. Thus I found that two choices I had made years before had
effectively precluded my participation in the CCDC.

Interestingly, my choice to learn the Dvorak layout is actually what
pushed me into learning Emacs. I had just gotten to the point of
actual touch-typing with Dvorak when I decided it was time to switch
from using PythonWin to a "real programmer's editor." Based on what I
had been reading on the internet, that choice seemed clear: it had to
be Vim.

But I was stalled almost immediately. Vim uses the letters 'h', 'j',
'k', and 'l' for text navigation, so you don't need to move your hand
to the arrow keys.  This is convenient for usage under QWERTY, all
four keys are on the home row and are easily accessible - without
stretching - to your right hand. But on Dvorak they are all over the
keyboard, and there is no mnemonic for telling which key does
what.

I struggled with Vim for a few days, trying to learn how I could remap
the movement keys to the same location under Dvorak as they are in
QWERTY. But I was unable to find a solution and the prospect of the
cascading key remappings was enough to drive me to look at Emacs.  By
contrast with Vim, most of the keys in Emacs have some kind of
mnemonic association. Moving forward a character is `ctrl f` and back
is `ctrl b`. Down one line is `ctrl n` and up is `ctrl p` for next and
previous. Not only that, but part of the very philosophy of Emacs is
easy customization, up to and including remapping every key on your
keyboard to do something different. More importantly, that philosophy
of customization is embedded in the Emacs community.

The seemingly simple choice of learning to type in Dvorak turned out
to be a key decision in my life as a programmer. It cut off certain
possibilities like learning to use Vim, and presents certain
challenges for pair programming, particularly in the quick
back-and-forth style where two people use the same computer. I have
also found that using Emacs appears to be the less common of the two,
and this is also limiting and isolating to some degree.

Here's the thing though, I *like* using Emacs; and typing in Dvorak
feels good to my fingers. So I'm a little bit stuck. I want to be
agreeable and able to collaborate and pair program with others
easily. But I also really like the tools that I use. They fit me. So
what do I do?

One possibility is to use more tools to overcome some of my
difficulties with pairing. Specifically, using a lightweight version
control system (like git) and a free code hosting site (like, say,
Github) you can arrange a style of pairing where two people work on
the same code, but each using their own device and tools and
setup. Pairing is the same during the actual coding process with
whatever Driver/Navigator or other dynamic you want to use. The
difference comes when you swap. Instead of simply sliding the keyboard
across to your partner, you commit, and push to your central
repository. Your partner then pulls down the latest code and starts
working on their machine. This is certainly a bit more work than just
handing off the keyboard, so it may not be suitable to very rapid
hand-offs. But I haven't found it to be overly onerous so far.

Another solution would be for me to maintain some skill at QWERTY and
Vim specifically for facilitating pairing. While more work for me
personally, it has the benefit of not requiring a new pairing
workflow. But this idea worries me a bit.

The human brain is [amazingly flexible][neuroplas]. My favorite
personal example of this is related to video games and how we control
them. Every first-person style game has at least one key setting in
the control options: whether the way you look upwards is by moving the
mouse or tilting the control stick upwards (usually known as "default"
or "normal"), or whether this mapping is "inverted" i.e. tilting up
looks down and tilting down looks up. My best friend and I have played
a lot of Halo together in our day. For a long time one of our favorite
pastimes was playing through Halo 2 levels on Legendary difficulty,
often with skulls active. Here's the thing though: he plays default,
and I play inverted.

[neuroplas]: https://en.wikipedia.org/wiki/Neuroplasticity

Under most circumstances this doesn't matter. If we're playing
cooperatively it doesn't matter because we both have our own
controller and thus our own setting. It only becomes an issue when we
are handing a controller back and forth. But boy is it a problem
then. Invariably we both forget to switch back at the hand-off and
there ensues a brief period of confusion and panic when the game
character doesn't respond as our brain is wired to think it
should. What's really fascinating though is how quickly my brain
starts to retrain itself.

I've been playing games on inverted for years, possibly decades at
this point. As such you would think that my brain is very much
hardwired to expect that when I tilt the stick up, the view will move
down. And this is true. But sometimes, for one reason or another I'll
end up playing for a short time on the default setting. What happens
is remarkable and incredibly frustrating. If I focus on trying to
remember that up means up and down means down, I can usually get to a
level that is usable - at least when I pay full attention. But as soon
as something intense happens like a bad guy jumping out from behind a
bush, my reflexes revert to inverted settings. Even more interestingly
though, when I inevitably switch my control scheme back to inverted I
am unable to fully shed the tendency towards trying to play with
default look controls.

Back to keyboard layouts and editors. In short, I'm concerned that an
attempt to learn how to use QWERTY again and to memorize Vim keyboard
shortcuts will seriously undermine my ability to use Emacs effectively.

On the other hand, maybe this is just what I need. I'm also currently
trying to learn how to do Test Driven Development (TDD) and I'm
finding that a lot of the thought-habits I have around programming are
actually detrimental to doing TDD. Maybe breaking out of my
comfortable Emacs environment and using a new keyboard layout will
help me get into a totally new frame of mind and let me TDD more
effectively.

I think there is another reason to embrace the idea of learning a new
set of tools at this time though. A large part of the reason that I
wanted to do this apprenticeship with 8th Light was to learn. Learning
from others always requires some humility; at the very least you have
to be able to admit that there are things that you do not know. This
is difficult for me. But possibly, intentionally cultivating
[Shoshin][shoshin] or "beginner's mind" regarding my most basic level
of programming - how I edit my source code - will help me do it at all
levels.

> In the beginner's mind there are many possibilities, in the expert's
> mind there are few. - Shunryu Suzuki

[shoshin]: https://en.wikipedia.org/wiki/Shoshin
