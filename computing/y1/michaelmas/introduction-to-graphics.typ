#import "@preview/cetz:0.4.2"
#import "@local/lecture:0.1.0" : *

#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Computer Science Lecture Notes]
    #h(1fr) _Introduction to Graphics_
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

= Computer Graphics

Computer graphics is part of a larger field that is visual computing, this includes
- Computer graphics and computer vision.
- Image capture and image display.

Computer graphics includes:
- User interface
- 3D renders
- AR/VR
- Special effects, including image editing

== Image as a 2D Array

From a discrete perspecitive, an image is a *2D array of pixels*. The memory is not two-dimensional, how do we store it in memory? (how to linearise an image?)

#grid(
  columns: (45%, auto),
  column-gutter: 30pt,
  [
    === Row Major

    The first row is stored before the second row. The index of a pixel
    $
    i(x, y) = x + y dot.c n_"cols"
    $

    #cetz.canvas({
      import cetz.draw : *

      for i in range(13) {
        i = i / 2
        line((i, 0), (i, 5), stroke: gray)
      }

      for i in range(11) {
        i = i / 2
        line((0, i), (6, i), stroke: gray)

        if i < 5 and i > 2 {
          line((0.25, i + 0.25), (5.75, i + 0.25), mark: (end: ">"))
          line((5.35, i + 0.15), (0.4, i - 0.15), mark: (end: ">"))
        }
      }
    })
  ],
  [
    === Column Major

    The first column is stored before the second column. The index of a pixel
    $
    i(x, y) = x dot.c n_"rows" + y
    $

    #cetz.canvas({
      import cetz.draw : *

      for i in range(11) {
        i = i / 2
        line((0, i), (6, i), stroke: gray)

      }

      for i in range(13) {
        i = i / 2

        line((i, 0), (i, 5), stroke: gray)
      }

      for i in range(13) {
        i = i / 2
        if i < 3 {
          line((i + 0.25, 4.75), (i + 0.25, 0.25), mark: (end: ">"))
          line((i + 0.4, 0.25), (i + 0.55, 4.65), mark: (end: ">"))
        }
      }
    })
  ]
)

CRT TVs draw images from top to bottom, which is why most APIs represent images in row major.

=== RGB Representations

- *Interleaved, row major* stores all colours of a pixel next to each other, before moving on to the next pixel.
  $
  i(x, y, c) = 3x + 3y dot.c n_"cols" + c
  $
- *Planar, column major* lays the R, G and B image next to each other, then use column major on the combined image.
#align(center,
  cetz.canvas({
    import cetz.draw : *

    rect((0, 0), (5, 5), stroke: none, fill: rgb(240, 125, 125))
    rect((5, 0), (10, 5), stroke: none, fill: rgb(125, 240, 125))
    rect((10, 0), (15, 5), stroke: none, fill: rgb(125, 125, 240))

    for i in range(11) {
      i = i / 2
      line((0, i), (15, i), stroke: gray)
    }

    for i in range(31) {
      i = i / 2

      line((i, 0), (i, 5), stroke: gray)
    }

    for i in range(13) {
      i = i / 2
      if i < 3 {
        line((i + 0.25, 4.75), (i + 0.25, 0.25), mark: (end: ">"))
        line((i + 0.4, 0.25), (i + 0.55, 4.65), mark: (end: ">"))
      }
    }
}))
$
i(x, y, c) = x dot.c n_"rows" + y + c x y
$
The general formula is $i(x, y, c) = x s_x + y s_y + c s_c$, where $s_x$ is the number of pixels for each step in the $x$ direction.

=== Padded Image

An algorithm that operates on neighbouring pixels need a padded image so every pixel in the image has neighbouring pixels.

#grid(
  columns: (50%, auto),
  column-gutter: 20pt,
  [
    The pixels in the region of interest are given by
    $
    i(x, y, c) = i_"first pixel" + x s_x + y s_y + c s_c
    $
    Where $i_"first pixel"$ is the index of the top left pixel of the ROI.
  ],
  cetz.canvas({
    import cetz.draw : *

    rect((0, 0), (5, 4))
    rect((2, 1), (4, 2.5), stroke: blue)
    content((3, 1.75), "ROI")
  })
)

=== Pixels

Pixel is short for *picture element*.

Each pixel consist of 3 values R, G, B describing the colour.
- 0-255 for each colour, because it is convenient to use 1 byte per colour.
- It is also the number of colours we need to have no visible artifacts.

