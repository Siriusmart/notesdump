#import "@local/lecture:0.1.0" : *
#import "@preview/cetz-plot:0.1.3"
#import "@preview/fletcher:0.5.8" : *
#import "@preview/cetz:0.4.2"

#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Computer Science Cheatsheet]
    #h(1fr) _Introduction to Graphics_
  ],
)

= Introduction to Graphics

== Image Representation

#grid(
  columns: (45%, auto),
  column-gutter: 30pt,
  [
    === Row Major $i(x, y) = x + y dot.c n_"cols"$

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
    === Column Major $i(x, y) = x dot.c n_"rows" + y$

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

RGB representations:
- *Interleaved row major* $i(x, y, c) = 3x + 3y dot.c n_"cols" + c$ all colours of a pixel next to each other.
- *Planar column major* $i(x, y, c) = x dot.c n_"rows" + y + c x y$

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

#grid2(
  [
    *Padded images* are used if an algorithm requires all pixels have neighbouring pixels.
    $
    i(x, y, c) = i_"first pixel" + x s_x + y s_y + c s_c
    $
  ],
  cetz.canvas({
    import cetz.draw : *

    rect((0, 0), (5, 2))
    rect((2, 0.5), (4, 1.5), stroke: blue)
    content((3, 1), "ROI")
  })
)

- *Colour banding* is visible when there are not enough bits to represent colour.
- *Dithering adds noise* to reduce banding.

== Ray Tracing

#grid2(
  [
    *Barycentric coordinates* $(alpha, beta, lambda)$ gives a point in a triangle if $0 <= alpha, beta, gamma <= 1$ where $P=alpha A + beta B + gamma C$

    === Finding Intersection
    #grid2(
      [
        - Ray-sphere: solve for $s$ in $(s bold(hat(d)) + (bold(o) - bold(c)))^2 - r^2 = 0$
        and choose the closer solution
        - Ray-plane: #br $bold(s) = - (bold(a) + bold(n) dot bold(o)) slash (bold(n) dot bold(hat(d)))$
        - Ray-triangle: additionally check barycentric coordinate.
      ],
      [
        $
        "ray" &: bold(r) = bold(o) + s bold(hat(d)) \
        "plane" &: bold(r) dot bold(n) + bold(a) = 0 \
        "sphere" &: (bold(r) - bold(c))^2 = r^2
        $
      ]
    )
  ],
  cetz.canvas({
    import cetz.draw : *

    line((2.5, 0.8), (3.6, 0.7), stroke: red)
    line((2.5, 0.8), (1.95, 1.55), stroke: red)
    line((2.5, 0.8), (2.4, -0.35), stroke: red)

    line((0, 0), (3.8, 3), (3.5, -0.5), (0, 0))

    content((2.25, 0.3), $gamma$)
    content((2.4, 1.3), $beta$)
    content((3.05, 1), $alpha$)

    content((-0.3, 0), $A$)
    content((-0.3, 0.5), $(1,0,0)$)
    content((4.1, 3), $C$)
    content((3.1, 3.5), $(alpha, beta, gamma)=(0,0,1)$)
    content((3.7, -0.5), $B$)
    content((3.7, -1), $(0,1,0)$)
  })
)

=== Phong's Shading Algorithm

#align(center,
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

#grid2(
  [
    $
    I_"specular" &= I_l k_s cos^n alpha = I_l k_s (bold(hat(R) dot bold(hat(V))))^n
    $
    - $I_l$ the light intensity
    - $k_s$ proportion of  light reflected specularly
    - $n$ is the roughness factor of the surface.
  ],
  [
    #br
    $
    I_"total" &= "ambient" + "diffuse" + "specular" \
    &=I_a k_d + sum_i I_i k_d bold(hat(L) dot bold(hat(N))) + sum_i I_i k_s (bold(hat(R)) dot bold(hat(V)))^n
    $
  ],
)

#tab2(
  [Sampling Method], [Description],
  [Single point sampling], [Samples at the center of pixels],
  [Super sampling], [
    Goal is the remove artifact
    - Random sampling: samples random points in a pixel
    - Poisson disc samping: reject rays less than distance $epsilon$ from each other.
    - Jitter sampling: divide pixel into a grid, then random sample on each cell
  ],
  [Distributed sampling],
  [Achieve effects such as antialiasing, area light, depth of field, motion blur.]
)

== Rasterisation

1. Model surface as polyhedrons (connected polygon surfaces)
2. Apply transformations to project plane on screen
3. Fill pixels with colour of the nearest visible polygon

