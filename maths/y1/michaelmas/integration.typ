#import "@local/lecture:0.1.0" : *
#import "@preview/cetz:0.4.2"

#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Mathematics Lecture Notes]
    #h(1fr) _Integration_
  ],
)

= Integration

== Integration as Area

To find the area under the curve $y=f(x)$ in range $a <= x <= b$.
+ *Partition* $[a, b]$ into $N$ subintervals with endpoints $x_0, x_1, dots, x_N$, the width of the partitions does not have to be equal.
+ Choose $N$ points $xi_1, xi_2, dots, xi_N$ in each of the partitions. The rectangle of each subpartition has area $A_i = (x_i - x_(i - 1))f(xi_i)$.
+ The total area is the *Riemann sum*
  $
  S_N = sum^N_(i=1)(x-x_(i-1))f(xi_i)
  $
+ Take the *Riemann integral* where $N to infty$ such that all $x_i - x_(i-1) to 0$.
  $
  int^b_a f(x) dx = lim_(N to infty) S_N
  $
  The integral in this form is also called a *definite integral*.

=== Properties of an Integral

From the geometric interpretation.
$
int^b_a f(x) dx = int^c_a f(x) dx + int^b_c f(x) dx
$

But in the definition we assume $a leq x leq b$, to make the above property true for all $c$, we can define
$
int^b_a f(x) dx = -int^a_b f(x) dx
$

Integration and differentiation are *linear operations*, this means
$
int^b_a k f(x) dx &= k int^b_a f(x) dx \
int^b_a f(x) + g(x) dx &= int^b_a f(x) dx + int^b_a g(x) dx
$

In $infty + (- infty)$ senarios, $int f + g dx$ may be finite, but $int f dx + int g dx$ are both undefined.

=== Fundamental Theorem of Calculus
$
F(x) = int^x_a f(u) du iff dF / dx = f(x)
$

Or
$
d/dx int^x_a f(u) du = f(x)
$

==== Proof
$
dF /dx &= lim_(delta x to 0) (F(x + delta x) - F(x))/(delta x) \
&= lim_(delta x to 0)(int^(x+delta x)_a f(u) du + int^x_a f(u) du)/(delta x) \
&= lim_(delta x to 0)(int^(x + delta x)_x f(u) du)/(delta x) \
&= f(x)
$

#defs([
  In $F(x) = int f(x) dx$
  - $f(x)$ is the *integrand*.
  - $F(x)$ is the *primitive*.
])

=== Definite and Indefinite Integrals

The primitive is also called the *indefinite integral* of $f(x)$.
- If $F(x)$ is the indefinite integral, then so is $F(x) + C$.
- The definite integral equals the difference between the primitives evaluated at the endpoins.
  $
  int^b_a f(x) dx = F(b) - F(a)
  $
  Note that the constant disappears.

=== Improper Integrals

#def([
  An *improper integral* is one which the integrand is _singular_ (not well behaved) within the range of integration.
])

$
int^infty_a f(x) dx = lim_(b to infty) (int^b_a f(x) dx)
$

=== Discontinuous Integrals

#def([
  A *discontinuous integrand* contains a finite number of discontinuities over the range of integration.
])

If $f(x)$ is discontinuous at $x=x_0$
$
int^b_a f(x) dx = int^(x_0)_a f(x) dx + int^b_(x_0) f(x) dx
$

Note that the primitive of a discontinuous function is continuous.

== Methods of Integration

=== Common Results
Since the indefinite integral is the reverse of differentiation.

#grid(
  columns: (45%, 40%),
  column-gutter: 20pt,
  $
  int x^n dx &= x^(n+1)/ (n+1) + C \
  int 1/x dx &= ln |x| + C \
  int e^(a x) dx &= 1/a e^(a x) + C \
  $,
  $
  int cos (a x) dx &= 1/a sin (a x) + C \
  int sin (a x) dx &= -1/a cos (a x) + C \
  int sec^2 (a x) dx &= 1/a tan (a x) + C
  $
)

Using results from inverse hyperbolic functions.

#grid(
  columns: (45%, 40%),
  column-gutter: 20pt,
  $
  int 1 / sqrt(x^2 - a^2) dx &= arcosh (x/a) + C \
  $,
  $
  int 1 / sqrt(x^2 + a^2) dx &= arsinh (x/a) + C
  $
)

From the chain rule
$
int (f(x))^n f'(x) dx &= 1/(n+1) f^(n+1)(x) + C \
int (f'(x)) / f(x) dx &= ln |f(x)| + C
$

=== Powers of Trig Functions

