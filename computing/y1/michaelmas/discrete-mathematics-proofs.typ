#import "@local/lecture:0.1.0" : *
#import "@preview/fletcher:0.5.8" as fletcher : *

#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Computer Science Lecture Notes]
    #h(1fr) _Discrete Mathematics Proofs_
  ],
)

#def(title: "Definition: odd number", [
  $n in bb(N)$ is odd if $Ex(i in bb(N)) n = 2i+1$.
])

== Proposition 8: product of odd integers is odd

Goal: $Fa(m,n in bb(N)) m "and" n "odd" imp m times n "odd"$

=== Proof

Assume:
1. $m, n in bb(N)$
2. $m "and" n$ odd

New goal: $m times n "odd"$

$
&Ex(i, j in bb(N)) m = 2i + 1 and n=2j+1 \
imp & Ex(i, j in bb(N)) m times n = (2i+1) times (2j+1) \
imp & Ex(i, j in bb(N)) m times n = 2(2 i j + i + j) + 1\
imp & Ex(k in bb(N)) m times n = 2k + 1\
imp & m times n "odd"
$

#def(title: "Definition: real numbers", [
  $Fa(x in bb(R))$
  - $Ex(m, n in bb(Z)) x = m slash n iff x "rational"$
  - $not (x "rational") iff x "irrational"$
  - $x > 0 iff x "positive"$
  - $x < 0 iff x "negative"$
  - $not (x "positive") iff x "nonpositive"$
  - $not (x "negative") iff x "nonnegative"$
  - $x "nonnegative" and x in bb(Z) iff x in bb(N)$
])

== Proposition 10: rational square root
Goal: $Fa(x "positive") sqrt(x) "rational" imp x "rational"$

=== Proof
Assume:
1. $x "positive"$
2. $sqrt(x) "rational"$

New goal: $x "rational"$
$
&Ex(p, q in bb(Z)) sqrt(x) = p slash q \
imp&Ex(p, q in bb(Z)) x = (sqrt(x))^2 = p^2 slash q^2 \
imp&Ex(p', q' in bb(Z)) x = p' slash q' \
iff&x "rational"
$

#def(title: "Definition: modus ponens", [
  $P and (P imp Q) imp Q$
])

== Theorem 11: implication transitivity
$Fa(P_1, P_2, P_3 "statement") (P_1 imp P_2 and P_2 imp P_3) imp (P_1 imp P_3)$

=== Proof

Assume:
1. $P_1 imp P_2$
2. $P_2 imp P_3$
3. $P_1$

New goal: $P_3$
$
& P_2 "as (4) by (1) and (3)" \
imp& P_3 "by (2) and (4)"
$

#def(title:"Definition: bi-implication", [
  $(P iff Q) iff (P imp Q and P oif Q)$
])

#def(title: "Definition: divisibility", [
  $d|n iff Ex(k in whole) n = k times d$
])

#def(title: "Definition: congruence", [
  $Fa(m in whole^+, a, b in whole) cong(a, b, m) iff m|(a-b)$
])

== Proposition 16: parity as congruence

Goal: $(n "even" iff cong(n, 0, 2)) and (n "odd" iff cong(n, 1, 2))$

#grid2(
  surround([
    Subgoal: $n "even" iff cong(n, 0, 2)$

    Assume:
    1. $n "even"$

    New goal: $cong(n, 0, 2)$
    $
    n "even" &iff Ex(k in whole) n = 2 times k \
    &iff Ex(k in whole) (n-0) = 2 times k \
    &iff cong(n, 0, 2)
    $
  ]),
  surround([
    Subgoal: $n "odd" iff cong(n, 1, 2)$

    Assume:
    1. $n "odd"$

    New goal: $cong(n, 1, 2)$

    $
    n "odd" &iff Ex(k in whole) n = 2 times k + 1 \
    &iff Ex(k in whole) (n-1) = 2 times k \
    &iff cong(n, 1, 2)
    $
  ])
)

== Proposition 18: linearity of congruence

Goal: $Fa(m in whole^+, a, b in whole) cong(a, b, m) iff (Fa(n in whole^+) cong(n times a, n times b, n times m))$

Assume:
1. $m in whole^+$
2. $a,b in whole$

#surround([

  Subgoal: $cong(a, b, m) imp Fa(n in whole^+) cong(n times a, n times b, n times m)$

  Assume:
  3. $cong(a, b, m)$
  4. $n in whole^+$

  New goal: $cong(n times a, n times b, n times m)$

  $
  &Ex(i in whole) a - b = m times i "by (3)" \
  imp&Ex(i in whole) n times a - n times b = (n times m) times i \
  imp&Ex(i in whole) cong(n times a, n times b, n times m) \
  imp&cong(n times a, n times b, n times m)
  $
])

