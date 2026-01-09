#import "@local/lecture:0.1.0" : *
#import "@preview/cetz:0.4.2"

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

== System Timing