==== Colour Banding
#definition([
  *Colour banding* is when there are not enough bits to reprsent colour.
])

This is very visible to our eyes due to the mach band/chevreul illution where our eyes enhances the contrast of an edge, making the band more visible than it is.

#definition([
  *Dithering* adds noise to reduce banding: randomly add a value to the pixel value, the probability determined by the colour of the pixel.
])

== Image as a Continuous Function

From a continuous perspective, an image is a continuous 2D function. This allows mathematical functions to run on the image.

#definition([
  A *pixel* is a point with no dimension.
])

We don't have continuous memory in computers, so we need to
- *Sample* the points, and
- *Quantise* the level of allowed values.

== Rendering

=== Depth Perception

Our eyes will use anything to infer the depth of a scene, including:
- Occlusion: where one thing covers another because it is in front of the other thing.
- Relative size
- Distance to the horizon: the closer to the horizon the further away it is.
- Infer the shape of an object from shading.
- Red objects look closer than blue objects: chromatic abberation focus it further back in retina.
- Atmosphere/focus
- Perspective, this is easier when there are parallel lines.

In CG we want to use all the cues we can give.

== Raytracing

We identify points on the image surface and calculate illumation for each pixel.
+ Shoot many rays from the camera.
+ Then calculate the colour of the pixel from where the ray hits, which is the closest intersection point (of the ray) to the camera.

Raytracing can easily handle reflection, refraction, shadows and motion blur, but is computationally expensive.

=== Finding Intersection

$
"ray": & bold(r) = bold(o) + s bold(d) \
"plane": & bold(r) dot.c bold(n) + a = 0 \
$

After solving
$
s = -(a + bold(n) dot.c bold(o))/(bold(n) dot.c bold(d))
$

To find an intersection with a polygon
+ Find intersections with the plane
+ Check whether the point is inside the polygon, which is just 2D geometry.

#hr

In the real word, the rays comes from the object
- It is computationally inefficient as a lot of the rays don't hit the eye.
- It can be mathematically proven that the result is the same regardless if you trace from the source to the eye or the other way round.

== 3D Object Intersection 

=== Sphere

- Ray: $bold(r) = bold(o) + s bold(hat(d))$
- Sphere: $(bold(r) - bold(c))^2 = r^2$

$
(bold(o) - s bold(hat(d)) - bold(c))^2 - r^2 &= 0 \
bold(hat(d))^2 s^2-2s bold(hat(d)) dot (bold(o) - bold(c)) - r^2 &= 0
$

This is the quadratic equation, solve for $s$.
- If there are 2 real solutions, then cloose the closer intersection.
- If there are 0 real solutions, then there is no intersection.

You can also find intersections with a cylinder, cone and torus, it's easier if the objet is *axis aligned*.

== Shading

+ Calculate the normal to the object at intersection.
+ Continue to look for a light source.
  - If the reflected ray intersect with another object, then the surface is not illuminated by the source. This is called a *shadow ray*.
+ If a surface is reflective, spawn a new ray to find the pixel's colour given by reflection.

#grid(
  columns: (40%, auto),
  cetz.canvas({
    import cetz.draw : *

    line((0, 0), (5, 0))
    line((2.5, 0), (1, 1), stroke: blue, mark: (end: ">"))
    content((0.8, 1), $bold(hat(v))$)
    line((2.5, 0), (4, 1), stroke: red, mark: (end: ">"))
    content((2.5, 2.2), $bold(N)$)
    line((2.5, 2), (2.5, 0), mark: (start: ">"))
    content((4.2, 1), $bold(hat(r))$)
  }),
  $
  bold(hat(v)) dot bold(N) &= - bold(hat(r)) dot bold(N) \
  bold(hat(r)) &= -bold(hat(v)) + 2 bold(N) (bold(hat(v)) dot bold(N))
  $
)

If we have a material that is both reflective and transparent, e.g. glass, then light will be refracted.
- 80% colour comes from reflection.
- 20% colour comes from refraction.

=== Types of Reflection
+ *Perfect reflection* as shown above.
+ *Imperfect specular reflection* (where the surface is not perfectly flat)
  #cetz.canvas({
    import cetz.draw : *

    line((0, 0), (5, 0))
    line((2.5, 0), (1, 1), stroke: blue, mark: (end: ">"))
    content((0.8, 1), $bold(hat(v))$)
    line((2.5, 0), (3.75, 1.3), stroke: red, mark: (end: ">"))
    line((2.5, 0), (4, 1), stroke: red, mark: (end: ">"))
    line((2.5, 0), (4.1, 0.7), stroke: red, mark: (end: ">"))
    content((2.5, 2.2), $bold(N)$)
    line((2.5, 2), (2.5, 0), mark: (start: ">"))
    content((4.2, 1), $bold(hat(r))$)
  })
