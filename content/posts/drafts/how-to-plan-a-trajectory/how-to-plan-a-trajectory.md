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

## Really Short Line Segments (Like, How Short?)

I'm going to make an assertion here that hopefully will be intuitively
appealing if not very mathematically rigorous. Nothing can change
directions instantaneously. I really don't have a good feeling for how
much people will intuitively disagree with me on this, so if you feel
like you have a good example of something that you think does change
direction instantaneously then let me know and I'll think about using
it as an example of something that appears to instantly change
direction, but doesn't actually. Billiards balls are probably the most
approachable example, but I couldn't find any good high speed video
online that actually shows the extremely small amount of time it takes
for a billiards ball to flex and start moving.

If people are interested in the math and science behind _why_ this is
true, then maybe I'll write another blog post trying to break that
down. However, that's basically the topic of a few weeks of an
introductory university physics class so I think it's out of scope for
this post.

Okay, so the print head of your printer is in fact a thing, and
according to our previous "law" it cannot change directions
instantly. If all the curves in our 3D model are being broken down
into tiny short straight lines that have small angles between them,
how do we process these as trajectories.

Let's back up to a hopefully more intuitive process. Let's consider
running in a square. I realize this is a bit unusual since most people
run in large ovals, which is actually kind of my point. Why don't we
run in squares instead, or at least rectangles? Especially if your
favorite local running track is inside a city, and is thus bounded on
at least a few sides by the straight lines of most modern city
streets, we could make the track longer if we just made the shape of
the running area have right angles at the turns right? Ignoring the
fact that this would make the outside lanes of the track _much_ longer
than the inside lanes, why don't we do this?

The answer is, because it's really hard for a human to run at speed
around a right angle corner. If you were attempting to run around a
right angle corner you basically need to slow down to a speed where
you can absorb the force need to change your direction 90 degrees in
one step. This is probably a fairly slow speed, especially compared to
the speeds to that a sprinter can reach on a straight shot. And think
about it, even when you're walking down a hallway how often do you
walk in a perfectly sharp 90 degree angle when you turn down a
hallway?

Okay, so 90 degree turns are too sharp, what if we cut it in half, and
made it two forty-five degree turns just separated by a bit. (TODO:
add a diagram of a 45 degree angle running track). Already, we can see
this is starting to look a lot more like a typical running track. If
we keep going with this process of dividing the angles into smaller
and smaller sections, we rapidly start approaching exactly what most
running tracks look like.

## How Long is a Print?

If you've never 3D printed anything before, you might be surprised at
how long printing things can take. I have a fairly cheap low-end 3D
filament printer, and printing the Boaty calibration piece took (TODO:
X hours). Even printing very simple slightly larger shapes can take
what feels like an unreasonable amount of time. Technically, my 3D
printer can print shapes up to (TODO: mm x mm). If I were to print a
cube that large however it would take (TODO: X hours)!

Part of this just comes down to the size of the plastic filament
feeding the printer and how quickly that filament can be heated up to
temperature where it can be printed and then provide a good bond to
the previous layer of plastic. Think about using a hot glue gun and
how you have to wait for it to heat up, and even then it takes fairly
slow steady pressure to get the glue hot enough to squeeze out the
nozzle.

However, there's another possible limiting factor to how fast we can
print something, how many times do we have to change direction? The
ideal 5mm cube path that I sketched earlier contains two 90 degree
turns in the transition between each line.

Let's start by saying the maximum speed we can heat plastic at for
extrusion means that we can move the print head at 1mm per
second. Since we can't start instantly, because of rule 1, let's say
it takes 1 second to get fully up to speed, and we travel 0.5mm during
that time.  Let's assume that we come to a full stop at each corner
and perfectly execute those 90 degree turns. Let's simplify the math
and ignore how long each short segment takes and just think about the
speeding up and slowing down on each long segment. There are 49
changes of direction, and we have to speed up and slow down for each
of them, plus speeding up at the beginning and slowing down at the end
of the layer, means that we have 100 speed transitions. If each one
takes a whole second, that means each layer of our cube will take at
least 100 seconds just slowing down for each turn! In reality, because
it also takes time to traverse the lines, 4 seconds each, 50 lines,
that's another 200 seconds! So already, each layer is taking 300
seconds, or 5 minutes. Then there are 50 layers in this print. At 5
minutes per layer, that's going to take 250 minutes, or just over 4
hours! And this is a tiny 5mm cube! And speeding up and slowing down
for the turns was fully 1/3 of that time.

Improving our top speed from 1mm/s to 2mm/s seems like it would cut
down on the time it takes to print the center of the long lines by
50%. But in fact, changing that top speed would also change how long
speeding up and slowing down takes. Using the same acceleration, if
our top speed is 2mm/s, it would now take us 2 seconds to slow at each
corner and another 2 seconds to speed up after it. There are still 100
speed transitions, and they now take 2 seconds each so that's 200
seconds for the acceleration. And taking longer means that you travel
farther during the speeding up and slowing down, fully 2mm in each
case. Now we only get to go full speed for 1mm, which takes 1 second
times 50 lines, that's 50 seconds of full speed travel time per layer.
But our total time per layer, including speeding up and slowing down
is still 250 seconds per layer, or just over 4 minutes. Doubling our
top speed only manages to bring our full print time down to just under
3 and 1/2 hours!

Of course, the speeds I chose for this example are meant to be
illustrative of how the amount of time it takes to speed up and slow
down for each turn impact the total time for a print.



## Processing Bit by Bit

So, we've sufficiently motivated the idea that whatever we do to plan
the trajectory of our print head, we need to do it incrementally.

The next thing we need to consider is how much math can we do

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

- Considerations from physics
  * Can't start going instantly.
  * Can't stop instantly.
  * Can't change directions instantly.


Use Technik's videos on oscillation dampening to show the difference
between smooth deceleration and not-smooth.
