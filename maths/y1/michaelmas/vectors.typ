#import "@preview/cetz:0.4.2"

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
    #h(1fr) _Vectors_
  ],
)

= Vectors
== Basic Definitions
#definition([
  - A *scalar* is a real value: $"value" in bb(R)$
  - A *vector* has a magnitude and direction: $"magnitude" times "direction"$
  - A *position vector* gives position relative to origin.
  - A *displacement vector* gives the relation between two points.
  - *Euclidean space* is where the shortest path between any two points is a straight line,
    and parallel lines are possible.
], title: "Definitions")

Vectors can have up to $infinity$ dimensions (used in quantum mechanics), this course focuses on vectors in 3 dimensions.

=== Notation
#table(
  columns: (auto, auto),
  table.header([*Vector type*], [*Notation*]),
  [ Displacement vector ],
    $arrow(A B)$,
    [ Position vector ],
    $arrow(O A)$,
    [ Magnitude vector],
    $|bold(v)|$,
    [ Unit vector ],
    $hat(bold(v))$
)

#definition([
  The unit vector $hat(bold(v))$ is a vector of unit length in the direction of $bold(v)$.
  $
  hat(bold(v))=bold(v)/(|bold(v)|)
  $
])

The 3D Euclidean space has 3 components, so 3 numbers are required to specify the vector.
$
bold(v) = (v_x, v_y, v_z)
$
The components also depends on the axes chosen.

=== Basic Vector Operations
- $bold(a) + bold(b)$ adds their geometric displacement.
- $lambda dot bold(v)$ where $lambda in bb(R)$ gives a vector that is:
  - Parallel to the original vector.
  - The length is scaled by $lambda$

== Vector Properties

- Vector addition is *commutative*: $bold(a) + bold(b) = bold(b) + bold(a)$
- Vector addition is *associative*: $(bold(a) + bold(b)) + bold(c) = bold(a) + (bold(b) + bold(c))$
- Vector multiplication is *distributive*: $lambda dot (bold(a) + bold(b)) = lambda dot bold(a) + lambda dot bold(b)$

This are non-trivial properties! Group theory studies these properties. Vector subtraction for example, is not associative.

== Coordinate Systems

For vector components, we need to know the orientation of axes, but not the location of the origin.

#definition([
  A *coordinate system* is a selection of terminal axes:
  - Axes of unit length
  - An origin
])

=== The Cartesian Coordinate System

Axes are *mutually perpendicular*.

By convension we use a *right-handed coordinate system*.
- There are two ways of defining a Cartesian coordinate system.
- We use the right hand as a convension so the coordinate is uniquely defined.
- $hat(bold(i))$, $hat(bold(j))$ and $hat(bold(k))$ are in the direction of the 1st, 2nd and 3rd finger of the right hand.
- Emanate for fixed origin $O$.

The coordinate of a point $P$ relative to the axes are denoted by the *length of the projections* of the vector $arrow(O P)$ onto the 3 axes, written in form $arrow(O P)=(x, y, z)$.

The *magnitude* is given by Pythagoras' theorem:
$
|bold(r)| = sqrt(x^2 + y^2 + z^2)
$

The distance between two points is given by $|bold(r_1) - bold(r_2)|$

=== Basis Vectors

The basis vectors $bold(i)$, $bold(j)$ and $bold(k)$ *spans* the space because it provides a way of accessing every point.

== Equations of a Line

Our goal is to parameterise all the points on a line.
- Take $bold(a)$ as a *reference vector*.
- The point is a scalar multiple of the direction vector $hat(bold(u)) = (bold(b) - bold(a))/(|bold(b) - bold(a)|)$
$
bold(r)=bold(a)+lambda|bold(b)-bold(a)|(bold(b)-bold(a))/(|bold(b)-bold(a)|)=bold(a)+lambda hat(bold(t))
$
where $hat(bold(t))$ is the unit vector in the direction of $bold(b) - bold(a)$.