Let homogenous coordinates $(x, y, w)$ represent $(x slash w, y slash w)$ in 2D cartesian coordinates.

#grid2(
  tab2(
    [2D Transformation], [_Homogenous_ Matrix],
    [Scale by $m$],
    $
    mat(m, 0, 0; 0, m, 0;0, 0, 1;)
    $,
    [Rotate by $theta$],
    $
    mat(cos theta, -sin theta, 0; sin theta, cos theta, 0;0, 0, 1;)
    $,
    [Translate by $(x, y)$],
    $
    mat(1,0,x;0,1,y;0,0,1)
    $
  ),
  tab2(
    [3D Transformation], [_Cartesian_ Matrix],
    [Rotate by $theta$ about $x$ axis],
    $
    mat(1,0,0;0,cos theta,-sin theta;0, sin theta, cos theta)
    $,
    [Rotate by $theta$ about $y$ axis],
    $
    mat(cos theta,0,sin theta;0,1,0;-sin theta, 0, cos theta)
    $,
    [Rotate by $theta$ about $z$ axis],
    $
    mat(cos theta,-sin theta,0;sin theta,cos theta,0;0,0,1)
    $
  ),
)

=== Model-View-Projection Transformations

+ To transform a cylinder at origin with radius 1, height 1, oriented in direction of $(0, 0, 1)$
  #set enum(numbering: "i)")
  + Apply scale $S$
  + Apply rotation $R$
    - Find $R_1$ which orients desired cylinder in direction $(0, y, z)$ 
    - Find $R_2$ which orients desired cylinder in direction $(0, 0, 1)$
    - $R = (R_1)^(-1)(R_2)^(-1)$
  + Apply translation $T$


  #grid2(
    [
      Find transformation $G$ so $bold(N')$ is normal to $bold(T')$
      $
      T' = M T quad quad N' = G N \
      $
      $
      (G N) dot (M T) &= 0 \
      N^T G^T M T &= 0 quad (T "is transpose")
      $
    ],
    
    cetz.canvas({
      import cetz.draw : *

      line((0, 0), (0, 1.5), (3, 0), (0, 0))
      line((0, 1.5), (2.5, 0.25), mark: (end: ">", fill: black))
      line((1.5, 0.75), (2, 1.75), mark: (end: ">"))
      content((2, 2), $bold(N)$)
      content((2.5, 0.7), $bold(T)$)

      line((3.5, 0.75), (5, 0.75), mark: (end: ">"))

      line((6, 0), (6, 1.5), (7, 0), (6, 0))
      line((6, 1.5), (6.85, 0.25), mark: (end: ">", fill: black))
      line((6.5, 0.75), (7.2, 1.2), mark: (end: ">"))
      content((7, 1.5), $bold(N')$)
      content((7.1, 0.4), $bold(T')$)
    })
  )

  If $G^T M = I$ then $N^T G^T M T = N^T T = 0$, so $G = M^T$.

  To attach object $B$ to $A$, make a *scene graph*.
  1. Apply scale to $A$
  2. Apply scale, rotation and translation to move $B$ to where it will attach to $A$
  3. Apply rotation and translation to both $A$ and $B$

#grid2(
  [
    2. Transform objects to a viewing coordinate system:
      - Before: camera centred at $bold(c)$, directed at $bold(l)$, the direction of up is $bold(u)$
      - After: camera centred at origin, directed at $(0, 0, 1)$, up is $(0, 1, 0)$
  ],
  cetz.canvas({
    import cetz.draw : *

    line((0, 0), (3, -0.65))
    circle((), radius: 3pt, fill: black)
    content((3, -0.1), $l$)
    line((0, 0), (-1, -0.2), mark: (end: ">"))
    line((0, 0), (0.1, 1.5), mark: (end: ">"))

    line((0.02, 0.3), (0.3, 0.25), (0.27, -0.05))
    line((0.02, 0.295), (-0.23, 0.23), (-0.25, -0.06))
    line((0.27, -0.05), (0, -0.1), (-0.25, -0.06))

    content((0.5, 0.2), $c$)
    content((1.5,  0), $bold(hat(v))$)
    content((0.4, 1.2), $bold(hat(u))$)
    content((-0.8, 0.2), $bold(hat(r))$)
  })
)
#v(-20pt)
$
bold(hat(v)) &= (l - c)/(|l-c|) quad quad bold(hat(r)) &= (bold(u) times bold(hat(v))) / (|bold(u) times bold(hat(v))|) quad quad bold(hat(u)) &= bold(hat(v)) times bold(hat(r))
$
$
"viewing coordinates" = mat(bold(hat(r)_x), bold(hat(r)_y), bold(hat(r)_z), 0;
bold(hat(u)_x), bold(hat(u)_y), bold(hat(u)_z), 0;
bold(hat(v)_x), bold(hat(v)_y), bold(hat(v)_z), 0;
0, 0, 0, 1)
mat(1, 0, 0, -bold(c_x); 0, 1, 0, -bold(c_y);0, 0, 1, -bold(c_z);0, 0, 0, 1)
times "scene coordinates"
$

3. Projection to viewing plane.
#grid2(
  [
    $
    vec(x',y',z',w') = mat(1,0,0,0;0,1,0,0;0,0,0,1 slash d;0,0,1 slash d,0)vec(x, y, z, 1)=vec(x, y, 1 slash d, z slash d)
    $
    Corresponding to $(x d slash z, y d slash z, 1 slash z)$, the $z$ component is used for $z$-buffer.
  ],
  cetz.canvas({
    import cetz.draw : *

    line((0, 0), (4, 1.5), stroke: red)
    line((4, 1.5), (4, 0), stroke: black)
    line((0, 0), (5, 0), stroke: gray)
    line((2, 0), (2, 0.8))

    content((2, 1.3), $(x', y', d)$)
    content((4, 1.9), $(x, y, z)$)
    content((4.3, -0.3), "Object")
    content((1.9, -0.3), "Viewing plane")

    circle((4, 1.5), radius: 3pt, fill: black)
    circle((2, 0.75), radius: 3pt, fill: black)
  })
)

The *rasterisation algorithm* goes as:
0. Initialise *colour buffer* with background colour
1. Find the MVP transformation matrix
2. Apply the matrix to the vertices of all triangles
3. For each *fragment* (candidate pixel), interpolate attributes with barycentric coordinates.
4. If fragment is closer to camera than pixels drawn so far, update *colour buffer* with fragment colour, and set value of *depth buffer*.

== The OpenGL Pipeline

#grid2(width: 72%,
  tab2(
    [Step name], [Description],
    [Vertex shader], [Apply MPV transformations to all vertices],
    [Tesselation shader], [Conditionally split surface into more polygons],
    [Geometry shader], [Create new geometry (e.g. fur and volumes)],
    [(Non-programmable)], [Clipping and rasterisation],
    [Fragment shader], [E.g. phong's shading algorithm]
  ),
  [
    Shaders are written in *GLSL* and runs in parallel in the GPU.

    Operations on aggregated types (e.g. ```glsl vec4``` ) are almost as fast as single values.
  ]
)

#block(breakable: false,
  [
#grid2(
  [
    There are 1D, 2D and 3D textures. OpenGL uses a UV-map, a $(u, v)$ coordinate is defined for each vertex so by interpolation, every surface point gets a value.

    - Upscaling:
      - *Nearest neighbour* (blocky artifact)
      - *Bilinear interpolation* (blurry artifact)
    - Downsampling:
      - *Area averaging*: averages the _texels_ the pixel covers (slow)
      - *Mipmap*: stores textures in multiple resolution to avoid recalculation
  ],
  cetz.canvas({
    import cetz.draw : *

    rect((0, 0), (2, 2))

    line((0, 2.5), (2, 2.5), mark: (end: ">"))
    content((1, 2.25), $u$)
    content((0.1, 2.25), $0$)
    content((1.9, 2.25), $1$)

    line((-0.5, 2), (-0.5, 0), mark: (start: ">"))
    content((-0.25, 1.9), $1$)
    content((-0.25, 1), $v$)
    content((-0.25, 0.1), $0$)
  }),
)
Textures can be tiled so it wraps around, e.g. $T(2, 1) = T(1, 1) = T(0, 1)$
#tab2(
  [Mapping], [Description],
  [Bump mapping], [Changes normal to affect shading],
  [Displacement mapping], [Changes the shape of an object],
  [Environment mapping], [Texture with infinite distances from the source of reflection, e.g. sky box]
)

