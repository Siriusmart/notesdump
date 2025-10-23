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

= Complex Numbers

== The Chain of Generalisation

#table(
  columns: (auto, auto),
  table.header([*Number set*], [*Description*]),
  [Counting numbers], [For counting objects.],
  [Natural numbers], [Counting numbers and 0, took 3000 years the realise that it is useful.],
  [Integers], [Natural numbers with negative integers. The negation of any two integer is also an integer.],
  [Rational numbers], [Any number that can be written as a ratio of two integers. It is not continuous, but there are infinitely many of them.],
  [Irrational numbers], [Numbers that cannot be expressed as a ratio of two numbers, some of them are solutions to equations.],
  [Real number], [Union of rational and irrationals.],
  [Complex numbers], [Many calculations are much easier in complex numbers. Many functions in physics are functions over complex numbers.]
)

=== Negative Square Roots in Equations
The formula for $t^3+p t+q=0$ is given by
$
t = root(3, -q/2+sqrt(q^2/4+p^3/27)) + root(3, -q/2-sqrt(q^2/4+p^3/27))
$
- If the term inside the square root $<0$, it will give a negative square root.
- But we know the cubic function has at least 1 real root, negative square roots are needed to find the real root of a cubic.

#definition([
  The *fundamental theorem of algebra*:
  $
  a_0 + a_1 x + a_2 x^2 + dots + a_m x^m = 0
  $
  Always have $m$ roots.
])

And you can factor like $c(x-x_0)(x-x_1) dots (x - x_m)=0$, which requires complex numbers.

== Properties of Complex Numbers

Define $i^2 = -1$. There are two roots for $i$, it doesn't matter which one you pick they will work the same, you just have to be consistent with that choice.


#definition([
  $
  i = sqrt(-1)
  $
])

=== Complex Numbers

We can write $z = x + i y in bb(C)$, where $x, y in bb(R)$. Every complex number has a tuple attached to it.
- $"Re"(z)=Re(z)=x$
- $"Im"(z)=Im(z)=y$

=== Properties of Complex Numbers

Let $z_1 = a + i b$ and $z_2 = c + i d$.
- $z_1 = z_2 arrow.l.r.double.long a = c "and" b = d$

We can represent complex numbers as points in 2D space in an *Argand diagram*. We can work with them the same as we worked with vectors. See the vector properties:
- Add commutative: $z_1 + z_2 = z_2 + z_1$
- Add associative: $z_1 + (z_2 + z_3) = (z_1 + z_2) + z_3$

And multiplication is also commutative, associative and distributive over addition. It does not always have an inverse (e.g. when $z=0$).

$
(a + i b)(c + i d) = (a c - b d) + i(a d + b c)
$

=== Modulus and Argument
- $r = |z|$ be the distance from the origin.
- $theta = arg(z)$ be the angle between $z$ and the x-axis.

#definition([
  The *principal argument* is $arg(z)$ restricted to $[-pi, pi]$.
])

Note $tan$ does not uniquely define $arg(z)$.

==== Multiplication in Modulus and Argument Form

$
z &= |z|(cos theta + i sin theta) \
|z_1z_2|&=|z_1||z_2| \
arg(z_1 z_2) &= arg(z_1) + arg(z_2)
$

#definition([
  The *complex conjugate* $z^* = x - i y$ when $z = x + i y$.
])

This gives an easy way to calculate the modulus $z z^* = |z|^2$.

=== Division

To express $z_1 div z_2$ in format $a + i b$
$
z_1/z_2 &= z_1/z_2 dot z_2^(*)/z_2^(*) \
&=(z_1z_2^(*))/(|z_2|^2)
$

== Exponential Form

We have not define the exponential function yet, for now we will use this as definition
#definition([
  $
  e^(i theta) = cos theta + i sin theta
  $
])

$
e^a + e^b &= e^(a + b) \
(cos theta_1 + i sin theta_1)(cos theta_2 + i sin theta_2) &= cos (theta_1 + theta_2) + i sin (theta_1 + theta_2)
$

