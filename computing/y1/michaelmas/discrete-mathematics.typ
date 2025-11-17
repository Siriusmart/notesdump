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

== Quantifiers
=== Universal Quantifications

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

==== Divisibility and Congruence

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

===== Example: Congruence Result

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

=== Equality

#def([
  The axioms for *equality* are
  - $Fa(x) x = x$
  - $Fa(x\, y) (x = y) imp (P(x) iff P(y))$
])

#hr

=== Conjunction

To prove a conjunction $P and Q$, we need to prove both $P$ and $Q$.

#def($
(P iff Q) iff (P imp Q and Q imp P)
$)

==== Example: $Fa(n) (6 | n iff 3 | n and 2 | n)$

Let $n$ be an arbitrary value.
$
6 | n &iff Ex(i) n = 6i \
&iff Ex(i) n = 2 dot 3 dot i \
&imp Ex(j, k) n = 2j and n = 3k \
&iff 2 | n and 3 | n
$

And the reverse direction
$
2 | n and 3 | n &iff Ex(i, j) n = 2i and n = 3j \
&iff Ex(i, j) 3n = 6i and 2n = 6j \
&iff Ex(i, j) n = 6(i - j) \
&imp Ex(k) n = 6k \
&iff 6 | n
$

=== Existential Quantifier

#def([
  $Ex(x) P(x):$ there exists an individual $x$ in the universe of the discourse which #px holds.
])

==== Proving an Existential Quantifier

Find a witness $w$ so $P(w)$ is true.

Target: $Fa(n) Ex(i, j) 4n = i^2 - j^2$

- Let $i = n + 1$
- Let $j = n - 1$

It is true that $4n = i^2 - j^2$.

==== Using an Existential Quantifier

Introduce a variable $w$ and assume $P(w)$ to be true.

=== Unique Existence

#def($
Ex(!x) P(x) iff (Ex(x) P(x) and (Fa(y, z) P(y) and P(z) imp y = z))
$)

To prove $Fa(x)Ex(!y) P(x, y)$
+ Find a *unique* witness $w$ so that $P(w, f(w))$ is true.
+ Show that $Fa(x) P(x, y) imp y = f(x)$

#hr

=== Disjunction

$P or Q$ can be proved by showing $P$ or $Q$.

To use disjunction, e.g. $P_1 or P_2 imp Q$, we need to show $P_1 imp Q and P_2 imp Q$.

== Proving Fermat's Little Theorem

=== Step 1: Lemma 1 for Fermat's Little Theorem

Required to prove:
$
Fa(m, n in bb(N)) m = 0 or m = n imp cong(vec(n, m), 1, n)
$

#let flittle1 = newproof("Lemma 1 for Fermat's Little Theorem")
#let flittle1 = addassume(flittle1, $m, n in bb(Z)$, $m = 0 or m = n$)
#let flittle1 = addgoal(flittle1, $cong(vec(n, m), 1, n)$)

#showproof(flittle1)

$
m = 0 &imp vec(n, 0) = 1 &imp cong(vec(n, m), 1, p) \
m = n &imp vec(n, n) = 1 &imp cong(vec(n, m), 1, p)
$

Therefore proved.

=== Step 2: Lemma 2 for Fermat's Little Theorem

#lemma("Euclid's Lemma", [
  This is provided without proof. If $p$ is prime
  $
  p | (a dot b) imp p | a or p | b
  $
])

Required to prove:
$
Fa(p, m in bb(N)) p "is prime" and 0 < m < p imp cong(vec(p, m), 0, p)
$

#let flittle2 = newproof("Lemma 2 for Fermat's Little Theorem")
#let flittle2 = addassume(flittle2, $p, m in bb(N)$, $p "is prime"$, $0 < m < p$)
#let flittle2 = addgoal(flittle2, $cong(vec(p, m), 0, p)$)

#showproof(flittle2)

