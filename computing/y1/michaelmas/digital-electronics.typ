#import "@preview/cetz:0.4.2"
#import "@preview/zap:0.4.0"

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
    #smallcaps[Computer Science Lecture Notes]
    #h(1fr) _Digital Electronics_
  ],
)

= Digital Electronics

#definition([
  *Abstraction* is the hiding of data/complexity when they are not important,
  only expose the things needed to impletment a particular task.
])

=== Layers of Abstraction

#table(
  columns: (auto, auto),
  table.header([*Layer*], [*Examples*]),
  [Application software], [Programs],
  [Operating systems], [Device drivers],
  [Architecture], [Instructions, registers],
  [Microarchitecture], [The way the processor implements the architecture],
  [Logic elements], [Adders, memories],
  [Digital circuits], [Gates and stuff],
  [Devices], [Transistors],
  [Physics], [Electrons, quantum mechanics, Maxwell's equations]
)

This course starts at the *devices* layer.

To design something on the stack, you need to know the layer below to implement it, and the layer above to see how the thing you design is used. 

== Combinatory Logic

#definition([
  *Combinatory output* depends only on current input.
  - It has no memory.
  - The same input always gives the same output, so is entirely predictable.
])

*Boolaen algebra* is used for simplifying logic so less gates are used, so is cheaper.

=== Logic Gates

#definition([
  *Logical variables* can only take on two values.
])

In electronic circuits, they are represented by
- High voltage for 1
- Low voltage for 0
Using only 2 voltages allows circuits to have greater immunity to signal corruption caused by interference.

#definition([
  - *Logical circuits* have one or more inputs.
  - Basic logic circuits are known as *gates*.
], title: "Definitions")

Logic gates are represented in *symbol*, *truth tables* and *algebra*.
- `NOT` $overline(a)$
  - The triangle means *buffer*.
  - The circle means *complement*.
- `AND` $a dot b$.
  - A lot of these gates can be extended to have more than 2 inputs.
- `OR` $a + b$
- `XOR` $a plus.circle b$
- `NAND` $overline(a dot b)$
- `NOR` $overline(a + b)$

==== Boolean Algebra Laws

`AND` takes precedence over `OR`.

#table(
  columns: (auto, auto),
  table.header([*`OR`*], [*`AND`*]),
  [$
  a + 0 &= a \
  a + a &= a \
  a + 1 &= 1 \
  a + overline(a) &= 1
  $],
  [$
  a dot 0 &= 0 \
  a dot a &= a \
  a dot 1 &= a \
  a dot overline(a) &= 0
  $]
)

==== Commutation
$
a + b &= b + a \
a dot b &= b dot a
$

==== Association
$
(a + b) + c &= a + (b + c) \
(a dot b) dot c &= a dot (b dot c)
$

==== Distribution
$
a dot (b + c + dots) &= a dot b + a dot c + dots \
a + (b dot c dot dots) &= (a + b) dot (a dot c) dot dots
$

==== Absorption
$
a + (a dot b) &= a \
a dot (a + b) &= a
$

==== Consensus Theorem
$
a dot b + overline(a) dot c + b dot c &= a dot b + overline(a) dot c \
(a + b) dot (overline(a) + c) dot (b + c) &= (a + b) dot (overline(a) + c)
$


#definition([
  + Expand each term until it includes on instance of each variable.
  + Then simplify the terms by cancelling terms.
  $x dot y -> x dot y dot overline(z) + x dot y dot z$ to include $z$.
], title: "Technique")

==== DeMorgan's Theorem
$
overline(a + b + c + dots) &= overline(a) dot overline(b) dot overline(c) dot dots \
overline(a dot b dot c dot dots) &= overline(a) + overline(b) + overline(c) + dots
$

===== Proof
First prove for 2 varibles by truth table.

#table(
  columns: (auto, auto, auto, auto),
  table.header([$a$], [$b$], [$overline(a + b)$], [$overline(a) dot overline(b)$]),
  [0], [0], [1], [1],
  [0], [1], [0], [0],
  [1], [0], [0], [0],
  [1], [1], [0], [0],
)

Extend to more variables by induction:
$
overline((a + b) + c) &= overline(a + b) dot overline(c) \
&= overline(a) dot overline(b) dot overline(c)
$

Sometimes we wish to use `NAND` or `NOR` gates since they are usually simpler and faster. We can use DeMorgan's law to replace `AND` and `OR` to `NAND` and `NOR`.

#definition([
  - 2 consecutive bubble operations cancel.
  - Bubbles change an `AND` into an `OR` when they pass through a gate (vice versa).
], title: "Technique: Bubble Logic")

#line(length: 100%)

== Logic Minification

=== Normal Forms

A *minterm* contains all input variables of boolean function $f$ so $f$ and itself both evaluate to 1.

#table(
  columns: (auto, auto, auto),
  table.header([$x$ $y$ $z$], [$f$], [minterm]),
  [0 0 0], [1], [$overline(x) dot overline(y) dot overline(z)$],
  [0 0 1], [0], [],
  [0 1 0], [0], [],
  [0 1 1], [1], [$overline(x) dot y dot z$],
  [$dots$], [$dots$], [$dots$]
)

#definition([
  A boolean function $f$ can be written in *disjunctive normal form*
  by expressing it as the _disjunction_ (`OR`) of its minterms. (Sum of products)
  $
  f = overline(x) dot overline(y) dot overline(z) + overline(x) dot y dot overline(z) + dots
  $
])

As an inverse to minterms, *maxterm* is all the input variables where $f$ evaluates to 0.

#table(
  columns: (auto, auto, auto),
  table.header([$x$ $y$ $z$], [$f$], [maxterm]),
  [0 0 0], [1], [],
  [0 0 1], [0], [$overline(x) dot overline(y) dot z$],
  [0 1 0], [0], [$overline(x) dot y dot overline(z)$],
  [0 1 1], [1], [],
  [$dots$], [$dots$], [$dots$]
)

#definition([
  *Conjunctive normal form* is where the function is written as the product of sums.
  $
  f = (x+y+z) dot (x + overline(y) + z) dot dots
  $
])

The CNF for $f$ can be found by writing the DNF for $overline(f)$ (maxterms of $f$), then use DeMorgan's laws.

$
overline(f) &= overline(x) dot overline(y) dot z + overline(x) dot y dot overline(z) + dots \
f &= (x + y + overline(z)) dot (x + overline(y) + z) dot dots
$

=== K-Maps

Both DNF and CNF are not simplified, K-maps are useful for simplifying logical expressions of up to 5 variables.

=== SOP (Sum of Power) Simplification
+ Convert the truth table to K-map by plotting the minterms on the table in *grey code* order, so adjacent cells are logically next to each other.

  #v(-5pt)
  #grid(
    inset: 5pt,
    columns: (auto, auto),
    grid.cell([]),
    grid.cell([*$y z$*]),
    grid.cell([*$x$*]),
    grid.cell([
      #table(
        align: center,
        columns: (auto, auto, auto, auto, auto),
        [], [*00*], [*01*], [*11*], [*10*],
        [*0*], [1], [1], [1], [1],
        [*1*], [], [], [1], []
      )
    ])
  )
+ Group the minterms, the larger the groups the better.
  - Group sizes have to be a power of 2.
  - Groups can wrap around edges.
  #v(-5pt)
  #grid(
    inset: 5pt,
    columns: (auto, auto),
    grid.cell([]),
    grid.cell([*$y z$*]),
    grid.cell([*$x$*]),
    grid.cell([
      #let pat = tiling(size: (30pt, 30pt))[
        #place(line(start: (-10% - 15pt, -10%), end: (110% - 15pt, 110%), stroke: 4pt + aqua))
        #place(line(start: (-10% - 10pt, -10%), end: (110% - 10pt, 110%), stroke: 4pt + yellow))
        #place(line(start: (-10% - 5pt, -10%), end: (110% - 5pt, 110%), stroke: 4pt + aqua))
        #place(line(start: (-10%, -10%), end: (110%, 110%), stroke: 4pt + yellow))
        #place(line(start: (-10% + 5pt, -10%), end: (110% + 5pt, 110%), stroke: 4pt + aqua))
        #place(line(start: (-10% + 10pt, -10%), end: (110% + 10pt, 110%), stroke: 4pt + yellow))
        #place(line(start: (-10% + 15pt, -10%), end: (110% + 15pt, 110%), stroke: 4pt + aqua))
        #place(line(start: (-10% + 20pt, -10%), end: (110% + 20pt, 110%), stroke: 4pt + yellow))
        #place(line(start: (-10% + 25pt, -10%), end: (110% + 25pt, 110%), stroke: 4pt + aqua))
      ]
      #table(
        align: center,
        columns: (auto, auto, auto, auto, auto),
        [], [*00*], [*01*], [*11*], [*10*],
        [*0*], table.cell(fill: yellow, [1]), table.cell(fill: yellow, [1]),
        table.cell(fill: pat, [1]), table.cell(fill: yellow, [1]),
        [*1*], [], [], table.cell(fill: aqua, [1]), []
      )
    ])
  )

So the simplified function is $f = overline(x) + y dot z$

The simplified expression is in SOP form, suitable for implementations using `AND` and `OR` gates.

==== POS Simplification

+ Find a SOP Simplification for $overline(f)$.
+ Use DeMorgan's to find a POS simplification for $f$.

This is suitable for implementing using `NOR` gates.

=== _Don't Care_ Conditions

Some combinations will never happen, we can declare those _don't care_ conditions.
- They are treated as 0 or 1 depending on which gives the simpler results.
- We write them as *`X`* in K-map.

#definition([
  #table(
    columns: (auto, auto),
    table.header([*Keyword*], [*Meaning*]),
    [Cover], [A term *covers* a minterm if the minterm is part of the term.],
    [Prime implicant], [A term that cannot be further combined.],
    [Essential prime implicant], [A term that covers a minterm that no other prime implicant covers.],
    [Covering set], [A minimu set of prime implicants which covers all minterms.]
  )
], title: "Definitions"))

=== Q-M Method
+ List all minterms and _don't care_ terms, group them by the number of *`1`*s.
  #grid(
    columns: (50%, 50%),
    [
      - Minterms: 4, 5, 6, 8, 9, 10, 13
      - _Don't care_ terms: 0, 7, 15
    ],

    grid(
      columns: (auto),
      inset: 6pt,
      [
        `0000`
      ],
      [
        `0100` \
        `1000`
      ],
      [
        `0101` \
        `0110` \
        `1001` \
        `1010`
      ],
      [
        `1101` \
        `0111`
      ],
      [
        `1111`
      ]
    )

  )
+ If two terms differ by 1 digit (e.g. `0000` and `0100`), merge them and write it on the next column (e.g. `0-00` where "`-`" is a wildcard), put a tick next to them. Merge all terms that can be merged, including previously ticked terms.

    Repeat for the 2nd column, and write the merge terms to the 3rd column, until no more terms can be merged.
    #grid(
      columns: (30%, 30%, 30%),
      [
        *Column 1*
        #grid(
          columns: (auto),
          inset: 10pt,
          [
            `0000` $checkmark$
          ],
          [
            `0100` $checkmark$ \
            `1000` $checkmark$
          ],
          [
            `0101` $checkmark$ \
            `0110` $checkmark$ \
            `1001` $checkmark$ \
            `1010` $checkmark$
          ],
          [
            `1101` $checkmark$ \
            `0111` $checkmark$
          ],
          [
            `1111` $checkmark$
          ]
        )],

        [
          *Column 2*
          #grid(
            columns: (auto),
            inset: 10pt,
            [
              `0-00` \
              `-000`
            ],
            [
              `010-` $checkmark$ \
              `01-0` $checkmark$ \
              `100-` \
              `10-0`
            ],
            [
              `-101` $checkmark$ \
              `01-1` $checkmark$ \
              `011-` $checkmark$ \
              `1-01`
            ],
            [
              `11-1` $checkmark$ \
              `-111` $checkmark$
            ],
          )],
        [
          *Column 3*
          #grid(
            columns: (auto),
            inset: 10pt,
            [
              `01--` \
            ],
            [
              `-1-1`
            ],
          )],
        )

