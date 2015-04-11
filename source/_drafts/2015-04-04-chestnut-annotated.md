---
layout: post
title: "Chestnut - Annotated"
date: 2015-04-04 13:34:16 -0500
comments: true
categories: [Clojure, Clojurescript, Walkthrough]
---

As I wrote [recently][yaks], I recently dove head first into doing web
development with Clojure and Clojurescript. Along the way I learned a
whole heck of a lot about how to actually set up a [Leiningen][lein]
project to support a nice workflow for such a project. However, most
of my new-found knowledge has already been put together into a very
nice package called [Chestnut][chestnut]. However, at first glance
(and second and third glance really) Chestnut projects are complex and
intimidating.

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
