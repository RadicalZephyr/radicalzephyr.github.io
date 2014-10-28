---
layout: post
title: "Playing with Org-mode"
date: 2014-10-27 18:30:05 -0400
comments: true
categories:
---

So, as a way to procrastinate on actually starting to write/practice
my lightning talk for Thursday, I decided that I absolutely wanted to
make a slide show using the [org-html-slideshow], a pretty neat piece
of Clojurescript written by those smart guys at
~~Relevance~~Cognitect.

[org-html-slideshow]: https://github.com/relevance/org-html-slideshow

Basically, it lets you take an outline/document written in [Org-mode]
(another really cool piece of software!) and put some small
annotations in it to delimit your "slides" and then you have a
document that can be viewed as either a slideshow, or a web page. It's
harder to explain in words than it is to observe, so here's the
[example page](/demos/example.html) from their github repo, and the
[org-mode document](/demos/example.org) that produced that page.

[Org-mode]: http://orgmode.org/

<!--more-->

Now that is pretty neat. However, the workflow needed to create one of
these is sort of a pain. From the documentation on the project page,
you're expected to create a one-off web site that has the contents of
this production folder available and then manually generate the
html document from the org-mode source. Ick.

My blog is made with [Jekyll], which is a static site generator. None
of my posts are actually written in html, instead I write them in
[Markdown], and then Jekyll handling converts the markdown into
html. When it does this I can also cause it to be inserted into a page
template (i.e. layout). The upshot is, I can create a static site but
not have to duplicate all of the code to have a common set of header
info, navigation toolbar, nifty sidebar etc. Because only the unique
things are specified in each document, and the general boilerplate is
automatically included for me by Jekyll.

So if I'm generating html from markdown automatically with Jekyll it
feels sort of wrong to be generating html manually with an interactive
emacs command and then committing this generated html into my git
repo. It would be so much nicer if I could just get Jekyll to invoke
emacs as the translator for turning `.org` files into `.html` files.

[Jekyll]: http://jekyllrb.com/
[Markdown]: http://daringfireball.net/projects/markdown/syntax

Well, pursuing that line of thought today I worked with
[Waldemar Quevedo]. He showed me his incredible org-based workflow for
everything (he also gave an awesome lightning talk on it the first
week of Hacker School!). While it looks really cool, it's sort
heavy-weight for what I want to do. Frankly, I'm really comfortable
writing markdown, so I'll probably continue to write most of my posts
in it. But org-html-slideshow is exciting enough that I'd be willing
to write my presentations in Org-mode so I can utilize it.

[Waldemar Quevedo]: https://github.com/wallyqs

I won't attempt to explain Wally's setup, but he's got some [pretty]
[cool] [stuff] going on. In essence though, he uses a ruby gem to
parse the org syntax and transform it into markdown. As of this
writing though, it doesn't support the tags feature that
org-html-slideshow depends on for it's functionality.

[pretty]: https://github.com/wallyqs/org-ruby
[cool]: https://github.com/eggcaker/jekyll-org
[stuff]: https://github.com/punchagan/org-hyde

While showing Wally the slideshow thing got him excited to try and
integrate it into his workflow, I started poking around and looking at
how to integrate it into my site. The solution I decided on was to
make `.org` files a generic member of the Jekyll source files. This
means that they'll still use a YAML frontmatter to mark that they need
to be transformed. This means that I need some way to transform a body
of org text into just the html content that it represents. Normally
when you generate an html page from org-mode, you get a complete html
page, `html`, `body` tags and all. What I needed was a way to invoke
the org->html transformation using the Elisp code in org-mode from
Jekyll.

With Wally's help, I was able to get this far towards that goal. This
is the elisp that will continuously read from the minibuffer until an
error occurs, and then transform that text using the org->html backend,
and finally print out the generated html.


``` common-lisp
(progn
  (require 'org)
  (progn
    (condition-case nil
        (while t
          (insert (read-string "") "\n"))
      (error nil))
    (set-buffer
     (org-export-to-buffer 'html "*Org HTML Export*"
       nil nil nil t nil
       (lambda () t)))
       (message "%s" (buffer-string))))
```

And this is how you invoke the transformation of a file from org to
html. The `$emacs` is because I use [Emacs for Mac OSX] which means
that my emacs executable is buried inside of a mac `.app` file/folder
thing. Pipe a file into this script and if it's valid org syntax,
you'll get the corresponding html.

[Emacs for Mac OSX]: http://emacsformacosx.com/

``` bash
tail -n+4 hello.org | $emacs --batch --eval "(progn (require 'org) (progn (condition-case nil (while t (insert (read-string \"\") \"\\n\")) (error nil)) (set-buffer (org-export-to-buffer 'html \"*Org HTML Export*\" nil nil nil t nil (lambda () t))) (message \"%s\" (buffer-string))))"
```

Now the only thing that's left is to write a Jekyll plugin to do this
invocation to produce the final output.
