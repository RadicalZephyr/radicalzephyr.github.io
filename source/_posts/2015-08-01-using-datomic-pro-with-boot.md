---
layout: post
title: "Using Datomic Pro with Boot"
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
current levels. Because we were using traditional relational databases
and hadn't planned for this use case, that turned out to be
impossible. However, if we had been using Datomic, that back-dated
query would have been absolutely trivial.

<!--more-->

When I attempted to actually learn to use Datomic however, I was
overwhelmed by the intensity and relative scarcity of the
documentation. My general inexperience meant that I wasn't prepared to
be an early adopter of this technology.

> My problem with the vast majority [of Datomic tutorials] is that
> they seem to be written for people who don't need a tutorial, and by
> and large all have the stench of "read the code and you'll
> understand," quickly coupled with "and if you don't, you're not smart
> enough to use this technology anyway."

I read this in a [tutorial blog about Datomic][datomic-tut] that I
recently ran across. It neatly sums up how I felt about Datomic at
that time. So nothing much came of my first attempt to learn Datomic.

[datomic-tut]: http://ben.vandgrift.com/2014/04/24/a-clojure-datomic-web-app-tutorial.html

Recently though, my interest was piqued again by a talk given by one
of my current co-workers. At the same time, I've been inspired
recently to pick up again a project I started around the time I was
first interested in Datomic, [Rotateam][rotateam]. Given my recent
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

Unfortunately, since Boot is still a relative newcomer to the Clojure
ecosystem, there are no official Coginitect-supported instructions for
securely using the My Datomic Maven repository with Boot.

Sounds like the perfect opportunity for a blog post :D

<a id="top-down"></a>

## Top Down

Let's start from what we want to be able to do. In an ideal world, I
would be able to simply include Datomic Pro as a dependency in my
`:dependencies` list. In a typical `build.boot` file that would look
like this:

```clojure build.boot
(set-env!
 :dependencies '[[com.datomic/datomic-pro "0.9.5206"]])
```

If we try this out it pretty clearly fails. On my machine Boot spat
out a huge amount of junk that boiled down to "Sorry chap, I couldn't
find version `0.9.5206` of `com.datomic/datomic-pro` for you." Of
course, this is because we haven't told boot how to look in the Maven
repository where it exists: `https://my.datomic.com/repo`.

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

<a id="first-working"></a>

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
adds entries for pulling from [Maven Central][mvn-central] and
[Clojars][clojars] which we probably don't want to blow away.

[mvn-central]: http://search.maven.org/
[clojars]: https://clojars.org/

<a id="side-note"></a>

### Side Note

Rather than bothering to go and read the Pomegranate documentation, we
also could have inspect Boot's default environment. Boot ships with a
handy task called `show` which is useful for this sort of inspection.
For Leiningen users, it's sort of equivalent to `lein pprint`. In this
case, since we're interested in what's in the environment we want to
run `boot show -e` or `boot show --env`.  And of course, as with all
Boot tasks we could find out this information by running `boot show
-h`. Okay, `</side note>`.

<a id="back-to-it"></a>

## Back to It

Obviously you'd need to put your real My Datomic credentials in
there. Just as obviously, this can't be the final form our solution
takes. The `build.boot` file pretty much _needs_ to be under source
control, and those secrets need to __*not*__ be present in source
control.

