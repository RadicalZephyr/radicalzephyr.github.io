+++
layout = "post"
title = "Sane Static Site Setups"
comments = "true"
categories = ["web"]
+++

During the last week of Hacker School I helped [Leta][] sort out
some issues she had with her blog setup and restore everything to
sanity. It was a lot of fun and the setup is pretty straightforward so
I thought I'd do a short write-up on what we did and why.

[Leta]: http://lmontopo.github.io/

To be clear, this blog post is about solving the particular problem of
how to organize a statically generated site/blog. The particulars I'm
going to discuss are for when you host the site on [Github Pages][]
but you need to generate the site locally because you're not using
vanilla [Jekyll][] or not using Jekyll at all.

[Github Pages]: https://pages.github.com/
[Jekyll]: http://jekyllrb.com/

<!--more-->

This isn't a tutorial about how to set up and use any particular
static site generator.  There are [quite][Jekyll] [a][Pelican] [few][] [out][]
[there][], and [they][] [all][] seem to be quite good. So pick one and
get your site setup.  You should be comfortable generating the content
of your site before worrying about what I'm describing in this post.

[Pelican]: http://docs.getpelican.com/en/3.5.0/
[few]: http://wintersmith.io/
[out]: https://github.com/greghendershott/frog
[there]: https://github.com/taylorchu/baker
[they]: https://github.com/hugoduncan/cl-blog-generator
[all]: https://staticsitegenerators.net/

One of the best and worst things about using a static site generator (SSG)
is that the source for the site is fundamentally a separate thing from
the actual files that compose the site itself. The good news is that
the generated files are, well, generated. Given the source for a
site you can always regenerate the presentation files.

So clearly we want to keep the source for our site under version
control. If you're using Github Pages then git is a natural
choice. But Github Pages also requires that the generated content of
your site be in a git repository. This leads to an un-intuitive setup.
Because the source and published files don't actually share a common
history, it seems like they need to be stored in separate git
repositories.  However, there is a fundamental relationship between
the files that dictates that organizationally they should always be
found together.

Luckily for us, git is flexible enough to allow us to achieve both
these seemingly conflicting goals. Since the usual workflow for a git
repository simply involves `git init` and then edit, `add`,
`commit` cycles, it's less well known that a git repository can
actually contain multiple independent "head" commits. Don't worry if
that doesn't totally make sense. The important thing is that we can
store two separate revision histories in the same git repository.

So, you have the source for a static site, and you've maybe written
some dummy (or real!) content for it and generated the site at least
once. Now, we want to make sure that we have a setup that will help us
preserve all of your hard work on making an awesome website.

The first thing we need to do is to make sure we have git repositories
in both the source and output directories by running `git init` in
both of them separately. Since most SSG's by default use a structure
where the output folder is a subdirectory of the source folder, make
sure that you have an entry in your gitignore file so that the output
isn't committed into the source repository. At this point we should
have two git repo's, one that _only_ has the site source content
(including any files need by your SSG) and one that _only_ has the
generated version of your site.

Now for the magic trick of combining the repositories. Let's say we
have this folder structure:

```
- website/
 - .git/  # Git folder for source files
 - ...    # Lots of awesome content files
 - output/
  - .git/ # Git folder for output files
  - ...   # The actual generated content files
```

At a shell prompt in the directory `website`, you can run:

```
git remote add output output/
git push output master:source
```

Basically, what we're doing is setting one repository as a remote of
the other, and then pushing the content to new branch there.  Now the
`output` repository contains both the source and output files in
separate git branches. Pushing all the branches of this to a hosting
site means you have a complete backup of your site.

Now, the process of updating your site is a little more complicated
than the general Github Pages workflow of edit, commit and push since
you need to generate the site yourself.

First, edit your site's content files.  Commit as necessary for your
peace of mind. Once you're satisfied with how the content looks
(you've been previewing and generating the site right?), it's time to
commit the new content to the output branch, and then push it to your
hosting location.

That's basically it. It's a simple structure, but it's not totally
straightforward of how to get it set up, and it's also a bit more work
to maintain. Of course there are some interesting tools out there to
help with this process. [Octopress 2.0][] tries to setup this
structure automatically for you, and provides a Rakefile for helping
to automate a lot of the normal tasks like site generation, previewing
and even deployment. [Pelican][] offers to generate a Makefile and/or
a fabfile for doing the same sorts of things. Pelican also makes use
of the really neat [GHP-Import][] project to simplify the deploying
process.

[Octopress 2.0]: http://octopress.org/
[GHP-Import]: https://github.com/davisp/ghp-import

Now go forth and blog!