The *back buffer* is the one the GPU draws to, the *front buffer* is displayed to the screen.

#grid2(width: 35%,
  [Call *swap* when done drawing.],
  cetz.canvas({
    import cetz.draw : *

    content((-1, 0.25), "front buffer")
    content((-1, -0.25), "back buffer")
    for i in range(8) {
      let fill1;
      let fill2;

      if calc.rem(i, 2) == 1 {
        fill1 = gray
      } else {
        fill1 = white
      }

      if calc.rem(i, 2) == 1 {
        fill2 = white
      } else {
        fill2 = gray
      }

      rect((i, 0), (i+1, 0.3), fill: fill1)
      rect((i, 0), (i+0.6, -0.3), fill: fill2)
    }

    line((0, 0), (8, 0))
  }),
  [
    Use 3 buffers so the GPU always have a buffer to draw to.
  ],
  cetz.canvas({
    import cetz.draw : *

    content((-1, 0.25), "front buffer")
    content((-1, -0.25), "back buffer")

    for i in range(8) {
      let fill1;

      if calc.rem(i, 3) == 0 {
        fill1 = white
      } else if calc.rem(i, 3) == 1 {
        fill1 = gray
      } else {
        fill1 = black
      }

      rect((i, 0), (i+1, -0.3), fill: fill1)
    }

    for i in range(8) {
      let i = i - 1
      let fill1;

      if calc.rem(i, 3) == 0 {
        fill1 = white
      } else if calc.rem(i, 3) == 1 {
        fill1 = gray
      } else {
        fill1 = black
      }

      rect((i + 1.2, 0), (i+2.2, 0.3), fill: fill1)
    }

    line((0, 0), (8, 0))
  })
)