So [that](#first-working) works. But to develop a more elegant and
secure solution, we're probably going to need a better understanding
of just how Boot goes about loading dependencies. Now, we could go and
read the source. Or we could treat Boot as a black box and play with
it until we have a better understanding of how it works. I vote the
latter.

Let's start with the simplest thing that probably __won't__ work. What if
we move the `:repositories` update into a separate `set-env!` like this:

```clojure build.boot
(set-env!
 :dependencies '[[com.datomic/datomic-pro "0.9.5206"]])
(set-env!
 :repositories #(conj %
                      ["my-datomic" {:url "https://my.datomic.com/repo"
                                     :username "notmyemail@example.com"
                                     :password "obviously-not-my-password"}]))
```

This again fails spectacularly for the same reason of not being able
to resolve the Datomic dependency. But this test has told us something
important. It tells us that the dependency resolution happened _during
the first call to `set-env!`_. This is important, because it implies
that if we get the `my-datomic` repository configuration into the boot
environment before that call, then everything should work just
fine. Let's try it out:

```clojure build.boot
(set-env!
 :repositories #(conj %
                      ["my-datomic" {:url "https://my.datomic.com/repo"
                                     :username "notmyemail@example.com"
                                     :password "obviously-not-my-password"}]))
(set-env!
 :dependencies '[[com.datomic/datomic-pro "0.9.5206"]])
```

Hey, presto! It works. Let's think about why this works for a moment
and what the implications are. Obviously, at some point during the
`set-env! function, some code gets called that notices that a new
dependency was added, and attempts to resolve it. As long as the
repository required to resolve that dependency is present in the list
of repositories at that moment, then everything works fine. This is an
excellent example of what the Boot authors are talking about when they
say that Boot builds are programs.

If you're like me then long familiarity with declarative build systems
has lulled you into thinking of build description files as
fundamentally not code. Even though a Leiningen project map is
entirely made of Clojure data structures, my experiences have taught
me that it isn't really code. But a Boot build file is. It's executing
Clojure code on an epicly simple level.

When I was first discovering how this worked for myself, I was working
on an actual project, and the `build.boot` was significantly more
complex. As such, I broke out the Datomic specific portions into the
snippets that I've included in this blog post. But because of my
build's-as-specification indoctrination, I had fallen into a rhythm of
always having my `build.boot` files have a certain structure to them.

```clojure My proto-typical build.boot
;;; Start with source paths and dependencies
(set-env!
 :source-paths #{"src" "test"}
 :dependencies '[[org.clojure/clojure      "1.6.0"]
                 [midje                    "1.7.0"          :scope "test"]
                 [zilti/boot-midje         "0.2.1-SNAPSHOT" :scope "test"]
                 [radicalzephyr/bootlaces  "0.1.15-SNAPSHOT"]])

;;; Require bootlaces and other boot tasks
(require '[radicalzephyr.bootlaces :refer :all]
         '[zilti.boot-midje        :refer [midje]])

;;; Define the project version
(def +version+ "0.1.1-SNAPSHOT")

;;; And use the bootlaces configuration
(bootlaces! +version+)

;;; Finally, configure any default task-options
(task-options!
 pom  {:project     'radicalzephyr/rotateam
       :version     +version+
       :description "A web-app for scheduling team role rotations."
       :url         "https://github.com/radicalzephyr/clj-rotateam"
       :scm         {:url "https://github.com/radicalzephyr/clj-rotateam"}
       :license     {"Eclipse Public License"
                     "http://www.eclipse.org/legal/epl-v10.html"}})
```

This structure is _very_ reminiscent of a `project.clj` file. It's
format is slightly different, but there's really nothing that takes
advantage of the fact that this is actually a regular Clojure
program. This is true for a reason though, and again it's mentioned in
Boot's rationale. Simple projects don't need the flexibility of having
their build be a real program. But here's the thing, simple projects
tend to become complex projects over time.

<a id="back-to-datomic"></a>

## Back to Datomic

Okay, enough philosophizing. What does this build as program mean for
storing and accessing our My Datomic credentials securely? Well for
starters, it means we can do something really simple like following
the Heroku paradigm of putting secrets into environment
variables. Pulling them out is easy with a little bit of Java-interop.

```clojure build.boot
(set-env!
 :dependencies '[[com.datomic/datomic-pro "0.9.5206"]]
 :repositories #(conj %
                      ["my-datomic" {:url "https://my.datomic.com/repo"
                                     :username (System/getenv "DATOMIC_USERNAME")
                                     :password (System/getenv "DATOMIC_PASSWORD")}]))