=== Component Form

$
bold(r)=(x, y, z)=(a_x+lambda(b_x-a_x), a_y+lambda(b_y-a_y), a_z+lambda(b_z-a_z))
$

Rearrange to give
$
lambda = (x-a_x)/(b_x-a_x) = (y-a_y)/(b_y-a_y) = (z-a_z)/(b_z-a_z)
$

#line(length: 100%)

== The Scalar Product

Given two vectors $bold(a)$, $bold(b)$, there are different ways of taking the product.
- $bold(a) dot bold(b) in bb(R)$
- $bold(a) dot bold(b) in "pseudovector"$
- $bold(a) times.circle bold(b)$ - the tensor product: two vectors of dimension $m$ and $n$ gives a vector of dimension $m times n$

#definition([
  $bold(a) dot bold(b) = |bold(a)| dot |bold(b)| dot cos theta$
])

=== Scalar Product Properties
- Commutative: $bold(a) dot bold(b) = bold(b) dot bold(a)$
- Distributive: $bold(a) dot (bold(b) + bold(c)) = bold(a) dot bold(b) + bold(a) dot bold(c)$
- $bold(a) dot bold(a) = |bold(a)|^2$
- $bold(a) dot bold(0) = 0$

==== Proof of Cosine Rule

Consider a triangle of with sides represented by vector $bold(a)$, $bold(b)$ and $bold(c) = bold(a) - bold(b)$
$
|bold(c)|^2 &= |bold(a)|^2 + |bold(b)|^2 - 2|bold(a)||bold(b)| cos theta \
|bold(a) - bold(b)|^2 &= |bold(a)|^2 + |bold(b)|^2 - 2 dot bold(a) dot bold(b) \
(bold(a) - bold(b)) dot (bold(a) - bold(b)) &= bold(a) dot bold(a) + bold(b) dot bold(b) - 2 dot bold(a) dot bold(b) quad "(true by distributivity)"
$

=== Scalar Product for Cartesian Vectors

Product for vectors are 0 if they are orthogonal to each other.
- $bold(a) = a_x hat(bold(i)) + a_y hat(bold(j)) + a_z hat(bold(k))$
- $bold(b) = b_x hat(bold(i)) + b_y hat(bold(j)) + b_z hat(bold(k))$

Since most terms evaluates to 0.
$
bold(a) dot bold(b) =& a_x hat(bold(i)) dot b_x hat(bold(i)) + a_x hat(bold(i)) dot b_y hat(bold(j)) + a_x hat(bold(i)) dot b_z hat(bold(k)) \
& + a_y hat(bold(j)) dot b_x hat(bold(i)) + a_y hat(bold(j)) dot b_y hat(bold(j)) + a_y hat(bold(j)) dot b_z hat(bold(k)) \
& + a_z hat(bold(k)) dot b_x hat(bold(i)) + a_z hat(bold(k)) dot b_y hat(bold(j)) + a_z hat(bold(k)) dot b_z hat(bold(k)) \
=& a_x b_x + a_y b_y + a_z c_z
$

=== Component Vector in Direction

The scalar product projects a vector onto another vector: $hat(bold(b)) dot (bold(a) dot bold(b))$ projects $bold(a)$ to $bold(b)$.

This is useful for changing the coordinate system: _what is the component in an axis?_

== Equation of a Plane

=== Normal + Point/Distance

We need a vector orthogonal to the plane $bold(n)$, as there is only one direction that is orthogonal to the plane.
If we know one point $A$ on the plane, then the plane is *uniquely specified*.

Let $bold(r)$ be a point on the plane.
$
r in "plane" & arrow.l.r.double.long (bold(r) - bold(a)) perp bold(n) \
& arrow.l.r.double.long (bold(r) - bold(a)) dot bold(n) = 0 \
& arrow.l.r.double.long bold(r) dot hat(bold(n)) = p
$

=== Three Reference Points

