#import "@local/lecture:0.1.0" : *
#import "@preview/fletcher:0.5.8" as fletcher : *

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

#note([
  This is more of a mess than an actual usable lecture note, please check the #link("https://github.com/Siriusmart/notesdump/blob/master/computing/y1/michaelmas/discrete-mathematics-proofs.pdf")[_discrete mathematics without words_] document for a more organised notes.
])

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
  $Fa(x)Px$ means: for all individuals $x$ of the universe of the discourse, the property $Px$ holds.
])

*Universal instantiation* allows any $a$ to be plugged in to $Fa(x)Px$ and conclude that $P(a)$ is true.

#let uniQ = newproof("Statement involving universal quantification")
#let uniQ = addgoal(uniQ, $Fa(x) Px$)
#showproof(uniQ)

We can rewrite as
#let uniQ = addgoal(uniQ, $Px$)
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
  $Ex(x) P(x):$ there exists an individual $x$ in the universe of the discourse which #Px holds.
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

#propos($
Fa(i in bb(N) "not a multiple of" p) space cong(i dot i^(p-2), 1, p)
$)

#def([
  $i^(p-2)$ is the reciprocal moduluo of $p$.
])

== Logical Equivalents

$
not (P imp Q) &iff P and not Q \
not (P iff Q) &iff (P iff not Q) quad "how tf is this true?" \
not(Fa(x) Px) &iff Ex(x) not Px \
not(P and Q) &iff (not P) or (not Q) \
not(Ex(x) Px) &iff Fa(x) not Px \
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

#hr

== Rings

#def([
  A *semiring* $(bb(N), 0, plus.circle, 1, times.circle)$ is an algebraic structure with
  - A commutative monoid structure $(bb(N), 0, plus.circle)$
  - A monoid structure $(bb(N), 1, times.circle)$
  And satisfies the distributive laws $x times.circle (y plus.circle z) = (x times.circle y) plus.circle (x times.circle z)$.

  A semiring is *commutative* if $times.circle$ is.
])

=== Cancellation

The additive and multiplicative structures of natural numbers allows for
- Additive cancellation: $k + m = k + n imp m = n$
- Multiplicative cancellation: if $k != 0$, then $k times m = k times n imp m = n$

=== Inverses

For a monoid with neutral element $e$ and binary operation $plus.circle$.
- $x$ admits an inverse on the left if $Ex(l) l plus.circle x = e$
- $x$ admits an inverse on the right if $Ex(r) x plus.circle r = e$
- $x$ admits an inverse if $l$ and $r$ both exists.

#propos([
  If $l$ and $r$ both exists, $l = r$.
])

$
e plus.circle r &= r \
iff (l plus.circle x) plus.circle r &= r \ 
iff l plus.circle (x plus.circle r) &= r \
iff l &= r
$

#defs([
  - A *group* is a monoid in which every element has an inverse.
  - An *Abelian group* is a group where the monoid is commutative.
])

- $x$ admits an additive inverse if $Ex(y) x + y = 0$
- $x$ admits an multiplicative inverse if $Ex(y) x times y = 1$

The natural numbers can be extended to include all additive inverses to give the set of *integers*.

#defs([
  - A *ring* is a semiring $(bb(Z), 0, plus.circle, 1, times.circle)$ where $(bb(Z), 0, plus.circle)$ is a group. #br A ring is commutative if $(bb(Z), times.circle, 1)$ is.
  - A *field* is a commutative ring in which every element besides $0$ has a *reciprocal* (inverse with respect to $times.circle$).
])

== Division Theorem

Required to prove:
$
Fa(m in bb(N), n in bb(N)^+)Ex(!q, !r) (q >= 0) and (0 <= r < m) and (m = q n + r)
$

We need to prove if $(q, r)$ and $(q', r')$ both satisfies the conditon, then $(q, r)=(q',r')$.

