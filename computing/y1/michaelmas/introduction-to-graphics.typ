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
"plane": & bold(r) dot.c bold(n) + d = 0 \
$

After solving
$
s = -(d + bold(n) dot.c bold(o))/(bold(n) dot.c bold(d))
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
  $bold(hat(N))$, [Normalised vector in direction of light source.],
  $I_l$, [ The intensity of light source. ],
  $k_d$, [ The proportion of light diffusely reflected by the surface.],
  $I$, [ The intensity of the light being reflected. ]
)

#grid(
  columns: (auto, auto),
  [
    $
    I &= I_l k_s cos^n alpha
    &= I_l k_s (bold(hat(R)) dot bold(hat(V))) ^n
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

=== _Why take multiple samples per pixel?_

Many effects can be achieved by distributing multiple samples over some range (*distributed ray sampling*)
- Distribute samples over a pixel - used for antialiasing.
- Distribute rays going through the light source - soft shadows.
- Distribute camera position - depth of field effects.
- Distribute sampling in time - motion blur.

#hr