#surround([
  Subgoal: $Fa(n in whole^+) cong(n times a, n times b, n times m) imp cong(a, b, m)$

  Assume:
  3. $Fa(n in whole^+) cong(n times a, n times b, n times m)$

  New goal: $cong(a, b, m)$

  $
  &cong(1 times a, 1 times b, 1 times m) "by (3)" \
  imp&cong(a, b, m)
  $
])

#def([
  - $Fa(x) x =x$
  - $Fa(x, y) x = y imp (P(x) imp P(y))$
  - $Fa(a,b,c) (a=b and b=c) imp a = c$
  - $Fa(a,b,x,y) (a=b and x=y) imp (a+x=b+x=b+y)$
])

== Theorem 19: divisibility of prime products

Goal: $Fa(n in whole) 6|n iff 3|n and 2|n$

Assume:
1. $n in whole$

New goal: $6|n iff 3|n and 2|n$

#surround([
  Subgoal: $6|n imp 3|n and 2|n$

  Assume:
  2. $6|n$

  New goal: $3|n and 2|n$

  #grid2(
    surround([
      Subgoal: $3|n$
      $
      6|n &iff Ex(i in whole) n = 6 times i \
      &imp Ex(j in whole) n = 3 times j \
      &iff 3|n
      $
    ]),
    surround([
      Subgoal: $2|n$
      $
      6|n &iff Ex(i in whole) n = 6 times i \
      &imp Ex(j in whole) n = 2 times j \
      &iff 2|n
      $
    ])
  )
])

#surround([
  Subgoal: $3|n and 2|n imp 6|n$

  Assume:
  2. $2|n and 3|n$

  New goal: $6|n$
  $
  Ex(i in whole) n &= 2 times i \
  imp Ex(i in whole) 3 times n &= 6 times i "as (3)" \
  Ex(j in whole) n &= 3 times j \
  imp Ex(j in whole) 2 times n &= 6 times j "as (4)" \
  $
  $
  imp&Ex(i, j in whole) n = 6 times(i - j) "by (3) and (4)" \
  imp&Ex(k in whole) n = 6 times k \
  imp& 6|n
  $
])

== Proposition 21: difference of squares

Goal: $Fa(k in whole^+)Ex(i,j in nat) 4 times k = i^2 - j^2$

Assume:
1. $k in whole^+$

Let $i=k+1, j = k-1$
$
i^2 - j^2 &= (k+1)^2 - (k-1)^2 \
&= 4 times k
$

== Theorem 23: divisibility transitivity

Goal: $Fa(l,m,n in whole) l|m and m|n imp l|n$

Assume:
1. $l,m,n in whole$
2. $l|m and m|n$

New goal: $l|n$

$
&Ex(i in whole) m = i times l \
&Ex(j in whole) n = j times m \
imp&Ex(i,j in whole) n = (j times i) times l \ 
imp&Ex(k in whole) n = k times l\
imp&l|n
$

#def($
(Ex(!x) Px) iff (Ex(x) Px and (Fa(y, z) P(y) and P(z) imp y = z))
$)

== Proposition 24: unique existence of proper congruence

#surround([
  === Lemma 24.1: congruence transitivity

  Goal: $cong(n, x, m) and cong(n, y, m) imp cong(x, y, m)$

  Assume:
  1. $cong(n, x ,m) : Ex(i in whole) (x - n) = i times m$
  2. $cong(n, y, m) : Ex(j in whole) (y - n) = j times m$

  New goal: $cong(x, y, m)$
  $
  &Ex(i, j in whole)x - y = (i - j) times m "by (1) and (2)" \
  imp&Ex(k in whole)x - y = k times m \
  iff&cong(x, y, m)
  $
])

Let $P(z) : 0 leq z lt m and cong(n, z, m)$

Goal: $Fa(m in whole^+, n in whole) Ex(!z) P(z)$

New goal: $Fa(m in whole^+, n in whole) (Ex(z) P(z)) and (Fa(x, y) P(x) and P(y) imp x = y)$

Assume:
1. $m in whole^+$
2. $n in whole$

New goal: $(Ex(z) P(z)) and (Fa(x, y) P(x) and P(y) imp x = y)$

#grid2(
  surround([
    Subgoal: $Ex(z) P(z)$

    #missing([
      This goal is not proved
    ])
  ]),
  surround([
    Subgoal: $Fa(x, y) P(x) and P(y) imp x = y$

    Assume:
    3. $x, y "exists"$
    4. $0 <= x < m and cong(n, x, m)$
    5. $0 <= y < m and cong(n, y, m)$

    New goal: $x = y$

    #missing([
      $-1 < i < 1 imp i = 0$
    ])
    $
    &-m < -y <= 0 "by (4) as (6)" \
    &-m < x-y < m "by (4) and (6) as (7)" \
    &cong(x, y, m) "by (4), (5) and (L24.1)"\
    iff&Ex(i in whole) x - y = i times m \
    iff&Ex(i in whole) -m < i times m < m "by (7)" \
    iff&Ex(i in whole) -1 < i < 1 "by cancellation" \
    iff&i = 0 "by magic" \
    imp&x - y = 0 \
    iff&x = y
    $
  ])
)