+ *Diffuse reflection* (where the structure is so complex light scatters in random direction)
  #cetz.canvas({
    import cetz.draw : *

    line((0, 0), (5, 0))
    line((2.5, 0), (1, 1), stroke: blue, mark: (end: ">"))
    content((0.8, 1), $bold(hat(v))$)
    line((2.5, 0), (2.67, 0.9), stroke: red, mark: (end: ">"))
    line((2.5, 0), (2.9, 0.85), stroke: red, mark: (end: ">"))
    line((2.5, 0), (3.13, 0.7), stroke: red, mark: (end: ">"))
    line((2.5, 0), (3.25, 0.5), stroke: red, mark: (end: ">"))
    line((2.5, 0), (3.35, 0.3), stroke: red, mark: (end: ">"))
    line((2.5, 0), (3.4, 0.1), stroke: red, mark: (end: ">"))

    line((2.5, 0), (2.33, 0.9), stroke: red, mark: (end: ">"))
    line((2.5, 0), (2.1, 0.85), stroke: red, mark: (end: ">"))
    line((2.5, 0), (1.87, 0.7), stroke: red, mark: (end: ">"))
    line((2.5, 0), (1.75, 0.5), stroke: red, mark: (end: ">"))
    line((2.5, 0), (1.65, 0.3), stroke: red, mark: (end: ">"))
    line((2.5, 0), (1.6, 0.1), stroke: red, mark: (end: ">"))
    content((2.5, 2.2), $bold(N)$)
    line((2.5, 2), (2.5, 0), mark: (start: ">"))
    content((3.5, 0.6), $bold(hat(r))$)
  })

E.g. *plastic* has specular reflection on the light's colour, and diffuse reflection on the plastic's colour. Different wavelengths of light may reflect/scatter differently.

=== Phong's Imperfection Model

#defstable(
  $bold(hat(L))$, [Normalised vector in direction of light source.],
  $bold(hat(N))$, [Normal vector of the plane.],
  $I_l$, [ The intensity of light source. ],
  $k_d$, [ The proportion of light diffusely reflected by the surface.],
  $I$, [ The intensity of the light being reflected. ]
)

#grid(
  columns: (auto, auto),
  [
    $
    I &= I_l k_s cos^n alpha
    &= I_l k_s (bold(hat(R)) dot bold(hat(L))) ^n
    $
  ],
  cetz.canvas({
    import cetz.draw : *

    line((0, 0), (5, 0))
    content((0.8, 1), $bold(hat(L))$)
    line((2.5, 0), (1, 1), stroke: blue, mark: (end: ">"))
    content((2.5, 2.2), $bold(N)$)
    line((2.5, 2), (2.5, 0), mark: (start: ">"))
    arc((2.5, 0.5), start: 90deg, stop: 15deg, radius: 0.5, stroke: red)
    arc((2.5, 0.5), start: 90deg, stop: 145deg, radius: 0.5)
    arc((2.5, 0.5), start: 90deg, stop: 35deg, radius: 0.5)

    line((2.5, 0), (4, 1), stroke: purple, mark: (end: ">"))
    line((2.5, 0), (4.2, 0.5), stroke: red, mark: (end: ">"))

    content((2.2, 0.8), $theta$)
    content((2.8, 0.8), $theta$)
    content((3.5, 0.53), $alpha$)

    content((4.2, 1), $bold(hat(R))$)
    content((4.4, 0.5), $bold(hat(V))$)
  })
)

$n$ determines how spread out the reflected light is - it is the *roughness factor*.

=== Overall Shading Equation
$
I = I_a k_d + sum_i I_i k_d bold(hat(L) dot bold(hat(N))) + sum_i I_i k_s (bold(hat(R)) dot bold(hat(V)))^n
$

The $I_a k_d$ term gives the *ambient* shading. The next two terms gives the diffuse and specularity.

== Sampling

So far we assume each ray passes through the centre of a pixel. This can lead to
- Jagged edges.
- Small objects being missed.
- Thin objects being split into pieces.

=== Antialiasing

