#import "@local/lecture:0.1.0" : *

= Multivariable Differential Equations

== Partial Derivatives

For $f = f(x, y)$
$
(partial f)/(partial x) &= lim_(h to 0) (f(x+h, y) - f(x,y))/h \
(partial f)/(partial y) &= lim_(h to 0) (f(x, y+h) - f(x, y))/h
$

Are the gradients of $f$ if we travel along the $x$ or $y$ direction.

For functions of more variables, you can calculate $partial f slash partial x$ by treating all other variables as constants.

=== Higher Derivatives

There are four 2nd order partial derivatives for a function $f(x, y)$

$
(partial^2 f)/(partial x)^2 &= partial/(partial x) ((partial f)/(partial x)) \
(partial^2 f)/(partial x partial y) &= partial/(partial x) ((partial f)/(partial y)) \
(partial^2 f)/(partial y partial x) &= partial/(partial y) ((partial f)/(partial x)) \
(partial^2 f)/(partial y)^2 &= partial / (partial y) ((partial f)/(partial y))
$

For any well defined function
$
(partial^2 f)/(partial x partial y) &= (partial^2 f)/ (partial y partial x)
$

For $f(x_1, x_2, x_3, dots, x_n)$, the gradient of $f$ is a vector.
$
gradient f = ((partial f)/(partial x_1), (partial f)/(partial x_2), (partial f)/(partial x_3), dots , (partial f)/(partial x_n))
$

#hr

== Partial Differentials

*Integration* is the opposite of differentiation.

$
(partial f)/(partial x) &= 2x y^2 quad "holding" y "constant" \
f(x, y) &= x^2y^2 + G(y) \
(partial f)/(partial y) &= 2x^2y + 2y quad "holding" x "constant" \
f(x, y) &= x^2y^2 + y^2 + H(x) \
therefore f(x, y) &= x^2y^2 + y^2 + C
$

There may be no $f(x, y)$ satisfying $partial f slash partial x$ and $partial f slash partial y$, for examples those that leads to
$
(partial ^2 f)/(partial y partial x) != (partial ^2 f)/(partial x partial y)
$

*Taylor series* of $f$ centred at $(x, y)$, all partial derivatives are evaluated at $(x_0, y_0)$
$
f(x_0+k,y_0+k) =&f(x_0,y_0) + (h (partial f)/(partial x) + y (partial f)/(partial y)) \
&+1/2!(h^2 (partial^2 f)/(partial x^2) + 2 h k (partial ^2 f)/(partial x partial y) + k^2 (partial^2 f)/(partial y^2)) + dots
$
The *linear approximation* of $f$
$
f(x_0+h, y_0+k) approx f(x_0, y_0) + h (partial f)/(partial x) + k (partial f)/(partial y)
$

For very small change in $x$ and $y$
$
d f = (partial f)/(partial x) d x + (partial f)/(partial y) d y
$

#hr

== Chain Rule

Consider
$
df &= (partial f)/(partial u) du + (partial f)/(partial v) dv \
du &= (partial u)/(partial x) dx + (partial u)/(partial y) dy \
dv &= (partial v)/(partial x) dx + (partial v)/(partial y) dy
$

Then
$
df &= ((partial f)/(partial u) (partial u)/(partial x) + (partial f)/(partial v) (partial v)/(partial x)) dx + ((partial f)/(partial u) (partial u)/(partial y) + (partial f)/(partial v) (partial v)/(partial y)) dy \
(partial f)/(partial x) &= (partial f)/(partial u) (partial u)/(partial x) + (partial f)/(partial v) (partial v)/(partial x) \
(partial f)/(partial y) &= (partial f)/(partial u) (partial u)/(partial y) + (partial f)/(partial v) (partial v)/(partial y)
$

== Reciprocity and Cyclic Relations

Let $z(x,y)$

$
dz &= (partial z)/(partial x) dx + (partial z)/(partial y) dy quad quad &(1)\
dx &= (partial x)/(partial y) dy + (partial x)/(partial z) dz &(2)\
dy &= (partial y)/(partial z) dz + (partial y)/(partial x) dx &(3)\
$
Rewrite $(2)$
$
dz &=1/(((partial x)/(partial z))) dx - (((partial x)/(partial y)))/(((partial x)/(partial z)))dy
$
Comparing coefficients of $dx$ and $dy$ with $(1)$
$
(partial z)/(partial x) &= 1/(((partial x)/(partial z))) \
(partial z)/(partial y) &= -(((partial x)/(partial y)))/(((partial x)/(partial z))) \
(partial z)/(partial y) (partial x)/(partial z) &= -(partial x)/(partial y) \
(partial z)/(partial y) (partial x)/(partial z) (partial y)/(partial x) &= -1
$