== Proposition 25: parity of square

Goal: $Fa(n in whole) cong(n^2, 0, 4) or cong(n^2, 1, 4)$

Assume:
1. $n in whole$

New goal: $cong(n^2, 0, 4) or cong(n^2, 1, 4)$

$
Ex(!z in whole) 0 <= z < 2 and cong(n, z, 2) "by (P24)"
$
#missing([
  $0 <= z < 2 imp z = 0 or z = 1$
])

Assume:
2. $z = 0 or z = 1$

#grid2(
  surround([
    Case $z=0$

    Subgoal: $cong(n, 0, 2) imp$ #br $cong(n^2, 0, 4) or cong(n^2, 1, 4)$

    Assume:
    3. $cong(n, 0, 2)$

    New goal: #br $cong(n^2, 0, 4) or cong(n^2, 1, 4)$
    $
    &Ex(i in whole) n = i times 2 \
    imp&Ex(i in whole) n^2 = i^2 times 4 \
    imp&Ex(j in whole) n^2 = j times 4 \
    imp&cong(n^2, 0, 4) \
    imp&cong(n^2, 0, 4) or cong(n^2, 1, 4)
    $
  ]),

  surround([
    Case $z = 1$

    Subgoal: $cong(n, 1, 2) imp$ #br $cong(n^2, 0, 4) or cong(n^2, 1, 4)$

    Assume:
    3. $cong(n, 1, 2)$

    New goal: #br $cong(n^2, 0, 4) or cong(n^2, 1, 4)$

    $
    &Ex(i in whole) n = i times 2 + 1 \
    imp&Ex(i in whole) n^2 = 4 times (i^2 + i) + 1 \
    imp&Ex(j in whole) n^2 = 4 times j + 1 \
    imp&cong(n^2, 1, 4) \
    imp&cong(n^2, 0, 4) or cong(n^2, 1, 4)
    $
  ])
)

== Lemma 27: congruence at ends of combinations

#def(title: "Definition: combinations", [
  $
  vec(p, m) = p!/((p - m)! m!)
  $
])

Goal: $Fa(p in whole^+, m in nat) p > 1 and (m = 0 or m = p) imp cong(vec(p, m), 1, p)$

#note([
  Added condition $p > 1$ for the statement to be correct.
])

Assume:
1. $p in whole^+, m in nat$
2. $p > 1$

New goal: $m = 0 or m = p imp cong(vec(p, m), 1, p)$

Assume:
3. $m = 0 or m = p$

#grid2(
  surround([
    Case $m = 0$

    Subgoal: $m = 0 imp cong(vec(p, m), 1, p)$

    Assume:
    4. $m = 0$

    New goal: $cong(vec(p, m), 1, p)$

    $
    &vec(p, 0) = p!/(p! times 1) = 1 \
    imp&cong(vec(p, m), 1, p)
    $
  ]),
  surround([
    Case $m = p$

    Subgoal: $m = p imp cong(vec(p, m), 1, p)$

    Assume:
    4. $m = p$

    New goal: $cong(vec(p, m), 1, p)$

    $
    &vec(p, p) = p!/(1 times p!) = 1 \
    imp&cong(vec(p, m), 1, p)
    $
  ])
)

== Lemma 28: congruence at non-ends of combinations

Goal: $Fa(p "prime", m in whole) 0 < m < p imp cong(vec(p, m), 0, p)$

Assume:
1. $p "prime"$
2. $m in whole$
3. $0 < m < p$

New goal: $cong(vec(p, m), 0, p)$

#missing(title: "Missing: Euclid's Lemma",
$p "prime" imp (p|(a times b) imp p|a or p|b)$
)

Assume:
4. $vec(p, m) in whole$ by magic
5. $¬ p|m!$
6. $¬ p|(p - m)!$
$
&p times (p - 1)! = vec(p, m) times (p - m)! times m! \
imp&p|vec(p, m) times (p-m)! times m! \
imp&p|vec(p,m) "by (5), (6) and (Euclid's Lemma)" \
imp&cong(vec(p, m), 0, p)
$

== Proposition 29: congruence of combinations

Goal: $Fa(p "prime", m in whole), 0 <= m <= p imp cong(vec(p, m), 0, p) or cong(vec(p, m), 1, p)$

Assume:
1. $p "prime", m in whole$
2. $0 <= m <= p$

New goal: $cong(vec(p, m), 0, p) or cong(vec(p, m), 1, p)$

Assume:
3. $(m = 0 or m = p) or 0 < m < p$

