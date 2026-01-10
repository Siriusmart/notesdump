#import "@local/lecture:0.1.0" : *
#import "@preview/zap:0.4.0"
#import "@preview/cetz:0.4.2"

#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Computer Science Cheatsheet]
    #h(1fr) _Digital Electronics_
  ],
)

= Digital Electronics

== Components

#grid2(
  [
    === 2-to-1 Selector (Multiplexer)

    #grid2(
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
    )
  ],
  [
    === Demultiplexer

    #grid2(
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
    )

    A *decoder* is a demux with $g$ set to 1.
  ],
  [
    === Level-triggered D Flip-flop

    #grid2(
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
      [
        A 1 input version of the RS-latch.
        - $E N = 1$ then $Q = D$
        - $E N = 0$ then $Q$ unchanged.
      ],
    )
  ],
  [
    === Edge-triggered D Flip-flop

    #grid2(
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
      [
        Output changes only on a rising edge.
      ],
    )
  ]
)

In addition, there are the *programmable logic array* and *ROM*.
Multiple memory devices can be connected to the same bus with *tristate buffers* which disconnects from the bus when not selected.

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

#{
  let a(content) = table.cell([#content], fill: aqua)
  let b(content) = table.cell([#content], fill: lime)
  let c(content) = table.cell([#content], fill: yellow)

  grid(
    columns: (60%, auto),
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

      The level of $c_4$ is reduced $8 -> 5$
    ]
  )
}

== Combinatory Logic

#grid2(width: 35%,
  [
    *Combinatory output* depends only on current input. 
    - *Disjunctive normal form* (sum of product) is the sum minterms.
    - *Conjunctive normal form* (product of sum) is the product of maxterms.

    *Hazards* are brief changes in output, multilevel logic can introduce hazards.
    - *Static hazards*: output momentarily transitions when isn't supposed to change.
    - *Dynamic hazard*: output changes more than once when it's supposed to change once.
  ],
  [
    #tab2(
      [Name], [Identity],
      [Distribution],
      $
      a dot (b + c + cdots) &= a dot b + a dot c + cdots \
      a + (b dot c dot cdots) &= (a + b) dot (a + c) dot cdots
      $,
      [ Absorption ],
      $
      a + a dot b &= a \
      a dot (a + b) &= a
      $,
      [ Consensus ],
      $
      a dot b + overline(a) dot c + b dot c &= a dot b + overline(a) dot c \
      (a + b) dot (overline(a) + c) dot (b + c) &= (a + b) dot (overline(a) + c)
      $,
      [ DeMorgan's ],
      $
      overline(a + b + c + cdots) &= overline(a) dot overline(b) dot overline(c) dot cdots \
      overline(a dot b dot c dot cdots) &= overline(a) + overline(b) + overline(c) + cdots
      $
    )

Logic minification with *K-maps* and the *QM-method*.
1. List all minterms and don't care terms.
2. Merge terms: tick them and write on the next column.
3. Select the minimum covering set of prime implicants.

  ]
)


== Sequential Logic

*Sequential logic* depends on current input and previous state.

- The *ripple counter* is not synchrnous, propagation delay build up, limiting maximum clock speed before miscounting happens. We used synchrnous counters in lab.
- Counters are used for counting, producing a delay, generating sequences, dividing frequences.

=== Shift Registers

#grid(
  columns: (60%, auto),
  [
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
  ],
  [
    - It is a synchrnous machine because all FFs are connected to the same $C l k$.
    - $Q_n$ is delayed by $n$ clock cycles.

    Used as a *serial data link*:
    1. Parallel data in
    2. Pass through a wire as serial data
    3. Parallel data out
  ]
)

== Timing Constraints for Asynchronous Input
$T_c$ clock period is the time between rising edges.

#let dtype = (x, y) => {
  import cetz.draw : *
  rect((0 + x, 0 + y), (1.5 + x, 2 + y))
  line((0.75 +x , -0.7 + y), (0.75 + x, 0 + y))
  line((-0.5 + x, 1 + y), (x, 1 + y))
  content((0.25 + x, 1 + y), $D$)
  content((1.25 + x, 1 + y), $Q$)
  line((0.6 + x, 0 + y), (0.75 + x, 0.25 + y), (0.9 + x, 0 + y))
}

#grid2(
  [
    - $t_(p c)$ time after $C l k$ when $Q_0$ changes
    - $t_(p d)$ time after $Q_0$ when $D_1$ changes
    - $t_(s u)$ setup time for the right FF, $D_1$ needs to settle $t_(s u)$ before the next rising edge
    - $t_"skew"$ is the range of time $C l k$ reaching all FFs

    Requires $T_c >= max(t_(p c) + t_(p d) + t_(s u) + t_"skew")$
  ],
  cetz.canvas({
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
)

- $t_"hold"$ minimum hold time for the right FF, $D_1$ cannot update for $t_"hold"$ after $C l k$

Requires $min(t_(p c) + t_(p d) + t_"skew") >= t_"hold"$

If violated, $Q$ will remain in a *metastable state* until it resolves to a valid state.

#grid2(
  $
  P(t_"res" > t) = T_0 / T_c exp(-t/tau)
  $,
  [
    #br
    where $T_0$ and $tau$ are characteristic of the FF.
  ]
)

- $P_"fail" = P(t_"res" > T_c - t_(s u))$ is the probability a single FF fails to resolve before the next clock edge.
- $(P_"fail")^n$ is the probability for a *synchroniser* of $n$ cascaded FFs to fail to resolve to a valid state.

If input $D_0$ changes $N$ times per second, the probability of failure is $t_(s u) slash T_c times N P_"fail"$ per second.
$
M T B F = 1 / (t_(s u) slash T_c times N P_"fail")
$

== Finite State Machines

#grid(
    columns: (auto, auto),
    gutter: 20pt,
    [
      Moore machine's output only depends state.
    ],
    [
      Mealy machine's also directly depend on input.
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
)

State assignment is chosen based on what we are trying to optimise: speed or complexity (FFs used).

#grid(
  columns: (auto, auto),
  column-gutter: 30pt,
  [
    === Sequential State #br Assisngment
    #tab2(
      $a b c$, $a'b'c'$,
      `000`, `001`,
      `001`, `010`,
      `010`, `011`,
      `011`, `100`,
      `100`, `101`,
      `101`, `110`,
      `110`, `111`,
      `111`, `100`
    )
  ],
  grid(
    columns: (auto, auto, auto),
    column-gutter: 30pt,
    [
      === Sliding State #br Assignment

      #tab2(
        $a b c$, $a'b'c'$,
        `000`, `001`,
        `001`, `011`,
        `011`, `110`,
        `110`, `100`,
        `100`, `000`
      )
    ],
    [
      === Shift Register #br Assignment

      #tab2(
        $a b c d e$, $a'b'c'd'e'$,
        `00011`, `00110`,
        `00110`, `01100`,
        `01100`, `11000`,
        `10001`, `00011`
      )
    ],
    [
      === One-hot State #br Encoding

      #tab2(
        $a b c d e$, $a'b'c'd'e'$,
        `00001`, `00010`,
        `00010`, `00100`,
        `00100`, `01000`,
        `00001`, `00001`
      )
    ]
  )
)

