+++
layout = "post"
title = "Getting started with LLVM and OCaml on OS&nbsp;X"
comments = "true"
categories = ["LLVM", "OCaml", "Homebrew"]
+++

I [wrote recently][llvm-mac] about my (second) experience trying to
get started using LLVM on my Macbook. Shortly after that, I became
interested in combining my interest in LLVM with my interest OCaml. As
it turns out, this was a much easier task than I anticipated.

[llvm-mac]: {% post_url 2014-11-19-getting-started-with-llvm-on-os-x %}

<!--more-->

Since my whole experiment with Vagrant was so successful for using
the C++ LLVM libraries, I immediately started doing the same thing for
my OCaml experiments. I created a `Vagrantfile` and started trying to
write a bash script to correctly provision an Ubuntu instance with the
requirements for the OCaml LLVM bindings.

I was stalled fairly quickly by the fact that the version of
[OPAM][opam] in the Ubuntu apt repositories is somewhat old.  Old
enough that it doesn't want to talk to the official OPAM servers for
package updates. So I futzed and fiddled a bit, and looked around for
alternate ways to install OCaml.

Eventually I got it figured out, and started trying to install the
OCaml bindings for LLVM. It didn't go well. The compilation of the
llvm opam package errored almost immediately. But while I was looking
through the error messages, I noticed something interesting. The
errors were related to nonexistent paths, and the paths that the
package was expecting all started with `/usr/local/Cellar`. For the
non brew-savvy, this is the default location that [Homebrew][brew]
uses for all it's installations.

[brew]: http://brew.sh/

I knew that homebrew had an LLVM package because of my C++
meanderings. The error messages from OPAM on Ubuntu made me think that
the OCaml LLVM package was actually expecting to be run on a Mac, or
at least to work with a `brew install`ed LLVM.

So I gave it a shot. I cleaned out and re-installed my LLVM installation
with `brew rm llvm && brew install llvm`. And then I simply ran `opam
install llvm`. As far as I remember (it was a couple weeks ago now ;),
everything went off without a hitch.

<How was I able to validate the installation? Looked at Kaleidoscope
tutorial?>

Finally, I wanted to be able to use the top-level to explore the LLVM
API, but that didn't appear to work right away. After some googling, I
found an answer on Stack Overflow (of course!) that said I had to
compile a custom version of utop with the LLVM libraries linked in.

I did that <describe it!! got to refigure out how I did that though>,
and then was able to get the wonderful utop completion stuff to work
with the totally unfamiliar LLVM bindings in OCaml.

Of course, then I needed to implement a [language to actually compile
with LLVM][ocaml-postfix]. And of course I still haven't actually done
anything with LLVM...

[ocaml-postfix]: https://github.com/RadicalZephyr/postfix-ocaml