#grid2(
  surround([
    Case: $m = 0 or m = p$

    Subgoal: #br $cong(vec(p, m), 0, p) or cong(vec(p, m), 1, p)$
    $
    &cong(vec(p, m), 1, p) "by (L27)"\
    imp&cong(vec(p, m), 0, p) or cong(vec(p, m), 1, p)
    $
  ]),
  surround([
    Case: $0 < m < p$

    Subgoal: #br $cong(vec(p, m), 0, p) or cong(vec(p, m), 1, p)$
    $
    &cong(vec(p, m), 0, p) "by (L28)"\
    imp&cong(vec(p, m), 0, p) or cong(vec(p, m), 1, p)
    $
  ])
)

#def(title: "Definition: binomial theorem", $
Fa(p in nat, m, n) (m+n)^p = sum_(k=0)^p vec(p, k) m^(p-k)n^k
$)

== Corollary 33: the freshman's dream

Goal: $Fa(m, n in nat, p "prime") cong((m+n)^p, m^p + n^p, p)$

Assume:
1. $m, n in nat, p "prime"$

New goal: $cong((m+n)^p, m^p + n^p, p)$

#informal([
  $
  (m+n)^p = vec(p, 0)m^p + sum^(p-1)_(k=1) m^(p-k)n^k + vec(p, p)n^p
  $
  $
  imp&cong((m^p + n^p) + sum^(p-1)_(k=1) m^(p-k)n^k, m^p + n^p + 0, p) "by (L28)" \
  imp&cong((m+n)^p, m^p+n^p, p)
  $

  Formal proof requires induction.
])

== Corollary 34: the dropout lemma

Goal: $Fa(m in nat, p "prime") cong((m+1)^p, m^p + 1, p)$

Assume:
1. $m in nat, p "prime"$

New goal: $cong((m+1)^p, m^p + 1, p)$

$
&Fa(m in nat) cong((m + 1)^p, m^p + 1^p, p) "by (C33)"\
imp&Fa(m in nat) cong((m + 1)^p, m^p + 1, p)
$

== Proposition 35: the many dropout lemma

Goal: $Fa(m, i in nat, p "prime") cong((m+i)^p, m^p + i, p)$

Assume:
1. $m, i in nat, p "prime"$

New goal: $cong((m+i)^p, m^p + i, p)$

#informal([
  $
  &(m + i)^p = (m + underbrace(1+1+1+1, i "times"))^p \
  imp&cong(((m + i - 1) + 1)^p, (m + i - 1)^p + 1, p) \
  imp&cong(((m + i - 2) + 1)^p, (m + i - 2)^p + 1 + 1, p)) \
  dots.v
  imp&cong((m + 1)^p, m^p + underbrace(1+1+1+1, i "times"), p) \
  imp&cong((m + i)^p, m^p + i, p) "by transitivity"
  $

  The formal proof requires induction.
])

== Theorem 36: Fermat's little theorem, clause 1

Goal: $Fa(i in nat, p "prime") cong(i^p, i, p)$

Assume:
1. $i in nat, p "prime"$

New goal: $cong(i^p, i, p)$
$
&cong((0 + i)^p, 0^p + i, p) "by (P35)" \
imp&cong(i^p, i, p)
$

#def(title: "Logical equivalences", $
not(P imp Q) &iff P and not Q \
not(P iff Q) &iff P iff not Q \
not(P and Q) &iff not P or not Q \
not(P or Q) &iff not P and not Q \
not (Fa(x) Px) &iff Ex(x) not Px \
not (Ex(x) Px) &iff Fa(x) Px \
not (not P) &iff P \
not P &iff (P imp "false")
$)

== Theorem 37: contrapositive forward

Goal: $(P imp Q) imp (not Q imp not P)$

Assume:
1. $P, Q "statement"$
2. $P imp Q$
3. $not Q$
4. $P$

New goal: $"false"$

$
&Q "by (2) and (4) as (5)" \
imp&"false" "by (3) and (5)"
$

== Theorem 39: contrapositive reverse

Goal: $(not Q imp not P) imp (P imp Q)$

Assume:
1. $not Q imp not P$
2. $P$

New goal: $Q$

Assume:
3. $not Q "by contradiction"$

New goal: $"false"$

$
&not P "by (1) and (3) as (4)" \
imp&"false" "by (2) and (4)"
$

== Corollary 40: contrapositive bi-implication

Goal: $(P imp Q) iff (not Q imp not P)$

#grid2(
  surround([
    Subgoal: $(P imp Q) imp (not Q imp not P)$

    Exact (T37)
  ]),
  surround([
    Subgoal: $(P imp Q) oif (not Q imp not P)$

    Exact (T38)
  ])
)

== Corollary 41: square root irrational
Goal: $Fa(x) x "irrational" and x > 0 imp sqrt(x) "irrational"$

Assume:
1. $x "irrational" and x > 0$

New goal: $sqrt(x) "irrational"$

Assume:
2. $sqrt(x) "rational"$ by contradiction

New goal: $"false"$

$
&Ex(p, q in whole) sqrt(x) = p slash q \
imp&Ex(p, q, in whole) x = (sqrt(x))^2 = p^2 slash q^2 \
imp&Ex(p', q' in whole) x = p' slash q' \
imp&x "rational" \
imp&"false" "by (1)"
$

