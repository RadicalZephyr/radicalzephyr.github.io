---
layout: post
title: "Getting Started with LLVM on OS&nbsp;X"
date: 2014-11-19 03:31:00 -0500
comments: true
categories: [LLVM, Vagrant]
---

A few weeks ago, I decided that one of the things I wanted to tackle
during my time at Hacker School was getting familiar with the LLVM
project. To that end, myself and several other Hacker Schoolers formed
an informal group to work through the official
[LLVM Kaleidoscope][llvmkal] tutorial. We made reasonable progress at
first, but as soon as we actually had to start dealing with the LLVM
tools, I started encountering problems.

[llvmkal]: http://llvm.org/releases/3.5.0/docs/tutorial/index.html

Long story short, I ended up getting frustrated with the state of the
documentation surrounding LLVM and moving on to working on other less
upsetting projects. This last weekend though I ended up getting back
into it. I tried two different approaches.

<!--more-->


First, I decided to use a Vagrant supported VM to do my LLVM
setups. This was for two reasons: the fact that I do my development on
a Mac running OS X seems to be problematic when trying to install LLVM
in a global manner. This is because *some* of the LLVM tools (like
Clang) make up the default build environment on OS X. But the toolset is
insufficient if you actually want to build languages with LLVM, and
the presence of these libraries makes it... complicated to try and
install a more complete version. As Homebrew says when you try to
install LLVM via `brew install llvm`:

> Mac OS X already provides this software and installing another
> version in parallel can cause all kinds of trouble.

This is essentially the problem that I ran into a couple weeks ago
that caused me to give up on working with LLVM. This time however, I
had the insight that I wasn't solely limited to the physical machine
that I had an the one operating system I have the space to install on
it. By using [Vagrant] I could pretty trivially have a working Ubuntu
environment to use as my development platform for working with LLVM.

[Vagrant]: https://www.vagrantup.com/

So that's what [I did][vagrantllvm]. The most interesting thing about
that repository is how I ended up provisioning my Vagrant
VM. To quote briefly from the [Wikipedia Article][wikiprov]:

> ... provisioning is a set of actions to prepare a server with
> appropriate systems, data and software, and make it ready...

[vagrantllvm]: https://github.com/RadicalZephyr/postfix-llvm
[wikiprov]: https://en.wikipedia.org/wiki/Provisioning#Server_provisioning

The provisioning is done via shell scripts (that's not the interesting
part!), but instead of using `apt-get` to install all the software
that I required I mostly had to build them from scratch. But let's go
through the story end to end.

First off, I did try to install all the software via `apt-get`. There
was some confusion for me about which version of LLVM to install. From
the reading I'd done on the [LLVM site] previously I thought that
since 3.5 has been officially released it would be considered the
stable version. However, when you install LLVM 3.5 via `apt` (with
`sudo apt-get install llvm-3.5`) the binaries don't seem to end up
getting installed on a path location. Or rather, they are on path, but
the names are all suffixed with `-3.5`.

[LLVM]: http://llvm.org/releases

This wasn't really what I wanted, so I also tried installing the 3.4
packages which it turns out are also the default set of packages
installed if you `apt-get install llvm`. This got the right names for
the tools onto my path, so step one check. So much easier to install
than with Homebrew! Well, to install and make sure that it was available
to me anyhow.

Then, since I was going to be doing `C++` development, I wanted to use
[CMake] as my build generator. If you've never used CMake but you do
`C/C++` development I'd highly recommend checking it out. It allows
you to specify your build process at a very high level.  As a bonus,
it can then generate the files to process that build with [several][1]
[different][2] [kinds][3] of actual [build systems][4]. It's way more
convenient than writing your own `Makefiles` and much more modern than
the whole [autoconf] system (which I can't say much about, I've never
learned it).

[CMake]: http://www.cmake.org/
[1]: http://www.gnu.org/software/make/
[2]: https://eclipse.org/
[3]: http://msdn.microsoft.com/en-us/vstudio/aa718325.aspx
[4]: http://www.cmake.org/cmake/help/v3.0/manual/cmake-generators.7.html#id4
[autoconf]: https://www.gnu.org/software/autoconf/

Anyhow, CMake has another handy benefit. It has a system for
[finding your dependencies][findpkg]. Not like over the internet like
[some build systems][maven], but still it's better than the basic
situation in C. Since CMake has actually been around for a while there
are many standard open source projects that provide the mechanics for
finding their libraries with CMake, including - handily enough - the
LLVM project.

[findpkg]: http://www.cmake.org/Wiki/CMake:How_To_Find_Libraries
[maven]: http://stackoverflow.com/questions/1541771/using-maven-for-c-c-projects

One requirement of this system is that a "module file" be somewhere on
the CMake `modules-path`. For packages that support it, this should
happen when the package is installed and the locations of the critical
library and header files are actually known. Only problem is that the
CMake packages available in the Ubuntu repositories don't actually do
this. Turns out there was a [bug report] early in 2014 describing the
issue. Then a long back and forth with the package maintainer (I
think) and many cases of "Hey, it should be fixed now!", followed by a
response of "No, it actually still doesn't work..."

[bug report]: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=735592

Then I found the LLVM `apt` [nightly builds page][llvmapt] which
possibly answers why LLVM 3.4 is still the default package on Ubuntu,
since the LLVM project considers 3.4 to be "stable" and 3.5 is the
"qualification branch." This `apt` repository seemed like a good bet
for finding an LLVM package that would properly install the necessary
CMake files, but alas, I had no such luck.

[llvmapt]: http://llvm.org/apt/

So instead I built LLVM from scratch. This is both easier and harder
than it sounds. Building LLVM from source is a very automated process,
and the parts that aren't automatic by default (like downloading,
checking file signatures and unpacking archives) are highly
automatable. The painful part is that VM's are always slower than a
natively installed OS. And my poor Macbook Air takes about 45 minutes
to do a full LLVM build under the native OS X. So basically once I got
everything setup I let the LLVM build run and stopped thinking about
it except to check on it every few hours.

I had quite a few build failures mostly related to what seem
like out of memory errors in GCC. Sometimes just restarting the
compilation helped, but I also restarted Vagrant VM and gave it a full
2GB of memory which helped a lot.

Once the install finished though CMake was able to find it
immediately. As pointed out earlier, the code is up on Github. I was
surprised to discover that there is no Vagrant VM that exists for
doing LLVM development, so that's going to go on my list of
projects. Ideally, that **won't** involve building LLVM from source in
the provisioning stage, because of the computational issues with
VM's. It might be an interesting excuse to learn how to build .deb
packages and make a PPA with a CMake that properly installs the
`FindLLVM.cmake` files...