State $p$ and $q$ are equivalent if they produce the same bit sequence for the same input sequence.
#grid2(
  $
  p equiv q iff lambda(p, x) equiv lambda(q, x) and delta(p, x) equiv delta(q, x)
  $,
  [
    - $lambda$ is the output function
    - $delta$ is the next state function
  ]
)

#let box = ((x, y)) => {
  import cetz.draw : *

  rect((-0.5 + x, -0.5 + y), (0.5 + x, 0.5 + y))
}

#let cross = ((x, y)) => {
  import cetz.draw : *

  line((-0.5 + x, -0.5 + y), (0.5 + x, 0.5 + y))
  line((0.5 + x, -0.5 + y), (-0.5 + x, 0.5 + y))
}

#grid2(
  [
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

  ],
  [
    We can eliminate identical states with *row matching*.
      1. Draw the implication table.
      2. _(Left)_ Cross out states that are not equivalent.
      3. _(Right)_ The cells not crossed out represents equivalent states.

      In example below, $A equiv D$ and $C equiv E$
  ],
  [
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
  ],
  [
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
  ]
)


#block(
  breakable: false,
  [
    == Electricity
    #tab2(
      [Name], [Statement],
      [ Ohm's law ], $V = I R$,
      [ Kirchoff's current law ], [ Sum of current entering a junction is zero],
      [ Kirchoff's voltage law ], [ In any closed loop the sum of all voltages is zero. ]
    )


    #grid2(
      [
        - *N-type silicon* has extra electrons.
        - *p-type silicon* has holes.

        A *P-N junction* is a diode.
        - When connected with forward bias, the depleted region shrinks so current flows.
        - Reverse bias then depleted region grows.
      ],
      [#cetz.canvas({
        import cetz.draw : *

        rect((0, 0.4), (2, 1.6))
        rect((2, 0.4), (3, 1.6))
        rect((3, 0.4), (4, 1.6))
        rect((4, 0.4), (6, 1.6))
        content((2.5, 1), "-ve")
        content((3.5, 1), "+ve")
        content((5, 1), align(center, [n-type \ (electrons)]))
        content((1, 1), align(center, [p-type \ (holes)]))

        line((-1, 1), (0, 1))
        line((6, 1), (7, 1))
        content((-0.5, 0.7), "-ve")
        content((6.5, 0.7), "+ve")
      })

      $
      "logic 0 noise margin" &= max(V_"input low") - max(V_"output low") \
      "logic 1 noise margin" &= min(V_"output high") - min(V_"input high") \
      $
    ]
  )

  #grid2(
    [
      #grid(
        columns: (auto, auto),
        column-gutter: 10pt,
        [
          === N-Channel MOSFET
          #grid3(
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
        ],
        tab2(
          [Location], [Voltage],
          [Body], [0V],
          [Source], [0V],
          [Drain], $+V_D$,
          [Gate (off)], [0V],
          [Gate (on)], $+V_G$
        ),
      )
    ],
    [
      #grid(
        columns: (auto, auto),
        column-gutter: 10pt,
        [
          === P-Channel MOSFET

          #grid3(
            zap.circuit({
              import zap : *
              import cetz.draw : *

              pmos("id", (0,0))
              wire("id.g", (rel: (-1, 0)))
              wire("id.d", (rel: (0, 1)))
              wire("id.s", (rel: (0, -1)))

              content((-1.8, -0.3), "Gate")
              content((0.7, 1.4), "Drain")
              content((0.7, -1.3), "Source")
            })
          )
        ],
        tab2(
          [Location], [Voltage],
          [Body], $+V_D$,
          [Source], $+V_D$,
          [Drain], [0V],
          [Gate (off)], $+V_G$,
          [Gate (on)], [0V]
        ),
      )
    ]
  )

  Resistance of the transistor changes non-linearly as gate voltage changes.

  #grid(
    columns: (auto, auto, auto, auto, auto),
    [
      === N-MOS Inverter
      - Slow transistion
      - High power consumption

      You can find the $V_"in"$ to $V_"out"$ graph using graphical methods.
    ],
    zap.circuit({
      import zap : *
      import cetz.draw : *

      nmos("mos", (2, 1))
      wire("mos.s", (rel: (0,-0.475)))
      wire("mos.d", (rel: (0,1)))
      wire("mos.g", (rel: (-0.34, 0)))
      content((0.6, 0.8), $V_"in"$)
      resistor("r1", (2, 2.5), (2, 5))
      wire((0.5, 5), (3, 5))
      wire((0.5, 0), (3, 0))
      wire((2, 2.5), (3, 2.5))
      content((2.5, 2.1), $V_"out"$)
      content((2.8, 0.3), "0V")
      content((2.8, 4.7), "5V")
      content((2.8, 3.75), $R_1$)
    }),
    [#h(15pt)],
    [
      === CMOS Inverter

      - Much sharper transition
      - Current flows briefly only when the input changes.
    ],

    zap.circuit({
      import zap : *
      import cetz.draw : *

      nmos("nmos", (0, 0))
      pmos("pmos", (0, 3), scale: (1, -1))

      wire("pmos.d", "nmos.d")
      wire("pmos.g", (rel: (0.2, 0)), (rel: (0.2, 0), to: "nmos.g"), "nmos.g")
      wire((-1, 1.5), (-1.7, 1.5))
      content((-1.4, 1.8), $V_"in"$)

      wire("pmos.s", (rel: (0, 0.5)))
      wire("nmos.s", (rel: (0, -0.5)))

      wire((0, 1.5), (0.8, 1.5))
      content((0.45, 1.85), $V_"out"$)

      wire((-1.7, -1.03), (0.8, -1.03))
      wire((-1.7, 4.03), (0.8, 4.03))
      content((0.5, 3.73), "5V")
      content((0.5, -0.73), "0V")
    })
  )


  #grid(
    columns: (auto, auto),
    column-gutter: 40pt,
    [
      === CMOS NOR Gate
      #v(-15pt)
      #scale(85%,
      zap.circuit({
        import zap : *
        import cetz.draw : *

        line((0, 10), (8, 10))
        line((0, 2.7), (8, 2.7))

        nmos("t1", (3, 4))
        nmos("t2", (7, 4))
        pmos("t3", (7, 8.8), scale: (1, -1))
        pmos("t4", (7, 6.5), scale: (1, -1))

        wire("t1.s", (rel: (0, -0.775)))
        wire("t1.g", (rel: (-1, 0)), (rel: (-5, 0), to: "t4.g"), "t4.g")
        wire("t2.s", (rel: (0, -0.775)))
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
        content((0.2, 3), "0V")
        content((0.2, 9.6), $V_(s s)$)
      })
    )
  ],
  [
    === CMOS NAND Gate
    #v(-15pt)
    #scale(85%,
    zap.circuit({
      import zap : *
      import cetz.draw : *

      line((0, 10), (8, 10))
      line((0, 2.5), (8, 2.5))

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
      wire("t4.s", (rel: (0, -0.97)))

      wire("t1.d", (rel: (1.5, 0)), (rel: (0, 0.2)), (rel: (0.6, 0)), (rel: (0, -0.8)), (rel: (3, 0)))
      content((8.5, 7.3), $V_"out"$)

      content((-0.3, 6), $V_A$)
      wire((0, 6), (0.8, 6))

      content((3.7, 7), $V_B$)
      wire((4, 7), (4.8, 7))

      circle((7, 7.37), radius: 0.05, fill: black)
      content((0.2, 2.8), "0V")
      content((0.2, 9.6), $V_(s s)$)
    })
  )
]
)
  ]
)