== Lemma 42: rational lowest terms

#surround([
  === Lemma 42.1: positive integers cannot be a product of infinitely many primes

  #informal([
    Goal: $Fa(a in whole^+, p_1, p_2, dots, p_infty "prime") a != p_1 times p_2 times cdots times p_infty$

    Assume:
    1. $a in Z^+, p_1, p_2, dots, p_infty "prime"$
    2. $a = p_1 times p_2 times cdots times p_infty$ by contradiction

    New goal: $"false"$

    $
    &a >= 2^infty "by 2 is the smallest prime" \
    imp&a in.not whole^+ "by all integers are finite"\
    imp& "false" "by (1)"
    $
  ])
])

Goal: $Fa(x in real and x > 0) x "rational" iff Ex(m, n in whole^+) x = m slash n and (not Ex(p "prime") p|m and p|n)$

Assume:
1. $x in real and x > 0$

New goal: $x "rational" iff Ex(m, n in whole^+) x = m slash n and (not Ex(p "prime") p|m and p|n)$

#surround([
  Subgoal: $Ex(m, n in whole^+) x = m slash n and (not Ex(p "prime") p|m and p|n) imp x "rational"$

  $
  &Ex(m, n in whole^+) x = m slash n and (not Ex(p "prime") p|m and p|n) \
  imp&Ex(m, n in whole) x = m slash n \
  iff&x "rational"
  $
])

#surround([
  Subgoal: $x "rational" imp Ex(m, n in whole^+) x = m slash n and (not Ex(p "prime") p|m and p|n)$

  Assume:
  2. $x "rational" : Ex(a, b in whole^+) x = a slash b$

  New goal: $Ex(m, n in whole^+) x = m slash n and (not Ex(p "prime") p|m and p|n)$

  Assume:
  3. $Fa(m, n in whole^+) x != m slash n or Ex(p "prime") p|m and p|n$ by contradiction

  New goal: $"false"$
  $
  &Fa(m, n in whole^+) x = m slash n imp Ex(p "prime") p|m and p|n "by (3)" \
  imp&Ex(p_0 "prime") p_0|a and p_0|b "by (2)" \
  imp&Ex(a_0, b_0 in whole^+) a = p_0 times a_0 and b = p_0 times b_0 \
  imp&Ex(p_1 "prime") p_1|a_0 and p_1|b_0 "by setting" x = a_0 slash b_0 \
  imp&Ex(a_1, b_1 in whole^+) a = p_0 times p_1 times a_1 and b = p_0 times p_1 times b_1 \
  vdots
  $

  false, positive integers cannot be written as a product of infinitely many primes by (L42.1).
])

#def(title: "Definition: commutative laws", [
  $(A, e, times.circle)$ satisfies commutative laws iff
  $
  a times.circle b = b times.circle a
  $
])

#def(title: "Definition: monoid laws", [
  $(A, e, times.circle)$ satisfies monoid laws iff
  $
  0 times.circle e = e = e times.circle 0 \
  (a times.circle b) times.circle c = a times.circle (b times.circle c)
  $

  A monoid is commutative if $(A, e, times.circle)$ satisfies the commutative laws.
])

#def(title: "Definition: semiring", [
  $(A, e_1, plus.circle, e_2, times.circle)$ is a semiring if
  - $(A, e_1, plus.circle)$ is a commutative monoid.
  - $(A, e_1, times.circle)$ is a monoid.
  - $times.circle$ is distributive over $plus.circle$ : $a times.circle (b plus.circle c) = (a times.circle b) plus.circle (a times.circle c)$

  A semiring is commutative if $times.circle$ is.
])

#def(title: "Definition: cancellation", [
  - $plus.circle$ allows cancellation by $c$ on the left if $c plus.circle x = c plus.circle y imp x = y$
  - $plus.circle$ allows cancellation by $c$ on the right if $x plus.circle c = y plus.circle c imp x = y$
  - $plus.circle$ allows cancellation by $c$ if it allows cancellation both on the left and on the right.
])

#def(title: "Defintion: natural numbers", [
  ```ml
  type N =
  | zero
  | succ of N
  ```
  - $(nat, 0 +, 1, times)$ is a commutative semiring.
  - $plus$ supports cancellation by any $c$
  - $times$ supports cancellation by any $c != 0$
])


#def(title: "Definition: inverse", [
  $
  Ex(l in A) l plus.circle x = e &imp x "admits an inverse to the left" \
  Ex(l in A) x plus.circle r = e &imp x "admits an inverse to the right" \
  x "admits an inverse to the left and right" &imp x "admits an inverse"
  $
])

== Proposition 47: equality of inverses

Goal: $Fa((A, e, plus.circle) "monoid") x "admits an inverse" imp l = r$