The last three lines are called the *cyclic relation* for partial derivatives.

#hr

== Exact Differentials

#def([
  If there exist a function $f(x, y)$ such that
  $
  df = P(x, y) dx + Q(x, y) dy
  $
  then $P(x, y) dx + Q(x, y) dy$ is an *exact differential*.
])

$
d f &= (partial f)/(partial x) dx + (partial f)/(partial y) dy \
$
Since $(partial^2 f) / (partial x partial y) = (partial^2 f) / (partial y partial x) $
$
P(x, y) dx + Q(x, y) dy "is an exact differential" iff (partial P)/(partial y) = (partial Q)/(partial x)
$

=== Solving ODEs with Exact Differentials

$
dy/dx &= -(P(x,y))/(Q(x,y)) \
df &= P(x,y)dx + Q(x,y)dy &= 0 \
f(x,y) &= C
$
You will need to solve for $f(x,y)$ yourself, using the fact that
$
P=(partial f)/(partial x) "and" Q = (partial f)/(partial y)
$

=== Integrating Factors for Inexact Differentials

In case $P(x,y)dx + Q(x,y)dy$ is not an exact differential, there may be a function $mu(x,y)$ such that
$
mu(x,y)[P(x,y)dx + Q(x,y)dy]
$
is an exact differential.

This requires
$
partial/(partial y)(mu P) = partial/(partial x)(mu Q)
$

#hr

== Stationary Points

For a function of two variables $f(x,y)$
$
nabla f = ((partial f)/(partial x), (partial f)/(partial y))
$

Let $bold(x) = (x, y)$

$
f(bold(x)) &= f(bold(x)_0) + (bold(x) - bold(x)_0) dot nabla f(x) + cdots \
df &= (nabla f) dot d bold(x)
$

So $bold(x)$ is a stationary point if any of the equivalent statement is true at $bold(x)$
- $nabla f(bold(x)) = 0$, or
- $df = 0$, or
- $partial f slash partial x = 0 and  partial f slash partial y = 0$

#tab3(
  [Form], [Type of stationary point], [Property],
  $f = (x-x_0)^2 + (y-y_0)^2$, "Minimum", "Curvature positive in all directions.",
  $f = -(x-x_0)^2 - (y-y_0)^2$, "Maximum", "Curvature negative in all directions.",
  $f = (x-x_0)^2 - (y-y_0)^2$, "Saddle point", "Curvature sign depends on direction."
)

#note([
  *Contour lines* form ellipses around maximum/minimum, and cross at saddle point.
])

=== Hessian Matrix

Define the symbols $(delta x, delta y) = (x - x_0, y - y_0)$
#grid2(
  $
  H_(x x) &= (partial^2 f)/(partial x^2) \
  H_(y x) &= (partial^2 f)/(partial x partial y) \
  $,
  $
  H_(x y) &= (partial^2 f)/(partial y partial x) \
  H_(y y) &= (partial^2 f)/(partial y^2)
  $
)

Let $D = H_(x x) H_(y y) < (H_(x y))^2$

At a stationary point
$
f(x, y) - f(x_0, y_0) &= 1/2 (H_(x x) delta x^2 + 2 H_(x y) delta x delta y + H_(y y) delta y^2) \
&= 1/(2 H_(x x))((H_(x x))^2 delta x^2 + 2 H_(x x)H_(x y) delta x delta y + H_(x x)H_(y y) delta y^2) \
&= 1/(2 H_(x x))((H_(x x) delta x + H_(x y) delta y)^2 + (H_(x x)H_(y y) - (H_(x y))^2)delta y^2)
$
- Case $H_(x x) >0$ and $D > 0$, RHS positive so is a minimum.
- Case $H_(x x) <0$ and $D > 0$, RHS negative so is a maximum.
  #note([
    When $D > 0 : (H_(x x) > 0  iff H_(y y) > 0)$
  ])
- Case $D < 0$
  - Moving in direction of $y$ makes the 1st term disappear
  - Moving in direction of $x$ makes the 2nd term disappear
  So it is a *saddle point*.

#hr
