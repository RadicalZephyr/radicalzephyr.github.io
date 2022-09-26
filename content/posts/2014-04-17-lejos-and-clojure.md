+++
layout = "post"
title = "LeJOS and Clojure"
categories = ["Programming", "EV3", "Clojure"]
comments = "true"
+++

This is a short followup to my first post about
[experimenting with the Lego EV3's][lego-ev3] and [leJOS]. Shortly
after I wrote that post, I went on the Clojure IRC channel and talked
to [Phil Hagelberg][technomancy] and some other helpful folks about my
issues. They steered me away from attempting to install [Leiningen] on
the EV3 itself, which was a relief since I think that way lay
madness. Instead, they suggested that I have a small launcher program
that would just setup a REPL. Then I could run my robot-controlling
Clojure code from there.

[lego-ev3]: {% post_url 2013-10-31-leJOS-and-EV3 %}

<!--more-->

This advice led to the creation of [ev3-nrepl]. It's basically a small
skeleton Clojure project to provide the basis for running Clojure code
on the EV3. It's a minimalist setup, so it should provide a good
starting point for other people to continue experimenting. I tried to
explain how to use it fairly clearly, as well as add all the links to
the necessary documentation to get leJOS running on the EV3.

Unfortunately, despite this seemingly great start, I never ended up
actually doing anything interesting with Clojure on the EV3. There are
two related reasons for this. First, the robotics class I was in
started having actual coding assignments (thanks to the fact that we
could now run leJOS). Second, it turns out that leJOS is designed from
an incredibly stateful and imperative point of view. This makes it
very hard to develop clean Clojure code that makes use of their
API. Specifically, leJOS makes the assumption that any code making use
of it is going to start-up, do robot stuff, and then die. A Clojure
REPL obviously breaks this assumption rather badly. As it turned out,
this was the most painful when I was trying to figure out how to
program and build my robot at the same time.

What I wanted to do was be able to open a Clojure REPL connect to it,
and then leave it running for a long time. This is my normal modus
operandi, but the EV3 makes it even more critical that this
work. Because of the limited hardware, it takes several minutes for
nrepl to actually boot up.

I think that using Clojure as a prototyping tool for building robots
with the EV3 could be incredibly powerful. All of the
[arguments](http://www.infoq.com/presentations/Clojure-Java-Interop)
for why Clojure is a great language for exploring Java API's are
applicable to working with the EV3 API's. Possibly even more so, since
there is something really, really cool about typing some commands at
the REPL and having your robot start moving around and doing
stuff. Unfortunately, because of the current architecture of leJOS and
the limited processing power of the EV3's it's not quite there yet.

[leJOS]: http://lejos.org
[technomancy]: http://technomancy.us/
[leiningen]: http://leiningen.org/
[ev3-nrepl]: https://github.com/RadicalZephyr/ev3-nrepl
