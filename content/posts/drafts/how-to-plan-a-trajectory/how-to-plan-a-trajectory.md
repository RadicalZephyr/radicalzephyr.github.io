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

Going from a concept to finished 3D printed part require three basic
steps.

1. Modeling - I don't know anything about this, go learn Blender or
   Maya or Rhino or SketchUp or whatever 3D modeling program you
   happen to like. This is often transmitted as an STY file or other
   similar format.

2. Slicing - I know more about this. It takes a 3D model and "slices"
   it into layers. 2D printers typically print in lines back and forth
   moving across the page. 3D printers print in layers vertically
   going from bottom to top of the part. This is transmitted to the
   printer as a sequence of gcode instructions.

3. Printing - This is what we're actually talking about.

The printing process can itself be broken down into three basic steps.

1. Gcode parsing
2. Trajectory planning
3. Step generation

Previous blog posts by Michael Bryan have pretty well covered the
gcode parsing process, and this blog post is about the trajectory
planning process. Many 3D printing control programs have very little
distinction between the trajectory planning and step generation
processes, and it's possible to treat them as one process.

In fact, because of the size of typical gcode files these three steps
typically are performed in a loop across the entire gcode file. Gcode
files for even fairly simple shapes often have many gcode instructions
in them. Let's take one of the simplest possible shapes, a cube. Let's
say it's 5mm on each side. With a reasonable sized nozzle of 0.1mm
with 100% infill, that means that just doing a simple back and forth
grid pattern there would be 50 lines of plastic need to be layed down
on each layer of the cube. Depending on the resolution of the printer,
the height of each layer could be as large as 0.1mm as well, so that
means 50 layers. Then there is at least one line to transition between
each parallel line, so that's another 49 per layer. Already, we're at
around 500 instructions for a 5mm cube. Then you start considering all
the complexities like different possible infill patterns, outlining,
nozzle "wiping" techniques to limit plastic filament creation between
layers and actually printing complex shapes like the standard [Boaty]
calibration checking shape and I hope it's easy to see how the
trajectory planner needs to handle small sections of the print at a
time. In practice slice a 5mm cube with reasonable printing parameters
usinge [Slic3r] actually produces a gcode file with (TODO: actually
create this file).

[Slic3r]: TODO::/link-to-slicer

In theory it would be possible to try and plan the trajectory of the
entire print as one mathematical problem, but the more different
points you add in the more computationally intensive it becomes to
compute an answer. (TODO: maybe add some napkin math regarding the
algorithmic complexity of how many points a trajectory contains).

[Boaty]: TODO::/link-to-boaty-shape

As an additional wrinkle in this, most 3D printer slicers that I'm
aware of don't really emit the gcodes for arc movements. I'm not
really sure why this is, though it probably has something to do with
the imprecise nature of taking 3D models and directly producing paths
from them with slicing. It also probably stems from the fact that a
lot of 3D printing is done with shapes that are not mathematically
precise circles. In fact, it's one of the strengths of 3D printing
that these kinds of complex shapes are relatively simple to
produce. Instead, curving shapes are generally approximated using
large numbers of short straight line segments. This causes the number
of instructions in a gcode file to rise dramatically. For a similar
sized 5mm tall and 5mm diameter cylinder, produces a gcode file
containing (TODO: actually create this file) gcode instructions.

For comparison, a slicing of Boaty model that's about 5cm long and
tall contains (TODO: actually create this file) gcode instructions.

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