Use the result $sin^2(x) = 1/2 (1 - cos 2x)$ and $cos^2(x) = 1/2 (1 + cos 2x)$

Since we don't know how to integrate higher power trig functions.
- If the power is even, e.g. $cos^4 x = 1/4 (1+cos 2x)^2$, expand and repeat until the expression can be integrated.
- If the power is odd, e.g. $sin^3 x = sin x(1-cos^2 x)$, expand and use the reverse chain rule.

Similar rules can be used for stuff related to $sec^2 x = 1 + tan^2x$ and the $csc^2 x$ equivalent.

=== Partial Fractions

$
f(x) = p(x) / q(x)
$
Where $p(x)$ and $q(x)$ are polynomials, then $f(x) = P(x) + Q(x)$

The fundamental theorem of algebra says that we can write $q(x)$ as $$.
But we don't actually want to deal with complex numbers, so we have
$
q(x) = (x - a_1)^(j_1)(x - a_2)^(j_2)cdots (r_(m-1) (x))^(j_(m-1)) (r_m (x))^(j_m)
$
Where $r_i(x)$ are the terms with no real roots. So
$
Q(x) = sum^m_(i = 1) sum^(j_i)_(r=1) A_(i r)/(x-a_i)^r
$

Once you write down these partial fractions, it is easy to integrate the terms.

#hr

=== Cover-up Rule

$
f(x) &= (a_0+a_1 x+a_2 x^2 + cdots)/((x-r_0)(x-r_1)(x-r_2) dot cdots) \
&=b_0/(x-r_0) + b_1/(x-r_1) + b_2/(x-r_2) + cdots \
b_0 + (x-r_0)(b_1/(x-r_1)+b_2/(x-r_2)+cdots) &= (a_0+a_1 x+a_2 x^2 + cdots)/((x-r_1)(x-r_2) dot cdots)
$

Substitute $x=r_0$ to get
$
b_0 = (a_0+a_1 x+a_2 x^2 + cdots)/((x-r_1)(x-r_2) dot cdots)
$

#note([
  When there is a repeated root, the cover-up method only gives the coefficient of higest power.
])

== Substitution

Substitution simplifies an integral by changing variables. Take example
$
int 1/(1+x^2) dx
$

Let $x = tan u$, then $dx = sec^2 u space du$.
- We are saying that making a small test in $dx$ is the same as making a small step in $sec^2 u space du$.
- Look at the graph of $tan x$ and this does make sense.

$
&= int 1/(1+tan^2 x) sec^2 x space dx \
&= u + C \
&= arctan x + C
$

=== Half-angle Formula

Using the substitution $tan(x/2) = t$, we can show
$
sin x &= (2t)/(1+t^2) \
cos x &= (1-t^2)/(1+t^2) \
tan x &= (2t) /(1-t^2)
$

=== Common Substitutions

#tab2(
  [Denominator], [Substitution],
  $a^2+x^2$, $x=a tan theta$,
  $sqrt(a^2 - x^2)$, $x = a cos theta "or "x = a sin theta$,
  $sqrt(x^2 - a^2)$, $x = a cosh^2 theta$,
  $sqrt(x^2 + a^2)$, $x = a sinh^2 theta$,
  $a^2 - x^2$, [
    $x = a tanh^2 theta$ if $|x| < |a|$ #br
    $x = a cosh^2 theta$ if $|x| > |a|$
  ]
)

Use completing the square to deal with general quadratic denominators.

=== Integration by Parts

From the product rule.
$
d/dx (f g) &= f dg/dx + df/dx g \
f dg/dx &=d/dx (f g) - df/dx g \
int f dg/dx dx &= f g - int df/dx g space dx
$

=== Integration with Complex Numbers

The integral of complex valued functions has the same rules as integrate with real valued function.
$
int Re(f) space dx = Re(int f(x) space dx)
$

=== Odd and Even Functions

#defs(
  [
    - $f(x) = f(-x) iff "even function"$
    - $f(x) = -f(-x) iff "odd function"$
  ]
)

Using the area interpretation of an integral, we have
$
int^a_(-a) f(x) space dx &= 0 &"if" f "is odd" \
int^a_(-a) f(x) space dx &= 2 int^a_0 f(x) space dx quad & "if" f "is even"
$

#hr


=== Reduction Formulae

