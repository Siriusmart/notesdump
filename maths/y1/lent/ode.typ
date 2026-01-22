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