#def([
  Artifacts are also known as *aliasing*.
])

- *Single point sampling* just samples the point at the centre.
- *Super sampling* samples points in a regular grid/gaussian pattern.
  - *Random sampling* sample random points in the pixel, as our eyes are less sensitive to noise than artifact.
  - *Poisson disc sampling* reject rays less than distance $epsilon$ from each other, but it takes $n^2$ comparisons to check for disc overlaps.
  - *Jitter sampling* is a type of stratified sampling: take a random grid, then random sample in each grid.
- *Adaptive super sampling* samples the four corners:
  - If the variance is high, do a super sample.
  - Otherwise, don't sample the pixel.

#hr

=== Distributed Sampling

- *Super sampling* - distributing samples in a pixel $imp$ *antialiasing*.
- *Area light* - distributing light on a plane $imp$ *soft shadows*.
  #grid(
    columns: (45%, auto),
    column-gutter: 30pt,
    cetz.canvas({
      import cetz.draw : *

      arc((0, 0), start: 180deg, stop: 90deg, radius: 2)
      line((-2, 1), (0.2, 1), mark: (end: ">"))
      line((0.2, 1.2), (1, 4), mark: (end: ">"))
      circle((1.03, 4.1), radius: 2pt, stroke: blue)
      content((2.1, 4.1), "point light")
    }),
    cetz.canvas({
      import cetz.draw : *

      arc((0, 0), start: 180deg, stop: 90deg, radius: 2)
      line((-2, 1), (0.2, 1), mark: (end: ">"))
      line((0.2, 1.2), (0.7, 4), mark: (end: ">"))
      line((0.2, 1.2), (1, 4), mark: (end: ">"))
      line((0.2, 1.2), (1.3, 4), mark: (end: ">"))
      line((0.5, 4.1), (1.5, 4.1), stroke: blue)
      content((2.4, 4.1), "area light")
    })
  )
- *Camera as an area* - distribute the camera position $imp$ *depth of field* effects.
  #grid(
    columns: (45%, auto),
    column-gutter: 30pt,
    cetz.canvas({
      import cetz.draw : *

      arc((0, 0), start: 180deg, stop: 60deg, radius: 2)
      line((-2, 1), (0.2, 1), mark: (end: ">"))
      line((-2.02, 1.1), (1.7, 2.8), mark: (end: ">"))
      circle((2.2, 3), radius: 10pt)
      circle((-2.2, 1), radius: 2pt, stroke: red)
      content((-1.8, 0.2), "point camera")
    }),
    cetz.canvas({
      import cetz.draw : *

      line((0.2, 0), (0.2, 3), stroke: gray)

      arc((0, 0), start: 180deg, stop: 60deg, radius: 2)
      line((-2, 1), (0.2, 1), mark: (end: ">"))
      line((-2, 1.3), (-0.1, 1))
      line((-2, 0.7), (-0.1, 1))
      line((-2.02, 1.1), (1.7, 2.8), mark: (end: ">"))
      line((-2.02, 1.4), (1.8, 2.6), mark: (end: ">"))
      line((-2.02, 0.8), (1.6, 3.0), mark: (end: ">"))
      circle((2.2, 3), radius: 10pt)
      line((-2.2, 0.6), (-2.2, 1.4), stroke: red)
      content((-1.8, 0.2), "area camera")

      line((-2.1, 3), (-0.1, 3), mark: (end: ">", start: ">"))
      content((-1.1, 2.5), "focal length")
    })
  )

And distributing sampling through time creates *motion blur*.
== Rasterisation

Ray tracing gives very high quality results, but is computationally expensive.

*Real-time applications* use rasterisation:
+ Model surfaces as polyhedrons.
+ Apply transformations to project the plane on screen.
+ Fill pixels with colours of the nearest visible polygon.

Most modern games use 90% rasterisation combined with 10% ray tracing.

#def([
  *Polyhedral surfaces* are made of connected polygons surfaces.
])

We can approximate curved surfaces with polygons - the triangle is the simplest polygon as it vertices must be planar. GPUs are optimised to draw triangles.

We can split a polygon surface to triangles.

