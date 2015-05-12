---
layout: post
title: "Chestnut - Annotated"
date: 2015-05-10 13:34:16 -0500
comments: true
categories: [Clojure, Clojurescript, Walkthrough]
---

#### A Note about version numbers

At the time of this writing, there were several newer versions of many
of the dependencies used in Chestnut. In particular, the ClojureScript
core team had fairly recently released a new version with
[vastly simplified REPL setup requirements][cljs-new-repl] which
triggered changes to many of the related ClojureScript tooling
libraries (Piggieback, and Weasel especially). So PLEASE! Use the
latest version of Chestnut, or if you're setting up your own project
then look up the latest versions on [Clojars][clojars]

[cljs-new-repl]: https://github.com/clojure/clojurescript/wiki/Running-REPLs
[clojars]: http://clojars.org/

## On to the Annotating!

As I wrote [recently][yaks], I recently dove head first into doing web
development with Clojure and Clojurescript. Along the way I learned a
whole heck of a lot about how to actually set up a [Leiningen][lein]
project to support a nice workflow for such a project. However, most
of my new-found knowledge has already been put together into a very
nice package called [Chestnut][chestnut]. However, at first glance
(and second and third glance really) Chestnut projects are complex and
intimidating.

[lein]: http://leiningen.org/
[chestnut]: https://github.com/plexus/chestnut

This post is an annotated walkthrough of the configuration that a new
Chestnut comes with. The best way to follow along would be to start
off by running `lein new chestnut tour` in shell and then exploring
the files as I talk about them.

[yaks]: {% post_url 2015-04-04-shaving-the-clojurescript-yaks %}

<!--more-->

Let's start by looking at the base directory.

```
# Directories
- resources
- src
- env

# Files
- LICENSE
- README.md
- code_of_conduct.md
- project.clj
- Procfile
- system.properties
```

If you're familiar with Clojure development at all, this should look
very familiar to you. But there a few unusual things: the `Procfile`
and `system.properties` files, and the `env` folder.  The `Procfile`
is a file for letting [Heroku][hero] know how to run your app, and the
contents of it are explained well in the
[Heroku guide to getting started with Clojure][clj-get-started].

[hero]: https://www.heroku.com/
[clj-get-started]:
https://devcenter.heroku.com/articles/getting-started-with-clojure#define-a-procfile

If we use the awesome [tree][tree] program to visualize some of these
directories we can see some interesting stuff. First, `src` looks
pretty standard for Clojure, with the addition of a second tree for
cljs files.

```
src
├── clj
│   └── tour
│       └── server.clj
└── cljs
    └── tour
        └── core.cljs
```

The same is true of the `test` folder. But what's really interesting
is what is in that new `env` folder.

```
env
├── dev
│   ├── clj
│   │   └── tour
│   │       └── dev.clj
│   └── cljs
│       └── tour
│           └── main.cljs
├── prod
│   ├── clj
│   │   └── tour
│   │       └── dev.clj
│   └── cljs
│       └── tour
│           └── main.cljs
└── test
    ├── js
    │   ├── polyfill.js
    │   └── unit-test.js
    └── unit-test.html
```

What we see is that there are three top-level directories underneath
`env`, and below each of these we see what looks like normal Clojure
and Clojurescript source trees. Veeery, interesting.

Now let's jump and take a look at the `project.clj`. This is where the
heart of the action is. The first is boring normal project meta-data,
and we're going to skip it. The next section is interesting though.

```clojure
  :source-paths ["src/clj"]
  :repl-options {:timeout 200000} ;; Defaults to 30000 (30 seconds)

  :test-paths ["spec/clj"]
```

The `:repl-options` is straightforward. It just increases the timeout
when launching a REPL. Presumably this is because Chestnut REPL's are
so filled with awesome that they take longer to load ;) The `*-paths`
options are simple too.  They just override the default place that
Leiningen looks for Clojure source and test files by default.

> N.B. The version of Chestnut I generated this with actually has a
> bug, since it generated "spec/clj" as the test path, but no "spec"
> folder.

Next come the dependencies and plugins needed by this project.

```
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [org.clojure/clojurescript "0.0-2511" :scope "provided"]
                 [ring "1.3.2"]
                 [ring/ring-defaults "0.1.3"]
                 [compojure "1.3.1"]
                 [enlive "1.1.5"]
                 [om "0.8.0-rc1"]
                 [environ "1.0.0"]]

  :plugins [[lein-cljsbuild "1.0.3"]
            [lein-environ "1.0.0"]]
```

Clojure and Clojurescript are obviously necessary, and when you're
using Clojurescript with Leiningen, you probably want the
[lein-cljsbuild][cljsbuild] plugin for compiling your
Clojurescript. [Ring][ring] is the standard Clojure web application's
library. [Ring-defaults][ring-def] is a library for providing standard
configurations of [Ring middleware][ring-mid].  [Compojure][compojure]
is a routing library built on top of Ring.

