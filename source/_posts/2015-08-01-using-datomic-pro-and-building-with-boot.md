---
layout: post
title: "Using Datomic Pro and Building with Boot"
date: 2015-08-01 20:14:20 -0500
comments: true
categories: [Clojure, Boot, Datomic]
---

I first heard about [Datomic][datomic] shortly after it was initially
released. I think I almost immediately went and read all of the
documents that ~~[Relevance][relevance]~~ [Cognitect][cognitect] released about
it's architecture. I was duly impressed, and really interested in
using it. In particular, the potential for
[time-travelling][datomic-time-travel] was really interesting and
exciting to me.

[relevance]: http://thinkrelevance.com/
[cognitect]: http://cognitect.com/
[datomic]: http://www.datomic.com/
[datomic-time-travel]: http://www.datomic.com/benefits.html

At the time I had been tasked with writing some code to determine
usage metrics for our system. One of my boss's hopes was that we could
generate usage data from some time ago as well to compare with our
current levels. Because we were using traditional relations databases
and hadn't planned for this use case, that turned out to be
impossible. However, if we had been using Datomic, that back-dated
query would have been absolutely trivial.

<!--more-->

At the time I was overwhelmed by the intensity and scarcity of the
documentation on Datomic. Also, my general inexperience meant that I
wasn't prepared to be an early adopter of this technology. This
statement from a [tutorial blog about Datomic][datomic-tut] that I
recently ran across really resonated with my experiences:

[datomic-tut]: http://ben.vandgrift.com/2014/04/24/a-clojure-datomic-web-app-tutorial.html

> My problem with the vast majority [of Datomic tutorials] is that
> they seem to be written for people who don't need a tutorial, and by
> and large all have the stench of "read the code and you'll
> understand," quickly coupled with "and if you don't, you're not smart
> enough to use this technology anyway."

So nothing much came of my first attempt to learn Datomic. Recently
though, my interest was piqued again by a talk by a co-worker at my
current job at [8th Light][8l]. At the same time, I've been inspired
recently to pick up again a project I started around the time I was
first interested in Datomic, [Rotateam][rotateam]. But given my recent
love affair/obsession with Clojure, and in particular the
[Boot][boot-git] project for creating Clojure [build tooling][boot], I
obviously wanted to rebuild the project using a
Boot/Clojure/Clojurescript stack. And what better database technology
to use than Datomic!

[8l]: http://8thlight.com/
[rotateam]: https://github.com/RadicalZephyr/rotateam
[boot-git]: https://github.com/boot-clj/boot
[boot]: http://boot-clj.com/

I chose to tackle the part I was least familiar with first: Datomic. I
followed the links and instructions from the Datomic home page until I
found out about the new (to me at least) free license for
[Datomic Pro Starter Edition][pro-starter]. From there I just followed
the getting started instructions and the tutorial.

[pro-starter]: http://www.datomic.com/get-datomic.html

Since Datomic is very proprietary software, the jar's for it aren't
available from public repositories. Instead, when you register with My
Datomic you get a generated password that gives you access to their
private, password-protected Maven repository. Conveniently, when you
sign up for the Starter Edition you are presented with a page that
tells you how to setup Maven and Leiningen projects to pull from these
repositories. They show you an excellent setup too, that doesn't
require the security-sin of committing secrets to a Git repository.

Unfortunately, since Boot is a still a relative newcomer to the
Clojure ecosystem, there are no supported instructions for securely
using the My Datomic Maven repository with Boot.

Sounds like the perfect opportunity for a blog post :D

## Top Down

Let's start from what we want to be able to do. In an ideal world, I
would be able to simply include Datomic Pro as a dependency in my
`:dependencies` list. In a typical `build.boot` file that would look
like this:

```clojure build.boot
(set-env!
 :dependencies '[[com.datomic/datomic-pro "0.9.5206"]])
```

If we try this out, it pretty clearly fails, on my machine spitting
out a huge amount of junk error messages that boil down to "Sorry
chap, I couldn't find com.datomic/datomic-pro version 0.9.5206 for
you." Of course, this is because we haven't told boot how to look in
the Maven repository where it exists: `https://my.datomic.com/repo`.

Let's try the simplest thing that could possibly work. If we look at
the Boot
[documentation on the keys in the Boot environment][boot-env], we can
see that there is a handy `:repositories` key that we should probably
be setting with the details of our My Datomic credentials. If we check
out the [documentation in Pomegranate][pom-doc] for what the values of
the `:repositories` vector should look like, we can see that to
include authentication credentials, we need to specify it as a
map. Concretely our `build.boot` should look more like this:

[boot-env]: https://github.com/boot-clj/boot/wiki/Boot-Environment#env-keys
[pom-doc]: https://github.com/cemerick/pomegranate/blob/pomegranate-0.3.0/src/main/clojure/cemerick/pomegranate/aether.clj#L639-L650

```clojure build.boot
(set-env!
 :dependencies '[[com.datomic/datomic-pro "0.9.5206"]]
 :repositories #(conj %
                      ["my-datomic" {:url "https://my.datomic.com/repo"
                                     :username "notmyemail@example.com"
                                     :password "obviously-not-my-password"}]))
```

The reason for the funny syntax of specifying a lambda function as the
repositories value is because we want to update the value
`:repositories` by adding (`conj`ing) the `my-datomic` repository. We
can't just blindly override the repositories, because by default Boot
adds entries (which we can see by running `boot show -e` for pulling
from [Maven Central][mvn-central] and [Clojars][clojars] which we
probably don't want to blow away.

[mvn-central]: http://search.maven.org/
[clojars]: https://clojars.org/

Obviously you'd need to put your real My Datomic credentials in
there. Just as obviously, this can't be the final form our solution
takes. The `build.boot` file pretty much _needs_ to be under source
control, and those secrets need to __*not*__ be present in source
control.