This is why complex numbers are so often used, they are really convenient to multiply.

Note that the exponential form is not unique, $e^(i theta)=e^(i (theta + 2 pi))$

=== Roots of Unity

Solve for $z^4 = 1$
$
z &= r e^(i theta) \
z^4 &= r^4 e^(4 i theta) \
$

So $4 theta = 2 pi m$ where $m in bb(Z)$, so $theta = (pi m)/2$
$
z = e^((i pi m)/2)
$
Which gives 4 solutions according to the fundamental theorem of algebra.

#line(length: 100%)

== DeMoivre's Theorem

Using the exponent form of complex numbers:
$
z^n &= exp(i theta)^n \
&= exp(n i theta) \
cos n theta + i sin n theta &= (cos theta + i sin theta)^n
$

=== Complex Conjugate using DeMoivre's

We can also use DeMoivre's theorem to take the complex conjugate of $z$.
$
exp(-i theta) = cos theta - i sin theta
$
Yielding identities:
$
cos theta &= 1/ 2(exp(i theta) + exp(-i theta)) \
sin theta &= 1/ (2i)(exp(i theta) - exp(-i theta))
$

We can also express $cos^3 theta$ in terms of $cos 3 theta$ and $cos 3 theta$, or $cos 4 theta$ in terms of $cos ^ 4 theta$ and $cos ^2 theta$.

=== Sum Series

We can work out the sum of trigonometric functions.
$
sum^(N - 1)_(N=0) cos k theta = Re[sum^(N - 1)_(N=0) exp(k i theta)]
$

Then we can use the geometric sum formula.

== Complex Logarithms

#definition([
  *$ln$* is the inverse of the *$exp$* function.
  $
  exp(ln z) = z
  $
])

$
ln z &= ln(|z|exp(i(theta + 2 pi n))) \
&= ln(|z|) + i(theta + 2 pi n)
$

The log of a complex number is *multivalued*, there are infinitely many solutions. This is similar to how taking the root of natural nubmers give 2 solutions.

#definition([
  The *principal value* is the root closest to the $x$-axis.
])

=== General Power of $z_1^(z_2)$

- Let $z_1 = |z_1|exp(i theta)$
- Let $z_2 = x + i y$
$
z_1 &= exp(z_2 ln z_1) \
&=exp(z_2 (ln|z_1| + i(theta + 2 pi n))) \
&=exp((x + i y) (ln|z_1| + i(theta + 2 pi n))) \
&=exp(x ln|z_1| - y(theta + 2 pi n) + i(y ln|z_1|+x(theta + 2 pi n))) \
&=(|z_1|^x)/exp(y(theta + 2 pi n))dot exp(i(y ln |z_1| + x(theta + 2 pi n)))
$

We can substitute any $z_2 in bb(Q)$ to show it is the expected behaviour.

== Applications of Complex Numbers

Used in problems that involve oscillatory/periodic motion.

E.g. a pendulum about the vertical
$
x(t) &= a cos omega t + b sin omega t \
&= Re(A exp i omega t)
$

The big advantage is that taking derivatives of the exponential function is very easy.
$
v(t) &= d / (d x)Re(exp i omega t) \
&= Re(d / (d x)exp i omega t) \
$

We can easily fix it to an initial condition to find a particular solution.

== Fundamental Theorem of Algebra (The Sequel)

#definition([
A polynomial of $n$ degree where $a_i in bb(C)$ has $n$ complex roots (possibly repeated).
], title: "Theorem")

If $P(z)$ is a function of $n$ degrees, then $P(z) = (z - z_1)Q(z)$ where $Q$ a function of $n-1$ degrees.

We can prove by induction (?) that there is at least one route $(z - z_1)(z - z_2) dots R(z) = 0$.

#line(length: 100%)

#align(center)[
  `END Complex Numbers`
]