<sub>
I'm not quite sure why the Clojurescript dependency is marked as
`provided`...
</sub>

[ring]: https://github.com/ring-clojure/ring#ring
[ring-def]: https://github.com/ring-clojure/ring-defaults#ring-defaults
[ring-mid]: https://github.com/ring-clojure/ring/wiki/Concepts#middleware
[compojure]: https://github.com/weavejester/compojure#compojure

[Enlive][enlive] is a "a selector-based (à la CSS) templating library
for Clojure." Very cool stuff, and wildly useful for many other HTML
processing/producing/consuming tasks than just templating.
Unfortunately very under-documented. [Om][om] is the only
Clojurescript specific dependency in the list, but it's a pretty cool
one. It's a Clojurescript interface to Facebook's React.js library.

[enlive]: https://github.com/cgrand/enlive#enlive-
[om]: https://github.com/omcljs/om#om

Finally we have the [Environ][environ] library, and it's associated
`lein-environ` plugin. As their README says:

> Environ is a Clojure library for managing environment settings from
> a number of different sources.

[environ]: https://github.com/weavejester/environ#environ

However, it is also the basis for a lot of the really neat things that
Chestnut does.

Next up, we have some more basic configuration stuff.

```
  :min-lein-version "2.5.0"

  :uberjar-name "tour.jar"
```

These two settings are specifically to help with deployment to Heroku
which looks for the `:min-lein-version` key to determine what version
of lein to build your app with. Chestnut also changes the uberjar name
so that the Procfile can specify a specific filename. Normally, the
uberjar name is derived from the project name and the current
version. However, this makes it a moving target.  Every time you bump
your version number you would have to update the Procfile to stay in
sync. This way, the uberjar always has one name and the Procfile never
needs to change.

Finally, we have the basic cljs build configuration:

```
  :cljsbuild {:builds {:app {:source-paths ["src/cljs"]
                             :compiler {:output-to     "resources/public/js/app.js"
                                        :output-dir    "resources/public/js/out"
                                        :source-map    "resources/public/js/out.js.map"
                                        :preamble      ["react/react.min.js"]
                                        :optimizations :none
                                        :pretty-print  true}}}}
```

This is remarkably similar to the configuration from the
[lein-cljsbuild none example project][none-example], and a standard
setup to enable source-maps.

[none-example]: https://github.com/emezeske/lein-cljsbuild/blob/1.0.5/example-projects/none/project.clj

### Profiles

So far, most of what we've seen is fairly standard
clojure/clojurescript configuration stuff. But one of the things that
makes Chestnut awesome is that it makes really good use of the
Leiningen profiles feature. In particular, it uses profiles to
concisely specify different clojurescript compilation settings and add
dependencies that are only needed for development. If this is the
first time you've heard about Leiningen profiles, you should probably
go [read about it][lein-profiles]. The basic summary is this though:

> You can place any arbitrary key/value pairs supported by defproject
> into a given profile and they will be merged into the project map
> when that profile is activated.

[lein-profiles]: https://github.com/technomancy/leiningen/blob/master/doc/PROFILES.md#profiles

Let's start with the extra `:dev` setups. It starts off nice and easy
just adding more clojure source and test paths and some extra
development-only dependencies.

```
  :profiles {:dev {:source-paths ["env/dev/clj"]
                   :test-paths ["test/clj"]

                   :dependencies [[figwheel "0.2.1-SNAPSHOT"]
                                  [figwheel-sidecar "0.2.1-SNAPSHOT"]
                                  [com.cemerick/piggieback "0.1.3"]
                                  [weasel "0.4.2"]]
```

Notice that there is a similar entry under the `:uberjar` profile for
`:source-paths` but that the `:test-paths` are omitted (since the
uberjar is typically for distributing production code).

[Figwheel][fig] is a very cool project that "pushes ClojureScript code
changes to the client." This enables a very smooth Clojurescript
workflow. It's so seamless in fact that in some ways it makes
Clojurescript programming *more enjoyable* than working with Clojure!

[fig]: https://github.com/bhauman/lein-figwheel#lein-figwheel

[Piggieback][piggie] provides support for running a ClojureScript REPL
on top of an nREPL session. Chas goes into the reasons of why this is
a desirable thing in the README, so go check it out if you're interested.

[piggie]: https://github.com/cemerick/piggieback#piggieback-

Finally, [Weasel][weasel] allows your ClojureScript REPL to use
WebSockets to communicate with your chosen execution environment.
Again, their README has good information about why this might be a
thing you want.

[weasel]: https://github.com/tomjakubowski/weasel#weasel

The next two sections are pretty much just setup for Piggieback and
Figwheel:

```
                   :repl-options {:init-ns tour.server
                                  :nrepl-middleware [cemerick.piggieback/wrap-cljs-repl]}

                   :plugins [[lein-figwheel "0.2.1-SNAPSHOT"]]

                   :figwheel {:http-server-root "public"
                              :server-port 3449
                              :css-dirs ["resources/public/css"]}
```
