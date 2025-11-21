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

== Definition 7
$n in bb(N)$ is odd if $Ex(i in bb(N)) n = 2i+1$.

== Proposition 8

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

== Definition 9
$Fa(x in bb(R))$
- $Ex(m, n in bb(Z)) x = m slash n iff x "rational"$
- $not (x "rational") iff x "irrational"$
- $x > 0 iff x "positive"$
- $x < 0 iff x "negative"$
- $not (x "positive") iff x "nonpositive"$
- $not (x "negative") iff x "nonnegative"$
- $x "nonnegative" and x in bb(Z) iff x in bb(N)$

== Proposition 10
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

#def([
  $P and (P imp Q) imp Q$
])

== Theorem 11
Goal: Let $P_1, P_2, P_3$ be statements, $(P_1 imp P_2 and P_2 imp P_3) imp (P_1 imp P_3)$

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

#def([
  $(P iff Q) iff (P imp Q and P oif Q)$
])

== Definition 12

$d|n iff Ex(k in whole) n = k times d$

== Definition 14

$Fa(m in whole^+, a, b in whole) cong(a, b, m) iff m|(a-b)$

== Proposition 16

Goal: $(n "even" iff cong(n, 0, 2)) and (n "odd" iff cong(n, 1, 2))$

#surround([
  Subgoal: $n "even" iff cong(n, 0, 2)$

  Assume:
  1. $n "even"$

  New goal: $cong(n, 0, 2)$
  $
  n "even" &iff Ex(k in whole) n = 2 times k \
  &iff Ex(k in whole) (n-0) = 2 times k \
  &iff cong(n, 0, 2)
  $
])

#surround([
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

== Proposition 18

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