Assume:
1. $(A, e, plus.circle)$ monoid
2. $Ex(l) l plus.circle x = e$
3. $Ex(r) x plus.circle r = e$

New goal: $l = r$

$
l &= l plus.circle e \
&= l plus.circle (x plus.circle r) \
&= (l plus.circle x) plus.circle r "commutative by monoid property" \
&= e plus.circle r \
&= r
$

#def(title: "Definition: group", [
  - A group is a monoid which every element has an inverse.
  - The group is commutative if the monoid is commutative.
])

#def(title: "Definition: additive and multiplicative inverses", [
  - $x$ admits an additive inverse if $Ex(y) x + y = 0$
  - $x$ admits a multiplicative inverse if $Ex(y) x times y = 1$
])

#def(title: "Definition: ring", [
  A ring $(A, e_1, plus.circle, e_2, times.circle)$ is a semiring where $(A, e_1, plus.circle)$ is a group.

  The ring is commutative if $(A, e_2, times.circle)$ is.
])

#def(title: "Definition: field", [
  A field $(A, e_1, plus.circle, e_2, times.circle)$ is a commutative ring where every element besides $0$ has an inverse with respect to $times.circle$.
])

#def(title: "Definition: integers and rationals", [
  - The integers $whole$ admits all additive inverses, $(whole, 0, plus, 1, times)$ is a commutative ring.
  - The rationals $rat$ also admits all multiplicative inverses, $(rat, 0 plus, 1, times)$ is a field.
])

== Theorem 53: division theorem

Let $P(q, r) : q >= 0 and 0 <= r <= n and q times n = r$

Goal: $Fa(m, n in nat) Ex(!q,!r in whole) P(q, r)$

Assume:
1. $m, n in nat$

New goal: $(Ex(q, r in whole) P(q, r)) and (P(q, r) and P(q', r') imp q = q' and r = r')$

#grid2(
  surround([
    Subgoal: $Ex(q, r in whole) P(q, r)$

    #missing([
      This goal is not proved.
    ])
  ]),
  surround([
    Subgoal: $P(q, r) and P(q', r') imp q = q' and r = r'$

    Assume:
    2. $q >= 0 and 0 <= r < n and q times n + r = m$
    3. $q' >= 0 and 0 <= r' < n and q' times n + r' = m$

    Goal: $q = q' and r = r'$

    $
    & 0 <= r < n and -n < r <= 0 \
    imp& -n < r - r' < n "by (2) and (3) as (4)" \ 
    m - r = q times n imp& cong(m,r, n) "by (2)" \
    m - r' = q' times n imp& cong(m,r', n) "by (3)" \
    imp& cong(r, r', n) "by (L24.1)" \ 
    imp& Ex(i in whole) r - r' = i times n \
    imp& i = 0 and bold(r = r') "by (4)" \
    imp& bold(q = q') "by cancellation"
    $

  ])
)

#def(title: "Definition: quo and rem", [
  For the $q$ and $r$ associated by $m = q times n + r$
  - $quo(m, n) = q$
  - $rem(m, n) = r$

  And satisfies the property $m = quo(m, n) times n + rem(m,n)$
])

== Theorem 56: existence of quotient and remainder

```ml
let divalg m n =
  let diviter q r =
    if r < n then (q, r)
    else diviter (q + 1) (r - n)
  in diviter 0 m
```

Goal: $mono("divalg") "terminates" and (mono("divalg") "terminates with" (q_0, r_0) imp r_0 < n and m = q_0 times n + r_0)$

#grid2(
  surround([
    Subgoal: $mono("divalg") "terminates"$

    #note([
      This goal is also called *total correctness*.
    ])

    #informal([
      $r in nat$ decreases in each step, which is bounded below. This cannot continue forever.

      It must terminate.
      #diagram(
        node((0,0), `divalg m n`),
        edge("-|>"),
        node((0, 1), `diviter 0 m`),
        edge("-|>", $r < n$),
        node((1, 1), `(0, m)`),
        edge((0, 1), "d" ,"-|>"),
        node((0, 2), `diviter 1 (m - n)`),
        edge("-|>", $r < n$),
        node((1, 2), `(1, m - n)`),
        edge((0, 2), "d" ,"-|>"),
        node((0, 3), `...`),
      )
    ])
  ]),
  surround([
    Subgoal: $mono("divalg") "terminates with" (q_0, r_0) imp r_0 < n and m = q_0 times n + r_0$

    #note([
      This goal is also called *partial correctness*.
    ])

    Assume:
    1. `divalg` terminates with $(q_0, r_0)$

    New goal: $r_0 < n and m = q_0 times n + r_0$

    #informal([
      In the $n$th call of `diviter`
      1. `diviter 0 m` : $m = q_0 times n + r_0$ by trivial, if $r_0 < n$ terminate. Otherwise
      2. `diviter q1 r1` $m = q_1 times n + r_1$ by trivial, if $r_1 < n$ terminate. Otherwise
      3. $dots$

      $
      m = (q + 1) times n + (r - n)
      $

      If the property holds for one point of the computation, then it holds for the next point of computation, this is called *proof by invariant*.
    ])
  ])
)

