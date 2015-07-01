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

First of all, let's talk briefly about the Repository Pattern
itself. My first exposure to the idea was through the discussion of it
in "Domain Driven Design" by Eric Evans. Martin Fowler has
[a page on Repositories][fowler-repo] where he summarizes the pattern
with this description:

> Mediates between the domain and data mapping layers using a
> collection-like interface for accessing domain objects.

[fowler-repo]: http://martinfowler.com/eaaCatalog/repository.html

This is a good high-level summary of what Eric Evans describes as
well. Broadly speaking, the idea is that you use the Repository
Pattern to thoroughly isolate your domain layer from whatever
strategies are used to persist the domain data. Evans offers this
description of the problem that Repositories help to solve:

> A subset of persistent objects must be globally accessible through a
> search based on object attributes. ... Providing access to other
> objects muddies important distinctions. Free database queries can
> actually breach the encapsulation of domain objects and
> AGGREGATES. Exposure of technical infrastructure and database access
> mechanisms complicates the client and obscures the MODEL-DRIVEN
> DESIGN.

He further explains that:

> A repository lifts a huge burden from the client, which can now talk
> to a simple, intention-revealing interface, and ask for what it
> needs in terms of the model. To support all this requires a lot of
> complex technical infrastructure, but the interface is simple and
> conceptually connected to the domain model.

Finally, he lists the advantages that using Repositories confers:

- They present clients with a simple model for obtaining persistent
  objects and managing their life cycle.
- They decouple application and domain design from persistence
  technology, multiple database strategies, or even multiple data
  sources.
- They communicate design decisions about object access.
- They allow easy substitution of a dummy implementation, for use in
  testing (typically using an in-memory collection).
