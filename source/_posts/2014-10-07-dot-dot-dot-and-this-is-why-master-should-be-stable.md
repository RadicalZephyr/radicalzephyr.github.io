---
layout: post
title: "... and this is why master should be stable"
date: 2014-10-07 13:28:48 -0400
comments: true
categories: [Programming, Rant, Troubleshooting]
---

Second day at Hacker School.  I spent the morning doing two things:

- getting my blog setup to use [Octopress].
- helping another HS-er troubleshoot getting setup with [Flask] and [Flaskr].

[Octopress]: http://octopress.org/
[Flask]: http://flask.pocoo.org/
[Flaskr]: http://flask.pocoo.org/docs/0.10/tutorial/introduction/

<!--more-->

Yesterday, I was super frustrated by the difficulties I had in getting
Octopress going, and was reminded of the frustrations with setting up
Ruby environments that led me to wipe my computer and start from
scratch a few weeks ago.  You know, that and a certain amount of boredom.

Anyhow, I was able to make more headway today, largely because I
sorted out all of the really silly stuff yesterday.

But helping Sammy with setting up [Flask] was a nightmare!  TL;DR, we
figured it out, and it was incredibly simple.

First off, there were some minor SNAFU's with me showing her about
[virtualenv], and explaining briefly how it works and how why she
should use it.  But then, we were confronted with these instructions
on the [Flaskr doc page][flaskr-github] on Github, a natural place to
look when the ["actual" docs][Flaskr] don't mention anything about how
to install or setup the damn thing.

WWe spent nearly two and a half hours searching for the mythical
`flask` binary, to no avail.  Finally, after I inadvertently ran
aacross this [flask issue][issue], it dawned on me that we might be
having the same problem.  Well, that's not quite true.  In reality, I
got so frustrated that I decided to just try the simplest thing that I
could think of to get flaskr to run `python flaskr.py`.  Low and
behold, it worked!!  Then, in retrospect, having seen that issue
describing the disconnect between the docs for flaskr in the flask
`master` branch and what the latest stable version was, I went and
looked at the [last stable release docs][laststable] for flaskr, and
there it was. Simple instructions to do the simple, straightforward
thing.

[[virtualenv]: http://virtualenv.readthedocs.org/en/latest/virtualenv.html
[flaskr-github]: https://github.com/mitsuhiko/flask/tree/master/examples/flaskr
[issue]: https://github.com/mitsuhiko/flask/issues/1180
[laststable]: https://github.com/mitsuhiko/flask/tree/0.10.1/examples/flaskr
