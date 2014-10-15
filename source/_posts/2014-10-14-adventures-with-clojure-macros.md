---
layout: post
title: "Adventures with Clojure macros"
date: 2014-10-14 19:20:56 -0400
comments: true
categories:
---

So, this is the second day of my second week of [Hacker School]. I'm
finally starting to feel like I'm getting into the
groove. etc. etc. about stuff I've been working on SICP, LLVM tut,
then on and off back to clojure stuff.  (aside about how good it is to
be able to move between different types of personal projects, gumption
etc.)

[Hacker School]: https://www.hackerschool.com/

<!--more-->

So I tackled [DCPL] in Clojure once again. I found two sort of scary
things. One, although my code was in a git repo, it wasn't pushed to
Github. Two, there was a big hairy macro that had apparently replaced
the core of my postfix program, but it wasn't checked in!!! Bad past
Geoff, very bad, no good software practices...

[DCPL]: http://mitpress.mit.edu/books/design-concepts-programming-languages

Anyhow, so I cleaned things up, and pushed up to Github (it's
[here][postfix-code] FYI), and then I started playing with that macro
again. Turns out it pretty much worked. After a bit of mucking around
I managed to get it going. This quick success buoyed my spirits and I
thought, why don't I write another... replacing repetitive code is
awesome etc.

[postfix-code]: https://github.com/RadicalZephyr/postfix-clj

Then there I wrote some tests, and it turns out that it didn't
actually work. Repeat for the better part of two hours with testing
getting slowly better and my implementation getting slowly more
correct. But, there were lots of little successes throughout, so I
didn't get discouraged, and the thrill of surmounting the difficulties
I encountered gave me a warm glow when I overcame them (macro writing
is hard! I know, because [Paul Graham told me so][pgmacro] ;).

[pgmacro]: http://www.paulgraham.com/avg.html

Anyhow, my success at writing this one macro made me want to write
another.  And I immediately saw an opportunity!  All of the binary
math operations for postfix are going to have the exact same form,
even with the last macro I wrote. etc. etc. about that macro, goes
pretty smooth.

Anyhow, so that went alright and now there are a bunch of tests I want
to write, just to validate that my macro is producing reasonable code
and continues to do so.

But... these tests are going to be SOOOO similar!!!  Are you thinking
what I'm thinking? Awww, yeah! Time for another macro.

So I start writing a macro to generate some simple tests for me.

All the tests have this general form:

``` clojure
(deftest subcommand-test
  (testing "Sub command"
    (is (= (sub-cmd [1 2])
           [-1]))
    (is (= (sub-cmd [0 3 2])
           [0 1]))
    (is (thrown-with-msg? clojure.lang.ExceptionInfo
                          #"sub: not enough values on the stack"
                          (sub-cmd [1])))))
```


So I start my macro working on that basic outline. Over the course of
another hour or so, I tweak and work it up to be this:


``` clojure
(defmacro defbinary-op-test [cmd-name op]
  (let [cmd-name (name cmd-name)
        fn-name  (symbol (str cmd-name "-cmd"))
        test-args [3 1]
        op-result (vector (apply op (reverse test-args)))]
    (prn "test-args:" test-args "\nop result:" op-result)
    `(testing ~(str cmd-name " command")
       (is (~'= (~fn-name ~test-args)
              ~op-result))
       (is (~'= (~fn-name ~(into [0] test-args))
              ~(into [0] op-result)))
       (is (~'thrown-with-msg? clojure.lang.ExceptionInfo
                               (re-pattern ~(str cmd-name
                                                 ": not enough values on the stack"))
                               (~fn-name [1]))))))
```

Okay, it looks like a monster.  But it's pretty straightforward.
Since my binary ops are actually implemented by the core functions
they represent I'm not concerned with the correctness or with testing
that they work per se. I'm more concerned with the vectors going in
and coming out.  So I figure, I'll use the same numbers for all of
them, and have the macro generate the result of actually applying the
given binary operator to the data I've hardcoded.

That's whats going inside the `let` with `test-args` and `op-result`.

There are a couple of other tricky things I found out. For instance,
the `is` testing macro is looking for exactly the symbol `=` not for
`clojure.core/=` or for `postfix.core-test/thrown-with-msg?`. I know,
because those are the things `defbinary-op-test` produced before I put
in the unquoted-quote `~'` to stop the automatic namespace resolution,
as described in the [Joy of Clojure][awesomebook].

[awesomebook]: http://www.manning.com/fogus2/


But then, after I debugged all of these little problems, I discovered
that, though my tests were being generated syntactically correctly,
they were failing!

Now, given the way that I constructed the macro, this didn't seem
possible.  I mean, I'm literally testing that my command, which uses
the given operator, produces the same thing as that operator.