+ The unmergable terms (no ticks beside them) are the *prime implicants*. We need to get rid of some of those terms to find the *mincover*.
  
  Create an *implication chart* with the *prime implicants* and the *minterms*. Put an `X` where the minterm can be expressed as the prime implicant. (e.g. $4_(10)=0100_2$ can be expressed as `0-00`)

  #table(
    align: center,
    columns: (40pt,) + range(1, 8).map(_ => 20pt),
    [], [4], [5], [6], [8], [9], [10], [13],
    `0-00`, `X`, [], [], [], [], [], [],
    `-000`, [], [], [], `X`, [], [], [],
    `100-`, [], [], [], `X`, `X`, [], [],
    `10-0`, [], [], [], `X`, [], `X`, [],
    `1-01`, [], [], [], [], `X`, [], `X`,
    `01--`, `X`, `X`, `X`, [], [], [], [],
    `-1-1`, [], `X`, [], [], [], [], `X`,
  )

+ Look for *essential prime indicants*: 6 is only covered by `01--`, and 10 only by `10-0`, they are essential prime indicants. Cross the two row out, also cross out the numbers they cover.
  #table(
    align: center,
    columns: (40pt,) + range(1, 8).map(_ => 20pt),
    [], table.cell([4], fill: aqua), table.cell([5], fill: aqua), table.cell([6], fill: aqua),
    table.cell([8], fill: aqua), [9], table.cell([10], fill: aqua), [13],
    `0-00`, `X`, [], [], [], [], [], [],
    `-000`, [], [], [], `X`, [], [], [],
    `100-`, [], [], [], `X`, `X`, [], [],
    table.cell(`10-0`, fill: aqua), table.cell([], fill: aqua), table.cell([], fill: aqua),
    table.cell([], fill: aqua), table.cell(`X`, fill: aqua), table.cell([], fill: aqua), table.cell(`X`, fill: aqua), table.cell([], fill: aqua),
    `1-01`, [], [], [], [], `X`, [], `X`,
    table.cell(`01--`, fill: aqua), table.cell(`X`, fill: aqua), table.cell(`X`, fill: aqua),
    table.cell(`X`, fill: aqua), table.cell([], fill: aqua), table.cell([], fill: aqua), table.cell([], fill: aqua), table.cell([], fill: aqua),
    `-1-1`, [], `X`, [], [], [], [], `X`,
  )
+ Cross out as few rows as possible to cover the remaining (uncovered) numbers.
  #table(
    align: center,
    columns: (40pt,) + range(1, 8).map(_ => 20pt),
    [], table.cell([4], fill: aqua), table.cell([5], fill: aqua), table.cell([6], fill: aqua),
    table.cell([8], fill: aqua), table.cell([9], fill: aqua), table.cell([10], fill: aqua), table.cell([13], fill: aqua),
    `0-00`, `X`, [], [], [], [], [], [],
    `-000`, [], [], [], `X`, [], [], [],
    `100-`, [], [], [], `X`, `X`, [], [],
    table.cell(`10-0`, fill: aqua), table.cell([], fill: aqua), table.cell([], fill: aqua),
    table.cell([], fill: aqua), table.cell(`X`, fill: aqua), table.cell([], fill: aqua), table.cell(`X`, fill: aqua), table.cell([], fill: aqua),
    table.cell(`1-01`, fill: aqua), table.cell([], fill: aqua), table.cell([], fill: aqua),
    table.cell([], fill: aqua), table.cell([], fill: aqua), table.cell(`X`, fill: aqua), table.cell([], fill: aqua), table.cell(`X`, fill: aqua),
    table.cell(`01--`, fill: aqua), table.cell(`X`, fill: aqua), table.cell(`X`, fill: aqua),
    table.cell(`X`, fill: aqua), table.cell([], fill: aqua), table.cell([], fill: aqua), table.cell([], fill: aqua), table.cell([], fill: aqua),
    `-1-1`, [], `X`, [], [], [], [], `X`,
  )

  The prime implicants we picked are `10-0`, `1-01` and `01--`, giving the simplification.
  $
  f = a dot overline(b) dot overline(c) + a dot overline(c) dot d + overline(a) dot b
  $

#line(length: 100%)

  == Binary Adders

  We are doing the *compositional approach*, where we put half adders and full adders together to build a *ripple carry adder*.

  === Half Adder

  #grid(
    columns: (47%, 28%),
    [
      Adds two bits together.

      By inspection or simplifying minterms:
      $
      "sum" &= a plus.circle b \
      c_"out" &= a dot b
      $
    ],
    table(
      columns: (auto, auto, auto, auto),
      table.header([*$a$*], [*$b$*], [*$c_"out"$*], [*sum*]),
      [0], [0], [0], [0],
      [0], [1], [0], [1],
      [1], [0], [0], [1],
      [1], [1], [1], [0],
    )
  )

  === Full Adder

  #grid(
    columns: (45%, 28%, 28%),
    [
      $
      "sum" &= a plus.circle b plus.circle c_"in" \
      c_"out" &= a dot b + c_"in" dot (a + b)
      $
    ],
    table(
      columns: (auto, auto, auto, auto, auto),
      table.header([*$c_"in"$*], [*$a$*], [*$b$*], [*$c_"out"$*], [*sum*]),
      [0], [0], [0], [0], [0],
      [0], [0], [1], [0], [1],
      [0], [1], [0], [0], [1],
      [0], [1], [1], [1], [0],
    ),
    table(
      columns: (auto, auto, auto, auto, auto),
      table.header([*$c_"in"$*], [*$a$*], [*$b$*], [*$c_"out"$*], [*sum*]),
      [1], [0], [0], [0], [0],
      [1], [0], [1], [1], [0],
      [1], [1], [0], [1], [0],
      [1], [1], [1], [1], [1],
    )
  )

=== Ripple Carry Adder

Cascade multiple of these adders together to make a ripple carry adder.

#let full_adder(x, y, handle: 0.5) = {
  import cetz.draw : *
    rect((x+ 0, y + 0), (x + 1.5, y + 1.5))
    content((x + 0.5, y + 1.45), $a$, anchor: "north")
    content((x + 1,y +  1.45), $b$, anchor: "north")
    content((x + 0.05, y + 0.75), $c_"in"$, anchor: "west")
    content((x + 1.45, y + 0.75), $c_"out"$, anchor: "east")
    content((x + 0.75, y + 0.05), "sum", anchor: "south")

    line((x + 0.5, y + 1.5), (x + 0.5, y + 1.5 + handle))
    line((x + 1, y + 1.5), (x + 1, y + + 1.5 + handle))
    line((x + 0.75, y + 0), (x + 0.75, y + -0.5))
  }

#cetz.canvas({
  import cetz.draw : *

  line((-0.5, 2), (-0.5, 0.75), (0, 0.75))
  content((-0.5, 2.05), $c_0$, anchor: "south")
  line((8, -0.5), (8, 0.75))
  content((8, -0.55), $c_4$, anchor: "north")

  for x in range(4) {
    content((x * 2 + 0.5, 2.05), $a_#(x + 1)$, anchor: "south")
    content((x * 2 + 1, 2.05), $b_#(x + 1)$, anchor: "south")
    content((x * 2 + 0.75, -0.55), $s_#(x + 1)$, anchor: "north")
    line((x * 2 + 1.5, 0.75), (x * 2 + 2, 0.75))
    full_adder(x * 2, 0)
  }
})

A 4 bit adder has 4 full adders.
- $c_0$ propagates from left to right.
- Physically, they have finite propagation delay, so there is a delay between the inputs and outputs.

If we complement $a$ then set $c_0$ to 1, we have $s = b - a$.

=== Speeding Things Up

- Design the adder as a single block of 2-level combinational logic with $2n$ inputs and $n$ outputs.
  - Low delay.
  - Truth table is massive, and simplification is complicated. It is very complex to design.

==== Fast Carry Generation

#{
  let a(content) = table.cell([#content], fill: aqua)
  let b(content) = table.cell([#content], fill: lime)
  let c(content) = table.cell([#content], fill: yellow)

  grid(
    columns: (65%, auto),
    cetz.canvas({
      import cetz.draw : *

      line((-0.5, 2), (-0.5, 0.75), (0, 0.75))
      content((-0.5, 2.05), $c_0$, anchor: "south")
      content((8, -0.55), $c_4$, anchor: "north")

      rect((0, 2.2), (8.25, 1.7))
      line((8, 1.7), (8, -0.5))

      for x in range(4) {
        content((x * 2 + 0.5, 2.75), $a_#(x + 1)$, anchor: "south")
        content((x * 2 + 1, 2.75), $b_#(x + 1)$, anchor: "south")
        content((x * 2 + 0.75, -0.55), $s_#(x + 1)$, anchor: "north")
        content((4.125, 1.9), "Fast Carry Generation")
        line((x * 2 + 0.5, 2.2), (x * 2 + 0.5, 2.7))
        line((x * 2 + 1, 2.2), (x * 2 + 1, 2.7))

        if x != 3 {
          line((x * 2 + 1.75, 1.7), (x * 2 + 1.75, 0.75), (x * 2 + 2, 0.75))
        }
        full_adder(x * 2, 0, handle: 0.2)
      }
    }),
    [
      #table(
        columns: (auto, auto, auto, auto),
        align: center,
        table.header([*$c_"in"$*], [*$a$*], [*$b$*], [*$c_"out"$*]),
        a("?"), a(0), a(0), a(0),
        b("?"), b(0), b(1), b("?"),
        b("?"), b(1), b(0), b("?"),
        c("?"), c(1), c(1), c("1"),
      )

      - If $overline(a_i) dot overline(b_i) = 1$ then $c_"out" = 0$
      - If $a_i plus.circle b_i$ then $c_"out" = c_"in"$
      - If $a_i dot b_i$ then $c_"out" = 1$
    ]
  )
}

Fast carry generation precomputes the relation between $c_"out"$ and $c_"in"$, so once $c_"in"$ is provided, only one gate delay is needed to calculate $c_"out"$.
- Lot's of gates are used in carry generation.
- Usually two 4-bit carry generators are used in an 8-bit adder.

== Multilevel Logic

The ripple adder is a multilevel logic - as it cascades, it forms many levels.
- It's difficult to buy large logic gates, we can use multilevel logic to expand the input.
- But it can introduce delays and *hazards*.

=== Reducing Number of Gates

Simplified SOP expressions requires a lot of gates to do.

The logic below uses 9 literals, 7 gates, 2 levels.
$
z &= a dot d dot f + a dot e dot f + b dot d dot f + b dot e dot f + c dot d dot f + c dot e dot f + g \
&=(a dot d + a dot e + b dot d + b dot e + c dot d) dot f + g \
&=(a + b + c) dot (d + e) dot f + g
$

We have recursively factored out common literals and express $z$ in *two-level form*.
$
x &= a + b + c \
y &= d + e \
z &= x dot y dot f + g
$
It uses 9 literals, 4 gates, 3 levels. The more levels the bigger the propagation delay.

=== Hazards

#definition([
  *Hazards* are brief changes in output (when there is a change in input), also called a *glitch*.
])

#table(
  columns: (auto, auto),
  table.header([*Type*], [*Description*]),
  [ Static hazard ], [ Output undergoes momentary transition when one input changes when it is supposed to remain unchanged.],
  [ Static 1 hazard ], [ Output should stay at 1, but as signal changes it briefly drops to zero.],
  [ Static 0 hazard ], [ The opposite of a static 1 hazard. ],
  [ Dynamic hazard ], [ Output changes more than once as opposed to just once.],
)

This is due to the difference in *propagation delay* between layers.

==== Removing Hazards
+ Plot the function on a K-map.
+ If the square it is moved from and to are not in the same group, there is a hazard.
+ Add an extra term containing the two squares to remove the static 1 hazard.

To remove a static 0 hazard, draw a K-map of the complement of the output.

#line(length: 100%)

== Multiplexers

#definition([
  *Multiplexers* (mux/selector) chooses 1 of many inputs to output according to the control input.
])

#let and_gate(
  (x, y),
  size: 1.0,
  out_length: 0.5,
  in_a_length: 0.5,
  in_b_length: 0.5,
) = {
  import cetz.draw : *
  line((x + 0.5 * size, y), (x, y), (x, y + 1 * size), (x + 0.5 * size, y + 1 * size))
  arc((x + 0.5 * size,y), start: -90deg, stop: 90deg, radius: 0.5 * size)
  line((x + 1.0 * size, y + 0.5 * size), (x + (1.0 + out_length) * size, y + 0.5 * size))
  line((x, y + 0.7 * size), (x - in_a_length * size, y + 0.7 * size))
  line((x, y + 0.3 * size), (x - in_b_length * size, y + 0.3 * size))
}

#let or_gate(
  (x, y),
  size: 1.0,
  out_length: 0.5,
  in_a_length: 0.5,
  in_b_length: 0.5,
) = {
  import cetz.draw : *
  arc((x,y), start: -45deg, stop: 45deg, radius: 0.5 * size * calc.sqrt(2))
  arc((x, y + size), start: 90deg, stop: 83deg, radius: size * 3.5)
  arc((x + 0.425 * size, y + 0.9745 * size), start: 83deg, stop: 18deg, radius: size * 0.7)
  arc((x, y), start: -90deg, stop: -83deg, radius: size * 3.5)
  arc((x + 0.425 * size, y + (1 - 0.9745) * size), start: -83deg, stop: -18deg, radius: size * 0.7)
  line((x + size, y + 0.5 * size), (x + (1 + out_length) * size, y + 0.5 * size))
  line((x -in_a_length * size, y + 0.7 * size), (x + 0.19 * size, y + 0.7 * size))
  line((x -in_a_length * size, y + 0.3 * size), (x + 0.19 * size, y + 0.3 * size))
}

#let not_gate(
  (x, y),
  size: 1.0,
  out_length: 0.5,
  in_length: 0.5,
) = {
  import cetz.draw : *
  line((x + size * 0.93, 0.5 * size + y), (x, y), (x, size + y), (x + size * 0.93, 0.5*size + y))
  line((x, y + 0.5 * size), (x - in_length * size, y + 0.5 * size))
  line((x + 1.0 * size, y + 0.5 * size), (x + (1.0 + out_length) * size, y + 0.5 * size))
  circle((x + size * 0.95, size * 0.5 + y), fill: white, radius: 0.12 * size)
}