#let divtheorem = newproof("Division theorem")
#let divtheorem = addassume(divtheorem, $(q >= 0) and (0 <= r < n) and (m = q n + r)$, $(q'>= 0) and (0 <= r' < n) and (m = q' n + r')$)
#let divtheorem = addgoal(divtheorem, $q = q'$, $r = r'$)

#showproof(divtheorem)

Because $m-r = q n$, similar for $(q', r')$
$
m &equiv r space (mod n) \
m &equiv r' space (mod n)
$
We have proved that congruence is transitive
$
cong(r, r', n)
$
As $0 <= r, r' < n$, therefore $r = r'$. And by cancellation, $q = q'$.

=== Proving the Division Algorithm

#grid2(
```ml
let divalg m n =
  let diviter q r =
    if r < n then (q, r)
    else diviter (q + 1, r - n)
  in diviter 0 m
```
)

Required to prove:
+ Partial correcteness #br
  $Fa(m in bb(N), n in bb(N)^+) "divalg"(m, n) "terminates with" (q_0, r_0) imp (r_0 < n and m = q_0 n + r_0)$
+ Total correctness. #br
  $Fa(m in bb(N), n in bb(N)^+) "divalg"(m, n) "terminates"$


  /*
#diagram(
  node((0,0), [Start]),
  edge("-|>"),
  node((0, 1), `th := transaction_start()`),
  edge("r,d,d,d,d,d", "-|>"),
  node((1, 6), [Transaction aborted]),
  edge((0, 1), (0, 2), "-|>"),
  node((0, 2), `ar := SELECT ...`),
  edge("-|>"),
  node((0, 3), `br := SELECT ...`),
  edge("-|>"),
  node((0, 4), `UPDATE A ...`),
  edge("-|>"),
  node((0, 5), `rc := transaction_commit(th)`),
  edge("-|>"),
  node((0, 6), [Transaction complete]),
  edge((0, 2), "r", "-|>"),
  edge((0, 3), "r", "-|>"),
  edge((0, 4), "r", "-|>"),
)
*/

#grid2(
  [
    We can prove partial correctness by induction:
    - If `divalg` exits then $r_0 < n$
    - Prove at each point of the computation #br
      $m = q n + r$

    To prove total correctness:
    - $m$ decreases in natural number at every step.
    - $m$ cannot decreate forever (all natural numbers comes from applying the successor function a finite number of times to 0).
  ],
  diagram(
    node((0,0), `divalg m n`),
    edge("-|>"),
    node((0, 1), `diviter 0 m`),
    edge("-|>"),
    node((1, 1), `(0, m)`),
    edge((0, 1), "d" ,"-|>"),
    node((0, 2), `diviter 1 (m - n)`),
    edge("-|>"),
    node((1, 2), `(1, m - n)`),
    edge((0, 2), "d" ,"-|>"),
    node((0, 3), `...`),
  )
)

#hr

=== Integer Modulo

$Fa(m in bb(Z)^+)$ the integer modulo of $m$ is $bb(Z)_m = {0,1,2,dots,m-1}$. And operators
$
k +_m l &= rem(k+l,m) \
k times_m l &= rem(k times l, m)
$

So $k+_m l "and" k times_m l in bb(Z)_m$

#propos([
  $Fa(m > 1) (bb(Z)_m, 0, +_m, 1, times_m)$ is a commutative ring.
])

#propos([
  Let $m in bb(Z)^+$, then $k in bb(Z)_m$ has reciprocal iff $Ex(i, j in bb(Z)) k times i + m times j = 1$
])

Assume:
1. $m in bb(Z)^+$
2. $k in bb(Z)_m$, meaning $0 <= k < m$
3. $k "has reciprocal"$, meaning $Ex(l in bb(Z)_m) cong(k times l, 1, m)$

New goal: $Ex(i, j in bb(Z)) k times i + m times j = 1$

$
& Ex(l, a in bb(Z)_m) k times l - 1 = a times m \
iff & Ex(l, a in bb(Z)_m) k times l + a times m = 1
$
As required.

