#import "@local/lecture:0.1.0" : *

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
