---
layout: post
title: "Shaving the Clojurescript Yak(s)"
date: 2015-04-04 13:08:18 -0500
comments: true
categories: [Clojure, Clojurescript, Yak-shaving]
---

About a week ago I got fed up with a [terrible website][mangafox] that
had comics on it I wanted to read.  So I decided to write a little web
app to make the reading experience more pleasant. Since I'm an avid
[Clojurian][clojure], I've been interested in checking out
[Clojurescript][cljs] for doing web development, and in particular
exploring the wonderful new world of React.js wrappers available in
Clojurescript. This is the story of how I learned to setup a
Clojurescript project.

[mangafox]: http://mangafox.me/
[clojure]: http://clojure.org/
[cljs]: http://clojure.org/clojurescript

<!--more-->

Since I've been interested in Clojurescript for a while, and even
toyed with it a few times, I came into this project with at least a
fair idea of what was out there. I knew about Om, and new basically
how the Clojurescript compilation process worked. I also am vaguely
comfortable with setting up a basic Clojure web app using [Ring][ring]
and [Compojure][compojure].

[ring]: https://github.com/ring-clojure/ring
[compojure]: https://github.com/weavejester/compojure

I was also aware that there had been significant advances in the
Clojurescript workflow in the past few years. Most importantly I knew
about an apparently awesome Leiningen project template for
Clojure/Clojurescript web apps called [Chestnut][chestnut]. However,
the times that I had tried to get up and running with Chestnut
previously I was totally overwhelmed by the amount of unfamiliar
code/configuration that it produced. Quite frankly, it seemed
excessive.

[chestnut]: https://github.com/plexus/chestnut