== Proposition 57: uniqueness of remainder

Goal: $cong(k, l, m) iff rem(k, m) = rem(l, m)$

#surround([
  Subgoal: $rem(k, m) = rem(l, m) imp cong(k, l, m)$

  Assume:
  1. $rem(k, m) = rem(l, m)$

  New goal: $cong(k, l, m)$

  $
  &Ex(q, r in nat) k = q times m + r "by (1)"\
  &Ex(q', r' in nat) l = q' times m + r' "by (1)"\
  imp&k - l = (q - q') times m + (r - r') \
  imp& Ex(a in nat) k - l = a times m \
  imp& cong(k, l, m)
  $
])

#surround([
  Subgoal: $cong(k, l, m) imp rem(k, m) and rem(l, m)$

  Assume:
  1. $cong(k, l, m)$

  New goal: $rem(k, m) = rem(l, m)$

  $
  &Ex(a in whole) k - l = a times m \
  imp&Ex(q, r, q', r' in whole) (q times m + r) - (q' times m + r') = a times m "by (T56)" \
  imp&r - r' = (a - q + q') times m \
  imp&r - r' = 0 times m "by bound" (-m) < r - r' < m \
  imp&r = r'
  $
])

== Corollary 58.1: congruence with remainder

Goal: $Fa(m in nat) cong(n, rem(n, m), m)$

Assume:
1. $m in nat$

New goal: $cong(n, rem(n, m), m)$

$
&Ex(a in whole) n = m times quo(n, m) + rem(n, m) \
imp&n - rem(n, m) = m times quo(n, m) \
imp&cong(n, rem(n, m), m)
$

== Corollary 58.2: existence of modulus integer

Goal: $Fa(k in whole) Ex(![k]_m) 0 <= [k]_m < m and cong(k, [k]_m, m)$

#surround([
  Subgoal: $Fa(k in nat) Ex(![k]_m) 0 <= [k]_m < m and cong(k, [k]_m, m)$

  Assume:
  1. $k in nat$

  New goal: $Ex(![k]_m) 0 <= [k]_m < m and cong(k, [k]_m, m)$

  Let $[k]_m = rem(k, m)$.

  Let $P(k) : 0 <= [k]_m < m and cong(k, [k]_m, m)$

  New goal: $P([k]_m) and (P(a) and P(b) imp a = b)$

  #grid2(
    surround([
      Subgoal: #br $0 <= [k]_m < m and cong(k, [k]_m, m)$

      Exact by (T56) and (P57).
    ]),
    surround([
      Subgoal: $P(a) and P(b) imp a = b$

      Assume:
      2. $0 <= a < m and cong(k, a, m)$
      3. $0 <= b < m and cong(k, b, m)$

      New goal: $a = b$

      $
      & -m < a - b < m "by (2) and (3)" \
      &Ex(i in whole) a - b = i times m "by (2) and (3)" \
      imp&i = 0 and bold(a = b) "by bounds"
      $
    ]),
  ),
])

#surround([
  Subgoal: $Fa(k in whole^-) Ex(![k]_m) 0 <= [k]_m < m and cong(k, [k]_m, m)$

  Assume:
  1. $k in whole^-$

  New goal: $Ex(![k]_m) 0 <= [k]_m < m and cong(k, [k]_m, m)$

  $
  &Ex(i in whole) k + i times m >= 0 "by magic" \
  &cong(k + i times m, k, m) "by trivial" \
  $
  Then get the goal by setting $k' = k + i times m$ using the previous subgoal.
])

#def(title: "Definition: modular arithmetic", [
  $
  k +_m l &= [k+l]_m = rem(k + l, m) \
  k times_m l &= [k times l]_m = rem(k + l, m)
  $
])

== Proposition 62: modular arithmetic is a commutative ring

Goal: $(whole_m, 0, +_m, 1, times_m)$ is a commutative ring

#surround([
  Subgoal: $(whole_m, 0, +_m)$ is a commutative monoid

  #tab2(
    [Property], [Proof],
    [Commutative], [$a_m +_m b_m = rem(a_m + b_m) = b_m +_m a_m$],
    [Neutral element], [$0_m +_m a_m = a_m = a_m + 0_m$],
    [Associativity], [$(a_m +_m b_m) +_m c_m = rem(a_m + b_m + c_m) = a_m +_m (b_m +_m c_m)$]
  )
])

#surround([
  Subgoal: $(whole_m, 1, times_m)$ is a commutative monoid

  #tab2(
    [Property], [Proof],
    [Commutative], [$a_m times_m b_m = rem(a_m times b_m) = b_m times_m a_m$],
    [Neutral element], [$1_m times_m a_m = a_m = a_m times 1_m$],
    [Associativity], [$(a_m times_m b_m) times_m c_m = rem(a_m times b_m times c_m) = a_m times_m (b_m times_m c_m)$]
  )
])

