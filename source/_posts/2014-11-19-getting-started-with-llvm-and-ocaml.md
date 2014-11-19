---
layout: post
title: "Getting Started with LLVM and OCaml"
date: 2014-11-19 03:31:00 -0500
comments: true
categories:
---

A few weeks ago, I decided that one of the things I wanted to tackle
during my time at Hacker School was getting familiar with the LLVM
project. To that end, myself and several other Hacker Schoolers formed
an informal group to work through the official
[LLVM Kaleidoscope][llvmkal] tutorial. We made reasonable progress at
first, but as soon as we actually had to start dealing with the LLVM
tools, I started encountering problems. Long story short, I ended up
getting frustrated with the state of the documentation surrounding
LLVM and moving on to working on other less upsetting projects.

[llvmkal]: http://llvm.org/releases/3.5.0/docs/tutorial/index.html

<!--more-->

This last weekend though I ended up getting back into it. I tried two
tacks.  First, I decided to use a Vagrant supported VM to do my LLVM
setups. This was for two reasons: the fact that I do my development on
a Mac running OS X seems to be problematic when trying to install LLVM
in a global manner. This is because *some* of the LLVM tools (like
Clang) make up the default build environment on OS X. But the toolset is
insufficient if you actually want to build languages with LLVM, and
the presence of these libraries makes it... complicated to try and
install a more complete version. As Homebrew says when you try and
install LLVM via `brew install llvm`:


<!!!!!!!!!!!!put in stuff about homebrew!!!!!!!!!!!!!!!!>