#let nor_gate(
  (x, y),
  size: 1.0,
  in_a_length: 0.5,
  in_b_length: 0.5,
  out_length: 0.5,
) = {
  import cetz.draw : *
  arc((x,y), start: -45deg, stop: 45deg, radius: 0.5 * size * calc.sqrt(2))
  arc((x, y + size), start: 90deg, stop: 83deg, radius: size * 3.5)
  arc((x + 0.425 * size, y + 0.9745 * size), start: 83deg, stop: 18deg, radius: size * 0.7)
  arc((x, y), start: -90deg, stop: -83deg, radius: size * 3.5)
  arc((x + 0.425 * size, y + (1 - 0.9745) * size), start: -83deg, stop: -18deg, radius: size * 0.7)
  line((x + size, y + 0.5 * size), (x + (1 + out_length) * size, y + 0.5 * size))
  line((x -in_a_length * size, y + 0.7 * size), (x + 0.19 * size, y + 0.7 * size))
  line((x -in_b_length * size, y + 0.3 * size), (x + 0.19 * size, y + 0.3 * size))
  circle((x + size * 1.05, size * 0.5 + y), fill: white, radius: 0.12 * size)
}

=== 2-to-1 Selector
#grid(
  columns: (25%, 25%, auto),
  cetz.canvas({
    import cetz.draw : *
    rect((0, 0), (1, 1.5))
    content((0.5, 0.75), "Mux")
    line((-0.5, 0.5), (0, 0.5))
    line((-0.5, 1), (0, 1))
    line((0.5, 0), (0.5, -0.5))
    line((1, 0.75), (1.5, 0.75))
    content((-0.7, 1.05), $a$)
    content((-0.7, 0.55), $b$)
    content((1.7, 0.75), $f$)
    content((0.5, -0.65), $x$)
  }),
  table(
    align: center,
    columns: (auto, auto, auto, auto),
    table.header([*$a$*], [*$b$*], [*$x$*], [*$f$*]),
    [`X`], [$b$], `0`, [$b$],
    [$a$], [`X`], `0`, [$a$],
  ),
  cetz.canvas({
    import cetz.draw : *
    line((-0.2, 0), (1, 0), (1, 0.3), (1.1, 0.3))
    and_gate((1.25, 0.15), size: 0.5)
    or_gate((2.25, 0.6), size: 0.5)
    line((1.8, 0.4), (2, 0.4), (2, 0.75), (2.1, 0.75))
    and_gate((1.25, 0.15), size: 0.5)
    and_gate((1.25, 1.05), size: 0.5)
    line((2.1, 0.95), (2, 0.95), (2, 1.3), (1.9, 1.3))
    not_gate((0.5,0.25), size: 0.5)
    line((-0.2, 1.2), (1, 1.2))
    line((-0.2, 1.4), (1, 1.4))
    line((0.25, 1.2), (0.25, 0.5), (0.3, 0.5))
    content((-0.4, 0.05), $b$)
    content((-0.4, 1.2), $x$)
    content((-0.4, 1.5), $a$)
    content((3.2, 0.85), $f$)
  }),
)

You can also express it as the sum of minterms with using a full truth table.
- $n$-to-1 mux is possible - an 8:1 mux requires 3 control lines.
- The mux is also called a hardware lookup table.

Sometimes it is possible to use less control lines if we use the logic variables as control input.

#grid(
  columns: (25%, 20%, auto),
  table(
    columns: (auto, auto, auto, auto),
    align: center,
    table.header([*$a$*], [*$b$*], [*$x$*], [*$f$*]),
    [`0`], [`0`], [`0`], [`1`],
    [`0`], [`0`], [`1`], [`0`],
    [`0`], [`1`], [`0`], [`1`],
    [`0`], [`1`], [`1`], [`0`],
    [`1`], [`0`], [`0`], [`0`],
    [`1`], [`0`], [`1`], [`0`],
    [`1`], [`1`], [`0`], [`1`],
    [`1`], [`1`], [`1`], [`1`],
  ),
  table(
    columns: (auto, auto),
    table.header([*$x y$*], [*$f$*]),
    `00`, $overline(z)$,
    `01`, $overline(z)$,
    `10`, `0`,
    `11`, `1`,
  ),
  cetz.canvas({
    import cetz.draw : *

    rect((0, 0), (2.5, 2.5))
    let ins = ($overline(z)$, $overline(z)$, `0`, `1`)
    for i in range(4) {
      content((0.3, 2 - i * 0.5), $I_#i$)
      content((-1.2, 2 - i * 0.5), ins.at(i))
      line((-1, 2 - i * 0.5), (0, 2 - i * 0.5))
    }

    content((1.6, 0.3), $S_0$)
    content((2.15, 0.3), $S_1$)
    line((1.6, 0), (1.6, -1))
    line((2.15, 0), (2.15, -1))
    content((1.6, -1.15), $x$)
    content((2.15, -1.15), $y$)

    content((2.15, 2), $F$)
    line((2.5, 2), (3.5, 2))
    content((3.65, 2), $f$)
  })
)

=== Demultiplexer

A single output is directed to exactly one of its inputs.

#grid(
  columns: (25%, 25%, auto),
  cetz.canvas({
    import cetz.draw : *
    content((0.5, 0.75), [De-\ mux])
    rect((0, 0), (1, 1.5))
    content((-0.7, 0.75), $g$)
    content((1.7, 0.5), $f_1$)
    content((1.7, 1), $f_0$)
    content((0.5, -0.65), $x$)
    line((-0.5, 0.75), (0, 0.75))
    line((1, 0.5), (1.5, 0.5))
    line((1, 1), (1.5, 1))
    line((0.5, 0), (0.5, -0.5))
  }),
  table(
    align: center,
    columns: (auto, auto, auto, auto),
    table.header([*$g$*], [*$x$*], [*$f_0$*], [*$f_1$*]),
    $g$, `0`, $g$, `0`,
    $g$, `1`, `0`, $g$,
  ),
  cetz.canvas({
    import cetz.draw : *
    line((0, 0), (1, 0))
    line((0, 0.55), (1.9, 0.55))
    line((1.7, 0), (1.75, 0), (1.75, 0.35), (1.8, 0.35))
    not_gate((1, -0.25), size: 0.5)
    and_gate((2, 0.2), size: 0.5)
    and_gate((2, -1), size: 0.5)
    line((0.7, 0.55), (0.7, -0.65), (1.8, -0.65))
    line((0.3, 0.55), (0.3, -0.85), (1.8, -0.85))
    content((-0.15, 0.05), $x$)
    content((-0.15, 0.6), $g$)
    content((2.95, 0.45), $f_0$)
    content((2.95, -0.75), $f_1$)
  }),
)

Larger demultiplexers are possible, e.g. a 3:8 demux.

A *decoder* is a demux where $g$ is permanently set to `1`, so only one output is `1` at any time. An *enabler* enables 1 out of $n$ logical subsystems.

If the number of pins is limited, using a decoder/multiplexer is essential.
- Without decoder: you need 8 pins to control 8 subsystems.
- With decoder: you need 3 pins to control 8 subsystems.

We can also create any combinational logic block using the decoder. By OR-ing the outputs that corresponds to the minterms of the logic.

=== ROM

ROM is a storage device that can be
- Written into once
- Read at will
- Non-volatile
- Essentially a lookup table: $n$ output lines specify the address of location holding $m$-bit data words.

The ROM has $2^n$ possible locations.

We can create any combinational logic by holding all the minterms in ROM and output the stored value.
- No simplification needed.
- Reasonably efficient if lots of minterms need to be generated.
- Can be inefficiently large if many spaces are zero (there are very few minterms).

=== Programmable Logic Array

In a PLA, only the required minterms are generated using the *AND-plane* and *OR-plane*.

