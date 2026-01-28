#import "@local/lecture:0.1.0" : *

= Ordinary Differential Equations

#def([
  An *$n$th order ODE* includes the $n$th derivate but no higher derivatives.
])

To solve an ODE we find the dependent variable as a function of the independent variables.
- In the real world: this is done numerically with computers.
- Here we do it analytically to demonstrate principles.

Some ODEs don't have analytical solutions.

== First Order ODEs

#grid2(
  def([
    *Integrable ODEs* have form
    $
    dy/dx = f(x)
    $
    where the RHS does not depend on $y$.
  ]),
  [
    $
    y = int fx dx
    $

    If $F'(x) = f(x)$, then $y = F(x) + C$. $y$ solves the ODE whatever $C$ is - threr are infinitely many solutions.

    $(*)$ is called the *general solution* if it contains all possible solutions.
  ]
)

If we choose any value for $C$, we get a particular solution.

#grid2(
  def([
    *Separable ODEs* have form
    $
    dy/dx = f(x)/(g(y))
    $
  ]),
  [
    $
    g(y) space dy/dx &= f(x) \
    int g(y) space dy/dx dx &= int f(x) dx \
    int g(y) dy &= int f(x) dx \
    G(y) &= F(x) + C
    $
  ]
)

=== Geometric Interpretation of First Order ODEs

Consider $dy/dx = F(x, y)$

For every point $(x, y)$:
- There is a particular solution passing through the point
- Its gradient is $F(x, y$)

#note([
  2 particular solutions don't have to be the same shape (shifted versions) of each other.
])

#hr

=== Linear ODE

$
dy/dx + y dot p(x) = f(x)
$
When $f(x) = 0$, the ODE is homogenous, two ways to solve it

#grid2(width: 50%,
  $
  dy/dx &= -y dot p(x) \
  int 1/y dy &= -int p(x) dx \
  y &= A e^(-P(x))
  $,
  $
  e^P(x) dot dy/dx + p(x) dot e^P(x) dot y &= 0 \ 
  d/dx (e^P(x) dot y) &= 0 \
  y&= A e^(-P(x))
  $
)

#note([
  $e^(int p(x) space dx)$ is called the integrating factor.
])

For inhomogenous cases, multiply both sides by the integrating factor.
$
e^P(x) dot dy/dx + p(x) dot e^P(x) dot y &= f(x) \
d/dx (e^P(x) dot y) &= f(x) \
e^P(x) dot y &= F(x) + C \
y &= (F(x) + C)e^(-P(x))
$

#def([
  $n$th order ODE contains $n$ arbitrary constants: $n$ pieces of informations to fix them. The extra information are called *boundary conditions*.

  #note([
    A *particular solution* has no unknown constants or $pm$ signs.
  ])
])

=== Substitutions

$
dy/dx = f(y/x)
$

$
"let" u(x) &= y(x)/x \
x dot u(x) &= y(x) \
u + x dot du/dx &= dy/dx
$

For example
$
dy/dx &= (x^2+y^2)/(x y) \ 
&= ((x slash y)^2 + 1)/(x slash y) \
u + x dot du/dx &= (u^2 + 1)/u \
x dot du/dx &= 1/u \
&vdots
$

=== Benoulli Equations

$
dy/dx + p(x) dot y = q(x) dot y^n
$

If $y=0$ or $y=1$, then the equation is homogenous, otherwise
$
"let" z(x) &= y(x)^(1-n) \
dz/dx &= (1-n) dot y(x)^(-n) dot dy/dx \
1/(1-n) dot dz/dx dot y(x)^n &= dy/dx \
1/(1-n) dot dz/dx dot y^n + p(x) dot y &= q(x) dot y^n \
1/(1-n) dot dz/dx + p(x) dot y^(1-n) &= q(x) \
dz/dx + (1-n) dot p(x) dot z &= (1-n) dot q(x) \
& vdots
$

#hr

== 2nd Order ODE

We consider linear cases only: the ODE can be written as $L y = f$.

$L$ is the *differential operator*
$
L = [d^2/dx^2 + p(x) d/dx + q(x)]
$
Similar to how $d slash dx$ is an operator on functions.

#def([
  A *linear operator* has properties:
  - $L(alpha u) = alpha L(u)$
  - $L(u + v) = L(u) + L(v)$

  #note([
    $d/dx$ is a linear operator.
  ])
])

The differential operator is a linear operator that includes $d^n/dx^n$.

#def([
  A *linear ODE* can be written as $L y = f$ where $L$ is a linear operator.
  - $f = 0 :$ homogeneous
  - $f != 0 :$ inhomogenous
])

=== The Principle of Superposition

If $y_1$ and $y_2$ are particular solutions of a homogeneous ODE
- Then so is $y_1 + y_2$
- And so is $alpha y_1 + beta y_2$ for any $alpha, beta in complex$

If:
- The *particular integral* $y_p$ solves an inhomogenous linear ODE, and
- The *complementary function* $y_c$ is the general solution of the homogeneous equation of the complementary ODE

Then the general solution is $y = y_p + y_c$

#hr