If we know reference points $A$, $B$ and $C$ on the plane, where they are not colinear.
- $arrow(A B)$ and $arrow(A C)$ must be entirely within the plane.
- The plane is any point that can be represented as a linear combination of the two vectors.

The plane is given by
$
bold(r) - bold(a) = mu (bold(b) - bold(a)) + nu (bold(b) - bold(a))
$

The plane is therefore entirely specified by giving 3 points.

#line(length: 100%)

== Equation of Other Objects

The goal is the parameterise every point on the surface of the object.
For each parameterisation you can change the center by setting $bold(r') = bold(r) - bold(a)$.

=== Sphere
Defining property: all points are a fixed distance away from the center.
$
|bold(r)| = rho
$
=== Cylinder
Defining property: all points are $R$ away from the centre line.
- A vector $bold(r)$ is projected to $hat(bold(n))$ at $(bold(r) dot hat(bold(n))) dot hat(bold(n))$
- The vector from $bold(r)$ to the projected vector is $bold(r) - (bold(r) dot hat(bold(n))) dot hat(bold(n))$

So the equation is
$
|bold(r) - (bold(r) dot hat(bold(n))) dot hat(bold(n))| = R
$

=== Cone
Defining property: take any point $A$ on the cylinder given by $bold(r)$, the angle between $arrow(O A)$ and $bold(n)$ is $theta$.
$
bold(r) dot hat(bold(n)) = |bold(r)| cos theta
$

== The Vector Product

The vector product is an easy formula to calculate the normal of the plane.
$
bold(a) and bold(b) = "pseudovector"
$
Also denoted $bold(a) times bold(b)$.

#definition([
  $bold(a) and bold(b) = |bold(a)||bold(b)| sin theta dot hat(bold(m))$

  where $hat(bold(m))$  is the unit vector orthogonal to both $bold(a)$ and $bold(b)$.
])

We use the *right-handed system* so the vector is uniquely defined: $bold(a)$, $bold(b)$ and $bold(a) and bold(b)$ are the direction of the first, second and third finger.

=== Properties
- Distributive: $bold(a) and (bold(b) + bold(c)) = bold(a) and bold(b) + bold(a) and bold(c)$
- If $bold(a) perp bold(b)$, then $|bold(a) and bold(b)| = |bold(a)||bold(b)|$ by definition, similar for $bold(a) parallel bold(b) arrow.double.long |bold(a) and bold(b)| = 0$

But it is *not*
- Commutative: $bold(a) and bold(b) = - bold(b) and bold(a)$, this is called *anti-commutative*.
- Associative: $bold(a) and (bold(b) and bold(c))$ is orthogonal to $bold(a)$, but $(bold(a) and bold(b)) and bold(c)$ is not.

=== Vector Product and the Cartesian Coordinate System
We define the basis vectors to be $hat(bold(i)), hat(bold(j)), hat(bold(i)) and hat(bold(j))$, so if we maintain the *cyclic order* or the vectors, handiness is maintained, convince yourself this is true using your hand.
- $hat(bold(i)) and hat(bold(i)) = hat(bold(j)) and hat(bold(j)) = hat(bold(k)) and hat(bold(k)) = bold(0)$
- $hat(bold(i)) and hat(bold(j)) = hat(bold(k))$
- $hat(bold(j)) and hat(bold(k)) = hat(bold(i))$
- $hat(bold(k)) and hat(bold(i)) = hat(bold(j))$

=== Component Form
$
bold(a) and bold(b) =& (a_x hat(bold(i)) + a_y hat(bold(j)) + a_z hat(bold(k))) and (b_x hat(bold(i)) + b_y hat(bold(j)) + b_z hat(bold(k))) \
=& a_x hat(bold(i)) and b_x hat(bold(i)) + a_x hat(bold(i)) and b_y hat(bold(j)) + a_x hat(bold(i)) and b_z hat(bold(k))  \
&+ a_y hat(bold(i)) and b_x hat(bold(i)) + a_y hat(bold(i)) and b_y hat(bold(j)) + a_y hat(bold(i)) and b_z hat(bold(k))  \
&+ a_z hat(bold(i)) and b_x hat(bold(i)) + a_z hat(bold(i)) and b_y hat(bold(j)) + a_z hat(bold(i)) and b_z hat(bold(k))  \
=& (a_y b_z - a_z b_y)hat(bold(i)) + (a_z b_x - a_x b_z)hat(bold(j)) + (a_x b_y - a_y b_x)hat(bold(k))
$

