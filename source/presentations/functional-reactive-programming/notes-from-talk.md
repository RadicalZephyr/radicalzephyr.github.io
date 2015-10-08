https://www.youtube.com/watch?v=gaG3tIb3Lbk&feature=youtu.be

What is Reactive Programming?
- A composable/modular way to code event-driven logic
- A different way of thinking (pull instead of push)
- An observer pattern that doesn't suck (drop in replacement)
- A technique to help rescue commercial projects that have hit the
  complexity wall

Kinds of applications it's good for:
- User Interfaces
- Games
- Configuration

* anything event-heavy
* anywhere observer is used

Observer Pattern

Inverts the dependency
- consumer depends on source
- separates concerns
- extensibility
- better than polling

* Simple, effective, widely used


Problems with the Observer Pattern:

- Unpredictable Order
- Missed first event
- Messy state
- threading issues
- leaking listeners
- accidental recursion

End result is compounding complexity

Reactive Programming has compositionality

Blackheath's definition: "A and B are compositional if the complexity
of A + B is the sum of the complexities of A and B."

( This has an interesting similarity to the definition of
orthogonality from the Pragmatic Programmers )


Observer doesn't scale. Because of compounding complexity

Is RP something fundamental?

- It's been reinvented several times
- Lots of similarity between independent reactive programming library
  implementations

Do you need a specialized language (i.e. Elm)?
-NO!

Do you need a functional language?
-NO!

Testability/Refactorability

Excellent:
- Dependencies are explicit
- Very loose coupling
- Compiler often detects breakage

Debuggability
- abstract, traces work, execution order jumps around
- in general, bugs are rare


Reactive system generally has inputs and outputs, and consists of pure logic

Two Data Types:
- Event
- Behavior
Some only use one: Signal

Eight primitives:
- never
- map
- filter
- merge
- hold
- snapshot
- lift
- switch


Event:

Represents an a stream of events NOT individual occurrences
Has a type, i.e payload

No explicit add/remove listener
- implied by referencing the Event

No explicit notify
- The only push operation is the original input event

Two main views on time

Classic FRP vs modern

Behaviours vary Continuously vs Discretely

Behaviour

Time varying value aka Signal

- like events that remember their last value
- continuous or discrete

Event primitives

State
- behaviours are the only way to keep state
- No Mutable variables (banned)


Atomicity
- all state changes caused by a single event occurrence are atomic
- Just don't have to care about ... (lots of things)