$
vec(p, m) &= p!/(m!(p - m)!) \
"since none of" m,m-1,&... "or" p-m, p-m-1,... "divides" p\
&= p ((p-1)!/(m!(p-m)!)) \
"where" &(p-1)!/(m!(p-m)!) "is an integer"
$
Therefore $cong(vec(p, m), 0, p)$.

#note([
  This is a pretty bad proof, especially we haven't define prime numbers yet.
])

=== Step 3: Freshman's Dream

#theorem("Binomial Theorem", $
(m+n)^p = sum^p_(k=0)vec(p, k)m^(p-k)n^p
$)

#def(title: "Properites of Congruence", [
  If $cong(a,b,m) and cong(x,y,m)$, then
  - $cong(a+x,b+y,m)$
  - $cong(i a,i b,m)$ where $i$ is an integer
])

Required to prove:
$
Fa(p "is prime") cong((m+n)^p, m^p + n^p, p)
$

#let freshman = newproof("Freshman's Dream")
#let freshman = addassume(freshman, $p "is prime"$)
#let freshman = addgoal(freshman, $cong((m + n)^p, m^p+n^p, p)$)
#showproof(freshman)

By bimonial theorem
$
(m+n)^p &= sum^p_(k=0)vec(p, k)m^(p-k)n^p \
&=m^p + n^p quad "cancel terms using lemma 2"
$

Therefore $cong((m+n)^p, m^p + n^p, p)$

=== Step 4: Dropout Lemma

When $n = 1$ for Freshman's dream.
$
cong((m + 1)^p, m^p + 1, p)
$

=== Step 5: Many Dropout Lemma
$
(m + i)^p &= (m + underbrace(1 + 1 + ... + 1, i "times"))^p \
&= (m + underbrace(1 + 1 + ... + 1, i - 1 "times"))^p + 1 \
&= m^p + i quad "after applying dropout lemma" i "times"
$

So $cong((m+i)^p, m^p + i, p)$.

=== Step 6: Fermat's Little Theorem, Cause 1

When $m = 0$ for many dropout lemma.
$
Fa(p "is prime") cong(i^p, i, m)
$

#prop($
Fa(i in bb(N) "not a multiple of" p) space cong(i dot i^(p-2), 1, p)
$)

#def([
  $i^(p-2)$ is the reciprocal moduluo of $p$.
])

== Logical Equivalents

$
not (P imp Q) &iff P and not Q \
not (P iff Q) &iff (P iff not Q) quad "how tf is this true?" \
not(Fa(x) px) &iff Ex(x) not px \
not(P and Q) &iff (not P) or (not Q) \
not(Ex(x) px) &iff Fa(x) not px \
not (P or Q) &iff not P and not Q \
not (not P) &iff P
$

#def($
not P &iff (P imp "false") \
"false" &iff "some absurd statement"
$)

=== Prove by Contradiction

Instead of showing $P$, show $not P imp "false"$.
$
(not P imp "false") iff not (not P) iff P
$

=== Prove by Contrapositive

Required to prove:
$
(not Q imp not P) iff (P imp Q)
$

#let contrapos = newproof("Contrapositive")
#let contrapos = addassume(contrapos, $not Q imp not P$, $P$)
#let contrapos = addgoal(contrapos, $Q$)

#showproof(contrapos)

Suppose A3: $not Q$. #linebreak()
A4. $not P$ by A1 and A3. #linebreak()
A5. false by A2 and A4.

This is a contradiction, therefore $Q$ must be true.

== Numbers

Natural numbers are constructed from zero by the successor relation.
```ml
type N =
  | zero
  | succ of N
```

#def([
  A *monoid* is an algebraic structure with
  - A neutral element $e$
  - A binary operation $dot$

  === Monoid Laws
  - Neutral element $e dot x = x = x dot e$
  - Associative $(x dot y) dot z = x dot (y dot z)$
])

A monoid is *commutative* if $x dot y = y dot x$.

*Addition* $(bb(N), 0, +)$ and *multiplication* $(bb(N), 1, times)$ satisfies monoid laws and commutative laws.