- *Tearing* happens if swap is called when the pixels are still being copied from buffer to screen.
  
  #grid2(width: 35%,
    [
      *Vsync* makes the GPU wait for a refresh cycle to complete before swapping.
    ],
    cetz.canvas({
      import cetz.draw : *

      content((-1, 0.25), "front buffer")
      content((-1, -0.25), "back buffer")

      for i in range(7) {
        line((i + 1, -0.7), (i + 1, 0.7), stroke: gray)
        line((1, -0.9), (2, -0.9), mark: (start: ">", end: ">"), stroke: gray)
        content((1.5, -1.2), "monitor scan")
      }

      for i in range(5) {
        let fill1;

        if calc.rem(i, 2) == 0 {
          fill1 = white
        } else {
          fill1 = gray
        }

        rect((i, 0), (i+1, 0.3), fill: fill1)
      }

      for i in range(2) {
        let fill1;

        if calc.rem(i, 2) == 0 {
          fill1 = white
        } else {
          fill1 = gray
        }

        rect((i + 5, 0), (i+6, 0.3), fill: fill1)
      }

      rect((0, 0), (8, 0.3))

      rect((0, 0), (0.7, -0.3), fill: gray)
      rect((1, 0), (1.5, -0.3))
      rect((2, 0), (2.8, -0.3), fill: gray)
      rect((3, 0), (3.7, -0.3))
      rect((4, 0), (5.2, -0.3), fill: gray)
      rect((6, 0), (6.7, -0.3))
      rect((7, 0), (7.5, -0.3), fill: gray)

      line((5, -1), (5.5, -0.4), mark: (end: ">"))
      content((5, -1.3), "skipped frame")

      line((0, 0), (8, 0))
    })
  )
- *Variable refresh rate* allows the GPU to control the timing of frames.

== Human Vision

3 types of cone cells $S, M, L$ are responsible for colour vision. For a particular light, the cone response for $S$ is
$R_s = int L(lambda) d lambda$
where the light intensity with wavelength $lambda$ is $L(lambda)$.

A percepted colour is entirely characterised by $R_s, R_m, R_l$.

- *Standard dynamic range* image encode only the colours that the display can show.
- *High dynamic range* tries to encode all visible wavelengths so the screen (OLED, laser, etc) can accurately display the encoded information.
There are matricies to convert between different SDR and HDR encodings.

=== Tone Mapping

#grid2(
  [
    - *Luma* is gamma corrected greyscale brightness.
    - *Exposure* changes scene white
    The *sigmoidal tone curve* mimics film.
    $
    R' = (R^b)/((L_m slash a)^b + R^b) 
    $
    $L_m$ is the median colour, $a$ shifts the curve left and right, $b$ is the steepness of the curve (contrast).
  ],
  cetz.canvas({
    import cetz.draw : *

    set-style(axes: (stroke: .5pt, tick: (stroke: .5pt)))

    cetz-plot.plot.plot(size: (6, 2.9),
    x-tick-step: none,
    y-tick-step: none, y-min: 0, y-max: 15,
    x-label: "actual luminosity",
    y-label: "screen brightness",
    {

      let domain = (0, 15)

      cetz-plot.plot.add(x => 10 * calc.exp(x - 5) / (1 + calc.exp(x - 5) + 0.5) + 2, domain: domain)
      cetz-plot.plot.add(x => 2, domain: domain)
      cetz-plot.plot.add(x => 12, domain: domain)
    })
  })
)
  ]
)
