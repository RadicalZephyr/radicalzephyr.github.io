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

## What is a "Repository"?

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

For someone seeking to implement the Repository Pattern in their own
project, this list serves as an excellent barometer of the quality of
their implementation.


## My Repository

A few weeks ago I started working on a new client project. It was a
greenfield application, and we started building it in Ruby on Rails,
using the basic Rails application structure, and all of the built-in
Rails Magic &trade;. This meant a standard MVC architecture,
ActiveRecord models, the whole nine yards.

We embraced the "Rails Way" largely to give the project a
jump-start. We were pretty confident that eventually we'd start
feeling the pain of using Rails and want to head towards some sort of
hybrid Rails architecture.

A few weeks ago, we got to that point and started looking at
implementing a repository for the new domain object we were about to
introduce. Unfortunately, I didn't return to the discussion from the
DDD book referenced earlier, and we basically started to feel our way
into implementing the Repository pattern based on my teammates prior
experience, what we generally knew about the pattern and some
interesting examples we found on blog posts regarding using the
Repository pattern with Rails' ActiveRecord technology.

We ended up with something that looked basically like this:

```ruby
module Notes
  class Repository
    def initialize(dao = Note)
      @dao = dao
    end

    def new(attributes)
      Notes::Note.new(attributes)
    end

    def find_by_id(id)
      record = @dao.find_by_id(id)
      Notes::Note.new(record.attributes)
    end

    def save(note)
      if note.valid?
        record = @dao.new(note.attributes).save
        note.id = record.id
        true
      else
        false
      end
    end
  end
end
```

This looks a lot like an ActiveRecord model. If we go back to that list
of benefits that repositories confer, it's not immediately obvious
that this implementation is really going to give us any of those,
except possibly the swappable database implementation.
