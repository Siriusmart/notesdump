#let definition(title: "Definition", body) = {
  block(
    fill: luma(230),
    inset: 8pt,
    radius: 4pt,
  )[
    === #title
    #body
  ]
}

#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Mathematics Lecture Notes]
    #h(1fr) _Infinite Series_
  ],
)

= Infinite Series

== Convergence

Given an infinite sequence of numbers, define the *partial sum* to be
$
S_n = u_1 + u_2 + dots.c + u_n
$

We want to know if the infinite series
- Have a well defined limit
- Diverges
- Oscillates

$
lim_(n -> infinity) S_n = S "iff" (forall epsilon > 0) (exists N) space n > N arrow.double.long |S-S_n| < epsilon
$

=== Conditions for Convergence

Requires $u_n -> 0$ as $n -> infinity$.

The sum of two diverging series may converge, e.g. when one diverges to $+infinity$ and the other to $-infinity$, and the two cancels each other out.

#definition(title: "Definitions", [
  - A series is *absolutely convergent* iff $sum|a_n|$ converges.
  - A series is *conditionally convergent* iff $sum a_n$ converges but not $sum |a_n|$.
])

If we rearrange the terms in a series, a converging series can diverge, or the other way round.
- If we have an absolutely convergent series, it doesn't matter if we change the order.
- If we have a conditionally convergent series, changing the order may cause it to diverge.

=== Geometric Progression

Let $u_k = r^k$, we already know the sum formula for the geometric progression, here's the proof.
$
(1-r)(1+r+r^2+dots.c+r^k) &= 1 - r^k quad ("by simplifying the expression") \ 
1+r+r^2+dots.c+r^k &= (1-r^k)/(1-r)
$

For the sum of infinite series
$
lim_(k -> infinity) (1 - r^k) / (1 - r) "exists if " |r| < 1"."
$

=== The Harmonic Series

The harmonic series is
$
sum_(k=1)^infinity 1/ k=1+1/2+1/3+dots.c
$

We can group terms *without reordering*.
$
1 + (1/2) + (1/3+1/4) + (1/5+1/6+1/7+1/7) + dots.c &>= 1 + 1/2 + 1/2 + 1/2 + dots.c
$
The sequence $sum 1/2$ diverges, so the harmonic series also diverges, this is called a *comparison test*.

The harmonic series is the slowest diverging sequence, to show this series diverges as slow as $log x$
$
gamma = lim_(k -> infinity)(S_k - ln k) = 0.57721566
$
Which is the *Euler-Mascheroni constant*.
