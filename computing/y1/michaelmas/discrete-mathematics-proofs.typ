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
&Ex(i, j in bb(N)) m = 2i + 1 "and" n=2j+1 \
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
- $x "nonnegative" "and" x in bb(Z) iff x in bb(N)$

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

== Theorem 11
Goal: Let $P_1, P_2, P_3$ be statements, $(P_1 imp P_2 "and" P_2 imp P_3) imp (P_1 imp P_3)$

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

== Definition 12