#cetz.canvas({
  import cetz.draw : *

  for i in range(3) {
    line((0, i), (12, i))
    line((1.5, i + 0.5), (12, i + 0.5))
    line((0.75, i), (0.75, i + 0.5), (0.8, i + 0.5))
    not_gate((1, i + 0.25), size: 0.5)

    for x in range(3) {
      line((x + 2 + i / 4, i), (x + 2 + i / 4, -1 - (2 - x) * 1.5 - (0.5 - i / 4)), (5, -1 - (2 - x) * 1.5 - (0.5 - i / 4)))
      line((x + 2 + i / 4 + 0.125, i + 0.5), (x + 2 + i / 4 + 0.125, -(1.375 - i / 4) - (2 - x) * 1.5), (5, -(1.375 - i / 4) - (2 - x) * 1.5))
    }
  }

  and_gate((5, -4.7), in_a_length: 0, in_b_length: 0)
  and_gate((5, -3.2), in_a_length: 0, in_b_length: 0)
  and_gate((5, -1.7), in_a_length: 0, in_b_length: 0)

  line((6, -1.2), (8, -1.2), (8, -8))
  line((6, -2.7), (7.5, -2.7), (7.5, -8))
  line((6, -4.2), (7, -4.2), (7, -8))

  for i in range(3) {
    or_gate((9, -i * 1.5 - 5))
    line((8, -i * 1.5 - 4.3), (9, -i * 1.5 - 4.3))
    line((7.5, -i * 1.5 - 4.5), (9.2, -i * 1.5 - 4.5))
    line((7, -i * 1.5 - 4.7), (9, -i * 1.5 - 4.7))
  }

  content((-0.2, 0.05), $c$)
  content((-0.2, 1.05), $b$)
  content((-0.2, 2.05), $a$)

  content((10.7, -4.5), $f_0$)
  content((10.7, -6), $f_1$)
  content((10.7, -7.5), $f_2$)
})

The PLA is programmed by selectively removing connections from the AND-plane and OR-plane.

==== Programmable Array Logic

To simplify design, the OR-plane is not programmable. There are instead multiple AND-planes each connected to an OR gate.

=== Memory Applications

Other memory devices includes:
- Non-volatile memory by ROMs and flash.
- Volatile memory offered by static RAM or dynamic RAM (much denser than SRAM, but has to be refreshed regularly).

Memory is connected to the CPU using *buses*.

#definition([
  *Buses* are a bunch of wires in parallel.
])

- The *address bus* specify the memory location being accessed.
- The *data bus* conveys data to and from that location.

==== Using Multiple Memory Devices

More than 1 memory device can be connected to the same bus wires. *Tristate buffers* controls which devices to enable by disconnecting the device from the bus when not selected.

#grid(
  columns: (70%, auto),
  [
    The tristate buffers are controlled by *output enabled* (OE) control signals, the other control signals are:
    - *Write enable* (WE) determines whether data is written or read.
    - *Chip select* (CS) determines if the chip is activated, otherwise the chip is powered down to conserve power.
  ],
  cetz.canvas({
    import cetz.draw : *

    for i in range(4, step: 2) {
      line((0, i), (1, i + 0.5), (0, i + 1), (0, i))
      line((0.5, i + 0.25), (0.5, i - 0.25))
      line((-0.5, i + 0.5), (0, i + 0.5))
      line((1, i + 0.5), (1.5, i + 0.5))
      content((0.5, i - 0.4), [OE = #(i / 2)])
    }

    line((1.5, 0), (1.5, 3))
    content((1.9, 1.5), [ Bus ])
  })
)


== Sequential Logic
... is the end to combinational logic.
- *Combinational logic* depends only on the condition of the latest inputs.
- *Sequential logic* also depend on earlier inputs.

#definition([
  - *Memory* stores data from earlier.
  - A snapstop of memory is called *state*.
  - 1 bit memory is called a *bistable*.
], title: "Definitions")

*Flip-flops* and *latches* are are implementations of bistable.

=== RS-Latch

The RS-latch is a memory element with 2 inputs.
Where $Q$ is the current state, and $Q'$ the next state.

#grid(
  columns: (40%, auto),
  table(
    align: center,
    columns: (auto, auto, auto, auto, auto),
    table.header([*$S$*], [*$R$*], [*$Q'$*], [*$overline(Q)$*], [*Comment*]),
    `0`, `0`, $Q$, $overline(Q)$, [ hold ],
    `0`, `1`, `0`, `1`, [ reset ],
    `1`, `0`, `1`, `0`, [ set ],
    `1`, `1`, `X`, `X`, [ illegal ],
  ),
  cetz.canvas({
    import cetz.draw : *

    nor_gate((0, 2), in_a_length: 1)
    nor_gate((0, 0), in_b_length: 1)
    line((1.5, 0.5), (3, 0.5))
    line((1.5, 2.5), (3, 2.5))
    line((2, 0.5), (2, 1), (-0.5, 1.8), (-0.5, 2.3), (-0.4, 2.3))
    line((2, 2.5), (2, 2), (-0.5, 1.2), (-0.5, 0.7), (-0.4, 0.7))
    content((-1.3, 0.3), $S$)
    content((-1.3, 2.7), $R$)
    content((3.3, 2.5), $Q$)
    content((3.3, 0.5), $overline(Q)$)
    content((0.5, 2.5), [1])
    content((0.5, 0.5), [2])
  })
)

- Consider $R=1$ and $S=0$:
  - Gate 1 is 0, so $Q$ is 0.
  - Gate 2 gives complement of gate 1, so 1.
- Consider $R=0$ and $S=0$:
  - Gate 1 gives the complement of gate 2.
  - Gate 2 gives the complement of gate 1, which is the hold condition.

==== State Transition Diagrams
+ Create a truth table of the RS-latch.
  #grid(
    columns: (48%, auto),
    table(
      columns: (auto, auto, auto, auto, auto),
      align: center,
      table.header([*$Q$*], [*$S$*], [*$R$*], [*$Q'$*], [*Comment*]),
      `0`, `0`, `0`, `0`, [hold],
      `0`, `0`, `1`, `0`, [reset],
      `0`, `1`, `0`, `1`, [set],
      `0`, `1`, `1`, `0`, [illegal],
    ),
    table(
      columns: (auto, auto, auto, auto, auto),
      align: center,
      table.header([*$Q$*], [*$S$*], [*$R$*], [*$Q'$*], [*Comment*]),
      `1`, `0`, `0`, `1`, [hold],
      `1`, `0`, `1`, `0`, [reset],
      `1`, `1`, `0`, `1`, [set],
      `1`, `1`, `1`, `0`, [illegal],
    )
  )
+ Consider all cases where $Q=1$ and $Q'=1$.
  #grid(
    columns: (35%, auto),
    table(
      columns: (auto, auto, auto,  auto),
      align: center,
      table.header([*$Q$*], [*$S$*], [*$R$*], [*$Q'$*]),
      `1`, `0`, `0`, `1`,
      `1`, `1`, `0`, `1`,
    ),
    [
      So when $Q = 1$, the next state $Q' = 1$ if
      $
      overline(S) dot overline(R) + S dot overline(R) = overline(R)
      $
    ]
  )
+ Repeat this for all other state transitions, we get.
  #cetz.canvas({
    import cetz.draw : *

    arc((0, 0), start: 120deg, stop: 60deg, radius: 4)
    arc((0, 0), start: -120deg, stop: -60deg, radius: 4)
    circle((-1, 0), radius: 0.5)
    circle((5, 0), radius: 0.5)
    circle((0, 0), radius: 0.7, fill: white)
    content((), $Q = 0$)
    circle((4, 0), radius: 0.7, fill: white)
    content((), $Q = 1$)
    polygon((2, 0.54), 3, fill: black, radius: 0.1)
    polygon((2, -0.54), 3, fill: black, radius: 0.1, angle: 180deg)
    polygon((-1.5, 0), 3, fill: black, radius: 0.1, angle: 90deg)
    polygon((5.5, 0), 3, fill: black, radius: 0.1, angle: -90deg)
    content((2, 0.9), $S dot overline(R)$)
    content((2, -0.9), $R$)
    content((-1.8, 0), $overline(S) + R$, anchor: "east")
    content((5.8, 0), $overline(R)$, anchor: "west")
  })

#line(length: 100%)

=== Transparent D-Latch

The output of a transparent D-latch will only change when there is a global *enable signal* called the system clock. This makes it easier to design large scale systems, as opposed to letting the circuits change state when ever the input changes.

#definition([
  The *system clock* produces square wave signals at a frequency.
  - Imposes order on state changes.
  - Allows a lot of states to update simultaneously.
])

#grid(
  columns: (42%, auto),
  gutter: 10pt,
  [
    Modify the RS-Latch so the signal only change there is an enabling signal.

    - There is only 1 input, $R$ and $S$ are complement of each other, so we can never set both of them to 1, avoiding the unwanted combination.
  ],
  cetz.canvas({
    import cetz.draw : *

    and_gate((-2.2, 2.2))
    and_gate((-2.2, -0.2))
    nor_gate((0, 2), in_a_length: 1)
    nor_gate((0, 0), in_b_length: 1)
    line((1.5, 0.5), (3, 0.5))
    line((1.5, 2.5), (3, 2.5))
    line((2, 0.5), (2, 1), (-0.5, 1.8), (-0.5, 2.3), (-0.4, 2.3))
    line((2, 2.5), (2, 2), (-0.5, 1.2), (-0.5, 0.7), (-0.4, 0.7))
    content((-0.5, 0), $S$)
    content((-0.5, 3), $R$)
    content((3.3, 2.5), $Q$)
    content((3.3, 0.5), $overline(Q)$)
    line((-3.2, 0.5), (-2.7, 0.5), (-2.7, 2.5), (-2.5, 2.5))
    content((-3.6, 0.5), $E N$)
    not_gate((-4, 2.4))
    line((-5.2, 0.1), (-4.5, 0.1), (-4.5, 2.9), (-4.3, 2.9))
    line((-5.2, 0.1), (-2.5, 0.1))
    content((-5.5, 0.1), $D$)
  }),
  [
    The square box means it is *level activated*. When it is enabled, it is in *transparent mode*.
    - $Q = D$ if $E N = 1$
    - $Q$ remains in previous state if $E N = 0$
  ],
  cetz.canvas({
    import cetz.draw : *
    rect((0, 0), (1.5, 2))
    rect((0.6, 0), (0.9, 0.2))
    line((0.75, -0.7), (0.75, 0))
    line((-0.7, 1), (0, 1))
    line((1.5, 1), (2.2, 1))
    content((0.25, 1), $D$)
    content((1.25, 1), $Q$)
    content((0.75, -0.9), $E N$)
  }),
)

=== Master Slave Flip-Flops

#grid(
  columns: (45%, 42%, auto),
  [
    The output changes only on a rising edg.

    - It is much simpler to design sequential circuits if outputs only changes on rising or falling edges.
    - In lab we use a truly F-F device (not affected by propagation delay).
  ],
  cetz.canvas({
    import cetz.draw : *
    rect((0, 0), (1.5, 2))
    rect((0.6, 0), (0.9, 0.2))
    line((0.75, -0.7), (0.75, 0))
    line((-0.7, 1), (0, 1))
    line((1.5, 1), (2.2, 1))
    content((0.25, 1), $D$)
    content((1.25, 1), $Q$)

    rect((2.2, 0), (3.7, 2))
    line((2.95, -0.7), (2.95, 0))
    rect((2.8, 0), (3.1, 0.2))
    line((3.7, 1), (4.2, 1))
    content((2.45, 1), $D$)
    content((3.45, 1), $Q$)
    not_gate((1.5, -1.1), size: 0.75)
    not_gate((-0.7, -1.1), size: 0.75)
    line((0.2, -0.725), (1.2, -0.725))
    line((2.4, -0.725), (2.95, -0.725), (2.95, -0.5))
    content((-1, 1), $D$)
    content((4.45, 1), $Q$)
    content((-1.5, -0.725), $C l k$)
  }),
  cetz.canvas({
    import cetz.draw : *
    rect((0, 0), (1.5, 2))
    line((0.75, -0.7), (0.75, 0))
    line((-0.5, 1), (0, 1))
    line((1.5, 1), (2, 1))
    content((0.25, 1), $D$)
    content((1.25, 1), $Q$)
    content((0.75, -0.9), $E N$)
    line((0.6, 0), (0.75, 0.25), (0.9, 0))
  }),
)