=== Vector Product as Determinant

A *matrix* is a collection of vectors, each column (or row) contains the component of a vector.

$
bold("M") &= mat(
  a_x, a_y, a_z;
  b_x, b_y, b_z;
  c_x, c_y, c_z;
) \
|bold("M")| &= bold(a) dot (bold(b) and bold(c))
$

=== Finding Angles

By definition,
$
(|bold(a) and bold(b)|) / (|bold(a)||bold(b)|) = sin theta
$
For this purpose, the scalar product is much more convenient.

#line(length: 100%)

=== Vector Product for a Line

$bold(r) - bold(a)$ must be parallel with $bold(b) - bold(a)$.
$
(bold(r) - bold(a)) and (bold(b) - bold(a)) = bold(0)
$

=== Vector Product Equation for a Plane
$(bold(b) - bold(a)) and (bold(c) - bold(a))$ gives the normal to the plane. For $bold(r)$ to lie on the plane,
$
(bold(r) - bold(a)) dot [(bold(b) - bold(a)) and (bold(c) - bold(a))] = 0
$

=== Finding Distances

==== Shortest Distance from a Point to a Line

#grid(
  columns: (70%, 50%),
  [
    Let $bold(a)$, $bold(b)$ and $bold(p)$ be the position vectors of $A$, $B$ and $P$ respectively.

    We see that $d = |bold(p) - bold(a)| sin theta$.

    Using the definition of the vector product.
    $
    d = |(bold(p) - bold(a)) and hat(bold(t))|
    $
    where $hat(bold(t))$ is the unit vector in the direction of $bold(b) - bold(a)$.
  ],
  cetz.canvas({
    import cetz.draw: *
    line((-4, 0), (0, 4))
    line((-1, 3), (-2, 4), (-3, 1), stroke: (dash: "dashed"))
    content((-3.3, 1), $A$, anchor: "south")
    content((-0.2, 3.6), $B$, anchor: "north")
    content((-2,4.1), $P$, anchor: "south")
    content((-1.3, 3.6), $d$, anchor: "south")
    content((-2.6, 1.5), $theta$, anchor: "south")
  })
)

==== Shortest Distance from a Point to a Plane
+ Find the unit normal vector $hat(bold(n))$ using the vector product.
+ $d = |(bold(p) - bold(a)) dot hat(bold(n))|$

==== Shortest Distance from between Two Lines

Here's two lines
$
bold(r) &= bold(a) + lambda bold(t) \
bold(s) &= bold(b) + mu bold(u)
$

+ Find the unit normal vector $hat(bold(n))$ of the two direction vectors using the vector product.
+ $d = (bold(b) - bold(a)) dot hat(bold(n))$, this value is the same for any two points $A$ and $B$ on the line.

The two lines intersect if the distance is 0.

=== The Triple Product

#definition([
  The triple product of $bold(a) dot (bold(b) and bold(c))$ is also written as $[bold(a), bold(b), bold(c)]$.
])

$
[bold(a), bold(b), bold(c)] &= bold(a) dot (bold(b) and bold(c)) \
&=a_x (b_y c_z - b_z c_y) + a_y (b_z c_x - b_x c_z) + a_z (b_x c_y - b_y c_x)
$

- If we maintain cyclic order, the value is the same.
  $
  bold(a) dot bold(b) and bold(c) = 
  bold(b) dot bold(c) and bold(a) = 
  bold(c) dot bold(a) and bold(b) 
  $