#align(center,
  cetz.canvas({
    import cetz.draw : *

    let f(x, y) = {
      line((0 + x, 0 + y), (1 + x, 0.5 + y), (1.7 + x, -0.2 + y), (0.8 + x, -0.8 + y), (0 + x, 0 + y))

      circle((0 + x, 0 + y), radius: 2pt, fill: white)
      circle((1 + x, 0.5 + y), radius: 2pt, fill: white)
      circle((1.7 + x, -0.2 + y), radius: 2pt, fill: white)
      circle((0.8 + x, -0.8 + y), radius: 2pt, fill: white)
    }

    line((2, -0.1), (3.7, -0.1), mark: (end: ">"))

    line((5, 0.5), (4.8, -0.8))

    f(0, 0)
    f(4, 0)
  })
)

- *Postscript*: 2D transformations.
- *OpenGL*: 3D transformations.

== Transformations as Matrices

#tab2(
  [Transformation], [Matrix],
  [Scale by factor $m$],
  $
  mat(m, 0; 0, m;)
  $,
  [Rotate by angle $theta$],
  $
  mat(cos theta, -sin theta; sin theta, cos theta)
  $,
  [Shear parallel to $x$ by factor $a$],
  $
  mat(1, a; 0, 1)
  $
)

=== Homogenous Coordinates

We could not represent transformation as matricies, unless we define the homogenous coordinates.
$
(italic("homogenous")) &= (italic("conventional")) \
(x, y, w) &= (x / w, y / w)
$

There is an infinite number of homogenous coordinates that maps to the same point.

#tab2(
  [Transformation], [Matrix],
  [Scale by factor $m$],
  $
  mat(m, 0, 0; 0, m, 0; 0, 0, 1)
  $,
  [Translate by $(x, y)$],
  $
  mat(1, 0, x; 0, 1, y; 0, 0, 1)
  $
)

Multiple transformations can be concatenated to make a more efficient transformation.

Note that in general, transformations are *not commutative*.

=== Scale/Rotation About a Point

To scale by factor of $m$ about point $(x_0, y_0)$
+ Translate by $(-x_0, -y_0)$
+ Scale by factor of $m$
+ Translate by $(x_0, y_0)$

Similar for rotation.

=== 3D Homogenous Coordinates

It is a simple extension of the 2D homogenous coordinates.
$
(x, y, z, w) to (x/w, y/w, z/w)
$

=== Example: Placing a Cylinder in 3D Space

The program defines a cylinder as one with radius 1, height 2, oriented in direction of $(0, 0, 1)$, and centred at origin. We need to apply transformations to get it to the correct place.

We usually do in order
+ Scale
+ Rotate
+ Translate
So each step does not interfere with the previous steps. (what's the word for that?)

Rotation is the only nontrivial step, it is easier to do it in reverse order
+ Find the rotation $R_1$ about the $y$ axis so the desired shape is oriented in direction $(0, y, z)$
+ Find the rotation $R_2$ about the $x$ axis so the desired shape is oriented in direction $(0, 0, 1)$

$
"The combined transformation" = T times (R_1)^(-1) times (R_2)^(-1) times S
$

#hr

With transformations an object can be modelled once, and multiple instances can be placed.

== 2D Projection

#tab2(
  [Parallel projection], [Perspective projection],
  [Used in CAD.], [Thing's get smaller as they get further away.],
  [Less realistic.], [More realistic.]
)

=== Project to Viewing Plane
#cetz.canvas({
  import cetz.draw : *

  line((0, 0), (8, 3), stroke: red)
  line((8, 3), (8, 0), stroke: black)
  line((0, 0), (10, 0), stroke: gray)
  line((4, -1), (4, 2.5))

  content((8.2, 3.4), $(x, y, z)$)
  content((5, 1.2), $(x', y', d)$)
  content((8.6, -0.3), "Object")
  content((5.3, -0.3), "Viewing plane")

  circle((8, 3), radius: 3pt, fill: black)
  circle((4, 1.5), radius: 3pt, fill: black)
})

By similar triangles.
$
x' &= x d/z \
y' &= y d/z \
$

The furthere things are the smaller they look, because it is divided by larger $z$.

We also want $z' = 1 slash z$ to use in the z-buffer algorithm.

$
vec(x', y', z', w') = mat(1,0,0,0;0,1,0,0;0,0,0,1 slash d;0,0,1 slash d, 0) vec(x, y, z, 1) = vec(x, y, 1 slash d, z slash d)
$

Which gives conventional coordinates $(x dot d slash z, y dot d slash z, 1 slash z)$.

=== Viewing Coordinates

Instead of projecting all objects to an arbitrary plane, it is easier to transform all aobjects to a viewing coordinates system.

