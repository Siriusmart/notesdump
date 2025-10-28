#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3"

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
    #h(1fr) _Hyperbolic Functions_
  ],
)

= Hyperbolic Functions

== Definitions

#grid(
  columns: (50%, 50%),
  [
    Similar to how
    $
    sin x &= (exp (i x) - exp (- i x))/(2i) \
    cos x &= (exp (i x) + exp (- i x))/2 \
    $
  ],
  [
    We have 
    $
    sinh x &= (exp (x) - exp (-x))/2 \
    cosh x &= (exp (x) + exp (-x))/2 \
    $
  ]
)

Also define the other hyperbolic functions:

#grid(
  columns: (50%, 50%),
  $
  tanh x &= (sinh x)/(cosh x) \
  sech x &= 1/(cosh x)
  $,
  $
  csch x &= 1/(sinh x) \
  coth x &= 1/(tanh x)
  $
)

#definition(title: "Note",
[
  We can see the relation between the circular trig and hyperbolic functions:
  $
  sin i x &= i sinh x \
  cos i x &= cosh x
  $
])

== Identities

$
cosh^2 x - sinh^2 x &= 1
$
$
sinh (A plus.minus B) &= sinh A cosh B plus.minus cosh A sinh B \
cosh (A plus.minus B) &= cosh A cosh B plus.minus sinh A sinh B \
tanh (A plus.minus B) &= (tanh A plus.minus tanh B) / (1 plus.minus tanh A tanh B)
$

These facts can be deplus.minuscircular trig identies using the relation mentioned above.

$
1 - tanh ^2 x &= sech ^2 x \
coth ^2 x - 1 &= csch ^2 x
$

== Graphing Hyperbolic Functions

#cetz.canvas({
  import cetz.draw : *

  set-style(axes: (stroke: .5pt, tick: (stroke: .5pt)), legend: (stroke: none, orientation: ttb, item: (spacing: .3), scale: 80%))

  cetz-plot.plot.plot(size: (12, 6.1),
      x-tick-step: 2,
      y-tick-step: 2, y-min: -10, y-max: 10,
      legend: "inner-north",
      {

      let fn = (
        ($ x - x^3"/"3! $, x => x - calc.pow(x, 3)/6),
        ($ x - x^3"/"3! - x^5"/"5! $, x => x - calc.pow(x, 3)/6 + calc.pow(x, 5)/120),
        ($ x - x^3"/"3! - x^5"/"5! - x^7"/"7! $, x => x - calc.pow(x, 3)/6 + calc.pow(x, 5)/120 - calc.pow(x, 7)/5040),
      )

        let domain = (-5, 5)

        cetz-plot.plot.add(calc.sinh, domain: domain, label: $ sinh x $)
        cetz-plot.plot.add(calc.cosh, domain: domain, label: $ cosh x $)
        cetz-plot.plot.add(calc.tanh, domain: domain, label: $ tanh x $)
      })
})

- $cosh$ is symmetric, $sinh$ and $tanh$ are odd, this is similar to their circular trig equivalent.
- $cosh x > sinh x$ for all values of $x$ because $exp (-x)$ is always positive.

== Inverse Hyperbolic Functions

With the example $y = sinh^(-1) x$, we can solve for $sinh y = x$ from definiton.
$
sinh^(-1) x &= ln (x + sqrt(x^2 + 1)) \
cosh^(-1) x &= ln (x plus.minus sqrt(x^2 - 1)) \
tanh^(-1) x &= 1/2 ln((1+x)/(1-x))
$

- $sinh$ is one-to-one, so its inverse is single valued.
- It is immediately obvious that $cosh$ has two roots.

=== Circular Trig Roots from Inverse Hyperbolic Functions

The log of a complex number has infinitely many solutions.
- $sinh$ has 1 solution.
- $sin$ has infinitely many solutins.

To find all roots of $cos z = 2$ where $z = x + i y$.
$
cos (x + i y) &= cos x cos i y - sin x sin i y \
&= cos x cosh y - i sin x sinh y
$

For $cos z = 2$, we need $cos x cosh y = 2$ and $sin x sinh y = 0$.
- Either $y = 0$, but then requires $cos x = 2$ which is impossible.
- Or $x = n pi$, then $cos n pi cosh y = 2$. Since $cosh$ is positive, $n$ must be even so $cos n pi = 1$.
$
x &= n pi \
y &= ln(2 plus.minus sqrt(x ^2 - 1))
$
Where roots $z$ are all $z = x + i y$.

== Circles

#definition([
  A *circle* is the set of all points equal distance $r$ from the origin.
])

$
x^2 + y^2 = r^2
$

Moving the origin to $(x_0, y_0)$:
$
(x - x_0)^2 + (y - y_0)^2 = r ^ 2
$

We can also express in an alternate form, we can find the centre of a circle in that form by completing the square. A circle requires $r^2 > 0$.
$
x^2 + a x + y^2 + b y + c &= 0 \
(x + a/2)^2 + (y + b/2)^2 &= (a/2)^2 + (b/2)^2 - c
$

We can also express as parameters which are functions of $theta in [0, 2 pi]$.
$
x &= x_0 + r cos theta \
y &= y_0 + r sin theta
$

Replacing the circular trig functions with their hyperbolic equivalent will give a hyperbola.

=== Elipses

#grid(
  columns: (50%, 50%),
  [
    Generalise the circle formula:
    $
    (x/r)^2+(y/r)^2 = 1
    $
  ],
  [
    So an elipse with semiaxes $a$ and $b$:
    $
    (x/a)^2+(y/b)^2 = 1
    $
  ]
)
- The larger of $a$ and $b$ is the *semi major axis*.
- The smaller of $a$ and $b$ is the *semi minor axis*.

The general form of an elipse where the axis are not vertical or horizontal is
$
a x^2 + b x y + c y ^2 + d x + e y + f = 0
$

==== Eliptical Area

Since an elipse is a stretched circle
$
A = pi a b
$

#definition(title: "Note", [
  The circumference of the elipse is not $pi (a + b)$, it would require the epliptical integral which is pretty nasty.
])

=== The Hyperbola

Swiching the sign in the equation of a circle:
$
x^2 - y^2 &= s^2 \
y &= plus.minus sqrt(x^2 - s^2)
$

Would be real if $|x| > |s|$.

The parameters of the hyperbola are the hyperbolic functions, similar to how a circle can be parametised using circular trig functions.
$
x^2 - y^2 = s^2 cosh^2 theta - s^2 sinh^2 theta = s^2
$

== Identifying Shapes

To identify what is an equation in form $a x^2 + b x + c y ^2 + d y + e = 0$.

First complete the square:
$
a(x - x_0)^2 + c(y - y_0)^2 = f
$

- Circle if $a = c$ and $a$ has the same sign as $f$. ($a slash f > 0$)
- Elipse if $a eq.not c$.
- Hyperbola if $a$ different sign as $c$.

#line(length: 100%)
#align(center, `END Hyperbolic Functions`)
