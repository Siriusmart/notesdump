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

#line(length: 100%)

=== Taylor's Theorem

An exact result can be written by including a *remainder term* $R_(n+1)$.
$
f(a+h) = f(a) + h f'(a) + cdots + h^n/n! f^((n))(a)+R_(n+1)
$

*Taylor's Theorem* states if $f$ is $n+1$ times differentiable, there exists a $zeta : a < zeta < a + h$ such that
$
R_(n+1)=h^(n+1)/(n+1)!f^((n+1))(zeta)
$

==== Proof

$
int^x_a f'(t) d t &= f(x) - f(a) "by fundamental theorem of calculus" \
f(x) &= f(a) + int^x_a f'(t) d t \
&= f(a) + [(t - x)f'(t)]^x_a - int^x_a (t - x)f''(x) d t "integrate by parts" \
&= f(a) + (x - a)f'(a) + int^x_a (t - x)f''(x) d t
$

Integrate by parts repeatedly to find
$
f(x) &= f(a) + (x-a)f'(a) + cdots + (x-a)^n/n! f^((n))(a)+int^x_a (t-x)^n/n!f^((n+1))(t)d t \ 
R_(n+1) &= int^x_a (t-x)^n/n! f^((n+1))(t) d t \
&= (x - a)^(n+1)/(n+1)! f^((n+1))(zeta) "where" a <= zeta <= x "by mean value theorem"
$

$
lim_(n to infty) R_(n+1) = 0 imp "Taylor series for " f(x) "converges"
$

By choosing the $zeta$ that would give the largest error, we can calculate the worst case error for an approximation.

#note([
  If $f(x)$ is infinitely differentiable, then we can represent $f$
  exactly as an infinite *power series*.
])

We could also prove that two functions are the same if they have the same Taylor series.

=== Common Series Expansions

A lot of these expansion can be proved using the expansion for $e^x$.

#grid2(width: 10pt,
  tab2(
    [Function], [Taylor series],
    $
    e^x
    $, $
    sum_(n=0) x^n/n!
    $,
    $cosh x$,
    $
    sum_(n=0)x^(2n)/((2n)!)
    $,
    $cos x$,
    $
    sum_(n=0)(-1)^(n)x^(2n)/((2n)!)
    $,
  ),
  tab2(
    [Function], [Taylor series],
    $ln (1+x)$, $
    sum_(n=1) (-1)^(n+1)x^n/n
    $,
    $sinh x$,
    $
    sum_(n=0)x^(2n + 1)/((2n + 1i)!)
    $,
    $sin x$,
    $
    sum_(n=0)(-1)^(n)x^(2n + 1)/((2n + 1i)!)
    $,
  )
)

It makes sense that the Taylor series of an even function only have even powered terms, and
an odd function only have odd powered terms.

The series expansion for _tanh_ has a radius of convergence of $|x| < pi/2$, this makes sense because
- Polynomials cannot capture the flat asymptote.
- _tan_ is only continuous over $(-pi/2, pi/2)$.

#hr

== Binomial Expansion

Consider $f(x) = (1+x)^n$
$
f'(x) &= n(1+x)^(n-1) \
f''(x) &= n(n-1)(1+x)^(n-2) \
f'''(x) &= n(n-1)(n-2)(1+x)^(n-3) \
& vdots
$

So we have
$
(1 + x)^n = 1 + n x + n(n-1)/2! x^2 + (n(n-1)(n-2))/3! x^3+ cdots
$

Which is the *binomial theorem*, when $n$ is a positive integer, it agrees with the binomial expansion.

We can show that the series is absolutely convergent for $|x| < 1$ by the ratio test.

== Stationary points with Taylor Series

If $f$ is stationary at $x=a$, and suppose $f''(a) != 0$.
$
f(x) &= f(a) + x f'(a) + x^2/2 f''(a) + cdots \
f(x) - f(a) & approx x^2/2 f''(a)
$

Now we know why if $f''(a) > 0$ then $f$ has a minimum at $x=a$, if $f''(a) < 0$ then $f$ has a maximum at $x = a$.

If the first $n-1$ derivatives of $f(x) - f(a)$ are *vanishing*, then the function will behave like the first nonvanishing (the $n$th) term. This is where the idea of *l'Hopital's rule* comes from.
$
f(x) - f(a) approx (x-a)^n/n! f^((n))(a)
$

- If $n$ is even then $x=a$ is either a local maximum or minimum for $f$, as $x<a$ and $x>a$ are both either less than or greater than $f$ at $x=a$.
- If $n$ is odd then $x=a$ is a point of inflection for $f$.

=== Approximating Functions with Taylor Series

Functions can be approximated by replacing them with their Taylor series, for example.
$
(log (1+x))/(1-x) &= log(1+x) dot (1-x)^(-1) \
&= (x - x^2/2 + x^3/3 - cdots) dot (1 + x + x^2 + cdots) \
&= x + x^2/2 + (5x^3)/6 + cdots
$

== Newton-Rapson Method

This is an efficient way of finding roots of a function.

The first order approximation of a function at $x = a$ is, we want to find $f(x) = 0$.
$
f(x) &approx f(a) + (x - a)f'(a) \
$

We want to find $f(x) = 0$.
$
0 &approx f(a) + (x - a)f'(a) \
&=(f(a))/(f'(a)) + x - a \
x &= a- (f(a))/(f'(a))
$

So if we define the sequence
$
x_(n+1) = x_n - f(x_n)/(f'(x_n))
$

This turns out to converge really quickly.

=== Estimating Error

Write a recursive relation that gives the error term $epsilon_n$, so we can find how quickly it converges.

Let $x^*$ be the exact solution where $f(x^*) = 0$.

$
f(x) approx f(x^*) + (x - x^*) f'(x^*) + 1 / 2 (x - x^*)^2 f''(x^*)
$

If $f$ is linear, thne we find $x^*$ in one step. Otherwise, define error $epsilon_n = x_n - x^*$.

$
f'(x) &= f'(x^*) + (x - x ^*) f''(x^*) + O(x^3) \
epsilon_(n+1) &= x_(n+1) - x^* \
&=(x_n - f(x_n)/(f'(x_n))) - x^* \
&=x_n - x^* - (f(x^*) + epsilon_n f'(x^*) + 1/2 (epsilon_n)^2 f''(x^*))/(f'(x^*) + epsilon_m f''(x^*)) \
&=epsilon_n - (epsilon_n f'(x^*) + 1/2 (epsilon_n)^2 f''(x^*))/(f'(x^*) + epsilon_n f''(x^*))
$

Assuming we are close, how much closer will we get for the next step?

For very small $epsilon$
$
epsilon_(n+1) &= -(1/2(epsilon_n)^2 f''(x^*))/(f'(x^*)) + O((epsilon_n)^2)
$

So the first term will be a quadratic term in $epsilon_n$ - the error will be squared for each term.

#hr

#align(center, `END Infinite Series`)