#note([
  OpenGL uses *right-handed coordinates*, which we will be using. (also note $y$ is up)
])

We want to place the camera
- Centred at $c$
- Directed at $l$
- Up in direction of $bold(u)$

#grid2(width: 40%,
  [
    $
    bold(hat(v)) &= (l - c)/(|l-c|) \
    bold(hat(r)) &= (bold(u) times bold(hat(v))) / (|bold(u) times bold(hat(v))|) \
    bold(hat(u)) &= bold(hat(v)) times bold(hat(r))
    $
  ],
  cetz.canvas({
    import cetz.draw : *

    line((0, 0), (5, -1))
    circle((), radius: 3pt, fill: black)
    content((5.4, -1), $l$)
    line((0, 0), (-2, -0.5), mark: (end: ">"))
    line((0, 0), (0.2, 2.3), mark: (end: ">"))

    line((0.02, 0.3), (0.3, 0.25), (0.27, -0.05))
    line((0.02, 0.295), (-0.23, 0.23), (-0.25, -0.06))
    line((0.27, -0.05), (0, -0.1), (-0.25, -0.06))

    content((0.5, 0.2), $c$)
    content((1.5,  0), $bold(hat(v))$)
    content((0.4, 1.2), $bold(hat(u))$)
    content((-1, 0), $bold(hat(r))$)
  })
)

We need to use this formula as $bold(u)$ is given by the user, we cannot be sure that $bold(u) perp bold(hat(v))$.

=== Transformaing Normal Vectors

Transformation by non-orthogonal matrix does not preserve angle, this breaks normals.

#cetz.canvas({
  import cetz.draw : *

  line((0, 0), (0, 1.5), (3, 0), (0, 0))
  line((0, 1.5), (2.5, 0.25), mark: (end: ">", fill: black))
  line((1.5, 0.75), (2, 1.75), mark: (end: ">"))
  content((2, 2), $bold(N)$)
  content((2.5, 0.7), $bold(T)$)

  line((3.5, 0.75), (5, 0.75), mark: (end: ">"))

  line((6, -1), (6, 2.5), (9, -1), (6, -1))
  line((7.5, 0.75), (8, 1.75), mark: (end: ">"))
  line((7.5, 0.75), (8.5,-0.4), mark: (end: ">", fill: black))
  content((8, 2), $bold(N)'$)
  content((8.5, 0.2), $bold(T)$)
})

We want $bold(N) dot bold(T) = 0$ after transformation $M$. Then we need to transform $bold(N)$ by matrix $G$.
$
T' &= M T \
N' &= G N
$

For two vectors $A$ and $B$, $A dot B = A^T B$ in matrix multiplication.

#note(
  [
    Let $A$ and $B$ be matrices, and $M^T$ the transpose operator.
    $
    (A B)^T = B^T A^T
    $
    (Why?)
  ]
)

$
(G N) dot (M T) &= (G N)^T (M T) \
N^T G^T M T &= 0
$

Because $N^T T = 0$, then $G^T M = I$, and $G = (M^(-1))^T$.

The overall process to display an object on screen.

#cetz.canvas({
  import cetz.draw : *

  rect((-1, -0.5), (3, 1.5))
  content((1, 0.5), [*Object coordinates* #br Defines the object])

  line((3, 0.5), (6, 0.5), mark: (end: ">"))
  content((4.5, 0.8), "Model matrix")

  rect((6, -0.5), (10, 1.5))
  content((8, 0.5), [*World coordinates* #br Positions the object])

  line((8, -0.5), (8, -2.5), mark: (end: ">"))
  content((9.2, -1.5), "View matrix")

  rect((6, -2.5), (10, -4.5))
  content((8, -3.5), [*Viewing coordinates* #br Normalise the camera])

  line((6, -3.5), (3, -3.5), mark: (end: ">"))
  content((4.5, 0.8 - 4), "Projection")

  rect((-1, -2.5), (3, -4.5))
  content((1, -3.5), [*2D screen #br coordinates*])
})

== Scene Graph

To attach object $B$ to object $A$.
+ Apply scale to $A$.
+ Apply scale, rotation and translation to move $B$ to where it will attach to $A$.
+ Apply rotation and translation to both $A$ and $B$.

To attach object $C$ to $B$, add extra steps between 1 and 2 to attach it to $B$, all other transformations applied to $B$ should also be applied to $C$.

We can build a *scene graph* by attachments, traversing the scene graph draws the scene.

#hr