We could sometimes write an integral as a recurrence relation.
$
I_(2n) &= int^(pi/2)_0 sin^(2n) x space dx \
&=[sin^(2n-1)x dot (-cos x)]^(pi/2)_0 + int^(pi/2)_0 (2n-1)sin^(2n-2)x cos^2 x space dx \
&=(2n - 1)int^(pi/2)_0 sin^(2n-2)x (1 - sin^2 x) dx \
&=(2n - 1)(I_(2n-n) - I_(2n)) \
I_(2n) &= (2n - 1)/(2n)I_(2n-2) \
$
$
I_(2n)&=((2n-1)!!)/(2n!!)I_0
&=((2n-1)!!)/(2n!!) pi/2
$

#def([
  *Double factorials* $n!!$ multiplies only the even or odd terms less than or equal to $n$.
  $
  n!! = n(n-2)(n-4)cdots
  $
])

== Differentiation of Integrals

When we want to differentiate an integral where
- Boundaries depends on $q$, or
- The function depends on $q$.
Such as
$
I(q) = int^b(q)_a(q) f(x, q) dx
$

Since there are 3 objects that depends on $q$ : $a(q), b(q)$ and $f(x, q)$, so $I'(q)$ have at least 3 terms.

$
(d I)/(d q) = underbrace(int^b(q)_a(q) (partial)/(partial q) f(x, q) dx, "area gained" #br "from curve changing") + underbrace(f(b(q), q) (d b)/(d q), "area gained from" br b(q) "increasing") - underbrace(f(a(q), q)(d a)/(d q), "area lost from" br a(q) "increasing")
$

=== Partial Differentiation

Let $h(x, y)$, by treating $y$ as a constant
$
(partial h)/(partial x) = (h(x+delta x,y)-h(x,y))/(delta x)
$

We also define $(partial h)/(partial y)$, because there's no reason for the two derivatives to be related.

=== Chain Rule

Let $tilde(h)(s) = h(x(s), y(s))$, the change in $tilde(h)$ will be the combined effect of change in $x$ and $y$.
$
delta h = (partial h)/(partial x) delta x + (partial h)/(partial y) delta y
$
And we know
$
delta x = dx/(d s) delta s quad quad quad delta y = dy/(d s) delta s
$

The chain rule allows us to take the derivative without expanding out all terms.
$
(d h)/(d s) = (partial h)/(partial x) dx/(d s) + (partial h)/(partial y) dy/(d s)
$

=== Example: Gamma Function

$
int^infty_0 x^n e^(-x) space dx
$

Let $I(a) = int^infty_0 e^(-alpha x) dx = 1/a$

#grid2(width: 50%,
  $
  (d I)/(d alpha) &= int^infty_0 (partial)/(partial alpha) e^(-alpha x) dx \ 
  &=int^infty_0-x e^(-alpha x) dx \
  &= -1/alpha^2
  $,
  $
  (d^2 I)/(d alpha ^2) &= int^infty_0 (partial)/(partial alpha) (-x e^(-alpha x)) dx \
  &= int^infty_0 (partial)/(partial alpha)(x^2 e^(-alpha x)) dx \ 
  &= 2/alpha^3
  $
)

Therefore $int^infty_0 x^n e^(-alpha x) dx = n! slash alpha^n$. Set $alpha = 1$ to get the factorial function.
$
Gamma(n) = int^infty_0 x^(n-1)e^(-alpha x) dx = (n - 1)!
$

=== Example: Stirling's Approximation

Use integrals to approximate summation.
$
ln n! = sum_(k=1)^n ln k
$
If $k leq x leq k + 1$, then $ln k leq ln x leq ln(k+1)$.
$
sum_(k=1)^n ln k leq int^n_1 ln x space dx &leq sum_(k=1)^(n-1) ln(k+1) \
&= sum^n_(k=1) ln k \
&leq int^(n+1)_1 ln x space dx
$

Boundnig $sum^n_(k=1) ln k$ with the two integrals.
$
n ln n - n + 1 leq ln n! leq (n+1)ln(n+1) - (n+1) + 1
$

Taking the leading terms of the expressions
$
ln n! approx n ln n - n
$
#grid(
  $
  "We can show the fractional error" (ln n! - n ln n - n) / (n!) = O(1/n) "as" n to infty.
  $
)

#hr

=== Schwarz's Inequality

As we have seen for vectors, $arrow(p) dot arrow(q) = |arrow(p)||arrow(q)| cos theta$.
$
&imp (arrow(p) dot arrow(q))^2 leq arrow(p)^(space.thin 2) space arrow(q)^(space.thin 2) \
&imp (sum_(i) p_i times q_i)^2 leq (sum_i (p_i)^2)(sum_i (q_i)^2) "where" p, q "have components" p_1, p_2, dots
$