#def([
  $r$ is a linear combination of $m, n$ if $Ex(s, t in bb(Z)) s times m + t times n = r$
])

== Sets

#def([
  A *set* is a collection of mathematical objects.
])

$x in A$ if $x$ is an element of $A$.

=== Creating Sets

We can define sets by
- Listing elements
- Using set comprehension, e.g. ${x in A | P(x)}$

#def([
  $A = B$ iff $Fa(x) x in A iff x in B$
])

If $Px = Qx$, then ${x in A | Px} = {x in A | Qx}$

=== Divisors

- Let $n in nat$, the set of $n$'s divisors $d(n) = {d in nat : d|n}$
- Let $m,n in nat$, the set of common divisors $cd(n, m) = {d in nat : d|n and d|m}$

#theorem("Key Theorem", [
  $Fa(m,m' in nat, n in whole) cong(m, m', n) imp cd(m,n) = cd(m',n)$
])

Assume:
1. $m,m' in nat$
2. $n in whole$
3. $cong(m,m',n)$

Goal: $d in cd(m,n) iff d in cd(m', n)$, or prove the predicates are equal: $d|m and d|n iff d|m' and d|n$

Assume:
4. $d|m and d|n$

New goal: $d|m'$ (we get rid of $d|n$ because it is trivial)

$
& Ex(a in whole) m = a times d "by 4 as 5" \
& Ex(b in whole) n = b times d "by 4 as 6" \
& Ex(c in whole) m - m' = c times n "by 3 as 7" \
& Ex(a, b, c in whole) a times d - m' = c times (b times d) "by 5, 6, 7 as 8" \
& Ex(a, b, c in whole) m' = d times (a - c times b) "by 8 as 9" \
& Ex(k in whole) m' = d times k "by 9"
$
Therefore $d|m'$ as required.

=== Euclid's Algorithm

$
cd(m,n) = cases(
  d(n) &"if" n|m ,
  cd(n, rem(m,n)) quad&"otherwise"
)
$

We are making progress here because $rem(m,n) < n$. This can be proved using the key theorem.

To find the GCD, we want the max element.
$
gcd(m,n) = cases(
  n &"if" n | m,
  gcd(n, rem(m,n)) quad &"otherwise"
)
$

Which is Euclid's algorithm.

#hr

#propos([
  75. $Fa(m,n,a,b in nat) cd(m, n) = d(a) and cd(m,n) = d(b) imp a = b$

  Proof:
  $
  a|a iff a in d(a) iff a in d(b) iff a|b
  $

  Run the same argument for $b$, we have $a|b and b|a$, this is true if $a=b$.
])

#propos([
  76. $cd(m,n) = d(k) iff (k|m and k|n and (Fa(a in nat) a|m and a|n imp a|k))$

  Proof:
  $
  &cd(m,n) = d(k) \
  iff&Fa(a) a|m and a|n iff a|k "by equal predicates" \
  $
  which contains the for all condition and $k|k imp k|m and k|n$ we require.
])

#def([
  77. $Fa(m, n in nat) Ex(!k) k|m and k|n and (Fa( a in nat) a|m and a|n imp a|k)$ _how?_
])

We can prove that the `gcd` ML algorithm computes GCD by
- Proving partial correctness, we have already done that.
- Proving that it terminates.

We notice for every 2 steps, the value of $r_(k+2) < r_k / 2$, and it decreases in natural numbers which has a lower bound.

$therefore$ gcd has running time $O(log n)$

=== Properties of GCD
$
gcd(m, n) &= gcd(n, m) "commutative"\
gcd(l, gcd(m, n)) &= gcd(gcd(l, m), n) "associative" \
gcd(l times m, l times n) &= l times gcd(m, n) "distributive over multiplication"
$

#def([
  $a, b in nat$ are coprime if $gcd(a, b) = 1$
])

