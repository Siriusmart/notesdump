#import "@local/lecture:0.1.0" : *

= Algorithms I

#def([
  An *algorithm* is a _well defined_ computation procedure that takes a set of values as input and produces a set of values as output.

  Note: the term _well defined_ is itself, not well defined.
])

#defs([
  - *Problems* have specific inputs and outputs, input must be finite and not a stream of data.
  - *Problem instances* is a specific set of inputs for a problem. A problem can have a Big-O but not a problem instance.
  - A program is *correct* if for every input instance, it terminates with the correct output.

  #note([
    - Randomised algorithms is a branch of incorrect algorithms.
    - Some algorithms produce incorrect outputs with a probablility (e.g. quantum computing)
    - Some algorithms loops infinitely for some inputs, but runs a lot faster that an algorithm that guarantees termination for cases where it terminates. It might be possible to determine whether it will terminate for a specific input before running it.
    - Some algorithms gives an output within a margin of error (e.g. A\* vs Dijkstra)
  ])
])

== Notation

=== Arrays
- `A[1]` is the first item
- `A[1..n]` is an array of length `n`
- `A.length` is the number of items in the array

We write pseudocode that is
- Imparative
- Block structured
- Fixed form (indentation matters)
- Parameters are passed by values, objects are passed by pointers
- Loop induction (for loops) increments after the final loop
  ```js
  for i=1 to 10
    // do stuff
  ```
  After this loop, consider `i=11`

== Sorting

Each *key* may have attached payloads.

=== Insertion Sort

```js
for j = 2 to A.length
  Key = A[j]
  i = j - 1
  while i > 0 && A[i] > Key
    A[i + 1] = A[i]
    i = i - 1
  A[i + 1] = Key
```

Use proof by induction for algorithms:
- *Initialisation*: find a property that is true at the start of the program
  
  $P$: at the start of each loop, $A[1 dots j-1]$ contains the $1 dots j-1$ items in sorted order.

  At the start of the first loop, that is just $[a_1]$, true.

  #note([
    Define "the start of the loop" as: after assigning the value of $j$, but before running the first line of code in the loop.
  ])
- *Maintenance*: show that the property is maintained as the program is running.
- *Termination*: when the program terminates, show the output is correct.
  
  After the last loop, $A[1 dots A."length"]$ would have been containing all the items $1 dots A."length"$ in order.

  And then we can also show the program terminates as it only needs to complete the loop $A."length"$ items.


#note([
  Which is the same as the following Hoare logic proof.

  Let $P,Q$ be pre and post-conditions, $B$ be body of the loop, $C$ be condition for the loop.

  Given:
  1. ${P} space B space {P}$
  2. $P and not C imp Q$

  Then ${P} "while" C "do" B space {Q} $
])

#hr

== Analysis

#def([
  *Analysis* is about predicting the resources (CPU, memory, disk operations) for input instances we haven't ran our algorithm on.
])

#tab2(
  [Input measurement], [Description],
  $A."length"$, [ Common for every day senarios, but may be incorrect if each item in array can have variable size (e.g. big integer)],
  [no. of bits/bytes], [Useful for algorithm that operates on some bit/byte value.],
  $2^(A."length")$, [ Overestimates the size in most cases, but can be used for search lists.]
)

#def([
  The *running time* of a program is the number of *basic operations*. (as they all cost 1)
  #tab2(
    [Basic operation], [Cost],
    [Indexing an array $A[i]$], [1],
    [Arithmetic operation], [1],
    [Comparisons], [1],
    [Assigment to variables], [1]
  )

  One basic operation might not be equal to one clock cycle, if you change the cost of the basic operations, the running time changes.
])

#note([
  Comparisons (numbers) is usually done by subtracting one from another, then compare with 0.
])

== Orer of Growth

- $Theta(g(n))$ is the *asymptotic tight bound* for $g(n)$
  $
  f(n) in Theta(g(n)) imp ex c_1, c_2, n_0 in real^+: (fa n >= n_0 : c_1 g(n) <= f(n) <= c_2 g(n))
  $
- $O(g(n))$ is the *asymptotic tight upper bound* for $g(n)$
  $
  f(n) in O(g(n)) imp ex c, n_0 in real^+ : (fa n >= n_0 : f(n) <= c g(n))
  $
- $Omega(g(n))$ is the *asymptotic tight lower bound* for $g(n)$
  $
  f(n) in Omega(g(n)) imp ex c, n_0 in real^+ : (fa n >= n_0 : c g(n) <= f(n))
  $
- $o(g(n))$ is the *asymptotic non-tight upper bound* for $g(n)$
  $
  f(n) in o(g(n)) imp fa c in real^+ : (ex n_0 in real^+ : f(n) < c g(n))
  $
- $omega(g(n))$  is the *asymptotic non-tight lower bound* for $g(n)$
  $
  f(n) in omega(g(n)) imp fa c in real^+ : (ex n_0 in real^+ : c g(n) < f(n))
  $

=== Properties of Orders of Growth

$
Theta(g(n)) &subset.eq O(g(n)) \
Theta(g(n)) &subset.eq Omega(g(n)) \
$

- *Transitive*: satisfied by all 5 orders
  $
  f(n) in Theta(g(n)) and g(n) in Theta(h(n)) imp f(n) in Theta(h(n))
  $
- *Reflexive*: satisfied by the tight bounds $Theta, O, Omega$
  $
  f(n) in Theta(f(n))
  $
