---
layout: post
title: "On the Importance of Distinguishing Between Stable and Development Documentation"
date: 2014-10-26 23:10:04 -0400
comments: true
categories:
---

A few weeks ago I wrote about [Why Master Should Be Stable][stable]. I
spent most of that post explaining what had actually happened to me,
but not really talking about the fundamental underlying difficulty.
Well, now that I've encountered this issue again in a different
context, maybe it's time to dive in a bit and see what's really the issue.

[stable]: {% post_url 2014-10-07-dot-dot-dot-and-this-is-why-master-should-be-stable %}
<!--more-->

As the title hints, this issue is really more about being able to
match the documentation of a project to a particular version. The
problem with Flaskr was that when you went searching for the
documentation, you most easily found the documentation for the
currently in development branch. This isn't a problem when no major
changes have been made, but when there are major changes this becomes
an issue.

Part of the reason that I'm writing this blog post is because last
week, while I was going through the [LLVM] project's [tutorial] I ran
into the exact same issue! But I didn't spot that this version
mismatch was the issue until after I had found another workaround.

[LLVM]: http://llvm.org
[tutorial]: http://llvm.org/docs/tutorial/index.html

Not to belabor the point, but basically the LLVM tutorial linked above
is actually the version of the tutorial written for the upcoming 3.6
release. Since there are several breaking changes to the API occurring
in this release, when you have installed LLVM 3.5 the tutorial appears
to be rather broken.

This problem is sort of ironic as the majority of open source software
out there (most definitely including all of my projects :) as
little-to-no documentation, and/or what there is, is hopelessly
out-of-date. In contrast, the issue that I had with both Flaskr and
LLVM was actually a case of the most easily available documentation
being TOO up-to-date.

[[Talk about projects that get it right - Django, Read the Docs]]

[[Related issue: how do you fix this?]]

The people who notice these kinds of issues are typically people just
wanting to use the project, not the people developing it. This is
probelmatic though because the noticer's, by not being in the project
probably have no opportunity to help fix this since often it involves
things like, access to the servers etc.
