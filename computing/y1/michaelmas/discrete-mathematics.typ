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

== Universal Quantifications

#def([
  $Fa(x)px$ means: for all individuals $x$ of the universe of the discourse, the property $px$ holds.
])

*Universal instantiation* allows any $a$ to be plugged in to $Fa(x)px$ and conclude that $P(a)$ is true.

#let uniQ = newproof("Statement involving universal quantification")
#let uniQ = addgoal(uniQ, $Fa(x) px$)
#showproof(uniQ)

We can rewrite as
#let uniQ = addgoal(uniQ, $px$)
#let uniQ = rmproof(uniQ, "g1")
#let uniQ = addassume(uniQ, [$x$ stands for an arbitrary individual.])
#showproof(uniQ)

=== Divisibility and Congruence

#def([
  Let $d$ and $n$ be integers. If $d$ divides $n$, we write $d | n$.
  $
  Ex(k) n = k dot d iff d | n
  $
])

#def([
  For integers $a$ and $b$, and positive integer $m$.
  $
  cong(a,b,m) iff m | (a - b)
  $
])

We can prove that
- If $n$ is odd, then $cong(n, 1, 2)$
- If $n$ is even, then $cong(n, 0, 2)$

==== Example: Congruence Result

Let $m$ and $n$ be positive integers, and $a$ and $b$ be arbitrary integers.

We want to prove the statement $Fa(n)$

#let mulcong = newproof("Multiplied Congruence")
#let mulcong = addassume(mulcong, $m, n, a, b in bb(Z)$, $a, b > 0$)
#let mulcong = addgoal(mulcong, $Fa(n) cong(a, b, m) imp cong(n a, n b, n m)$)
#showproof(mulcong)

Rewriting the target

#let mulcong = rmproof(mulcong, "g1")
#let mulcong = addassume(mulcong, $cong(a, b, m)$)
#let mulcong = addgoal(mulcong, $cong(n a, n b, n m)$)
#showproof(mulcong)

Then rewrite A3
$
& imp cong(a, b, m) \
& imp Ex(k) (a-b) = k dot m \
& imp Ex(k) n(a-b) = k dot m dot n \
& imp cong(n a, n b, n m)
$
Which is the goal.

To prove $Fa(n)(n a, n b, n m) imp cong(a, b, m)$, plug $n = 1$ and we have the goal.

== Equality

#def([
  The axioms for *equality* are
  - $Fa(x) x = x$
  - $Fa(x\, y) (x = y) imp (P(x) iff P(y))$
])