The general proof for vectors more than 2 components:
$
&imp Fa(lambda in bb(R)) sum_i^n (lambda p_i + q_i)^2 >= 0 \
&iff lambda^2(sum_i^n (p_i)^2) + 2lambda (sum_i^n p_i q_i) + (sum_i^n (q_i)^2) >= 0
$
This is a quadratic in $lambda$. Since $lambda$ has 0 or 1 root, the discriminant $b <= 4a c$
$
4(sum_i^n p_i q_i)^2 &<= 4 (sum_i^n (p_i)^2)(sum_i^n (q_i)^2) \
(sum_i^n p_i q_i delta s)^2 &<= (sum_i^n (p_i)^2 delta s)(sum_i^n (q_i)^2 delta s) \
$
This looks like the Riemann sum, we could write a proof for integrals only, or if we take $n to infty$.

$
(int^b_a p(x) q(x) dx)^2 &<= (int^b_a p(x)^2dx)(int^b_a q(x)^2 dx)
$

This is an inequality iff $p(x) prop q(x)$ - the vectors are in the same direction as each other.

== Multiple Integrals

We want to calculate the value under the surface $z=h(x, y)$

Similar to Riemann sums, divide the region into little boxes, the $i$th box has area $delta A_i$.
$
V_n &= sum^n_(i=1) h(x_i, y_i) delta A_i \
V &= int.two_A h(x, y) dA = lim_(n to infty) V_n
$

=== 2D Regions

For a rectangular region:
$
int.two_A h(x, y) dA &= int^(x=b)_(x=a) int^(y=d)_(y=c) h(x, y) space.sixth dy space.sixth dx \
&= int^(y=d)_(y=c) int^(x=b)_(x=a) h(x, y) space.sixth dx space.sixth dy
$

From the geometric interpretation of the integrals, the order does not matter.

For a region bounded by $y=f(x)$ below and $y=g(x)$ above.
$
V = int^(x=b)_(x=a) int^(y=f(x))_(y=g(x)) h(x, y) space.sixth dy space.sixth dx
$
We can change the order at which $x, y$ are if the new integral is easier to evaluate.

If we set $h(x, y) = 1$, then we get the area of the region by
$
A = int.two_A dA
$

=== Separating Integrand

If we can separate $f(x, y)$ as $g(x)h(y)$, where the bounds don't depend on $x$ or $y$ (a rectangle).
$
int^b_a int^d_c g(x) h(y) space.sixth dy space.sixth dx = (int^b_a g(x) dx)(int^d_c h(y) dy)
$
We can do this because $f(x) dx$ is a constant with respect to $y$, we can take it out using the constant multiple rule.
$
int k f(y) dy = k int f(y) dy
$

=== Polar Coordinates

Many regions have symmetry, it may be easier to write $h(r, theta)$ than $h(x, y)$.

$
x &= r cos theta \
y &= r sin theta
$

#grid2(
  [
    For a small change in $r$ and $theta$, a point moves by vector
    $
    d/dr vec(x, y) dr&= vec(cos theta, sin theta) dr\
    d/(d theta) vec(x, y) d theta &= vec(-r sin theta, r cos theta) d theta\
    $
  ],
  cetz.canvas({
    import cetz.draw : *

    line((0, 0), (4, 1), (3.7,  1.8), (0, 0))
    line((3.2, 1.58), (3.48, 0.85))
    line((3.54, 0.65), (4.1, 0.8), mark: (end: ">"))
    content((3.8, 0.3), $arrow(d r)$)
    line((4.2, 1.05), (3.9, 1.9), mark: (end: ">"))
    content((4.5, 1.5), $arrow(d theta)$)

    arc-through((1, 0.25), (1.01, 0.3), (0.945, 0.45))
  })
)

$dA$ is the area spanned by the two vectors. We can find $dA$ using the determinant.
$
dA = det mat(cos theta, -r sin theta; sin theta, r cos theta) space.sixth dr space.sixth d theta= r space.sixth dr space.sixth d theta
$
So we have
$
int.two_A f(r, theta) dA &= int.two_A f(r, theta) space.sixth r space.sixth dr space.sixth d theta
$

Then multiple integration can continue as normal.

=== Triple Integrals

By finding $dV$ using the matrices technique.

#tab2(
  [Coordinate system], [$dV$],
  [Cartesian coordinates], [$dx$ $dy$ $dz$],
  [Cylindrical polar coordinates], [$r$ $dr$ $d theta$ $dz$],
  [Spherical polar coordinates], [$r^2$ $sin theta$ $dr$ $d theta$ $d phi$]
)

#hr
