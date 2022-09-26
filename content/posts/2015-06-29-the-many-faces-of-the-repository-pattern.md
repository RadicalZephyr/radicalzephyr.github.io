+++
layout = "post"
title = "The Many Faces of the Repository Pattern"
comments = "true"
categories = ["Programming", "Patterns"]
+++

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

This looks pretty similar to the interface that ActiveRecord gives
us. If we go back to that list of benefits that repositories are
supposed to confer, it's not immediately obvious that this
implementation is really going to give us any of those, except
possibly the ability to swap database implementations.

But what are we to do instead? Well, as it turns out waiting a few
days provided an answer. Over the weekend one of the Craftsmen at 8th
Light took the initiative to toss our codebase headfirst into a
slightly different repository implementation. This was a tricky
prospect for a codebase that was fairly coupled to the use of
ActiveRecord, but once we got everything figured out we ended up with
something that looked sort of like this:

```ruby
module Repository
  class RepositoryBase
    def initialize(db)
      @db = db
    end

    def create(attributes)
      convert(repository.create(attributes))
    end

    def find_by_id(id)
      convert(repository.find_by_id(id.to_i))
    end

    def all
      repository.all.map { |e| convert(e) }
    end

    def count
      repository.all.count
    end

    def convert(data)
      @db.adapter.convert(model_class, data)
    end

    def model_class
      raise NotImplementedError
    end

    def repository
      raise NotImplementedError
    end
  end
end

module Notes
  class Repository < Repository::RepositoryBase
    def find_all_by_user_id(user_id)
      repository.where(user_id: user_id).map do |note|
        convert(note)
      end
    end

    def model_class
      Notes::Note
    end

    def repository
      @db.notes
    end
  end
end
```

This actually looks substantially similar, and in some ways bears even
more resemblance to an ActiveRecord API.

Since it's come up a few times, let's consider the differences between
ActiveRecord and the Repository pattern. From the Rails Guide on
ActiveRecord:

>  In Active Record, objects carry both persistent data and behavior
>  which operates on that data. Active Record takes the opinion that
>  ensuring data access logic as part of the object will educate users
>  of that object on how to write to and read from the database.

So the essential feature of ActiveRecord is that the Model class
represents both the domain model, and the data model. Contrast this
with one of the primary features of the Repository Pattern as
described by Eric Evans:

> [The repository] Mediates between the domain and data mapping layers
> using a collection-like interface for accessing domain objects.

Instead of combining domain and data access into the same object, the
Repository gives us an explicit boundary to partition our system
on. On one side, we can hide the often significant technical
complexity of storing and retrieving data. On the other side we can be
concerned solely with domain objects and their behaviour.

So it's not really the difference in API that we're looking for, it's
the architecture surrounding that API. In particular, simply by having
a separate Repository object we've started to achieve that separation
between data and domain. So despite the fact that our Repositories
don't try to fully emulate a collection of domain objects we've
actually managed to achieve one of the primary goals of the Repository
Pattern.


## Taking it Further

I think the most important question to ask when talking about
technical infrastructure is "What does it buy me?" In this case, what
might we be able to do now that we use repositories everywhere that
would have been difficult or impossible before? It just so happens
that one of the next features on our list was implementing users in
the system having a balance of some kind.

We decided that in the domain, this could naturally be represented by
each user having an Account. This [indirection][too-much] conveniently
gives us the ability to potentially model transfers to non-User
entities. But how would we actually store the data associated with an
Account? The most obvious (and somewhat naive) way would be to store a
simple integer balance for each Account. As an ActiveRecord migration
it would probably look something like this:

[too-much]: https://en.wikipedia.org/wiki/Indirection

```ruby
create_table "accounts", force: :cascade do |t|
  t.integer  "balance",    null: false
  t.integer  "user_id",    null: false
end
```

But a common model for recording balances in the domain of accounting
is typified by double entry book-keeping. In this model the sum of all
debits and credits must always be equal, and the balance for a
particular account can be calculated by the sum of debits and credits
associated with that account. Again, in ActiveRecord that might look
something like this:

```ruby
create_table "accounts", force: :cascade do |t|
  t.integer  "user_id", null: false
end

create_table "transactions", force: :cascade do |t|
  t.integer "account_id", null: false
  t.integer "amount", null: false
end
```

If we've implemented a successful Repository, it should be possible
for us to write the Repository using the naive strategy, develop
client code that utilizes the Repository, and then transition the
Repository to use the more sophisticated transaction scheme without
making any changes to the clients.

The first key element for implementing the accounts repository is
going to be an Account domain object. Ignoring how it gets created for
the moment, here's a basic implementation.

```ruby
module Accounts
  class Account
    attr_reader :id, :balance, :user_id

    def deposit(amount)
      @balance += amount
    end

    def transfer_to(account, amount)
      if !has_funds?(amount)
        raise "Balance too low"
      else
        @balance -= amount
        account.deposit(amount)
      end
    end

    def has_funds?(amount)
      @balance >= amount
    end
  end

  class Repository < Repository::RepoBase
    def create_for(user)
      account = create({user_id: user.id})
      account
    end

    def find_by_user(user)
      convert(@db.accounts.find_by_user_id(user.id))
    end

    def model_class
      Accounts::Account
    end
  end
end
```

Notice that this version of the account uses the same naive model of
storing a simple balance. We could rewrite this domain level code to
store a list of transactions as an array of hashes, and then collapse
the list of transactions to the new effective balance when saving the
object. So already, we can see that separating the concerns of data
storage and domain behaviour has achieved some level of isolation.

Now let's imagine we change the database implementation so there is no
longer any `db.accounts` object. Instead, we have `db.transactions`
which has methods like `find_all_transactions_for_account_id`.

Again ignoring details of how the transactions are created or saved:

```ruby
module Accounts
  class Repository < Repository::RepoBase
    def create_for(user)
      account = create({user_id: user.id})
      account
    end

    def find_by_user(user)
      transactions = @db.transactions.find_by_user_id(user.id)
      balance = transactions.reduce(0) { |r,t| r + t.amount }
      convert({user_id: user.id, balance: balance})
      end

    def model_class
      Accounts::Account
    end
  end
end
```

This was a very minor change, given that under the covers data is
being stored in an entirely different manner. Even better, the change
is totally isolated to the repository. Because of the original naive
implementation of the Account domain object, some changes will need to
be made to the way it handles transfers. This may look like the
details of the data storage are leaking into the domain, but in fact
this is a data requirement bubbling up. We can't store transactions if
we don't record them in the first place. And realistically, we're
probably going to need the concept of a Transaction to be added to the
domain model.

You may then find yourself wondering, "What value do we really get
from this separation if both sides of the boundary are going to need
to change anyhow?" The answer I think is two things: separation of
concerns and incremental changes. The details of how we handle
transactions in the domain layer are going to be different from the
details needed to handle storing data in the database. This separation
of concerns allows us to focus on the technical complexity of data
storage when writing that code, and to focus on the business
complexity when dealing with the domain code instead of mixing the two
together.

Second, this separation layer provides us an abstraction layer that we
can use to isolate changes to our code. Earlier I demonstrated how the
domain layer could stay the same even though storage had moved to a
transaction model. It's not too hard to imagine changing the domain
model to track transactions using pure Ruby data structures and having
the repository still store accounts with an explicit balance.

This separation layer then gives us a nice stepping stone to move from
one implementation to the other. This stepping stone is important
because it's a place where we should be able to stop making code
changes and have all of our tests pass. To me, being able to make real
changes in this stepwise manner is one of the hallmarks of
well-factored and decoupled code.
