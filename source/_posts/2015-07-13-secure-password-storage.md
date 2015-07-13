---
layout: post
title: "Secure Password Storage"
date: 2015-07-13 14:34:31 -0500
comments: true
categories: [Security]
---

At a high-level, when storing secrets like passwords, the standard
best practice is to never store the plain-text version of the password
in the system.  Instead, you store some information that is uniquely
and repeatably derived from the password in an irreversible fashion.
This is often called a "digest."

This preserves the ability to check whether someone has entered the
correct password for an account in order to authenticate them (you
simply recalculate the derived value and check those for equality),
but it prevents an attacker who somehow obtains the password digest
from immediately having access to the plain-text version of a user's
password. That's the process at a very high-level.

<!--more-->

Now there are a number of different types of attacks that can be
executed against a web application and a legitimate user to attempt to
intercept the plain text version of a single user's password.  The
defenses for these are well known, and all of the countermeasures that
are part of the source code of the app are being used.  There are some
further countermeasures (such as usage of https) that are a concern
of how the app is deployed, but we will certainly be implementing
those when we get to the point of production deployment.

This leaves the main attack vector for obtaining user passwords as
somehow obtaining access to the password digests that we store in our
database.  In our meeting on Thursday, Paul outlined some of the
deployment choices we can make to help prevent this from ever
occurring, but for illustrative purposes let's assume that an attacker
has compromised our database in some manner and now has access to our
user password digests offline.

It is at this point that a detail I have glossed over becomes very
important: the method that we use to generate the password
digests. The industry standard is to use a key derivation function
(KDF). There are three current industry standard KDF's: PBKDF2,
bcrypt, and scrypt.

All three of these KDF's produce values that cannot be used to derive
the original key (i.e. the plain-text of the user password).  This
leaves two avenues of attack: a brute-force search for the original
password plain-text (a "preimage attack"), or a brute-force search for
another password plain-text that produces the same digest (a "collision
attack").

It's important to realize that defending against a brute-force
password search is not a question of making it "impossible."  It's
really a question of how expensive it would be, and how long it would
take. The goal in this case is to make it so that the attacker can't
try enough passwords in a "reasonable amount of time" that they will
get a sufficient return on the hardware they need to throw at the
problem, without making password authentication take so long that it
makes users upset.

At a high-level, all three of the industry standard KDF's are tunable
as to how much time they take, so they effectively have equivalent
resistance to a brute-force attack.  However, PBKDF2 is a relatively
simple algorithm that can be very efficiently computed in specialized
hardware, or on commercial graphics cards.  This makes it
substantially weaker than the other two because graphics cards and
specialized hardware can increase the number of passwords that an
attacker can test per unit of time.

To quote an piece of writing I found about bcrypt:

> Bcrypt has the best kind of repute that can be achieved for a
> cryptographic algorithm: it has been around for quite some time,
> used quite widely, "attracted attention", and yet remains unbroken
> to date.

Recently, advances in hardware have made bcrypt somewhat vulnerable in
a similar manner to PBKDF2.  Scrypt was designed to be tunable in both
speed and memory usage.  This tunable memory usage makes scrypt far
less susceptible to these specialized hardware attacks.

In general though these types of hardware attacks come at significant
cost, so for many applications tuned usage of PBKDF2 or bcrypt is more
than adequate.  Using scrypt also carries another form of risk. Since
it is a much newer algorithm it hasn't had time to be subjected to the
same analysis and attack attempts as PBKDF2 and bcrypt.  This means
that it is possible for a security vulnerability to be discovered in
scrypt at some point in the future that makes it significantly less
secure than the other two.