```

This again works perfectly. But why stop there? This solution only
works when you have your Datomic username and password set as
environment variables. Instead, we could fallback to prompting the
user for the credentials. Borrowing and adapting some code from
[Adzerk's bootlaces][adzerk-bootlaces], we can provide a reasonable
fallback experience.

[adzerk-bootlaces]: https://github.com/adzerk-oss/bootlaces

```clojure build.boot
(let [[user pass] (mapv #(System/getenv %) ["DATOMIC_USERNAME" "DATOMIC_PASS"])
      datomic-creds (atom {})]
  (if (and user pass)
    (swap! datomic-creds assoc :username user :password pass)
    (do (println (str "DATOMIC_USERNAME and DATOMIC_PASS were not set;"
                      " please enter your Datomic credentials."))
        (print "Username: ")
        (#(swap! datomic-creds assoc :username %) (read-line))
        (print "Password: ")
        (#(swap! datomic-creds assoc :password %)
         (apply str (.readPassword (System/console))))))
  (set-env! :repositories
            #(conj % ["my-datomic" (merge @datomic-creds
                                          {:url "https://my.datomic.com/repo"})])))
```

This code may look a bit intimidating, but it's mostly managing the
details of user friendly input and output. But again, why stop here?
This is _just Clojure code_ here, so all of Clojure's ability to
define and use abstractions is right there.

```clojure build.boot
(defn get-cleartext [prompt]
  (print prompt)
  (read-line))

(defn get-password [prompt]
  (print prompt)
  (apply str (.readPassword (System/console))))

(let [user (or (System/getenv "DATOMIC_USERNAME")
               (get-cleartext "DATOMIC_USERNAME was not defined.\nUsername: "))
      pass (or (System/getenv "DATOMIC_PASSORD")
               (get-password  "DATOMIC_PASSWORD was not defined.\nPassword: "))]
  (set-env! :repositories
            #(conj % ["my-datomic" {:url "https://my.datomic.com/repo"
                                    :username user
                                    :password pass}])))
(set-env!
 :dependencies '[[com.datomic/datomic-pro "0.9.5206"]])
```


There's still some obvious duplication in there. Let's see if we can
get rid of that too.


```clojure build.boot
(defn get-cleartext [prompt]
  (print prompt)
  (read-line))

(defn get-password [prompt]
  (print prompt)
  (apply str (.readPassword (System/console))))

(require '[clojure.string :as str])

(defn get-env-or-prompt [prefix prompt-fmt word get-fn]
  (let [env-name (str prefix word)]
    (or (System/getenv env-name)
        (get-fn (format prompt-fmt env-name (str/capitalize word))))))

(let [[user pass] (mapv #(get-env-or-prompt "DATOMIC_"
                                            "%s was not defined.\n%s"
                                            %1 %2)
                        ["USERNAME"    "PASSWORD"]
                        [get-cleartext get-password])]
  (set-env! :repositories
            #(conj % ["my-datomic" {:url "https://my.datomic.com/repo"
                                    :username user
                                    :password pass}])))

(set-env!
 :dependencies '[[com.datomic/datomic-pro "0.9.5206"]])
```

The code is longer now, but it's been decomposed and de-duplicated
significantly. It also gained the ability to prompt for values only if
the corresponding environment variable isn't set. We could keep going
with this, and define that `let` block as a function. We could move
all this code into a Clojure source file in the `src` folder of the
current project, and then `require` it in. Or we could put it into a
separate library like [my bootlaces][my-bootlaces] and add that as a
dependency. Once we extract this functionality into a libryr we could
add tests for it, and then continue to expand it's functionality. We
could add another method for retrieving the credentials. Perhaps
storing them in an encrypted edn file, which we read in if it exists.

[my-bootlaces]: https://github.com/radicalzephyr/rotateam

All of these various permutations are possible, and more. And we
always have the full power of Clojure at our disposal. Notice what we
didn't have to do at any point along this process. We didn't have to
write a plugin for our build tool, or try to get a patch merged into
the source code and wait for it's release. It's all just been regular
Clojure code, following a very natural and easy code growth
path. Start out with an inline-definition and usage, then slowly
abstract and tease apart into a separate package.

This is the philosophy of Lisp writ large in the paradigm of building
programs. There is no difference between what is built into Boot, and
what we define personally. There is nothing done in the Boot built-in
tasks that could not have been done by a Boot user. Based on a few
carefully chosen "primitives" an elegant and powerful structure can be
built. This is what happens when your code is just data, or your build
is just a program.
