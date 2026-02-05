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
  f(n) in o(g(n)) imp fa c in real^+ : (ex n_0 in real^+ : (fa n >= n_0: f(n) < c g(n)))
  $
- $omega(g(n))$  is the *asymptotic non-tight lower bound* for $g(n)$
  $
  f(n) in omega(g(n)) imp fa c in real^+ : (ex n_0 in real^+ : (fa n >= n_0 : c g(n) < f(n)))
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
f(n) in O(n^(-epsilon + log_b a)) "for some" epsilon > 0 &imp T(n) in Theta(n ^(log_b a)) \
f(n) in Theta(n^(log_b a)) &imp T(n) in Theta(n ^(log_b a) dot lg n) \
f(n) in Omega(n^(epsilon + log_b a)) "for some" epsilon > 0 "and" f(n slash b) <= c f(n) \
"for some" c > 1 "for all sufficiently large" n &imp T(n) in Theta(f(n))
$

#note([
There is an extended master theorem for conditions between case 2 and 3.
])

#hr

=== Quicksort

```js
QuickSort(A, p, r)
  if p < r
    q = partition(A, p, r)
    QuickSort(A, p, q - 1)
    QuickSort(A, q + 1, r)

Partition(A, p, r)
  x = A[r]
  i = p - 1
  for j = p to r - 1
    if A[j] <= x
      i = i + 1
      swap(A[i], A[j])
  swap(A[i + 1], A[r])
  return i + 1
```

The strategy: *divide* (partition array into 3 parts), *conquer* (recurse on $L$ and $G$), *combine* (no-op).

Requirements for *Partition(A, p, r)* is
- Pick any element as pivot
- Rearrange so array looks like $["items" <= "pivot", "pivot", "items" >= "pivot"]$

$
[L, x, G]
$

==== Proof

Let $P$ be the statement:
1. If $p <= k <= i$ then $A[k] <= x$
2. If $i + 1 <= k <= j - 1$ then $A[k] > x$
3. If $k = r$ then $A[k] = x$

#note([
  No statements made for $j <= x <= r - 1$ which is the unprocessed region.
])

- *Initialisation*: (1) and (2) vacuously true, (3) is true by definition.
- *Maintenance*
  - Case does not enters if branch: (1) and (3) remains true, (2) is true as the new item $ >x$
  - Case enters if branch: (3) remains true, (1) and (2) are true as their new items both satisfies contraint.
- The final swap ensures post-condition.

==== Performance

The number of comparisons depends on how $"Partition"$ splits the array.

- *Best case*: partition splits array in half
  $
  T(1) &= 1 \
  T(n) &= 2 dot T(n/2) + k dot n \
  T(n) &in Theta(n log n)
  $
  by master theorem.

#hr

- *Unbalanced partition*, e.g.
  $
  T(1) &= 1 \
  T(n) &= T(n/4) + T((3n)/4) + k n
  $
  The *computation tree* is unbalanced.
  - The shallowest node has depth $log_4n$
  - The deepest node has depth $log_(4 slash 3)n$

  Both gives $Theta(n log n)$, so any ratio split gives $Theta(n log n)$
- *Worst case* when the pivot is the largest/smallest item in array.
  $
  T(n) &= T(n-1) + T(0) + k n \
  &= T(n - 1) + k n \
  & in Theta(n^2)
  $

  The probability of worst case on each split is $2^n slash n!$, when $n$ is small, this is quite significant.
- *Constant case* where a constant number of items are partitioned to one side. Still $Theta(n^2)$

== Order Statistic

#def([
  The $i$th order statistic is the $i$th smallest item in a set.
  - Input: a set $A$, and an integer $i$
  - Output: $x in A$ so it is larger than exactly $i-1$ other elements.
])

- Selecting the minimum and maximum item is simple at $O(n)$
- Selecting the $i$th item can be done in $Theta(n lg n)$
  1. Sort the array
  2. Get the $i$th element

```py
QuickSort(A, p, r, i)
  if p = r
    return A[p]

  q = Partition(A, p, r)
  k = q - p + 1
  if i == k
    return A[q]
  else if i < k
    return QuickSelect(A, p, q - 1, i)
  else
    return QuickSelect(A, q + 1, r, i - k)
```