=== Other Types of Flip-Flops
- The *JK F-F*: a clocked RS F-F that has 2 outputs $Q$ and $overline(Q)$. The illegal state now represents *toggle*.
- The *T F-F*: similar to the D F-F but there are 2 outputs.


=== Asynchronous Inputs

It is common for F-Fs to have additional asynchronous inputs which are independent of clock signals.
- Reset/clear: set $Q$ to 0
- Preset/set: set $Q$ to 1

==== Timing

The transparent D-latch requires
- $D$ to change before a minimum *setup time* $t_"su"$ before the clock signal.
- The data is held for *hold time* $t_"h"$ after the clock edge.
- Then the output will change in *propagation delay* $t_"p"$ after the clock edge.

== Flip-Flops Applications

#definition([
  A *counter* is a clock sequential circuit that goes through a predetermined sequence of states.
])

A *ripple counter* can be made by cascading edge triggered T-type F-Fs operating in toggle mode.

#cetz.canvas({
  import cetz.draw : *

  for i in range(9, step: 3) {
    rect((i + 0,0), (i + 1.5, 2))
    content((i + 0.25, 1), $T$)
    content((i + 1.25, 1.5), $Q$)
    content((i + 1.25, 0.5), $overline(Q)$)
    line((i + 0.6, 0), (i + 0.75, 0.25), (i + 0.9, 0))

    if i != 6 {
      line((i + 1.5, 1.5), (i + 2.25, 1.5), (i + 2.25, -0.5), (i + 3.75, -0.5), (i + 3.75, 0))
    }

    line((i + 1.5, 1.5), (i + 2.25, 1.5), (i + 2.25, 2.25))
    content((i + 2.25, 2.5), $Q_#(i / 3)$)
    line((i - 0.375, 1.5), (i - 0.375, 1), (i, 1))
    content((i - 0.375, 1.8), "1")
  }

  line((-3 + 2.25, -0.5), (-3 + 3.75, -0.5), (-3 + 3.75, 0))
  content((-1.2, -0.5), $C l k$)
})

A string of $n$ F-Fs can have $2^n$ states.

Counters are used for
- Counting.
- Producing a delay of a particular duration.
- Generating sequences.
- Dividing frequencies by 2.

A ripple counter is not a synchronous device as the clock to the next stage comes from the previous stage, in a true synchronous device, all the clock input to the flip flops come from the clock.

- Output does not change synchronously - hard to know when the output is actually valid.
- Propagation delay bulids up, limiting the maximum clock speed before *miscounting* occurs. Where $Q_0$ changes to the next state before $Q_2$ manages to change to the current state.

=== BCD Counters

To count a number that is not a power of 2 (e.g. 10), we need
- An F-F with a clear/reset signal.
- An AND gate to detect the count of 10 and use its output to reset the F-F.

#line(length: 100%)

== Synchronous Counters

We can identify a synchronous design if all F-F clock inputs are connected to the clock signal, so they all change at the same time.

The *excitation table* shows the input required for a particular transition. Note that $D$ is the input we want to create, and $Q'$ is caused by $D$.

#table(
  columns: (auto, auto, auto),
  align: center,
  table.header([*$Q_2 Q_1 Q_0$*], [*$Q_2' Q_1' Q_0'$*], [*$D_2 D_1 D_0$*]),
  `000`, `001`, `001`,
  `001`, `010`, `010`,
  `010`, `011`, `011`,
  `011`, `100`, `100`,
  `100`, `101`, `101`,
  `101`, `110`, `110`,
  `110`, `111`, `111`,
  `111`, `000`, `000`,
)

By inspection, we can see that $D_0 = overline(Q_0)$ and $D_1 = Q_1 plus.circle Q_0$.

To find out $D_2$, we need to draw a K-map.

#grid(
  columns: (40%, 50%),
  grid(
    gutter: 7pt,
    columns: (auto, auto),
    grid.cell([]),
    grid.cell([*$Q_1 Q_0$*]),
    grid.cell([*$Q_2$*]),
    grid.cell([
      #table(
        align: center,
        columns: (auto, auto, auto, auto, auto),
        [], [*00*], [*01*], [*11*], [*10*],
        [*0*], [], [], [1], [],
        [*1*], [1], [1], [], [1]
      )
    ])
  ),
  [
    $
    D_2 &= Q_2 dot overline(Q_1) + Q_2 dot overline(Q_0) + overline(Q_2) dot Q_1 dot Q_0 \
    &= Q_2 dot (overline(Q_1) + overline(Q_0)) + overline(Q_2) dot Q_1 dot Q_0
    $
  ]
)

The design process for counters that count in any sequence is the same.

#line(length: 100%)

=== Shift Registers

#let dtype = (x, y) => {
  import cetz.draw : *
  rect((0 + x, 0 + y), (1.5 + x, 2 + y))
  line((0.75 +x , -0.7 + y), (0.75 + x, 0 + y))
  line((-0.5 + x, 1 + y), (x, 1 + y))
  content((0.25 + x, 1 + y), $D$)
  content((1.25 + x, 1 + y), $Q$)
  line((0.6 + x, 0 + y), (0.75 + x, 0.25 + y), (0.9 + x, 0 + y))
}

#cetz.canvas({
  import cetz.draw : *

  line((2, 1), (3, 1))
  line((5, 1), (6, 1))
  line((-0.5, -0.7), (6.75, -0.7), (6.75, -0.5))

  for x in range(9, step: 3) {
    line((1.5 + x, 1), (2 + x, 1), (2 + x, 2.5))
    content((2 + x, 2.7), $Q_#{x / 3}$)
    dtype(x, 0)
  }

  content((-0.9, -0.7), $C l k$)
  content((-0.9, 1), $D_"in"$)
})

A shift register is a *synchronous machine* because all the F-Fs are connected to the same clock.
- Serial input, parallel output.
- The first clock $Q_0$ outputs the value of $D$ at the next clock edge.
- $Q_1$ output is delayed by 1 clock cycle.
- $Q_2$ output is delayed by 2 clock cycles.

==== Application

#grid(
  columns: (auto, auto),
  [
    Use it as a *serial data link*.
    + Parallel data in.
    + pass through a wire as serial data.
    + Parallel data out.
  ],
  cetz.canvas({
    import cetz.draw : *

    rect((0, 0), (2.5, 1.5))
    content((1.25, 0.75), [
      Parallel \
      to serial
    ])
    rect((5, 0), (7.5, 1.5))
    content((6.25, 0.75), [
      Serial \
      to parallel
    ])
    line((2.5, 0.75), (5, 0.75))

    content((0.75, 2.75), $Q_0$)
    content((1.25, 2.75), $Q_1$)
    content((1.75, 2.75), $Q_2$)
    line((0.75, 1.5), (0.75, 2.5))
    line((1.25, 1.5), (1.25, 2.5))
    line((1.75, 1.5), (1.75, 2.5))

    content((5.75, 2.75), $Q_0$)
    content((6.25, 2.75), $Q_1$)
    content((6.75, 2.75), $Q_2$)
    line((5.75, 1.5), (5.75, 2.5))
    line((6.25, 1.5), (6.25, 2.5))
    line((6.75, 1.5), (6.75, 2.5))

    line((-1, -1), (1.25, -1), (1.25, 0))
    line((-1, -1), (6.25, -1), (6.25, 0))
    content((-1.2, -0.7), $C l k$)
  })
)

== System Timing

#definition([
  - The *clock period* $T_c$ is the time between rising clock edges.
  - The *clock frequency* $f_c = 1 slash T_c$.
], title: "Definitions")

=== Setup Time Constraint

The correct operation of a D-type F-F requires
- Minimum *setup time* $T_(s u)$ before the edge.
- Minimum *hold time* $T_h$ after the edge
- Output changes in *propagation delay* $T_(p c)$ after the clock.

#cetz.canvas({
  import cetz.draw : *

  dtype(0, 0)
  dtype(6, 0)

  rect((2.5, 0.25), (5, 1.75))
  line((1.5, 1), (2.5, 1))
  line((7.5, 1), (8, 1))
  line((5, 1), (6, 1))
  content((2, 1.3), $Q_0$)
  content((5.5, 1.3), $D_1$)
  content((3.75, 1), [Logic])
  line((-0.5, -0.7), (6.75, -0.7), (6.75, 0))
})

To satisfy the setup time for the 2nd F-F $D_1$ must settle before $t_(s u)$ before the next clock. Giving the *minimum setup period*.
$
T_c gt.eq t_(p c) + t_(p d) + t_(s u)
$

=== Hold Time Constraint

For the 2nd F-F to output correctly, $D_1$ must hold (not update) for a minimum of $t_"hold"$ after clock.
$
min(t_(p c) + t_(p d)) gt.eq t_"hold"
$
- We would expect 2 F-Fs to cascade with no combinational logic in between, so
$
min(t_(p c)) gt.eq t_"hold"
$
- Often F-F are designed with $t_"hold" = 0$.

Hold time violations cannot be fixed by adjusting clock period and is hard to fix.

#definition(title: "Note", [
  - Setup time constrain is concerned with the *maximum propagation delay*.\
    (time after clock edge required to guarantee stable output)
  - Hold time constraint concerned with the *minimum propagation delay*.\
    (time after clock edge which output is guaranteed to not change)
])

=== Clock Skew

- Previously we assumed all clock signals reach all the F-Fs the same time.
- Skew is caused by the differences in the length of physical lengths from the clock to the flip-flops.
This increases the *maximum propagation delay* possible.
$
T_c gt.eq t_(p c) + t_(p d) + t_(s u) + t_"skew"
$
- Skew decreases the maximum propagation delay allowed $t_(p c) lt.eq T_c - (t_(p c) + t_(s u) + t_"skew"$
- But makes the hold time constraint looser $min(t_"skew" + t_(p c) + t_(p d)) gt.eq t_"hold"$

== Meta Stability

It is not always possible to control when an input to an F-F changes (e.g. user inputs). If the *dynamic requirements* are violated:
- This causes output $Q$ to be *undefined* (between 0V and $V_(D D)$).
- $Q$ will remain in a *metastable state* (undefined) until it resolves to a stable valid state.

The resolution time is unbounded, the distribution of resolution time is given by
$
P(t_"res" > t) = T_0/T_c exp(-t/tau)
$
Where $T_0$ and $tau$ are the characteristics of the F-F.

So the longer we wait, the less likely the F-F is still in the metastable state.

#definition(title: "Note", [
  $P_"fail"$ can present *mean failures per second* and can go over 100.
])

=== Synchroniser

A synchroniser is made by cascading an extra F-F after the first F-F.
+ The probability of each F-F resolves to a valid level $t_(s u)$ before the next clock edge is
  $
  P_"fail" = P(t_"res" > T_c - t_(s u)) = T_0/T_c exp(-(T_c - t_(s u))/tau)
  $
