#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Mathematics Lecture Notes]
    #h(1fr) _Elementary Analysis_
  ],
)

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

= Elementary Analysis

== The Limit

This section gives a more rigorous understanding of the limit.

The function $sinc x = (sin x) / x$ is well behaved for $x != 0$, but $sinc 0 = 0/0$ is undefined.
- The intuitive understanding of the limit tells us to take some step away from the limit.
- Then get closer to the value and see what happens to the function value:
  - Does it get closer and closer?
  - Or does it diverges.

#definition(title: "Tangent", [
  A *monster function* is a function everywhere continuous, but nowhere differentiable.
  $
  f(x) = sum_(k=0)^infinity a^k cos (b^k pi x) 
  $
  Where $0<a<1$, $b in bb(Z)_"odd"$, $a b > 1 + (3 pi)/2$
])

=== Epsilon Delta Definition of a Limit

Let $f$ be defined and continuous on an open interval containing $x_0$, but not necessarily on $x_0$.

$
lim_(x -> x_0) f(x) &= K
$
Iff $(forall epsilon > 0)(exists delta > 0) space 0 < |x - x_0| < delta arrow.double.long |f(x) - K| < epsilon$

We can prove a function has a limit iff this has a value.

#definition([
  A function does not have a limit at $x = x_0$ iff
  $
  (forall L)(exists epsilon > 0)(forall delta > 0) space 0 < |x - x_0| < delta arrow.double.long |f(x) - L| >= epsilon
  $
])

=== One-Sided Limits
$
lim_(x -> x_0) f(x) = L arrow.l.r.double.long (forall epsilon > 0)(exists delta > 0) space 0 < x - x_a < delta arrow.double.long |f(x) - L| < epsilon
$

=== Limits at Infinity

If we define a box that have finite height and extend to infinity, check if the function is still in the box.
$
lim_(x -> infinity) f(x) = L arrow.l.r.double.long (forall epsilon > 0)(exists X < infinity) space x > X arrow.double.long |f(x) - L|<epsilon
$
== Algebra of Limits

$
lim_(x -> x_0)f(x) &= A \
lim_(x -> x_0)g(x) &= B \
lim_(x -> x_0)f(x) + g(x) &= A + B \
lim_(x -> x_0)f(x) g(x) &= A B quad ("unless" A=0, B = infinity)
$
These also applies to $x -> infinity$.

=== l'Hopital's Rule

Used in cases where the limit is undefined: $0/0$, $infinity/infinity$, $0 dot.c infinity$.

$
lim_(x -> x_0)(f(x))/(g(x)) = lim_(x -> x_0)(f'(x))/(g'(x))
$

- Requires $f$ and $g$ be differentiable in an open interval.
- $f'(0)$ and $g'(x)$ not equal to 0 in the open interval and exists.

The way to understand this is with the Taylor series.
