#import "@local/discmaths:0.1.0" : *
#import "@local/contmaths:0.1.0" : *
#import "@local/lecture:0.1.0" : *

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

$
gamma = lim_(k -> infinity)(S_k - ln k) = 0.57721566
$
Which is the *Euler-Mascheroni constant*.

#line(length: 100%)

== Convergence Tests

=== Comparison Tests

The comparison test can be used on two nonnegative series: $(forall k) u_k, v_k >= 0$

$
(forall k >= K) space u_k <= v_k "and" sum^infinity_(k=0) v_k "convergent" imp sum^infinity_(k=0)u_k "convergent" \
(forall k >= K) space u_k >= v_k "and" sum^infinity_(k=0) v_k "divergent" imp sum^infinity_(k=0)u_k "divergent"
$

=== Ratio Tests

For a positive series: $(forall k)space u_k > 0$
$
lim_(k to infty)(u_(k+1)/u_k) < 1 & imp "converges" \
lim_(k to infty)(u_(k+1)/u_k) > 1 & imp "diverges" \
$

==== Proof

If $lim_(k to infty) u_(k+1)/u_k = alpha < infty$, then for large enough $k$:
$
sum u = u_1 + u_2 + cdots + u_k (1 + alpha + alpha^2 + cdots)
$
Which converges.

=== Leibniz Criterion

#def([
  *Alternating series* have terms with alternating signs.
])

If $a_k > 0$ and $a_k$ is monotonically decreasing for large enough $k$, and $lim_(k to infty) a_k = 0$.
$
S = sum_(k=1)^infty (-1)^(k+1)a_k "converges"
$

==== Proof

We know it is true that
$
sum_(k=1)^(2n) = (a_1 - a_2) + (a_3 - a_4) + cdots "is a monotonically increasing series" \
sum_(k=1)^(2n + 1) = a_1 - (a_2 - a_3) - (a_4 - a_5) - dots "is a monotonically decreasing series" \
lim_(k to infty) (sum_(k=1)^(2n + 1) a_k - sum_(k=1)^(2n) a_k) = 0
$

So we write the inequality
$
a_1 - a_2 = S_2 < S_4 < cdots < S_(2n) < S_(2n + 1) < cdots < S_3 < S_1 < a_1
$

== Power Series

A power series have form
$
sum^infty_(k=0) a_k x^k = a_0 + a_1 x + a_2 x^2 + cdots
$

The *domain of convergence* is either
- Only $x=0$
- All finite $x$
- Only for some $|x| < R$

We can find out which case it is with the *ratio test*, which gives the shortcut if $lim_(k to infty) |a_(k+1)/a_k|$ exists.
$
|x|<1/L &imp "converges" \
|x|>1/L &imp "diverges" \
|x|=1/L &imp "indeterminate" \
$

Note the endpoints at $|x|=1\L$ may behave differently.

=== The Taylor Series

We can approximate the value of a function using its tangent at a point.
$
f(x) &approx f(a) + (x-a)f'(a) \
f'(x) &approx f'(a) + (x-a)f''(a) \
$

By the fundamental theorem of calculus, which links the derivative to the integral:
$
int^(a+h)_a f'(x) d x &= f(a+h) - f(a) \
f(a+h) &= f(a) + int^(a+h)_a f'(x) d x\
&= f(a) + int^(a+h)_a f'(a) + (x - a)f''(a) d x \
&= f(a) + [x f'(a) + (x - a)^2/2f''(a)]^(a+h)_a \
&= f(a) + h f'(a) +h^2/2 f''(a)\
$

We can show that the *second order approximation* is better than the first order approximation. (how?)

Extend this to higher order approximations, and we get
$
f'(x) approx f'(a) + (x - a) f''(a) + (x - a)^2/2!f'''(a) +(x-a)^3/3!f''''(a) + cdots
$

Since the factorial function grows faster than any polynomial, we know that $n!$ grows faster than $(x-a)^n$ so the series converges for a lot of approximations.
