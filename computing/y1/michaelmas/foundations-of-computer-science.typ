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
    #h(1fr) _Foundations of Computer Science_
  ],
)

= Foundations of Computer Science

#table(
  columns: (auto, auto),
  table.header([*Layer*], [*Description*]),
  [Transistors], [On the smallest scale, computers are turning transistors on and off.],
  [Microcontroller], [The Raspberry Pi Pico has millions of *transistors*.],
  [Motherboard], [Contains multiple *CPUs* all trying access shared resources (RAM).],
  [Devices], [The Apple Vision Pro contains lots of *sensors* and *chips* fit in a small box.],
  [Supercomputer], [Thousands of *CPUs*\/*GPUs* working together, connected to internet and storage.],
  [The user],
  [Computers in *data centres* are rented out to users doign all sorts of stuff,
  e.g. doing AI research, watching Netflix, etc.]
)
== Abstraction

There's no way of understanding the whole tower at once: you cannot understand agentic AI in terms of transistors.

- With abstraction, you only understand the layer below.
- This is the _"What operations do I need to do the task?"_ mentality of a programmer.

#definition([
  *Abstraction barrier* allows one layer to be changed without affecting levels above.
])

=== Representing Data

#definition([
  The concept of a *data type* involves
  - How a value is represented inside the computer.
  - The suite of operations (services) provided to the programmer.
])

How the data is represented may produce undesired results.
- The Y2K crisis.
- Floating point precision error.

== Programming in OCaml

The goals of programming is to *describe a computation* so it can be done mechanically.
- Be efficient and correct.
- Allow easy modification: the effect of changes can be easily predicted.

#definition(table(
    columns: (auto, auto),
    table.header([*Keyword*], [*What they do*]),
    [Expressions], [Compute values, _may_ cause side effects.],
    [Commands], [Cause _only_ side effects]
), title: "Definitions")

=== Why OCaml?
- Interactive evaluation in *Jupyter notebooks* and in a *REPL*.
- Flexible and powerful notion of a data type.
- Hides underlying complexity - it throws an exception but never crashes, manages memory for us.
- Programs written can be understood/reasoned mathematically. (as there is no side effect)

=== Basics in OCaml

```ml
(* = Variable declaration *)
let pi = 3.1415926                 (* val pi : float = 3.1415926 *)

(* = Function declaration *)
let area r = pi *. r *. r          (* val area : float -> float *)

(* = Function invocation *)
area 2.0                           (* - : float = 12.556 *)

(* = Recursive functions *)
let rec npower x n =               (* npower : float -> int -> float = <fun> *)
    if n = 0 then 1.0
    else x *. power x (n - 1)

(* Type hints for the compiler *)
let side : float = 1.0             (* side : float *)
let square (x : float) = x *. x    (* square : float -> float *)

(* If-Else *)
let rec power x n =                (* power : float -> int -> float *)
    if n = 1 then x
    else if (n mod 2) == 0 then
        power (x *. x) (n / 2)
    else 
        x *. power (x *. x) (n / 2)
(* this is a more efficient power function than npower *)
```

OCaml automatically infers types, but it does *not* implicitly convert types.
- Type inference by looking at the operations values, `*.` for float multplication and `*` for integers.
- All branches of an if-else block must return value of the same type.

Type hints are useful to prevent OCaml from inferring all the wrong types when you make one small mistake.

#line(length: 100%)

== Recursion and Complexity

#definition([
  Separating expressions from side effect is known as *functional programming*.
])

We can trace an expression, for example `power` function defined above.

#list(
  `power 2.0 12`,
  `power 4.0 6`,
  `power 16.0 3`,
  `16 *. power 256.0 1`,
  `16 *. 256.0`,
  `4096.0`,
  marker: $arrow.r.double$
)

#grid(
  columns: (45%, auto),
  ```ml
  (* sums the first n integers *)
  let rec nsum n =
    if n = 0 then 0
    else
      n + nsum (n - 1)
  ```,
  list(
    `nsum 3`,
    `3 + nsum 2`,
    `3 + (2 + nsum 1)`,
    `3 + (2 + (1 + nsum 0))`,
    `3 + (2 + (1 + 0))`,
    `6`,
    marker: $arrow.r.double$
  )
)

Nothing can progress until the innermost sum is calculated. All the intermediate values have to be stashed onto the *program stack*. Evaluating `nsum 10000000` can cause a stack overflow.

=== Alternative Approach: Iterative Summing

#grid(
  columns: (45%, auto),
  ```ml
  let rec sum n total =
    if n = 0 then total
    else
      summing (n - 1) (n + total)
  ```,
  list(
    `sum 3 0`,
    `sum 2 3`,
    `sum 1 5`,
    `sum 0 6`,
    `6`,
    marker: $arrow.r.double$
  )
)

The trace looks quite different.
- The total is known as an *accumulator*.
- Functions like this is called *tail recursive*.

#definition([
  In a *tail recursive* function, the recursive function call is the last thing the function does.
])

`nsum` is not tail recursive because it has to do the _add_ operation after calling the function.
- `sum` won't stack overflow only if the compiler knows the function is tail recursive and optimises it.
- OCaml pops the function call off the stack before it finishes executing.

==== Downsides of Tail Recursion
- Extra variable needed, so easier to call the function incorrectly.
- Function is more complicated.
Don't use tail recursion with accumulator unless gain is significant.

=== Analysing Efficiency

```ml
let rec sillySum n =
  if n = 0 then 0
  else
    n + (sillySum (n - 1) + sillySum (n - 1)) / 2
```

`sillySum` is ran twice, as there may be side effects and the two functions may give different results.
- This is why pure functional evaluation is much simpler.
- Assign the value to a variable to avoid it being evaluated twice.

```ml
let rec sillySum n =
  if n = 0 then 0
  else
    let previousSum = sillySum (n - 1) in
      n + (previousSum + previousSum) / 2
```

=== Asymptotic complexity

#definition([
  *Asymptotic complexity* refers to how programs costs grow with increasing inputs.
])

E.g. space and time, the latter usually being larger than the former.

#definition([
  The *Big-O* notation is defined as $f(n) = O(g(n))$ provided that $|f(n)| lt.eq c|g(n)|$ for large $n$.
])

Intuitively, consider the most significant term and ignore the constant coefficient or smaller factors.

Here are some interesting results:
- $O(log n) = O(ln n)$
- $O(log n)$ is contained in everything, including $O(sqrt(n))$
- An exponential algorithm can be faster than a linear algorithm for a particular input size interval.
- $O(n log n)$ is called *quasi-linear*.

=== Simple Recurrence Relation

Set the time cost of base case $T(1) = 1$.
#table(
  columns: (auto, auto),
  table.header([*Recurrence relation*], [*Time complexity*]),
  $T(n + 1) = T(n) + 1$, $O(n)$,
  $T(n + 1) = T(n) + n$, $O(n^2)$,
  $T(n) = T(n slash 2) + 1$, $O(log n)$,
  $T(n) = T(n slash 2) + n$, $O(n log n)$,
)

Some examples in analysing time complexity.

#grid(
  columns: (45%, auto),
  inset: 15pt,
  ```ml
  let rec nsum =
    if n = 0 then 0
    else
      n + nsum (n - 1)
  ```,
  [
    - $T(0) = 1$
    - $T(n + 1) = T(n) + 1$
    - So $O(n)$
  ],
  ```ml
  let rec nsumsum n =
    if n = 0 then 0
    else
      nsum (n - 1) + nsumsum(n - 1)
  ```,
  [
    - $T(0) = 1$
    - $T(n + 1) = T(n) + n$
    - So $O(n^2)$
  ],
  ```ml
  let rec power x n =
    if n = 1 then x
    else if even n then
      power (x *. x) (n / 2)
    else
      x *. power (x *. x) (n / 2)
  ```,
  [
    - $T(0) = 1$
    - $T(n) = T(n / 2) + 1$
    - So $O(log n)$

    At each call $n$ is halved, and add 1 as there is always some extra work (e.g. calling the function, if branch).
  ]
)

#line(length: 100%)

== Lists

#definition([
  A *list* is a finite, ordered sequence of elements, all elements must have the same type.
])

=== List Primitives

There are only 2 kinds of lists, the 2 operations covers all possible lists.
```ml
[] (* nil : the empty list *)
x :: xs (* cons : put one element in front of the list *)
```

`[3; 5; 9]` is syntactical sugar for `3 :: (5 :: (9 :: []))`.

```ml
[3; 5; 9]
(* - : int list = [3; 5; 9] *)

[[3; 1]; [2]]
(* - : int list list = [[3; 1]; [2]] *)

(* concatenate two lists *)
[3; 5; 9] @ [2; 4]
(* - : [3; 5; 9; 2; 4] *)

(* the List library contains useful functions *)
List.rev [1; 2; 3]
(* - : [3; 2; 1] *)
```

=== Tuples

#definition([
  *Tuples* are fixed size and hetrogeneous sequences.
])

```ml
let pair = (1, true)
(* val pair : int * bool = (1, true) *)

(* you can do it without the brackets *)
let another_pair = 1, true, 3.2
(* val another_pair : int * bool * float = (1, true, 3.2) *)

(* take care not to use commas instead of semicolons *)
let list = [1, 2, 3]
(* val list : int * int * int list *)
```

=== Pattern Matching

All possible values that can be matched must be matched.

```ml
let null = function
  | [] -> true
  | _ :: _ -> false

let is_zero = function
  | 0 -> true
  | _ -> false
```

You can also pattern match parameters.

```ml
let hd = (x :: _) = x

hd [1] (* 1 *)
hd [] (* match error *)
```
In this case is better to use an option type.

=== Polymorphic Functions

The `List.tl` function returns the tail of a list

```ml
List.tl
(* - : 'a list -> 'a list = <fun> *)
```

An `'a` type (read: alpha type) means it can be of any type, but all elements of the list must be the same type.

#line(length: 100%)

== More List Functions

```ml
let rec append = function
    | [], ys -> ys
    | x :: xs, ys -> x :: append xs ys
(* val append : a' list * a' list -> a' list *)
```

The match keyword keeps the reference to the original value.

```ml
let rec append xs ys =
  match xs, ys with
    | [], ys -> ys
    | x :: xs, ys -> x :: append xs ys
(* val append : a' list -> a' list -> a' list *)
```

=== Take and Drop

- `take` takes the first `i` items of a list.
- `drop` returns all the items that are not included in `take`

```ml
let rec take = function
  | [], _ => []
  | x :: xs, i =>
    if i > 0 then
      x :: take (xs, i - 1)
    else
      []
;;

let rec drop = function
  | [], _ -> []
  | x :: xs, i ->
    if i > 0 then
      drop (xs, i - 1)
    else
      x :: xs (* we could do this better using a match *)
;;
```

In the `drop` function:
- We advance the pointer as we go through the list.
- Then just returns the pointer where we stop.
- No memory is used.

In the `take` function has to construct a list from scratch.

=== Searching

Goal is to find $x$ in a list $[x_1; dots;x_n]$
#table(
  columns: (auto, auto, auto),
  table.header([*Name*], [*Description*], [*Cost*]),
  [Linear search], [Compare each element], [$O(n)$],
  [Oredred search], [The list is bisected every time], [$O(log n)$],
  [Indexed search], [Create an index, e.g. a hash map], [$O(1)$],
)

=== Equality Test

The polymorphic equality operator `=` to compare integers, bools, floats but not functions.

_Do not use `==`_

=== List Membership

```ml
let rec member x = function
  | [] -> false
  | y :: ys -> x = y || member x ys
```

The `||` is not a normal function, if the first case evaluates to true, it will not bother to evaluate the 2nd bit.

=== Zip and Unzip

```ml
let D in E
```
- Embeds declaration `D` within expression `E`
- Useful for performing intermediate computations within a function.

```ml
let rec zip = function
  | (x :: xs, y :: ys) ->
    (x, y) :: zip (xs, ys)
  | _ -> []
;;

let rec unzip pairs = function
  | [] -> []
  | (x, y) :: pairs ->
    let xs, ys = unzip pairs in
    (x :: xs, y :: ys)
;;
```

If we redo that in an iterative algorithm.

```ml
let rec unzipRev pairs = function
 | [], xs, ys -> xs, ys
 | (x, y) :: pairs, xs, ys ->
  unzipRev (pairs, x :: xs, y :: ys)
```

- In `unzip`, we traverse to the end then build up the list.
- In `unzipRev` we start building up the list right away.

That's why their order is different.

#line(length: 100%)