#surround([
  Subgoal: $(whole_m, 0, +_m, 1, times_m)$ is a semiring

  Apply subgoals (1) and (2).

  New goal: distributivity $a_m times (b_m +_m c_n) = a_m times_m b_m +_m a_m times_m c_m$

  $
  a_m times (b_m +_m c_n) &eqv a_m times (b_m +_m c_m) space (mod m)\
  &eqv a_m times (b_m + c_m) space (mod m)\
  &eqv a_m times b_m + a_m times c_m space (mod m)\
  &eqv a_m times_m b_m +_m a_m times_m c_m space (mod m)
  $
])

#surround([
  Subgoal: $(whole_m, 0, +)$ is a group

  Apply subgoal (1).

  New goal: $Fa(x_m in whole_m) Ex(y_m in whole_m) [x_m +_m y_m] = 0$

  Assume:
  1. $x_m in whole_m$

  Let $y_m = [-x_m]_m$

  New goal: $x_m +_m y_m = 0$

  $
  x_m +_m y_m &eqv x_m + [-x]_m space (mod m) \
  &eqv x_m + (m - x_m) space (mod m) "by trivial"
  &eqv m space (mod m) \
  &eqv 0 space (mod m)
  $
])

#surround([
  Sugboal: $(whole_m, 0, +_m, 1, times_m)$ is a commutative ring.

  Exact by subgoal (2) and (4).
])

== Proposition 63: condition for reciprocal

Goal: $Fa(m in whole^+, k in whole_m) (Ex(l in whole_m) k times_m l &=1) iff (Ex(i, j in whole) k times i + m times j = 1)$

Assume:
1. $m in whole^+, k in whole_m$

#surround([
  Subgoal: $(Ex(l in whole_m) k times_m l &=1) imp (Ex(i, j in whole) k times i + m times j = 1)$

  Assume:
  2. $Ex(l in whole_m) k times_m l =1$

  New goal: $Ex(i, j in whole) k times i + m times j = 1$

  Let $i = k$

  New goal: $Ex(j in whole) k times l + m times j = 1$

  $
  &Ex(l in whole_m) cong(k times l, 1, m) \
  imp&Ex(a in whole )k times l - 1 = m times a \
  imp&Ex(j in whole )k times l + m times j = 1 \
  $
])

#surround([
  Subgoal: $(Ex(i, j in whole) k times i + m times j = 1) imp (Ex(l in whole_m) k times_m l &=1)$

  Assume:
  2. $Ex(i, j in whole) k times i + m times j = 1$

  New goal: $Ex(l in whole_m) k times_m l &=1$

  $
  &Ex(i, j in whole) k times i - 1 = m times (-j) \
  &Ex(i, a in whole) k times i - 1 = m times a \
  &cong(k times i, 1, m) \
  &k times_m [i]_m = 1
  $
])

#def(title: "Definition: linear combination",[
  $r in whole$ is a linear combination of $m, n in whole$ if
  $
  Ex(s, t in whole) s times m + t times n = r
  $
])

== Proposition 65: condition for reciprocal (linar combination)

Goal: $Fa(k in whole_m) (Ex(l in whole_m) k times_m l = 1) iff "1 is a linear combination of" m "and" k$

Exact by (P63).

#def(title: "Definition: sets", [
  - $x in A$ if $x$ is an element in $A$
  - $A = B iff (Fa(x) x in A iff x in B)$
  - ${ x in A | P(x) } = { x in A | Q(x) } iff (Fa(x in A) P(x) iff Q(x))$
])

#def(title: "Definition: common divisiors", [
  $
  D(m) &= { d : d|m} \
  CD(m, n) &= {d : d|m and d|n}
  $
])

== Lemma 71: key lemma

Goal: $Fa(m, m' in nat, n in whole^+) cong(m, m', n) imp CD(m,n) = CD(m', n)$

Assume:
1. $m, m' in nat, n in whole^+$
2. $cong(m,m',n)$

New goal: $d|m and d|n iff d|m' and d|n$ (equality of predicates)

$
&Ex(k in whole) m' = m + k times n "by (1)" \
$

#grid2(
  surround([
    Subgoal: $d|m and d|n imp d|m' and d|n$

    Assume:
    3. $d|m and d|n$

    New goal: $d|m' and d|n$

    $
    &d|n "by (3)" \
    &Ex(i in whole) m-m' = i times n "by (2)" \
    imp&m' = i times n - m \
    imp&Ex(j, k in whole) m' = d times j times i - d times k \
    imp&Ex(l in whole) m' = d times l \
    imp&d|m'
    $
  ]),
  surround([
    Subgoal: $d|m' and d|n imp d|m and d|n$

    #note([
      This is true by symmetry of the first subgoal.
    ])
  ])
)
