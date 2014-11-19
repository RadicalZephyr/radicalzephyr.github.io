<!!!!!!!!!!!!put in stuff about homebrew!!!!!!!!!!!!!!!!>

<general outline>
Talk about successfully setting up LLVM development with Vagrant VM

Key points:

- debian repo's bad/old
- CMake findlibrary support doesn't really work (from .debs)
- Need to build from source to get that support
- I needed to run build multiple times because of memory errors (and
  increase VM memory)
- But then CMake worked like a charm.  Sort of... Clang didn't build properly


Also, write another blog post about getting setup with LLVM and
OCaml.  Because that's another story.

Key points there:

- went through the same process (Vagrant VM, automated shell script
setup, build from scratch thoughts...)
- Looked at some errors, seems like opam *expects* to be dealing with homebrew!!
- Well shoot, why not try native!
- `brew install llvm`
- `opam install llvm`
- llvmutop thing, then `#require "llvm"` or whatever and voila!

TL;DR much easier.


Also, more notes for a more meta-ish blog post: talking about why I
came to hacker school, and what I've gotten out of it.

I sort of felt like I'd reached a plateau in my development as a
programmer. Could do some things, didn't really feel proficient in a
profound way.  hadn't "arrived."  bif fish, small pond feeling?  Also
a bit of impostor syndrome.

Came to HS to rediscover my joy in programming and the excitement of
it and of learning new stuff.  Realizing I'd gotten so stressed out in
general, and particularly overwhelmed by the amount of stuff there is
to learn.  Also ,ties in to the lesson learned working with David.
Can't learn everything just by tackling it.  Learned somewhat the
wrong thing. from that.  Should have learned a caveat and estimation
lesson.  Under time and budget pressure, not the time to tackle
learning three totally new subjects!! But tackling new subjects gamely
with beginner mind is actually awesome. Especially when you have
people to back you up.  Advice, find a community (Like HS!!).

I've noticed an increase in my confidence since I came to hacker
school.  This is essentially the hump that I was failing to get over
before coming to HS, that felt like a plateau. (I felt I'd stopped
making progress). Also, talk about my silly analogy of the plateau,
being able to see that their are higher places to be reached but not
how to get there from where I was. Then, at Hacker School what has
happened is that I fell of the other side of my current plateau. The
base level of the ground over here is higher though, and more
importantly now I can see a ridgeline that I can follow, that looks
like it will take me to those higher places.

What is that ridgeline though? The philosophy of "Never Graduate"
maybe. Of challenging myself to continue asking questions. To avoid
the temptation to seek out only the things that I'm already good at.

This ties in to the thoughts I've had in the past regarding "when am I
going to feel competent at something?"  Because there is a balance to
be maintained.  And that balance comes back to gumption. When it comes
down to it, I have been getting by for years on an essentially empty
tank of gumption. It's been a great learning experience because it's
forced me to create strategies to generate gumption and pay attention
to what it feels like both to have it and not have it.  And I've been
able to get by on the absolute minimum.

But it just feels better to be alive when you have a surplussage of
gumption.

That is actually the real story of how I started teaching myself to
program. By taking time off from school after graduating high school I
was able to actually build up a supply of gumption for pretty much the
first time in my life. Life was good. This is a virtuous cycle.

But it took me a year and a half to get enough gumption to try
something as bold as teaching myself to program. (sort of... :)

This is one of the reasons that I wanted to come to Hacker
School. Because I recognized (mostly subconsciously) that it would be
an excellent place to build gumption. And it really has been.