#theorem("82",[
  $Fa(k,m,n in whole^+) k|(m times n) and gcd(k, m) = 1 imp k|n$

  Proof:
  $
  Ex(l in whole) m times n &= k times l \
  n times gcd(k, m) &= n \
  &= gcd(n times k, n times m) \
  &=gcd(n times k, l times k) \
  &=k times gcd(n, l)
  $
]) 

#propos([
  83. $Fa(m, n in whole^+, p "prime") p|(m times n) imp p|m or p|n$

  - If $p|m$ then close.
  - If not $p|m$ then $gcd(p, m) = 1 imp p|n$
])

If $i$ is not a multiple of $p$
$
cong(i^p, i, p) &imp p|(i^p - i) \
&imp p|i(i^(p-1) -1) \
&imp p|(i^(p-1) - 1) \
&imp cong(i times i^(p-2), 1, p)
$
$i^(p-2)$ is called the multiplicative inverse of $i$

$because Fa(p "prime", i in whole_p^+) "has" [i^(p-2)]_p "as multiplicative inverse", therefore whole_p $is a field

I missed 85 completely.

#hr

The GCD is a linear combination of $m$ and $n$.
$
gcd(m,n) = m  times l_1(m,n) + n times l_2(m,n)
$

#coro([
  - $cong(n times l_2(m,n), gcd(m,n), m)$
  - $gcd(m,n) = 1 imp [l_2]_m "is the multiplicative inverse of" whole_m$
])

C92 and L93 I have no idea how to prove them.

== Mathematical Induction

Let $P(m)$ be a statement for $m in nat$.
$
P(0) and (Fa(n in nat) P(n) imp P(n+1)) imp Fa(m in nat) P(m)
$

#lemma("Sum of combinations", [
  $vec(n, k) + vec(n, k - 1) = vec(n + 1, k)$

  To choose $k$ elements from a set of $n+1$ elements, we either
  - Choose the first element, then choose $k-1$ elements from the other $n$ elements.
  - Don't choose the first element, then choose $k$ elements from the other $n$ elements.
])


Either

Goal: binomial theorem.

Let $P(n) : (x+y)^n = sum^n_(k=0) vec(n, k) x^(n-k) y^k$

Goal: $Fa(n in nat) P(n)$

#grid2(
  $P(0)$, [Trivial],
  $P(n) imp P(n+1)$,
  [
    $
    (x+y)^(n+1) &= (x+y) sum_(k=0)^n vec(n, k) x^(n-k) y ^k \
    &= sum_(k=0)^n vec(n, k) x^(n+1-k) y ^k + sum_(k=0)^n vec(n, k) x^(n-k) y ^(k+1) \
    &= x^(n+1) + sum_(k=1)^n vec(n, k) x^(n+1-k) y ^k + sum_(k=0)^(n-1) vec(n, k) x^(n-k) y ^(k+1) + y^(n+1) \
    &= x^(n+1) + sum_(k=1)^n vec(n, k) x^(n+1-k) y ^k + sum_(k=1)^n vec(n, k - 1) x^(n-k) y ^(k+1) + y^(n+1) \
    &= x^(n+1) + sum_(k=1)^n [vec(n, k) + vec(n, k - 1)] x^(n+1-k) y ^k + y^(n+1) \
    &= x^(n+1) + sum_(k=1)^n vec(n+1, k) x^(n+1-k) y ^k + y^(n+1) \
    &= sum_(k=0)^(n+1) vec(n+1, k) x^(n+1-k) y ^k \
    $
  ]
)

=== Principle of Strong Induction

Let $P(m)$ be a statement for $m in nat$ where $m >= "some fixed" l$

$
P(l) and ((Fa(k in [l..n]) P(k) imp) imp P(n+1)) imp Fa(m >= l in nat) P(m)
$

