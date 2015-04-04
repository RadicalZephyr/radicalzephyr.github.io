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
excessive, and quickly led to me giving up on whatever
project-of-the-moment had inspired me.

[chestnut]: https://github.com/plexus/chestnut

So! This time, I determined to not start with Chestnut, and instead
build up slowly from the basic Lein app template that I was already
familiar with. And so commenced roughly five full days of mostly
yak-shaving. I'm not going to try and recount it all here; just the
highlights will be more than enough.

I started with off with a very vanilla `lein new app
comic-reader`. From there, I copied the basic dependencies for a
jetty/ring/compojure web app from my [url-shortener][shorturl]
project. I made some basic routes to make sure everything was working
correctly.

[shorturl]: https://github.com/RadicalZephyr/url-shortener

Next came adding Clojurescript into the project. This meant setuping
the `project.clj` to point to where the `*.cljs` files would live, and
then configuring the Clojurescript compiler.  Basic Clojurescript
compilation with [lein-cljsbuild][cljsbuild] is not totally trivial to
configure, especially since there are now many different options to
the Clojurescript compiler and many resources on the web have
older/outdated configuration examples, and typically no explanation
whatsoever of why they have it configured they way they do. But
overall it wasn't too tough. It helped significantly that I could
again copy setups I had previously found to work.

[cljsbuild]: https://github.com/emezeske/lein-cljsbuild

At this point, I was sick of shaving Yaks for a moment so I went and
learned how to use [Enlive][enlive] for doing
[web scraping][en-scrape]! Then, feeling refreshed, I went back to the
Yak.

[enlive]: https://github.com/cgrand/enlive
[en-scrape]: https://github.com/swannodette/enlive-tutorial#an-introduction-to-enlive

I knew that I wanted the awesome [Figwheel][fig] plugin for an awesome
(mostly) reload-less Clojurescript experience. Again, Figwheel comes
with a Lein template that I didn't use directly. Instead, I made an
extra copy and then used it as a reference for when my configuration
based on reading the documentation didn't work.

[fig]: https://github.com/bhauman/lein-figwheel

Next step was adding in Om, and making a basic page setup
there. Again, nothing incredibly hard. I mostly just followed the
tutorial and everything came together fairly quickly. Only maybe an hour
of struggling and cursing at my computer. Then, I decided that I
wanted to build a single-page application (SPA). So I started looking
at libraries like [Secretary][secretary]

[secretary]: https://github.com/gf3/secretary
