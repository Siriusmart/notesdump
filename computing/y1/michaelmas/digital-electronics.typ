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
  === Definition
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

Sometimes, the carry bit may be known before $c_"in"$ is given.

If that is not possible, the main speedup is that carry generation happens in parallel with the adders.
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
