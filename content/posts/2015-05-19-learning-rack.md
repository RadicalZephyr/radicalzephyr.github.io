+++
layout = "post"
title = "Learning Rack"
comments = "true"
categories = []
+++

For the past two weeks or so I've been grappling with trying to build
a simple HTTP front-end for my ruby Tic-Tac-Toe program. There have
been some non-technical hurdles with scheduling and other projects
demanding my time, but I've also spent a fair amount of time simply
struggling to put the pieces together with how the Rack libraries
work.

<!--more-->

Rack as a concept is exceptionally simple. Inspired by [PEP 333][wsgi]
which specified the Python Web Server Gateway Interface or WSGI, Rack
has come to be the de-facto way that Ruby applications interface with
web servers. Beyond the [basic concept][rack], Rack provides a set of
helper libraries. These include many useful middleware and convenience
classes for things like static file serving, sessions, and request
parsing and response generation. However, the documentation for the
classes included in Rack is pretty dismal.

[wsgi]: https://www.python.org/dev/peps/pep-0333/
[rack]: http://rack.github.io/

For the most part it is all auto-generated documentation, but many of
the classes have only a vague description of what they do, with no
indication of how they're meant to be used. Conspicuously absent or
good examples of configuration of middleware, especially in the
special DSL that is made available in [rackup] files.

[rackup]: https://github.com/rack/rack/wiki/%28tutorial%29-rackup-howto

Given the number of different web frameworks that are built on top of
Rack, it's sort of shocking to me that the documentation is in this
sort of state. Though I guess it's consistent with my general
experience of Ruby libraries as a whole.

I've really worked in Ruby since I started my apprenticeship at 8th
Light, but from what I've seen, many Ruby libraries have awkward gaps
in their documentation. For instance, Guard is an amazing and vital
piece of a smooth Ruby TDD toolchain. But it's documentation is
incredibly cryptic about how to properly setup a Guardfile. There are
more paragraphs about how to debug problems in your Guardfile than
what the format is!

Now documentation is hard. But over the last several years, it's been
increasingly clear to me that [good documentation][good-doc] is one of
the most valuable assets that a software product can have, especially
an open-source one.

[good-doc]: https://jacobian.org/writing/great-documentation/

So then why is writing good documentation still so elusively
difficult? I know I struggle with it immensely. The majority of
[my projects] have little to no documentation, with the notable
exception of [Hermit].

[my projects]: https://github.com/RadicalZephyr?tab=repositories
[Hermit]: https://github.com/RadicalZephyr/hermit

I think there are a few reasons. First off, writing in general is
hard. It takes effort, and the will to keep re-writing and trying new
things to end up with a nicely polished piece of writing that reads
well, and communicates the author's intent clearly and succinctly.

Another reason is that it's much easier to polish a piece of writing
with good critical feedback from someone else. The complicating factor
for code documentation is that you need to find the right audience to
give you feedback. Often this means someone who is totally unfamiliar
with your exact software, but if it's code documentation it probably
also can't be your friend who only uses their computer for writing
Word documents and checking their social media.

But I think the final reason is that we don't do it enough. Again,
like all other writing, the best way to get better at it, is simply by
writing lots and lots of documentation. Also, critically reading the
documentation that you read, and reflecting on what is helpful, and
what isn't.