- *Symmetric*: satisfied by $Theta$
  $
  f(n) in Theta(g(n)) imp g(n) in Theta(f(n))
  $

=== Analysis of Insertion Sort

```js
for j = 2 to A.length         // ran (n-1)+1 times
  Key = A[j]                  // ran n-1 times
  i = j - 1                   // ran n-1 times
  while i > 0 && A[i] < Key   // ran sum_(j=2)^n t_j times
    A[i+1] = A[i]             // ran sum_(j=2)^n (t_j - 1) times
    i = i - 1                 // ran sum_(j=2)^n (t_j - 1) times

  A[i+1] = Key                // ran n-1 times
```

Where $t_j$ is the number of times the while loop is tested on the $j$th cycle.

- Best case: $t_j=1$ then $T(n) = p n + q$
- Worst case: $t_j = j$ then $T(n) = p n^2 + q n + r$
- Average case: the claim is that on average, half  of the keys in $A[1 dots j-1]$ will be less than $A[j]$
  
  $t_g = j slash 2$ gives $T(n) in O(n^2)$

The worst case is useful because
- It gives the upper bound on resource
- Often the same as the average case

Insertion sort is an *incremental algorithm*: it builds up an output that satisfies some properties.

== Divide and Conquer

1. Split into 2 or more smaller subproblems.
2. call the same algorithm on each subproblem recursively.
3. Combine solutions to the subproblems to build the solution to the original problem.

#note([
  Recursion will terminate because the subproblem will get smaller and smaller.
])

=== Merge Sort
```js
// we are sorting A[p..r]
if p < r
  q = floor((p + r) / 2)
  MergeSort(A, p, q)
  MergeSort(A, q + 1, r)
  Merge(A, p, q, r)
```

And `Merge` defined as
```js
n1 = q - p + 1
n2 = r - q

L = new Array(1 .. n1 + 1)
R = new Array(1 .. n2 + 1)

L[1 .. n1] = A[p .. q]
L[n1 + 1] = infinity
R[1 .. n2] = A[q + 1 .. r]
R[n2 + 1] = infinity

i = j = 1

for k = p to r
  if L[i] <= R[j]
    A[k] = L[i]
    i = i + 1
  else
    A[k] = R[j]
    j = j + 1
```

#hr

- If the length of the array is not a power of 2, pad $infty$ to the end so that it is.
- After sorting, remove the added $infty$ at the end of the sorted array.

The input array is modified, ```js Merge``` has no return value.

=== Recurrence Relations

The input size is lengh of the region to be sorted $n = r - p + 1$

Let $T(n)$ be the cost of solving $"MergeSort"(A, p, r)$
- If $p = r$, $T(1) = 1$
- If $p < r$
  #tab2(
    [Action], [Cost],
    [Calculate $q$], $Theta(1)$,
    [Calls itself on 2 subproblems], $T(n slash 2) times 2$,
    [
      Calls $"Merge"(A,p,q,r)$
      #tab2(
        [Action], [Cost],
        [Creates 2 arrays of length $n + 2$], $Theta(n)$,
        [Loop $n$ iterations: assign into array and increment $i$ or $j$], [$Theta(n)$]
      )
    ],
    $Theta(n)$
  )

$
T(1) &= 1 \
T(n) &= Theta(1) "work" + 2 dot T(n/2) + Theta(n) "work" \
&= k_1 + 2 dot T(n/2) + k_2 dot n
$

#def([
  A *closed form solution* is not defined in terms of itself through direct or indirect recursion.
])

$
T(n) &= k_1 + k_2 dot n + 2 dot T(n/2) \
&=k_1 + k_2 dot n + 2 dot (k_1 + k_2 dot n/2 + 2 dot T(n/4)) \
&=k_1 + k_2 dot n + 2 dot (k_1 + k_2 dot n/2 + 2 dot (k_1 + k_2 dot n/4 + 2 dot T(n/4))) \
&vdots \
&=k_1 dot underbrace((1 + 2 + 4 + dots), log n "terms")+ k_2 dot n dot underbrace((1+1+1+dots), log n "times") + 2^(log n) dot T(1) \
&=k_1 dot (n - 1) + k_2 dot n log n + n \
&in Theta(n log n)
$

#note([
  We preserved the equal signs instead of saying "this term dominates" so we know $T(n) in Theta(f(n))$ instead of just $O(f(n))$
])

If the array length is not a power of 2
$
T(n) &= T(ceil(n slash 2)) + T(floor(n slash 2)) + k_1 + k_2 dot n
$

Which gives the same solution.

=== The Master Theorem

Let $a >= 1$ and $b > 1$ be constants.

- $T(1) = 1$
- $T(n) = a dot T(n slash b) + f(n)$

#note([
  $n slash b$ can be interpreted as ceil or floor, it doesn't matter.
])

$
f(n) in O(n^(-epsilon + log_b a)) "for some" epsilon > 0 &imp T(n) in Theta(n log_b a) \
f(n) in Theta(n^(log_b a)) &imp T(n) in Theta(n log_b a dot lg a) \
f(n) in Omega(n^(epsilon + log_b a)) "for some" epsilon > 0 "and" f(n slash b) <= c f(n) \
"for some" c > 1 "for all sufficiently large" n &imp T(n) in Theta(f(n))
$

#note([
There is an extended master theorem for conditions between case 2 and 3.
])

#hr
