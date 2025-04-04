+++
title = "Introduction to Bash Scripting"
+++

# A.K.A. - How To Use The Command-Line Like A Pro


## Unix Tools Philosophy     :slide:

-   Files and plain-text
-   Library of composable tools
-   Arguments
-   Standard Input/Output/Error
-   Pipes
-   The Environment


### Everything is a (plain-text) file     :slide:

-   Very file-oriented
-   Characters are characters

-   As opposed to office suites
    -   Binary file format (also proprietary)
    -   Need specialized code to read/write in the correct format
    -   Has "export" functions to transform it to different formats


### Library of Tools     :slide:

Check it out:

<https://en.wikipedia.org/wiki/List_of_Unix_commands>


#### Notes     :note:

Focus on a few at a time.  Empahasize incremental learning.  It's a
large toolbox and potentially overwhelming.  Take away is that adding
even one tool is a valuable outcome.


### Arguments     :slide:

-   Two types
    -   Switches (i.e. `-c` or `--count`)
    -   Other

-   Conventional Switches                                               :slide:
    -   Short and long switches
    -   `-v` / `--version` - program version
    -   `-h` / `--help` - help!
    -   `--` - end of switches

There are MANY exceptions!!


#### Notes     :note:

For instance, ruby supports -v and &#x2013;version
git only supports &#x2013;version
java requires -version!!!


### Standard Input/Output/Error     :slide:

Most standard unix tools except to receive on stdin

After processing they put the changed text to stdout

Three streams. One for input, two for output.

-   All programs have these.
-   That doesn't mean they're always different!


#### Notes     :note:

Demonstrate cat as prototypical of stdin stdout pattern. It takes
arguments, but in their absence it defaults to read stdin, write stdout


### Pipes     :slide:

Shorthand for hooking the output of one program to the input of
another

There's more to it though&#x2026;


#### Notes     :note:

Demonstrate tr as very similar to cat, but takes no file arguments

So how do we feed it files as input? Pipe from cat!

This demonstrates pretty well the composable toolkit idea, and
DRY-ness of program logic.  Cat knows how to open files and
filenames.  So pretty much very few other programs need to.

Also, pull performance:

This is a good example though: what does find . -type f -name 'a\*' do
normally?

Why does the pipe run so much quicker?!?!?!


### The Environment     :slide:

-   Convenient place to store information
-   Lots of interesting stuff is there already
-   Many commands take cues from environment variables


#### Notes

-   Show the `env` command

-   Use EDITOR variable and git commit as an example

(USE A REAL SHELL!!) Go to hermit, delete runtests, then commit it no
message

First time, should open a buffer in zile, then nano, then vi
Don't write commit messages


## Jobs of a shell     :slide:

High-level

-   Expansions
-   Argument splitting
-   Setup environment
-   Find/execute program
-   Cleanup


### Expansions     :slide:

-   file "globs"
-   Special variables
    -   Arguments, `$0`-`$9`, `$#`, `$@`
    -   Shell info, `$$` `$!` `$?`
-   Variables (so many possibilities!!)
    -   Controlling variable expansion ${} etc.
-   Sub-shells


#### Notes     :note:

Do many demonstrations here!!

Have a script that demonstrates how argument expansion works


### Arguments processing     :slide:

Who is familiar with processing command-line arguments?

All command line programs get arguments in this format:

A list of: `program name arg1 arg2 arg3`

But how does it make that list?


#### Quoting     :slide:

Preventing processing from occurring

-   This can be tricky and subtle


### Setup environment     :slide:

-   Input/output redirection
-   Temporary variable setting


#### Notes     :note:

Redux the git commit editor thing with temporary variable

Use cat to copy a file, use diff to show they're the same

Append some lines to the end of the new one


### Program look-up/execution     :slide:

Search all paths in `PATH` variable, left-to-right order

-   Overriding default paths


#### Notes     :note:

Show adding a directory to PATH and then executing that file from
somewhere else


### Exit Codes     :slide:

0 => success
anything else => some kind of failure

-   not always clear what the meaning is for non-zero codes


#### Notes     :note:

Redo the diff thing, then show that the exit code changes

diff defines no differences as success, and different as failure

git commit -a.  If no commit happens, then 1, else 0


### Implicit State - this is not so important


#### Current User

-   `$UID`, `$USER`


#### Current Directory

-   `$PWD`, `pwd`, `cd`


#### Environment Variables

-   `env`


## Actual Scripting     :slide:


### Loops and Conditionals     :slide:

These are similar to most programming languages but subtly different.


#### if     :slide:

Runs a program, and checks the exit code

Show how `[` is a program also called `test`


#### loops     :slide:

-   while: similar in concept to if
    -   Show a standard counter style while loop
    -   Show a more exotic bash type while loop (using which to figure out
        what path element an executable lives in)
-   for: very different.  More reminiscent of python
    -   does expansions, doesn't run commands


#### Notes     :note:

For demos, consider using common files like /usr/dict and /etc/passwd


### Cool examples

I have none&#x2026;

Mine my github, the LDP pages, my provel scripts


### Common Idioms

<http://www.billharlan.com/papers/Bourne_shell_idioms.html>


#### Argument processing


## Developing Shell Scripts


### Man pages!!     :slide:

Reading them is sort of an art


### Incremental Build-up     :slide:

-   Avoid permanent effects
-   But learn how to setup test environments for doing destructive stuff


#### Notes     :note:

Show the example of trying to figure out how many discrete shell
scripts


### Guarding commands with echo     :slide:

Very simple, very effective


#### Notes     :note:

find all files pipe to xargs echo

find . -type f -name 'a\*' | head | xargs -n1 echo


### `set -e` and `set -x`     :slide:

Really powerful options


#### -e "most important line in any bash script"

Default behavior


#### -x "almost as good a debugger"

Display everything!!


### Mindset     :slide:

Talk about the gitignore thing.  Upfront data structure creation
(process all .hignore files, then check each filename against all
patterns.  Obviously really bad in bash because no way to use a hash
table or something to speed up the checks

But what about flipping it around? Instead, enumerate all files, then
enumerate all files that match each pattern in a .hignore.  Then,
filter the list of those files by the ones that only appear once.


### Dummy     :slide:

<div class="HTML" id="orga72a22d">
<p>
&lt;script type="text/javascript" src="org-html-slideshow.js"&gt;&lt;/script&gt;
</p>

</div>
