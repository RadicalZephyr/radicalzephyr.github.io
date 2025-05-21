What is trajectory planning? Speaking super broadly and specifically
in the case of a 3D printer it's answering the question of how quickly
and smoothly can we traverse the path that we've been given.

3D printers receive their instructions in the form of Gcode. These
gcode instructions describe a path through space that the print head
should follow along with a requested speed. In order to turn that plan
into actual motion though the printer control program needs to
determine whether the requested speeds are physically possible for the
path being described. More specifically, the control program needs to
decide just how fast the print head should move at every moment in
time during the print. This brings up the question, how fast do we
want the print head to move? The speed the print head moves directly
dictates how long the print will take, so perhaps intuitively we want
the printer to move as fast as it possibly can. There are a lot of
other considerations however.

First, we're limited by how fast we can feed and melt plastic. In a
typical "rep-rap" style 3D printer, the plastic feed is from a spool
of plastic filament. You can get filament in different sizes, but
ultimately the filament is melted by pushing it through a heated
nozzle, typically called the "hot end." At some point as we try to
feed the plastic filament faster and faster the amount of heat the hot
end can produce won't be enough to fully melt the plastic.
