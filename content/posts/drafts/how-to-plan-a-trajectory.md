+++
layout = "post"
title = "How to Plan a Trajectory"
categories = ["3D Printer", "Rust"]
comments = true
draft = true
+++

Have you ever watched a 3D printer worked and thought "That's so cool,
how does it do that?" No? Just me then. Well, if you're now interested
in that thought let me tell you what I know about trajectory
planning. A few years ago now I got hired to work on the software for
a 3D printer and I learned a few things about this topic. While
working on that I ran across Michael F Bryan's blog series "Adventures
in Motion Control." Michael's blog series seems to have ended right around
actually getting into how to simulate the motion part of motion
control. Since I have some small familiarity with this topic I thought
I would continue on in that vein.

The first of which is that "motion control" and "motion planning" are
not the proper scientific terms used for how a 3D printer does it's
thing. The proper term is **trajectory planning**, and it's a core
component of motion planning which is a more holistic field that deals
with navigating complex environments. Automatic machines like 3D
printers or regular printers for that matter, have a very simple
environment and they are primarily concerned with what path to follow
to achieve their end goal.

<!--more-->

## Overview

Trajectory planning starts with the physics of motion, also known as
kinematics. We need to understand a bit about how to mathematically
describe the position of an object, and how that position changes over
time.

Once we can describe the movement of an we need to talk a little bit
about force, mass and acceleration and how the relationship between
these quantities dictates how fast we can change a real object's
position, velocity and acceleration.


I don't have any familiarity with _slicing_ the process of taking a 3D
model and slicing it into layers, then creating a path for the printer
to follow to actually recreate that object. So we won't be starting
there. What I'm concerned with is what happens after that. The slicer
will generate a file with GCode instructions, typically hundreds of
thousands of them. Each of these instructions will tell the machine to
make one specific motion. In the 3D printer world most slicers will
approximate curves using very short line segments, so typically the
majority of the instructions will be G1.

Before we get way down into the weeds though, let's start with some
good old physics. Woo, where to start. Okay, well... uh. Jeez, where
did my physics courses start. We want to talk about how the print head
moves through space. During that movement it will pass through a bunch
of different _positions_. This will take a certain amount of _time_,
that relationship of how _position_ changes over _time_ is called
velocity. In every day life most people refer to it is a speed, as in
"what's the speed limit?". Velocity is a slightly more complex notion
in that it includes the direction of travel. Everything moving has a
velocity as well as a speed. A car driving down the highway might have
a _speed_ of 60 MPH. To determine it's velocity we need to know the
direction of the highway at the point in time we're interested in, in
this case perhaps it happens to be north. The velocity of the car is
then 60 MPH, heading north. This is one example of a math concept
called a vector which is a direction and a magnitude.

There's another quantity that we care about in motion planning which
is also a vector. Nothing goes from motionless to moving
instantaneously, so we also need to think about the acceleration of an
object, that is the rate at which velocity changes over
time. Acceleration is actually the only physical quantity that we can
directly sense. To know your position is meaningless without reference
to some reference position, and the same is true with
velocity. We actually have an organ in our bodies capable of sensing
acceleration, our inner ear that helps us keep our balance.

For human scales of direction tracking a relative tracking system like
the cardinal directions (North, South, East, West) is usually good
enough. Perhaps we break it down into the four intercardinal
directions as well (Northeast, Southwest etc.). If you want to get
very precise in your navigation you might need to use the eight
secondary intercardinal directions (north-northwest, east-southeast
etc. Or perhaps you're familiar with the military relative bearing
system of using clock hands "I have a bogey on my six!"

For computing purposes we need to get even more precise than that, and
for a 3D printer we need to be able to talk about movements in all 3
spatial dimensions. For that we'll use a common mathematical
representation of a 3 dimensional vector, which is a series of 3
numbers representing the magnitude in the X, Y and Z
directions. Commonly written like so `(1, 2, 3)`. This vector has an
implied start point at the origin `(0, 0, 0)`. Vectors can also
include negative numbers and zeroes in any position `(-1, 0, 2)`.

A unit vector is a vector in a particular direction, starting at the
origin with a length of 1.

We can represent the cardinal directions in this system using four
vectors: North `(0, 1, 0)`, South `(0, -1, 0)`, East `(1, 0, 0)` and
West `(-1, 0, 0)`. For fun and completeness we can also add Up
`(0, 0, 1)` and Down `(0, 0, -1)`. The intercardinal directions can be
calculated by adding together the two unit vectors: Northeast
`(1, 1, 0)`, Southeast `(1, -1, 0)`, Southwest `(-1, -1, 0)`. These
vectors are no longer unit vectors but they do point in the correct
direction and I don't want to get into normalizing vectors because it
isn't important.

## 3D Printing Overview

Going from a concept to finished 3D printed part require four basic
steps.

1. Modeling - I don't know anything about this, go learn Blender or
   Maya or Rhino or SketchUp or whatever 3D modeling program you
   happen to like.

2. Slicing - I know more about this. It takes a 3D model and "slices"
   it into layers. 2D printers typically print in lines back and forth
   moving across the page. 3D printers print in layers vertically
   going from bottom to top of the part.

3. Printing

4. what's the fourth step? why did I say four. that's nonsense.


## Super High Level Overview Without Any Math and Barely Any Physics




### Self-Notes - REMOVE BEFORE PUBLISHING

Write about what I learned about trajectory planning. Honestly it
could be a series, it's a pretty deep topic.

- What is trajectory planning? Mention terms I was searching for
  incorrectly like "motion control".

- Considerations for correctness at a high-level.
  * Is it that right path?
  * Is it physically possible?
  * Is it smooth?
  * Is it fast?


#### Process

Where's the fun flirty attitude I had yesterday about writing? being
sleep deprived and maybe a little manic definitely helped the writing
just flow. I feel less emotionally and mentally constipated than I
did. Just, let it flow. What is this blog post going to be about. It's
kind of an introduction, and I kind of want to follow up where Michael
F Bryan's series Adventures in Motion Control left off. It's been six
years, he's probably moved on to other stuff. It sucks that his code
is broken I was hoping to actually be able to try and build off it and
complete it, because that would be sick.

let's not worry about actually building his code for now though
because I think that isn't the most productive direction to go. We
aren't going to start with the math anyhow, we're going to start with
the concepts of trajectory planning.

woof, trying to think about this stuff just immediately draws me back
into thinking about the printer. the emotions get deep and tangled
veeeery quickly.

okay, back to the blog post. I want to start by linking to Michael F
Bryan's series, and say that I want to pick up on where he left off
because I have some small experience with trajectory planning and it's
a cool series that deserves to be finished.



ahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh, it is so difficult for
my brain to organize information! it just. it takes so long and I feel
so confused the entire time. Obviously I need to do this more, but
damn.

where do I start with this 3D printing stuff? Do I really explicitly
pick up where Michael left off? What background information that I
have is actually important? Explaining it to Allie was a pretty good
way to try and keep it non-technical.

But it's been like a week now and I don't really remember what I said
to her.

When I sit here like this and try to think about printing, my thoughts
just wander so much in a not very useful way.
