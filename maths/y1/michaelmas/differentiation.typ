#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Mathematics Lecture Notes]
    #h(1fr) _Differentiation_
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

= Differentiation

== First Principles

We are interested in the slope of the function at every point.

We want to create a linear function that is tangent to the point, if $delta x$ becomes very small, and the function is smooth, then the slope is
$
(d y)/(d x)=lim_(delta x -> 0)(y(x + delta x) - y(x))/(delta x)=lim_(delta x -> 0)(delta y)/(delta x)
$

$d/(d x)$ is an operator, because it _maps_ a function $y(x)$ into its derivative $y'(x)$.


=== Non-differentiable Functions
Functions don't have to be differentiable everywhere.
- $(d|x|)/(d x) = 1$ for $x>0$ and $-1$ for $x < 0$.
- The derivative does not exist when $x=0$.
  - If we take the derivative by first principle at $x=0$, we will get the derivative is 1 at $x=0$.
  - But that's because we are using the $+delta x$ definition of the limit, if we do that by the $-delta x$ definition which is equally valid, we will get $-1$.
  - The derivative requires both definitions to agree with each other.

=== The Heaviside Step Function

$
H(x) = cases(
  0\, quad &x < 0,
  1\, &x > 0
)
$

Consider a graph of a normal distribution so the area under the graph is 1.
- The Heaviside step function is the ingeral of the function from $- infinity$ to $x$ when $sigma -> 0$ (standard deviation) so the peak becomes infinitely tall.
- So we have $H'(x)=0$ everywhere but

$
integral^infinity_(-infinity)H'(x)d x = 1
$

#definition([
  *Differentiability*: the derivative exists iff
  - The function is continuous.
  - $f'$ exists and is finite and defined.
])

*Implicit differentiation* says if you can get the derivative of a function, you can also very easily take the derivative of the inverse function. We can see this is true by rotating the graph.

== Differentiation Rules

We can do *first order approximation*
$
u(x+delta x) approx u(x) + (d u)/(d x) dot delta x = u + delta u
$
As $delta x -> 0$ the approximation becomes exact.
$
(d f)/(d u) &= (f(u + delta u) - f(u))/(delta u) \
(d f)/(d x) &= ((f(u + delta u) - f(u))/(delta u))((u(x + delta x)-u(x))/(delta x))
$

The rules we will use are
#align(center,
  grid(
    columns: (20%, auto),
    gutter: 20pt,
    "Chain rule",
    $
    d/(d x)(f(u(x))) = (d f)/(d u)(d u)/(d x)
    $,
    "Product rule",
    $
    d/(d x) (f g) = (d f)/(d x)g + f (d g)/(d x)
    $,
    "Quotient rule",
    $
    d/(d x) f/g = (g (d f)/(d x) - f (d g)/(d x))/g^2
    $
  )
)

You are expected to know the proof to these rules.

When differentiating functions like $(sin x)/x$, analysis won't be useful because the function is not defined at 0, but we can differentiate it using the quotient rule.

=== Implicit Differentiation
$
g(y) = h(x)
$
Where $y$ is a function over $x$, using the chain rule.
$
d/(d x)g(y(x))&=d/(d x)h(x) \
(d g)/(d y) dot (d y)/(d x)&=(d h)/(d x) \
 (d y)/(d x)&=(d h)/(d x) slash (d g)/(d y)
$

=== Reciprocal Rule

From the geometric intepretation of the alternative, if we know the derivative of a function at a point, we automatically know the derivative of the inverse at that point.
$
(d x)/(d y) &= lim_(delta x -> 0)(delta x)/(delta y)=lim_(delta y -> 0)((delta y)/(delta x))^(-1) \
&=(lim_(delta x -> 0)(delta y)/(delta x))^(-1) \
&= 1/(d y slash d x)
$

== Higher Derivatives
- The first derivative gives the slope of the graph.
- The second derivative gives the curvature of the graph.

Since the derivative is an operator, we can differentiate the function again and have as many derivative as we want, as long as it is differentiable.

=== Approximation

Higher derivatives is useful for approximating the formula.

With the first derivative
$
y(x + delta x) approx y(x) + delta x dot (d y)/(d x)
$

This can be extended to a Taylor series.

=== Leibnitz's Formula

How does the product rule extend if we take multiple derivatives?
$
y &= f g \
y' &= f'g + f g' \
y'' &= f''g + 2 f'g' + f g'' \
y''' &= f'''g' + 3 f''g' + 3 f' g'' + f g'''
$

This looks like *Pascal's triangle*, which is given by the binomial coefficient, so we are suggesting
$
(d^n (f g))/(d x^n) = sum_(m=0)^n binom(n, m) f^(n - m)g^m
$

Which can be proved by induction.

#line(length: 100%)
