Big picture for this iteration is looking at the boundary between core
and shell functionality. Focus on pushing core business rules into a
simple small, unit-tested, mostly functional API that the shell can
use and take advantage of.

The shell then wraps the core with behavior and state specific to the
interface with the outside world.

This meshes well with the "only depend on things that are more stable
than you" rule. Because ideally the business rules domain is more
stable than how the interaction works with particular clients etc.


Also start thinking about and taking notes for giving a talk on SOLID
principles and how they relate to the evolution of the design of my
tic tac toe app.