#propos([
  95. Either $n>=2$ is a prime or $n$ is a product of primes.

  Goal: $Fa(n >= 2 in whole^+) n "prime" or n "product of primes"$

  #grid2(
    $P(2)$, [2 is a prime, so true.],
    $(Fa(k in [l..n]) P(k)) imp P(n+1)$, [
      Assume $Fa(k in [l..n]) P(k)$

      - Case 1: $n+1$ is prime, then done.
      - Case 2: $n+1$ is composite, $Ex(a, b in whole) n+1 = a times b$
        
        $a$ and $b$ are smaller than $n+1$ and $>= 2$, by $P(a)$ and $P(b)$, $a times b$ is a product of primes.
    ]
  )
])

#theorem("96. uniqueness of prime factors", [
  Goal: $Fa(n in whole^+) Ex(!p_1 <= p_2 <= p_3 <= dots <= p_l, l in nat) product_(i=1)^l p_i = n$

  Assume:
  1. $n in whole^+$

  Existence by (P95)

  New goal: $n = p_1p_2p_3 dots p_l and n = q_1q_2q_3 dots q_l imp Fa(i <= l) p_i = q_i$

  Clearly $p_1 | product q_i$ and $q_1 | product p_i$
  - $Ex(i) q_1 <= p_1 = q_i$
  - $Ex(j) p_1 <= q_1 = p_j$
  $q_1 <= p_1 and p_1 <= q_1 imp p_1 = q_1$, repeat for other primes.
])

#hr

== Naive Set Theory

#def([
  $x in.not A iff not (x in A)$
])

- If a set a finite, then I can list its elements.
- Set equality: $A = B iff Fa(x) (x in A iff x in B)$

#propos([
  L103
  $
  Fa(A) A &subset.eq A \
  A subset.eq B and B subset.eq C &imp A subset.eq C \
  A subset.eq B and B subset.eq A &imp A = B
  $
])

- If there is a set $A$, then there exist a set ${x in A | P(x)}$ - you can construct a subset from a set.
  
  $a in { x in A | P(x) } iff a in A and P(a)$
- The empty set exists $emptyset = {x in A | "false"}$

=== Russell's Paradox

Suppose we allow the existence of ${ x | P(x) }$

Let $U = {x | x in.not x }$

If $U in U$?
$
U in U iff U in.not U
$

There is a contradiction, so ${ x | P(x) }$ should not be allowed in our theory.

#defs([
  - *Cardinality* is the number of elements in the set.
  - If $\#S$ is a natural number, then it is a finite set.
])

- Powerset axiom: There exist a set $cal(P)(U)$ where $Fa(X) X in cal(P)(U) iff X subset.eq U$

#propos([
  P104: $\# cal(P)(U) = 2^(\#U)$

  $
  \#cal(P)(U) &= \#{X | X subset.eq U} \
  &= sum_(i=0)^(\#U) \#{x | x subset.eq U and \#X = i} \
  &= sum_(i=0)^(\#U) vec(\#U, i) \
  &= (1+1)^(\#U) \
  &= 2^(\#U)
  $
])

#grid2(
  [
    $cal(P)$ is called a *family of sets*, we can draw a *Hasse diagram* to show relation in a family of sets.
  ],
  diagram(
    node((0, 0), ${0, 2, 4}$),
    edge((0, 0), "dl"),
    edge((0, 0), "d"),
    edge((0, 0), "dr"),
    node((-1, 1), ${0, 2}$),
    edge((0, 1), "dl"),
    edge((0, 1), "dr"),
    node((0, 1), ${0, 4}$),
    edge((-1, 1), "d"),
    edge((-1, 1), "dr"),
    node((1, 1), ${2, 4}$),
    edge((1, 1), "d"),
    edge((1, 1), "dl"),
    node((-1, 2), ${0}$),
    edge((-1, 2), "dr"),
    node((0, 2), ${2}$),
    edge((0, 2), "d"),
    node((1, 2), ${4}$),
    edge((1, 2), "dl"),
    node((0, 3), $emptyset$),
  )
)

#hr