+ For $n$ cascaded F-Fs to resolve to a metastable state, the probability is $(P_"fail")^n$.

=== Mean Time Between Failures

If input $D$ changes $N$ times per second, the probability of failure is $N P_"fail" slash s$.

System reliability is measured in mean time between failures.
$
M T B F = 1/(N P_"fail" slash s) = (T_c exp(-(T_c - t_(s u))/tau))/(N T_0)
$

#line(length: 100%)

== Finite State Machines

#definition(title: "Definitions", [
  #table(
    columns: (auto, auto),
    table.header([*Keyword*], [*Meaning*]),
    [Finite state machine], [A deterministic circuit that produces outputs which depends on its internal state and external outputs.],
    [State], [A set of internal memorised values.],
    [Input], [External stimuli to the FSM.],
    [Output], [Results of the FSM.]
  )
])

#grid(
    columns: (auto, auto),
    gutter: 20pt,
    [
      Moore machine's output only depends on the state. The 2nd combinational logic is *optional*.
    ],
    [
      Mealy machine also additionally takes the input to generate an output directly.
    ],
    cetz.canvas({
      import cetz.draw : *

      rect((0, 0), (1.5, 1.5))
      content((0.75, 0.75), [Comb.\ logic])
      rect((2.3, 0), (3.5, 1.5))
      content((2.5, 0.75), $D$)
      content((3.3, 0.75), $Q$)
      line((1.5, 0.75), (2.3, 0.75))
      line((3.5, 0.75), (4.3, 0.75))
      rect((4.3, 0), (5.8, 1.5))
      content((5.05, 0.75), [Comb.\ logic])

      line((0, 0.75), (-0.7, 0.75))
      line((5.8, 0.75), (6.5, 0.75))
      line((2.75, 0), (2.9, 0.2), (3.05, 0))

      line((3.9, 0.75), (3.9, 2), (-0.5, 2), (-0.5, 1), (0, 1))
      line((-0.7, -1), (2.9, -1), (2.9, 0))
    }),
    cetz.canvas({
      import cetz.draw : *

      rect((0, 0), (1.5, 1.5))
      content((0.75, 0.75), [Comb.\ logic])
      rect((2.3, 0), (3.5, 1.5))
      content((2.5, 0.75), $D$)
      content((3.3, 0.75), $Q$)
      line((1.5, 0.75), (2.3, 0.75))
      line((3.5, 0.75), (4.3, 0.75))
      rect((4.3, 0), (5.8, 1.5))
      content((5.05, 0.75), [Comb.\ logic])

      line((0, 0.75), (-0.7, 0.75))
      line((5.8, 0.75), (6.5, 0.75))
      line((2.75, 0), (2.9, 0.2), (3.05, 0))

      line((3.9, 0.75), (3.9, 2), (-0.5, 2), (-0.5, 1), (0, 1))
      line((-0.7, -1), (2.9, -1), (2.9, 0))

      line((-0.2, 0.75), (-0.2, -0.5), (3.9, -0.5), (3.9, 0.5), (4.3, 0.5))
    }),
    [
      The Moore machine is clocked and relatively predictable. Although the combinational logic may have a glitch.
    ],
    [
      We know inputs are generally not synchronised, so the combinational logic can change at any time.
    ],
    [
      Only input shown on transition arcs, next state is given by current state and current input.
    ],
    [
      Inputs and outputs shown on transition arcs, because the output is determined by current input and current state.
    ]
)

=== Example: Traffic Lights

#grid(
  columns: (auto, auto),
  column-gutter: 50pt,
  cetz.canvas({
    import cetz.draw : *

    let light((x, y), r, a, g) = {
      rect((x, y), (x + 1.2, y + 2.4))

      if r {
        circle((x + 0.6, y + 1.9), radius: 8pt, fill: red)
      } else {
        circle((x + 0.6, y + 1.9), radius: 8pt, stroke: red)
      }

      if a {
        circle((x + 0.6, y + 1.2), radius: 8pt, fill: orange)
      } else {
        circle((x + 0.6, y + 1.2), radius: 8pt, stroke: orange)
      }

      if g {
        circle((x + 0.6, y + 0.5), radius: 8pt, fill: green)
      } else {
        circle((x + 0.6, y + 0.5), radius: 8pt, stroke: green)
      }
    }

    light((0, 0), true, false, false)
    light((3, 0), true, true, false)
    light((6, 0), false, false, true)
    light((9, 0), false, true, false)

    line((1.2, 1.25), (3, 1.25), mark: (end: ">"))
    line((4.2, 1.25), (6, 1.25), mark: (end: ">"))
    line((7.2, 1.25), (9, 1.25), mark: (end: ">"))
    line((9.6, 0), (9.6, -1), (0.6, -1), (0.6, 0), mark: (end: ">"))
  }),
  table(
    columns: (auto, auto),
    table.header($R A G$, $R'A'G'$),
    `100`, `110`,
    `110`, `001`,
    `001`, `010`,
    `010`, `100`
  )
)

4 states, so minimum 2 F-Fs required, but if we have 3 F-Fs we don't need any additional combinational logic, we only use 4 out of 8 possible states.

We can use K-maps to find the expressions for $R'$, $A'$ and $G'$.

=== Initial State

The FSM can be powered up in any of the unused state. This may cause the FSM to be looping in an arbitrary sequence of unintended cases. We can solve that by
+ Checking if the FSM eventually enter a known state from the unused states.
+ If not, we can insert an unused state to the state transition transition table, so the next state is a used state.

== State Assignment

State assignment is nontrivial, and depends on what we are trying to optimise:
- Complexity (e.g. no. of chip used, wiring complexity)
- Speed

If we have $n$ states, we need at least $log_2 n$ F-Fs (a.k.a. bits) to encode the states.

=== Sequential State Assignment

+ Assign states in increasing natural binary count.
+ Write down the state transition table using $log_2 n$ gates.
+ Determine the next state logic and the output logit.

#grid(
  columns: (auto, auto),
  column-gutter: 50pt,
  table(
    columns: (auto, auto),
    table.header($c b a$, $c' b' a'$),
    `000`, `001`,
    `001`, `010`,
    `010`, `011`,
    `011`, `100`,
    `100`, `000`
  ),
  $
  'a &= overline(a) \
  'b &= a plus.circle b \
  'c &= a dot b
  $
)

=== Sliding State Assignment

#grid(
  columns: (auto, auto),
  column-gutter: 50pt,
  table(
    columns: (auto, auto),
    table.header($c b a$, $c' b' a'$),
    `000`, `001`,
    `001`, `011`,
    `011`, `110`,
    `110`, `100`,
    `100`, `000`
  ),
  $
  'a &= overline(b) dot overline(c) \
  'b &= a \
  'c &= b
  $
)

Note the simpler logic, but more unusable states.

=== Shift Register Assignment

#grid(
  columns: (auto, auto),
  column-gutter: 50pt,
  table(
    columns: (auto, auto),
    table.header($e d c b a$, $e' d' c' b' a'$),
    `00011`, `00110`,
    `00110`, `01100`,
    `01100`, `11000`,
    `11000`, `10001`,
  ),
  $
  'a &= e \
  'b &= a \
  'c &= b \
  'd &= c \
  'e &= d \
  $
)

Extremely simple logic, but a lot of unusable states.

#line(length: 100%)

=== One-hot State Encoding

It is a shift register design style where only one F-F is 1 at a time, so 1 F-F per state.
- The next state logic is very simple, resulting in a faster state machine.
- Outputs are generated by OR-ing appropriate F-F outputs.

== Implementation of FSMs

=== Generic Logic Arrays

GLAs are PAL styled devices fitted with D-type F-Fs in the OR-plane.
- Programmable only on the AND plane, same as PALs.
- The output of the F-Fs are also avaibable in the AND-plane.

=== Field Programmable Gate Arrays

FPGAs are the latest type of programmable logic.
- An array of configurable logic blocks (CLB) surrounded by input/output blocks (IOB).
  - A CLB contains lookup tables, mux, and D-type F-Fs.
  - The FPGA is configured by specifying the content of these tables to select signals for the mux.
- Programmable routing channels permits connections to othere CLBs and IOBs.

#line(length: 100%)

FPGAs are very useful for making prototypes, but not for high volume application because FPGAs are expensive.
- They are converted to custom silicon which has a much lower manufacturing cost.
- But converting to silicon is an expensive process.

== Eliminating Redundant States

Reducing the number of states reduced the number of F-Fs required and the complexity of the next state logic, as there are more unused (don't care) states.

#definition([
  State $p$ and $q$ are *equivalent* if they output the same bit sequence for the same input bit sequence.
  $
  p equiv q arrow.l.r.long.double lambda (p, x) equiv lambda (q, x) and delta(p, x) equiv delta(p, x)
  $
  Where $lambda$ is the output function and $delta$ is the next state function.
])

We want to eliminate identical states.

We may be able to eliminate some states using *row matching*, but there are hidden cases where row matching would not find. This is problematic because there is a infinite number of bit sequences to test.

#table(
  columns: (auto, auto, auto, auto),
  table.header([*Current state*], [*`X=0`*], [*`X=1`*], [*Output*]),
  `A`, `D`, `C`, `0`,
  `B`, `F`, `H`, `0`,
  `C`, `E`, `D`, `1`,
  `D`, `A`, `E`, `0`,
  `E`, `C`, `A`, `1`,
  `F`, `F`, `B`, `1`,
  `G`, `B`, `H`, `0`,
  `H`, `C`, `G`, `1`,
)

But from definition we only need $p$ and $q$ output the same for the same single bit input, and the next states are equivalent.

#let box = ((x, y)) => {
  import cetz.draw : *

  rect((-0.5 + x, -0.5 + y), (0.5 + x, 0.5 + y))
}

#let cross = ((x, y)) => {
  import cetz.draw : *

  line((-0.5 + x, -0.5 + y), (0.5 + x, 0.5 + y))
  line((0.5 + x, -0.5 + y), (-0.5 + x, 0.5 + y))
}

+ Draw the implication table
  - If the outputs of the two states are equal, wirte the current-next states for the different inputs.
  - If the output is different, put a cross.
  - Remove self-implied cases: where _if A is equivalent to D, then A is equivalent to D_.
  #cetz.canvas({
    import cetz.draw : *

    for i in range(7) {
      for j in range(7 - i) {
        box((j, i))
      }
    }

    let cs = ([A], [B], [C], [D], [E], [F], [G], [H])

    for i in range(7) {
      content((-0.8, i), cs.at(7 - i))
      content((i, -0.8), cs.at(i))
    }

    content((0, 6), [
      `D-F` \
      `C-H`
    ])
    cross((0, 5))
    content((0, 4), [
      #strike[`A-D`] \
      `C-E`
    ])
    cross((0, 3))
    cross((0, 2))
    content((0, 1), [
      `B-D` \
      `C-H`
    ])
    cross((0, 0))
    cross((1, 5))
    content((1, 4), [
      `A-F` \
      `E-H`
    ])
    cross((1, 3))
    cross((1, 2))
    content((1, 1), [
      `B-F` \
      #strike[`H-H`]
    ])
    cross((1, 0))
    cross((2, 4))
    content((2, 3), [
      #strike[`C-E`] \
      `A-D`
    ])
    content((2, 2), [
      `E-F` \
      `B-D`
    ])
    cross((2, 1))
    content((2, 0), [
      `C-E` \
      `D-G`
    ])
    cross((3, 3))
    cross((3, 2))
    content((3, 1), [
      `A-B` \
      `E-H`
    ])
    cross((3, 0))
    content((4, 2), [
      `C-F` \
      `A-B`
    ])
    cross((4, 1))
    content((4, 0), [
      #strike[`C-C`] \
      `A-G`
    ])
    cross((5, 1))
    content((5, 0), [
      `C-F` \
      `B-G`
    ])
    cross((6, 0))
  })
