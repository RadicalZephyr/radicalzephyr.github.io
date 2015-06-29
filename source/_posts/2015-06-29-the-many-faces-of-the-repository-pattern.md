---
layout: post
title: "The Many Faces of the Repository Pattern"
date: 2015-06-29 00:43:06 -0500
comments: true
categories: [Programming, Patterns]
---

Last week I spent quite a lot of time working closely with my a fellow
apprentice on refactoring a Rails application away from direct usage
of ActiveRecord for data persistence, and towards some incarnation of
the Repository Pattern. Now that we've finished, I thought some
reflection on the different possible implementations that we
considered, and what we ended up implementing might be in order.

<!--more-->
