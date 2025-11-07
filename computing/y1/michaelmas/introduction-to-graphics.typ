#import "@preview/cetz:0.4.2"

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

From a discrete perspecitive, an image is a *2D array of pixels*. The memory is not two-dimensional, how do we store it in memory?

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
