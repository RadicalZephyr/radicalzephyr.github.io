+++
layout = "post"
title = "Clojure, LeJOS and EV3"
categories = ["Programming", "EV3", "Java"]
comments = "true"
+++

I've had the opportunity in the last couple weeks to start playing
with a Lego Mindstorms EV3.  Since this hardware is such a new release
though, most of the normal contenders in the robot programming scene
(namely, RobotC) haven't had time to update their offerings to work
with it.

Enter [LeJOS][lejos].  Apparently the maintainer of the LeJOS project
got early access to the developer documentation and other necessary
infos, so he's been able to develop a setup for allowing people to
program their EV3 using Java.

<!--more-->

It's a really elegant solution actually.  Since the EV3 already runs a
full linux kernel, he just modified the base Legos linux image.  You
then partition a microSD card and write this image to it.  Now you can
boot the EV3 from the microSD card and ssh into it over either WiFi
(if you have an external USB wifi adapter that's compatible), or over
USB (a more recent feature).

My next goal is to get a clojure projet running on the ev3.  There are
two approaches that I could take.  First, I could try AOT compiling my
clojure source and then shipping just the uberjar to the EV3.  This
seems the most straightforward.  However, following this plan I almost
immediately ran into a stumbling block.  The LeJOS java library cannot
be compiled using Leiningen when not on the EV3.

Apparently this is because something about the clojure compilation
process actually loads the EV3 classes into the JVM.  This causes the
static initializers to be run.  And the static initializers look for
specific files in the /dev directory to try and do their thing.

Obviously, when you're not on an EV3 these files don't exist.

So the second way of doing things would be to attempt to install
leiningen on the EV3 itself.  I see a lot of potential problems with
this, first and foremost being how do I do it without a direct
connection to the internet?  Secondly, the linux installation is very
minimal, and might not actually contain all the necessary tools to
install and use leiningen.

[lejos]: http://lejos.org