+ On the top square, $A equiv B$ requires $D equiv F$ and $C equiv H$. But we can see the intersection on $C$ and $H$ is crossed out, meaning $C equiv.not H$. So $A equiv.not B$, and we can cross out the intersection of $A$ and $B$.  

  Keep crossing squares until no more states can be eliminated.
  #cetz.canvas({
    import cetz.draw : *

    for i in range(7) {
      for j in range(7 - i) {
        box((j, i))
      }
    }

    let cs = ([A], [B], [C], [D], [E], [F], [G], [H])

    for i in range(7) {
      content((-0.8, i), cs.at(7 - i))
      content((i, -0.8), cs.at(i))
    }

    content((0, 6), [
      `D-F` \
      `C-H`
    ])
    cross((0, 5))
    content((0, 4), [
      #strike[`A-D`] \
      `C-E`
    ])
    cross((0, 3))
    cross((0, 2))
    content((0, 1), [
      `B-D` \
      `C-H`
    ])
    cross((0, 0))
    cross((1, 5))
    content((1, 4), [
      `A-F` \
      `E-H`
    ])
    cross((1, 3))
    cross((1, 2))
    content((1, 1), [
      `B-F` \
      #strike[`H-H`]
    ])
    cross((1, 0))
    cross((2, 4))
    content((2, 3), [
      #strike[`C-E`] \
      `A-D`
    ])
    content((2, 2), [
      `E-F` \
      `B-D`
    ])
    cross((2, 1))
    content((2, 0), [
      `C-E` \
      `D-G`
    ])
    cross((3, 3))
    cross((3, 2))
    content((3, 1), [
      `A-B` \
      `E-H`
    ])
    cross((3, 0))
    content((4, 2), [
      `C-F` \
      `A-B`
    ])
    cross((4, 1))
    content((4, 0), [
      #strike[`C-C`] \
      `A-G`
    ])
    cross((5, 1))
    content((5, 0), [
      `C-F` \
      `B-G`
    ])
    cross((6, 0))

    cross((0, 6))
    cross((0, 1))
    cross((1, 4))
    cross((1, 1))
    cross((2, 2))
    cross((3, 1))
    cross((4, 2))
    cross((4, 0))
    cross((5, 0))
    cross((2, 0))
  })

  The states that are not crossed out are equivalent.
  - $A equiv D$
  - $C equiv E$

We can remove these redundant states from the table, and replace all references to the removed states to the new equivalent state.

== Electricity

#definition([
  An *electric current* is produced when charged particles moves in a definite direction.
])

In metals, electrons are very loosely associated with those atoms and are free to move.
- When they move about randomly, there is no flow in any particular direction.
- If a metal wire is connected across the terminals of a battery, the free electrons are forced towards the +ve terminal and flow through the battery, which supplies the electrical force and energy that drives the electrons around the circuit.
  - The drift is slow ($lt$1mm per second) due to frequent collisions with ions.

=== The Effect of Current

The flow of electrons make the metal warmer and deflects nearby magnetic compasses.
#definition(title: "Definitions", [
  - *Conventional current* is defined as the flow from +ve to the -ve terminal.
  - The unit of charge is the *coulomb*, an electron has charge $1.6 times 10^(-16)$ C.
  - The *emf* of a battery is defined to be 1 volt if it gives 1 joule of electrical energy to each coulomb of charge passing through it.
  - The *potential difference* is defined to be 1 volt if it changes 1J of electrical energy into other forms of energy.
])
$
Q &= I t \
E &= Q V \
P &= I V
$

=== Semiconductors and Insulators

The electrical properties of a material is determined by how strongly the valance electrons are bound to the atoms.
- If they are bound very strongly, it is an *insulator*, when a voltage is applied, the crystal structure will distort but no charge will flow until breakdown occurs.
- If they are weakly bound, the charge is free to flow when voltage is applied.

=== Silicon

We can control the *free electron density* in a silicon by changing its temperature.
- At low temperatures, it is a terrible conductor.
- When temperature is increased, the electrons break free and conductivity increases.

Its conductivity is a positive feedback loop, be careful when using silicon in power appliances:
+ Current causes silicon to heat up.
+ More current is allowed to pass through, go to step 1.

This is *intrinsic semiconductor*, which is just pure silicon.

#grid(
  columns: (45%, 45%),
  column-gutter: 15pt,
  [
    === N-type Silicon

    Silicon is doped with arsenic (group V) which has an additonal electron not in bonds.
    - The more arsenic we add in the more conductive it gets.
  ],
  [
    === P-type Silicon

    Silicon is doped with boron (group III) which takes one electron from a silicon, leaving a hole. This hole can appear to move.
    - In this case the hole is the "charge carrier".
  ]
)

*MOSFET* is used everywhere, and they are made of type n and p silicon.

#definition(title: "Definitions", [
  - The *resistance* of a conductor is defined as $V=I R$, which is *Ohm's law*.
  - The I/V graph of an *ohmic conductor* is a straight line through the origin.
  - *Kirchhoff's current law*: the sum of currents entering a junction is zero.
  - *Kirchhoff's voltage law*: in any closed loop of an electric circui, the sum of all voltages in that loop is zero.
])

#line(length: 100%)

=== The Potential Divider

#grid(
  columns: (50%, auto),
  [
    The potential difference between $V_"out"$ and 0V is
    $
    V_"out" = (V R_1)/(R_1 + R_2)
    $
    This only applies to components with a linear I-V characteristic.
  ],
  zap.circuit({
    import zap : *
    import cetz.draw : *

    vsource("v1", (0, 0), (0, 5), label: (content: $V$))
    resistor("r1", (2, 0), (2, 2.5))
    resistor("r2", (2, 2.5), (2, 5))
    wire((0, 5), (2, 5))
    wire((0, 0), (3, 0))
    wire((2, 2.5), (3, 2.5))
    content((3.4, 2.5), $V_"out"$)
    content((3.4, 0), "0V")
    content((2.8, 1.25), $R_2$)
    content((2.8, 3.75), $R_1$)
  })
)

== Transistors and Gates

=== P-N Junction

*Diffusion* occures when you stick a p-type and n-type semiconductor together.
- The free electrons in the n-type diffuses to the p-type.
- At the region near the boundary, the n-type is positively charged, p-type is negatively charged.
- The diffusion stops when no more electrons can pass through the boundary due to repulsion.
  #cetz.canvas({
    import cetz.draw : *

    rect((0, 0), (2, 2))
    rect((2, 0), (3, 2))
    rect((3, 0), (4, 2))
    rect((4, 0), (6, 2))
    content((2.5, 1), "-ve")
    content((3.5, 1), "+ve")
    content((5, 1), align(center, [n-type \ (electrons)]))
    content((1, 1), align(center, [p-type \ (holes)]))

    line((-1, 1), (0, 1))
    line((6, 1), (7, 1))
    content((-0.5, 0.7), "-ve")
    content((6.5, 0.7), "+ve")
  })

==== Bias in P-N Junction

When connected to a battery with a *reversed bias*.
- The free electrons are attracted to the negative terminal, similar for the hole.
- This makes the *depletion region* even larger, no current flows because the junction is blocked.

When connected with a *forward bias*, the depletion region is reduced so current flows.

#definition([
  A single P-N junction is called a *diode*.
])

=== N-Channel MOSFET

#grid(
  columns: (70%, auto),
  [
    The current flows from drain to source, the flow of current is controlled by the voltage on the gate.
    - If there is no voltage on the gate, no current flows.
  ],
  zap.circuit({
    import zap : *
    import cetz.draw : *

    nmos("id", (0,0))
    wire("id.g", (rel: (-1, 0)))
    wire("id.d", (rel: (0, 1)))
    wire("id.s", (rel: (0, -1)))

    content((-1.8, -0.3), "Gate")
    content((0.7, 1.4), "Drain")
    content((0.7, -1.3), "Source")
  })
)

#grid(
  columns: (auto, auto, auto),
  column-gutter: 20pt,
  [
    When the transistor is off, the diodes are reverse biased, so no current flows.

    When gate is given a positive voltage, it attracts electrons towards it. The p-type becomes *inverted*, creating a channel for current to flow through.

    #definition(title: "Note", [
      The gate is insulated from the transistors (black = insulator).
    ])
  ],
  [
    #cetz.canvas({
      import cetz.draw : *

      rect((0, 0), (1.5, 4))
      rect((0, 0.2), (-0.2, 1.2), fill: black)
      rect((0, 3.8), (-0.2, 2.8), fill: black)
      rect((0, 1.5), (-0.2, 2.5), fill: black)

      line((-1, 1.35), (0, 1.35))
      content((-1.3, 1.35), "0V")
      line((-1, 2.65), (0, 2.65))
      content((-1.5, 2.65), $+V_D$)
      line((-1, 2), (-0.2, 2))
      content((-1.3, 2), "0V")
      line((-1, -0.5), (0.75, -0.5), (0.75, 0))
      content((-1.3, -0.5), "0V")

      rect((0, 1), (0.5, 1.7), fill: gray)
      rect((0, 3), (0.5, 2.3), fill: gray)
      content((0.25, 2.65), "n")
      content((0.25, 1.35), "n")
      content((1.1, 2), "p")
    })
    #align(center, "Off")
  ],
  [
    #cetz.canvas({
      import cetz.draw : *

      rect((0, 1.7), (0.2, 2.3), fill: gray, stroke: none)

      rect((0, 0), (1.5, 4))
      rect((0, 0.2), (-0.2, 1.2), fill: black)
      rect((0, 3.8), (-0.2, 2.8), fill: black)
      rect((0, 1.5), (-0.2, 2.5), fill: black)

      line((-1, 1.35), (0, 1.35))
      content((-1.3, 1.35), "0V")
      line((-1, 2.65), (0, 2.65))
      content((-1.5, 2.65), $+V_D$)
      line((-1, 2), (-0.2, 2))
      content((-1.5, 2), $+V_G$)
      line((-1, -0.5), (0.75, -0.5), (0.75, 0))
      content((-1.3, -0.5), "0V")

      rect((0, 1), (0.5, 1.7), fill: gray)
      rect((0, 3), (0.5, 2.3), fill: gray)
      content((0.25, 2.65), "n")
      content((0.25, 1.35), "n")
      content((1.1, 2), "p")
    })
    #align(center, "On")
  ]
)

The G volatage $V_G$ required is known as the *threashold voltage* (typically 0.3 - 0.7V).

#definition(title: "I-V Characteristics of an N-MOSFET", [
  - Increasing drain voltage increases the current, but has little effect past a certain voltage.
  - Increasing gate voltage increases the current linearly, but only beyond the threashold voltage.
])


==== P-Channel MOSFET

