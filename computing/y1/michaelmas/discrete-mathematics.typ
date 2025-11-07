#import "@local/discmaths:0.1.0" : *
#import "@local/lecture:0.1.0" : *

#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Computer Science Lecture Notes]
    #h(1fr) _Discrete Mathematics_
  ],
)

= Discrete Mathematics

Discrete mathematics deals with finite or countably infinite sets, this includes integers and related concepts.

#defstable(
  [Statement], [Something that is either true or false.],
  [Predicate], [A statement whose truth depends on one or more variables.],
  [Theorem], [An important true statement.],
  [Proposition], [A less important true statement.],
  [Lemma], [A statement used to prove other true statements.],
  [Corollary], [A true statement that is a simple deduction from a theorem or proposition.],
  [Conjecture], [A statement believed to be true, but not proved yet.],
  [Proof], [A way to show a statement is true.],
  [Logic],[The study of methods and principles used to distinguish correct reasoning from incorrect reasoning.],
  [Axiom], [A basic assumption about a mathematical situation.],
  [Definition], [An explaination of the mathematical meaning of a word.],
  [Simple statement], [A simple statement cannot be broken down.],
  [Composite statement], [A compisite statement is built using several other statements connected by logical expressions.]
)

== Proof Structure

#defstable(
  [Assumptions], [Statements that may be used for deduction.],
  [Goals], [Statements to be established.]
)

Start by listing out assumptions and write down the goal.

=== Implication

$
"collection of hypotheses" imp "some conclusion"
$

To prove $P imp Q$
- Add $P$ to the list of assumptions.
- Replace $P imp Q$ in goal with $Q$.

=== Types of Real Numbers

#defstable(
  [Rational], [A number is rational if it is in form $m slash n$ for some integer $m, n$, otherwise it is irrational.],
  [Positive], [A number is positive if it is greater than 0, otherwise it is nonpositive.],
  [Negative], [A number is negative if it is less than 0, otherwise it is nonnegative.],
  [Natural], [A number is natural if it is a nonnegative integer.]
)

=== Modus Ponens (Implication Elimination)

#grid(
  columns: (60%, auto),
  [
    The main rule for logical deduction is
    - From statements $P$ and $P imp Q$.
    - $Q$ follows.
  ],

  impelim($P$, $Q$)
)

=== Bi-implications

Some theorems are in form $P iff Q$, to prove it
- Prove $P imp Q$
- Prove $Q imp P$

#line(length: 100%)