So I dig in to make sure my macro is doing the right stuff, and pull
out `(clojure.pprint/pprint (macroexpand-1 '(defbinary-op-test add
+)))`

which produces this:

``` clojure
(clojure.test/testing
 "add command"
 (clojure.test/is (= (add-cmd [3 1]) [3]))
 (clojure.test/is (= (add-cmd [0 3 1]) [0 3]))
 (clojure.test/is
  (thrown-with-msg?
   clojure.lang.ExceptionInfo
   (clojure.core/re-pattern "add: not enough values on the stack")
   (add-cmd [1]))))
```


Okay, okay everything looks good... Wait a second... Did the macro
produce the result that 3 + 1 is 3?  Okay, let's take a closer look at
that macro again. Specifically, the two relevant portions of the let:


    test-args [3 1]
    op-result (vector (apply op (reverse test-args)))]


and the part where `op-result` is used:

    (is (~'= (~fn-name ~test-args)
           ~op-result))


Okay, everthing looks pretty kosher, but to be sure, let's try it out
in the repl, with the appropriate values filled in.

``` clojure
(let [op +
      test-args [3 1]]
  (vector (apply op (reverse test-args))))
;; => [4]
```

That's correct.  But that macroexpand clearly shows a `[3]` where that
`[4]` should be.

Okay, maybe I didn't reproduce something correctly in the REPL.  Let's
put some print statements in the macro before the expansion

``` clojure
(defmacro defbinary-op-test [cmd-name op]
  (let [cmd-name (name cmd-name)
        fn-name  (symbol (str cmd-name "-cmd"))
        test-args [3 1]
        op-result (vector (apply op (reverse test-args)))]
    (prn "test-args:" test-args "op result:" op-result)
    `(testing ~(str cmd-name " command")
       (is (~'= (~fn-name ~test-args)
              ~op-result))
       (is (~'= (~fn-name ~(into [0] test-args))
              ~(into [0] op-result)))
       (is (~'thrown-with-msg? clojure.lang.ExceptionInfo
                               (re-pattern ~(str cmd-name
                                                 ": not enough values on the stack"))
                               (~fn-name [1]))))))
```

When I reload the namespace I get this:

    :reloading (postfix.core postfix.core-test)
    "test-args:" [3 1] "op result:" [3]
    "test-args:" [3 1] "op result:" [3]
    "test-args:" [3 1] "op result:" [3]
    "test-args:" [3 1] "op result:" [3]

Okay, that's clearly what's happening but it's still really strange
that the `[3]` is showing up at all. So how about a
[minimal working example][MWE] (or rather, not-working in this case)?

[MWE]: https://en.wikipedia.org/wiki/Minimal_Working_Example


``` clojure
(defmacro deftestaddproblem [op]
  (let [test-args [3 1]
        op-result (vector (apply op (reverse test-args)))]
    `[~test-args ~op-result]))
```


Then macroexpanding it:


    (clojure.pprint/pprint (macroexpand-1 '(deftestaddproblem +)))
    [[3 1] [3]]


Just for sanity, lets make sure it's the right version of `+`:


    (clojure.pprint/pprint (macroexpand-1 '(deftestaddproblem clojure.core/+)))
    [[3 1] [3]]


What is going on!?!?!?!?! Okay, back to the REPL. This time, a raw
REPL from `lein repl` in my home directory.

``` clojure
user=> (defmacro dotest [op]
  #_=>   (let [test-args [3 1]
  #_=>         op-result (vector (apply op (reverse test-args)))]
  #_=>     `[~test-args ~op-result]))
#'user/dotest
user=> (dotest +)
[[3 1] [3]]
user=> (dotest -)
[[3 1] [3]]
user=> (dotest *)
[[3 1] [3]]
user=> (dotest /)
[[3 1] [3]]

;;; And without using the macro preprocessing
user=> (vector (apply + (reverse [3 1])))
[4]
user=> (vector (apply - (reverse [3 1])))
[-2]
user=> (vector (apply * (reverse [3 1])))
[3]
user=> (vector (apply / (reverse [3 1])))
[1/3]

;; Removing more complexity...
user=> (defmacro dotest2 [op]
  #_=>   (let [test-args [3 1]
  #_=>         op-result (apply op test-args)]
  #_=>    `[~test-args ~op-result]))
#'user/dotest2
user=> (dotest2 +)
[[3 1] 1]
user=> (dotest2 -)
[[3 1] 1]
user=> (dotest2 *)
[[3 1] 1]
user=> (dotest2 /)
[[3 1] 1]

;; And again outside of the macro
user=> (apply + [3 1])
4
user=> (apply - [3 1])
2
user=> (apply * [3 1])
3
user=> (apply / [3 1])
3
```