- The value is 0 if two or more vectors are parallel. (think about volumes)

$
bold("M") &= mat(
  a_x, a_y, a_z;
  b_x, b_y, b_z;
  c_x, c_y, c_z;
) \
 |bold("M")| &= bold(a) dot bold(b) and bold(c)
$

By the cyclic order rule, there are many cyclic permutations of a matrix to get the same determinant.

==== Volume of a Parallelepiped

Find the volume of the parallelepiped formed by 3 vectors $bold(a), bold(b), bold(c)$.
+ Find area spanned by $bold(b)$ and $bold(c) = |bold(b) and bold(c)|$
+ Height is $bold(a) dot hat(bold(n))$ where $bold(n) = bold(b) and bold(c)$.

If $bold(a) dot bold(b) and bold(c) = 0$, the vectors are *coplanar* and spans onl ya 2D space.

=== The Vector Triple Product

$
bold(a) and (bold(b) and bold(c))
$
Note the vector product is not associative.

$
bold(a) and (bold(b) and bold(c)) =& (a_x hat(bold(i)) + a_y hat(bold(j)) + a_z hat(bold(k)))
                                      and [(b_y c_z - b_z c_y)hat(bold(i)) + (b_z c_x - b_x c_z)hat(bold(j)) + (b_x c_y - b_y c_x)hat(bold(k))] \
                                  =& (-a_y hat(bold(k)) + a_z hat(bold(j)))(b_y c_z - b_z c_y) \
                                  & +(-a_z hat(bold(i)) + a_x hat(bold(k)))(b_z c_x - b_x c_z) \
                                  & +(-a_x hat(bold(j)) + a_y hat(bold(i)))(b_x c_y - b_y c_x) \
                                  =& (bold(a) dot bold(c)) bold(b) - (bold(a) dot bold(b)) bold(c)
$

Similarly , $(bold(a) and bold(b)) and bold(c) = (bold(c) dot bold(a))bold(b) - (bold(c) dot bold(b))bold(a)$.

== Basis Vectors

Basis vectors are linearly independent so no basis vector is redundant.

#definition([
  We say a set of basis vectors $e_1, e_2, dots, e_n$ are *linearly independent* if
  $
  sum_i lambda_i e_i = 0 arrow.double.l.r.long "all" lambda_i = 0
  $
  There are no solutions to the equation where $lambda_i eq.not 0$.
])

You can also test for linear independence by creating an $N times N$ matrix $bold("M")$. The basis vectors are linearly independent if $|bold("M")| eq.not 0$. (Think of the volume of a parallelepiped spanned by those vectors)

==== Reciprocal Basis

Let $bold(a), bold(b), bold(c)$ be the basis vector, then the *reciprocal basis* is

#grid(
  columns: (20%, 20%, 20%),
  $
  bold(A)&=(bold(b) and bold(c))/([bold(a), bold(b), bold(c)]) \
  $,
  $
  bold(B)&=(bold(c) and bold(a))/([bold(a), bold(b), bold(c)]) \
  $,
  $
  bold(C)&=(bold(a) and bold(b))/([bold(a), bold(b), bold(c)])
  $
)

- $bold(a) dot bold(A) = bold(b) dot bold(B) = bold(c) dot bold(C) = 1$
- 0 for all other products.

Let vector $bold(r) = alpha bold(a) + beta bold(b) + gamma bold(c)$, convince yourself that
- $bold(A) dot bold(r) = alpha$
- $bold(B) dot bold(r) = beta$
- $bold(C) dot bold(r) = gamma$

This is useful for changing basis for a vector.

==== Orthonormal Basis

#definition([
 The basis is said to be *orthonormal* if
  - They are orthogonal to each other.
  - They have unit length.
])

For orthonormal basis $bold(a), bold(b), bold(c)$, $bold(A) = bold(a)$, $bold(B) = bold(b)$ and $bold(C) = bold(c)$.