Worst case:
  $
  T(1) &= 1 \
  T(n) &= T(n-1) + k n \
  &in Theta(n^2)
  $

=== Optimisations

- Randomise input data before starting
- Choose pivot at random
- Medium of 3: choose the median of 3 selected items as pivot.

  Hitting worst case if:
  - One of the 3 element is max or minimum element
  - The other median element is right next to the max/minimum element.
  This has probability $2 slash n^2$
- Median of medians:
  1. Consider array as groups of 5 elements.
  2. Pick the median of each group with insertion sort.
  3. Use quick select to select the median of the medians as pivot.
  The final median is a median of $ceil(n slash 5)$ "medians"
  - Half the "medians" are greater than the median.
  - Number of elements greater/smaller than the pivot is
    $
    "number of elements">= 3 dot ceil(1/2 ceil(n/5) - 2) >= (3n)/10 - 6
    $
    #note([
      $-2$ removes 2 groups for worst case, includes the last group that is possibly incomplete, and the group that the pivot is in.
    ])

    Worst case is $3n slash 10 - 6$ on one side and $7n slash 10 + 6$ on the other.

    Suppose
    $
    T(n) &= k quad "if" n < 140 \
    T(n) &= T(ceil(n/5)) + T((7n)/10 + 6) + k n quad "as we are considering the worst case"
    $

    If we guess that $T(n) in Theta(n)$, then
    $
    T(n) &<= c dot ceil(n / 5) + c dot ((7n)/10 + 6) + k n \
    &<= (c n)/5 + c + (7 c n)/10 + 6 c + k n \
    &= c n + (-(c n)/10 + 7c + k n)
    $

    If $(-c n slash 10 + 7c + k n) <= 0$, then $T(n) in O(n)$
    - (Not in handout) Also need to check lower bound is in $Omega(n)$ to show $T(n) in Theta(n)$

#hr

== HeapSort

#def([
  - A *heap* is a full tree, except the lowest level, which is filled from left to right.
  - The *ordering property*: for a *min-heap* the key of every node is less than its children. Similar for a *max heap*.
])

Heaps can be stored as a tree or in an array:
- Root node at $A[1]$
- Left/right child of athe node at $2i$ and $2i+1$
- Parent of a node at $floor(i slash 2)$
- A child exist only if $2i$ and/or $2i+1$ is $<=$ the array's length
- A node has no parent if $floor(i slash 2) = 0$
Storing in array uses less memory as no pointers need to be stored.

Heaps are *semi-structures* - it only maintain *partial order*.
- Smallest item at the root
- 2nd smallest item in 2 possible places
- 3rd smallest item in 3 places, etc.
A semi-structure is cheaper to build than fully structured data structures.

Consider operations on a *max-heap*.
#tab3(
  [Operation], $T(n)$,[Description],
  [MaxPeek], $T(1)$, [Just return the root node],
  [MaxReheapify], $T(lg n)$, [
    Call on heaps where the root node is larger than one of its children to repair the heap.
    1. Swap root node with child if needed, this damages the child heap
    2. Call reheapify on the child heap.
  ],
  [MaxFullHeapify], $T(n)$, [
    Perform swaps on an array so it is a valid heap.
    1. The bottom level leaves are valid heaps.
    2. Take two leaves, pick another node as the root node, call reheapify to make the tree of 3 a valid heap.
    3. Repeat for next layer, etc.
  ],
  [MaxExtract], $T(lg n)$, [
    1. Swap the root with bottom right leaf.
    2. Remove the now bottom right leaf.
    3. Call reheapify to repair the heap.

    This is better than removing the root node then merge the heaps, because
    the ordering property is easier to repair than the structural properity.
  ]
)
So the HeapSort algorithm.
```py
MaxFullHeapify(A) # O(n)

for i = A.length downto 2: # O(n lg n)
  # ASSERT: A[i..] is sorted
  swap(A[1], A[i]) # essentially a MaxExtract
  A.length = A.length - 1
  MaxReheapify(A)
```

#hr