#grid(
  columns: (auto, auto, auto),
  column-gutter: 20pt,
  [
    These are the diagrams for a p-type MOSFET, they do exactly what you think they do.
  ],
  [
    #cetz.canvas({
      import cetz.draw : *

      rect((0, 0), (1.5, 4), fill: gray)
      rect((0, 0.2), (-0.2, 1.2), fill: black)
      rect((0, 3.8), (-0.2, 2.8), fill: black)
      rect((0, 1.5), (-0.2, 2.5), fill: black)

      line((-1, 1.35), (0, 1.35))
      content((-1.5, 1.35), $+V_S$)
      line((-1, 2.65), (0, 2.65))
      content((-1.3, 2.65), "0V")
      line((-1, 2), (-0.2, 2))
      content((-1.5, 2), $+V_G$)
      line((-1, -0.5), (0.75, -0.5), (0.75, 0))
      content((-1.5, -0.5), $+V_S$)

      rect((0, 1), (0.5, 1.7), fill: white)
      rect((0, 3), (0.5, 2.3), fill: white)
      content((0.25, 2.65), "p")
      content((0.25, 1.35), "p")
      content((1.1, 2), "n")
    })
    #align(center, "Off")
  ],
  [
    #cetz.canvas({
      import cetz.draw : *

      rect((0, 0), (1.5, 4), fill: gray)
      rect((0, 0.2), (-0.2, 1.2), fill: black)
      rect((0, 3.8), (-0.2, 2.8), fill: black)
      rect((0, 1.5), (-0.2, 2.5), fill: black)

      rect((0, 1.7), (0.2, 2.3), fill: white, stroke: none)

      line((-1, 1.35), (0, 1.35))
      content((-1.5, 1.35), $+V_S$)
      line((-1, 2.65), (0, 2.65))
      content((-1.3, 2.65), "0V")
      line((-1, 2), (-0.2, 2))
      content((-1.3, 2), "0V")
      line((-1, -0.5), (0.75, -0.5), (0.75, 0))
      content((-1.5, -0.5), $+V_S$)

      rect((0, 1), (0.5, 1.7), fill: white)
      rect((0, 3), (0.5, 2.3), fill: white)
      content((0.25, 2.65), "p")
      content((0.25, 1.35), "p")
      content((1.1, 2), "n")
    })
    #align(center, "On")
  ]
)

=== N-MOS Inverter

We can replace a resistor in the potential divider with an N-MOSFET.

#grid(
  columns: (auto, auto),
  column-gutter: 6pt,
  [
    Increasing $V_"in"$ causes $V_"out"$ to drop: as $V_"in"$ increases from 0V to 10V, $V_"out"$ smoothly decreases from 10V to 0V.

    - This is not the ideal _binary_ characteristic we want for an inverter.
    - But we can achieve binary action by specifying allowed voltages.

    There are also other issues
    #table(
      columns: (auto, auto),
      table.header([*Issue*], [*Cause*]),
      [Very slow transition], [The $V_"out"$ and 0V wires acted as capacitors, increasing the rise time of the output signal.],
      [Power consumption], [Current passes through $R_1$ when it is on, the power dissipated is $P=I V$.]
    )
  ],
  zap.circuit({
    import zap : *
    import cetz.draw : *

    vsource("v1", (0, 0), (0, 5), label: (content: $V$))
    nmos("mos", (2, 1))
    wire("mos.s", (rel: (0,-0.475)))
    wire("mos.d", (rel: (0,1)))
    wire("mos.g", (rel: (-2, 0)))
    content((-1, 0.8), $V_"in"$)
    resistor("r2", (2, 2.5), (2, 5))
    wire((0, 5), (2, 5))
    wire((0, 0), (3, 0))
    wire((2, 2.5), (3, 2.5))
    content((3.4, 2.5), $V_"out"$)
    content((3.4, 0), "0V")
    content((2.8, 1.25), $R_2$)
    content((2.8, 3.75), $R_1$)
  })
)

=== CMOS Inverter

#grid(
  columns: (auto, auto),
  [
    The CMOS inverter has a much sharper graph than the N-MOS inverter.
    - In the CMOS inverter, only one transistor is on at a time.
    - If the input is not changing, no current is flowing, so there is no power dissipation.

    The only time current flows is when switching where both transistors are momentarily on. Once they finished switching, the power dissipated will
    go back to zero.
  ],
  zap.circuit({
    import zap : *
    import cetz.draw : *

    nmos("nmos", (0, 0))
    pmos("pmos", (0, 3), scale: (1, -1))

    content((0.8, 0), "n-MOS")
    content((0.8, 3), "p-MOS")

    wire("pmos.d", "nmos.d")
    wire("pmos.g", (rel: (-1, 0)), (rel: (-1, 0), to: "nmos.g"), "nmos.g")
    wire((-2.2, 1.5), (-3.5, 1.5))
    content((-3.9, 1.5), $V_"in"$)

    wire("pmos.s", (rel: (0, 1)), (rel: (4, 0)))
    wire("nmos.s", (rel: (0, -1)), (rel: (4, 0)))
    vsource("v1", (rel: (4, -1), to: "nmos.s"), (rel: (4, 1), to: "pmos.s"), label: (content: $V arrow.t$))

    wire((0, 1.5), (1, 1.5))
    content((1.5, 1.5), $V_"out"$)
  })
)

#line(length: 100%)

For both $n$ and $p$-type MOS transistors, if $V_(G S) = 0$, then the transistor is off. But for $n$-type, the drain voltage $>$ source voltage. This is reversed for $p$-type.

#set scale(reflow: true)

#grid(
  columns: (auto, auto),
  column-gutter: 40pt,
  [
  === CMOS NOR Gate
    #scale(85%,
      zap.circuit({
        import zap : *
        import cetz.draw : *

        line((0, 10), (8, 10))
        line((0, 2), (8, 2))

        nmos("t1", (3, 4))
        nmos("t2", (7, 4))
        pmos("t3", (7, 8.8), scale: (1, -1))
        pmos("t4", (7, 6.5), scale: (1, -1))

        wire("t1.s", (rel: (0, -1.475)))
        wire("t1.g", (rel: (-1, 0)), (rel: (-5, 0), to: "t4.g"), "t4.g")
        wire("t2.s", (rel: (0, -1.475)))
        wire("t2.g", (rel: (-1, 0)), (rel: (-1, 0), to: "t3.g"), "t3.g")
        wire("t2.d", "t4.d")
        wire("t4.s", "t3.d")
        wire("t3.s", (rel: (0, 0.68)))

        wire("t1.d", (rel: (1.5, 0)), (rel: (0, -0.2)), (rel: (0.6, 0)), (rel: (0, 0.8)), (rel: (3, 0)))
        content((8.5, 5.2), $V_"out"$)

        content((-0.3, 5.5), $V_A$)
        wire((0, 5.5), (0.8, 5.5))

        content((3.7, 6), $V_B$)
        wire((4, 6), (4.8, 6))

        circle((7, 5.13), radius: 0.05, fill: black)
        content((0.2, 1.7), "0V")
        content((0.2, 10.3), $V_(s s)$)
      })
    )
  ],
  [
  === CMOS NAND Gate
    #scale(85%,
      zap.circuit({
        import zap : *
        import cetz.draw : *

        line((0, 10), (8, 10))
        line((0, 2), (8, 2))

        pmos("t1", (3, 8.5), scale: (1, -1))
        pmos("t2", (7, 8.5), scale: (1, -1))
        nmos("t3", (7, 6))
        nmos("t4", (7, 4))

        wire("t1.s", (rel: (0, 0.975)))
        wire("t1.g", (rel: (-1, 0)), (rel: (-5, 0), to: "t4.g"), "t4.g")
        wire("t2.s", (rel: (0, 0.975)))
        wire("t2.g", (rel: (-1, 0)), (rel: (-1, 0), to: "t3.g"), "t3.g")
        wire("t2.d", "t3.d")
        wire("t3.s", "t4.d")
        wire("t4.s", (rel: (0, -1.47)))

        wire("t1.d", (rel: (1.5, 0)), (rel: (0, 0.2)), (rel: (0.6, 0)), (rel: (0, -0.8)), (rel: (3, 0)))
        content((8.5, 7.3), $V_"out"$)

        content((-0.3, 6), $V_A$)
        wire((0, 6), (0.8, 6))

        content((3.7, 7), $V_B$)
        wire((4, 7), (4.8, 7))

        circle((7, 7.37), radius: 0.05, fill: black)
        content((0.2, 1.7), "0V")
        content((0.2, 10.3), $V_(s s)$)
      })
    )
  ]
)

=== Logic Families

A logic family has the same accepted voltage levels and gate current handling capabilities. It is recommended to use parts from the same logic family.

#table(
  columns: (auto, auto),
  table.header([*Family*], [*Description*]),
  [NMOS], [Compact, cheap but slow and obsolete.],
  [CMOS], [Older families are slow, but the new ones are faster.],
  [TTL], [Uses bipolar transistors, again the new ones are faster.],
  [ECL], [High speed but high power consumption.]
)

=== Noise Tolerance

The noise tolerance is quantified in terms of the noise margin.
$
"logic 0 noise margin" &= V_(I L) - V_(O L) \
"logic 1 noise margin" &= V_(I H) - V_(O H)
$

$V_(O L)$ is the highest output voltage that is a low, and $V_(I L)$ the highest input voltage interpreted as low.

In hardware labs, the logic 0 and 1 noise margin from the 7400s series is 1.25V.

= Introductory Processor Architecture

A very simple computer has a processor and a memory.
- The CPU issue addresses on the address bus.
- The data bus conveys items between the CPU and the memory.

#definition([
  A *computer architecture* is defined by its instruction set and architectural state.
])

Based on current architectural state, the processor executes a particlar instruction with a particular set of data to produce a new architectural state.

#definition([
  *Microarchitecture* is how the architecture is implemented in hardware.
  - *Data paths* operates on words of data (e.g. registers and multiplexers).
  - *Instruction decoder* receives the current instruction from data path, and tells the data path how to execute the instruction.
])

== Single Cycle Processor

A single cycle processor executes one instruction every clock cycle.

=== Fetch

+ The PC issues sequentially increasing addresses for the instruction.
+ The instruction is sent to the instruction decoder via the data path.
+ The PC is then incremented by 1.

Including a MUX allows the PC value to change to an arbitrary value, this allows branching. The ALU has a flag output that is set to 1 if a condition is true. This is used for conditional branching.

#definition([
  There is a diagram of a branching computer in lecture handouts, it has an ALU and data memory. I am too lazy to draw it out.
])

== Multicycle Processor

- A clock cycle in a single cycle processor needs to be longer than the slowest instruction.
- In a multicycle processor, an instruction is broken into multiple steps, more complicated instructions take multiple clock cycles to complete.
  - A single adder can be used for different purposes.
  - Only one memory is needed for both instruction and data.

To achieve this, extra registers are needed to hold intermediate results, the registers have propagation delay, so unless the time difference is large, instructions are not broken down.

The controller also needs an FSM to produce different output at each step.

== Pipelined Processor

Pipelining is a type of *temporal parallelism*: it speeds up processing without duplicating hardware.
- Divide a single processor cycle into 5 parallel stages:
  + Fetch
  + Decode
  + Execute (ALU)
  + Memory R/W
  + Register write
- These 5 stages can happen in parallel.

Note the clock cycle has to be slower than the slowest stage to keep the stages synchronised. So for a single instruction, a pipelined processor is slower than a single cycle processor. It also includes more propagation delay from storing values in registers at each stage.

#table(
  columns: (auto, auto),
  table.header([*Type of hazard*], [*Description*]),
  [Data hazard], [An instruction reads a register before it is written back.],
  [Control hazard], [The decision for which instruction to fetch is note made at the fetch stage.]
)