- Let $bold(r) = r_1 bold(e_1) + r_2 bold(e_2) + r_3 bold(e_3) + dots$
- Let $bold(s) = s_1 bold(e_1) + s_2 bold(e_2) + s_3 bold(e_3) + dots$
If $bold(e_1), bold(e_2), bold(e_3), dots$ is orthonormal.
$
bold(a) dot bold(b) = sum_j a_j b_j
$

#line(length: 100%)

=== Cylindrical Polar Coordinates

A point $P$ in cylindrical polar coordinates is written as $(r, theta, z)$.
- $r$ is the length of the projection of $arrow(O P)$ onto the $x y$-plane.
- $theta$ is the anticlockwise angle between the projection of $arrow(O P)$ and the $x$-axis.
- $z$ is the same as for Cartesian coordinates.
$
bold(p) = r cos theta hat(bold(i)) + r sin theta hat(bold(j)) + z
$

To define the *cylindrical polar basis vectors*, set
$
hat(bold(e_r)) &= cos theta hat(bold(i)) + sin theta hat(bold(j)) \
hat(bold(e_theta)) &= -sin theta hat(bold(i)) + cos theta hat(bold(j)) \
hat(bold(e_z)) &= hat(bold(k))
$

So the basis vectors are orthonormal and forms a right-handed coordinate system. $hat(bold(e_r)), hat(bold(e_theta)), hat(bold(e_z))$ are in the direction where $P$ would move if $r, theta, z$ are increased respectively.

The oritentation of the basis depends on $theta$, if $bold(a)$ and $bold(b)$ uses different orthonormal basis, generally
$
bold(a) dot bold(b) eq.not a_r b_r + a_theta b_theta + a_z b_z
$

We can find the orientation $theta$ of a vector using the tangent, note that $arctan$ only maps to value between $-pi slash 2$ and $pi slash 2$.

#definition([
  *Plane polar coordinates* only works on the $x y$-plane.
])

=== Spherical Coordinates

Start with $(x, y, z)$, we want to work out $(r, theta, phi)$
- $r$ is the distance from the origin to that point, $r gt.eq 0$
- $theta$ is the angle between the $z$-axis to the vector, $0 lt.eq theta lt.eq pi$
- $phi$ is the angle the projection of the vector to the $x y$-plane makes with the $x$-axis, $0 lt.eq phi lt.eq 2 pi$

If $r = 0$, we don't need information about $theta$ or $phi$ as there is no angle with either the axes.
- The distance from the $z$-axis to $P$ is $r sin theta$
$
x &= r sin theta cos phi \
y &= r sin theta sin phi \
z &= r cos theta
$
Since we restrict $0 lt.eq theta lt.eq pi$, $sin theta$ is always positive.

Again define the orthonormal basis.
$
hat(bold(e_r)) &= sin theta (cos phi hat(bold(i))+sin phi hat(bold(j))) + cos theta hat(bold(k)) \
hat(bold(e_theta)) &= cos theta (cos phi hat(bold(i))+sin phi hat(bold(j))) - sin theta hat(bold(k)) \
hat(bold(e_phi)) &= -sin phi hat(bold(i)) + cos phi hat(bold(j))
$

== Vector Area

A surface on a 3-dimensional space have a normal vector $hat(bold(n))$.
- If the surface has area $A$, we can write a vector about it $bold(s) = A hat(bold(m))$.
- The length of $bold(s)$ is proportional to the area of the surface.

$
bold(s) = (s_x, s_y, s_z)
$

If we project the area to the $y z$-plane, it is an image with area $s_x$.

=== Vector Area of Closed Surfaces

Imagine an object (e.g. that of a cube) where the vector on each surface points outwards.

$
sum_i S_i = bold(0)
$
for any object.

If we have a curved surface in 3D, if the surface is *closed* then
- Take the surface vector at every infitesimally small point and sum them together.
- It will be 0 for any *closed surface*.

#line(length: 100%)

#align(center)[
  `END Vectors`
]
