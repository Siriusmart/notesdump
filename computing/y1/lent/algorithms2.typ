#import "@local/lecture:0.1.0" : *
#import "@preview/algorithmic:1.0.7"
#import algorithmic: style-algorithm, algorithm-figure
#show: style-algorithm

= Algorithms II

== Graphs

#def([
  A *graph* $G=(V,E)$ where $E subset.eq V times V$
])

- In an *undirected graph*, edges are unordered pairs.
- A *weighted graph* has a *weighting function* $E to real$ which could be positive, zero or negative.
- A graph is *complete* if $E = V times V$

=== Representations of a Graph

#tab2(
  [Adjacency matrix], [Adjacency list],
  [
    A $|V| times |V|$ matrix $Theta(|V|^2)$ in size.
    - If unweighted, each cell stores a 0 or 1
    - If weighted, stores the weight
    - If undirected, it is symmetric, so only half of the matrix will need to be stored.
  ],
  [
    List of holding a linked list of adjacent vertices.
  ],
  [
    $O(1)$ to check $(u, v) in E$.
  ],
  [
    $O(|V|)$ to check $(u, v) in E$.
  ],
  [
    $O(|V|)$ to list neighbours.
  ],
  [
    $O("neighbour count")$ to list neighbours.
  ],
  [
    $O(|V|^2)$ to iterate over edges.
  ],
  [
    $O(|E|)$ to iterate over edges.
  ],
  [More compact for dense graphs (1 bit per edge)],
  [More compact for sparse graphs],
)

- The *transpose of a graph* $G^T = (V, E^T)$ represents a *reverse index*.
- The *square of a graph* $G^2 = (V, E^2)$ where $(u, v) in E^2$ if there is a path from $u$ to $v$ consisting of at most 2 edges.

Two vertices are adjacent if they share a vertex.

#def([
  An *induced subgraph* $G' = (V', E')$ where $V' subset.eq V$ is where
  $
  fa u, v in V' : (u, v) in E iff (u, v) in E'
  $

  A *clique* in a graph is any induced subgraph that is *complete*.
])

#tab2(
  [Colouring problem], [Description],
  [Vertex colouring], [Assign colours to $v in V$ so no adjacent vertices have same colour.],
  [Edge colouring], [... no adjacent edges have the same colour.],
  [Face colouring], [... no two adjacent faces on a *planar graph* have the same colour.]
)

#defs([
  - A *planar graph* can be drawn on a plane so no two lines intersect.
  - A *face* is a region bounded by edges.
])

=== Breadth First Search

To work on cyclic graphs, mark vertices we have visited to prevent us from visiting twice.

```py
for v in G.V:
  v.marked = false

Q = new Queue
Enqueue(Q, s)

while !QueueEmpty(Q):
  u = Dequeue(Q)
  if (!u.marked):
    u.marked = true
    for v in G.E.adj[u]:
      Enqueue(Q, v)
```

This algorithm is inefficient because it may add the same vertex multiple times to the queue, to fix this add a *pending* flag for the element.

The flags are be replaced by any data structures where membership can be tested.

=== Two Vertex Colourability

Input: connected, undirected graph

1. Run BFS to colour the first level as red, 2nd as black, etc $O(|V|)$
2. Check if every adjacent vertices are of different colour $O(|E|)$

Total cost: $O(|V| + |E|)$, for a complete graph, it is $O(|E|)$

#note([
  - The algorithm doesn't matter wherever you run it from.
  - If the graph is not connected, that part will not be explored.
])

=== Single-source All-destination Shortest Path

- Input: unweighted graph and a starting node $s$
- Output: distance and shortest path to all nodes

Run BFS with:
- Source distance $=0$, path $=[space]$
- The output of any unreachable vertices have distance $infty$

If average path length is $O(|V|)$, then output is $O(|V|^2)$

#hr

The path to a node is given by repeatedly visiting $v.pi$ until $v.pi = "NIL"$

#algorithm-figure(
  "SSAD_HOPCOUNT",
  {
    import algorithmic : *
    Function(
      "SSAD_HOPCOUNT",
      ($G$, $s$),
      {
        For(
          $v "in" V$,
          {
            Assign($v."pending"$, "false")
            Assign($v.d$, $infty$)
            Assign($v.pi$, "NIL")
          }
        )
        LineBreak
        Assign($s."pending"$, "true")
        Assign($s.d$, $0$)
        Assign($s.pi$, "NIL")
        LineBreak
        Assign($Q$, "new queue")
        Assign($Q$, $"enqueue" s$)
        LineBreak
        While(
          $Q "not empty"$,
          {
            Assign($u$, $"dequeue" Q$)
            For(
              $v "in" E."adj"[u]$,
              If(
                $"not" v."pending"$,
                {
                  Assign($v."pending"$, "true")
                  Assign($v.d$, $u.d + 1$)
                  Assign($v.pi$, $u$)
                  Assign($Q$, $"enqueue" v$)
                }
              )
            )
          }
        )
      }
    )
  }
)

=== Proof of Correctness

- Goal: when #smallcaps("Ssad_Hopcount") terminates, $v.d$ is the length of the shortest path from $s$ to $v$.
- Let $delta(s,v)$ be the actual shortest path length from $s$ to $v$.
  
  If there is no path from $s$ to $v$, $delta(s,v) = infty$

#lemma("1", [
  If $(u,v) in E$ then $delta(s, v) <= delta(s, u) + 1$
  - Case $u$ is unreachable: $delta(s,u) = infty$, so inequality holds.
  - Case $u$ reachable: 
  - If the shortest path is through $u$, then $(u,v)$ is shorter than any other edge from $u$ to $v$
  - Otherwise $delta(s,v) < delta(s,u) + delta(u, v) = delta(s,u) + 1$
])

#lemma("2", [
  On termination, $v.d >= delta(s,v)$ for all $v in V$

  Induction hypothesis: $fa v in V : v.d >= delta(s, v)$
  - Base case: before the first while loop
    - $delta(s,s) = 0$ and $s.d = 0$ for source
    - $v.d = infty$ for all other nodes
  - $v.d$ is only updated if $v$ is not pending
    $
    v.d &= u.d + 1 \
    &>= delta(s,u) + 1 \
    &= delta(s,v)
    $
    $v.d$ is then never changed again.
])

#lemma("3", [
  Inductive hypothesis: if $Q = v_1,v_2, dots,v_x$, then $v_x.d <= v_1.d + 1$ and $v_i.d <= v_(i+1).d$ for all $i$

  Dequeue:
  - If dequeuing leaves $Q$ empty, then vacuous.
  - Otherwise $v_x.d <= v_1.d <= v_2.d$

  Enqueue: the new $v_(x+1).d = v_1.d + 1$, then $v_(x+1).d <= v_1.d + 1$ and $v_x <= v_(x+1)$
])

#coro([
  If $v_a$ is enqueued before $v_b$, then $v_a.d <=v_b.d$ on termination.

  - If $v_a$ and $v_b$ are in $Q$ simultaneously, then $v_a <= v_b$
  - Otherwise, apply transitivity
])

Suppose the algorithm doesn't work, then there is a minimum $delta(s,v)$ that has an incorrect $v.d$ upon termination. This means $v.d > delta(s,v)$
- $v$ must be reachable from $s$, otherwise $delta(s,v) = infty >= v.d$ contradicts $v.d > delta(s,v)$

Let $u$ be the node on the shortest path from $s$ to $v$ that comes immediately before $v$
- We know $delta(s,u)=u.d$ is correct
- $v.d > delta(s,u) + 1 = u.d + 1$

When $u$ is dequeued, either
1. $v$ is not yet queued, $v.d = u.d + 1$, but this contradicts $v.d > u.d + 1$
2. $v$ is enqueued but not yet dequeued $v.d = w.d + 1 <= u.d + 1$, again contradiction
3. $v$ has already been dequeued, then $v.d <= u.d$, contradiction

Therefore there is no _first time_ the algorithm goes wrong, it must be correct.

#note([
  $v.pi$ traces a path of length $v.d$, which is the shortest path.
])

All edges $(v.pi,v)$ forms a *predecessor subgraph* of G called the *breadth-first tree*.

- $V_"PSG" = {v in V | v.pi != "NIL"} union {s}$
- $E_"PSG" = {(v.pi,v) | v in V \\ {s}}$
- $"PSG" = (V_"PSG", E_"PSG")$

=== Depth First Search

+ Pick a random vertex
+ Explores everything reachable
+ Repeat until all vertices have been visited

#hr

- $v."discover"$ is the global time when the DFS first considered $v$
- $v."finish"$ is the global time when DFS finished recursing into all descendents of $v$

#note([
  $u$ is a descendent of $u$ iff $v."discover" < u."discover" < u."finish" < v."finish"$
])

An edge $(u,v)$ can be classified into
#tab2(
  [Edge type], [Definition],
  [Tree edge], [$v$ is discovered by exploring $(u,v)$],
  [Back edge], [$v$ is an ancestor of $u$],
  [Forward edge], [$v$ is a descendent of $u$],
  [Cross edge], [Directed graphs only, $u$ is neither an ancestor or descendent of $v$]
)
- $u."discover" < v."discover" < v."finish" < u."finish" iff "tree or forward edge"$
- $v."discover" < u."discover" < u."finish" < v."finish" iff "back edge"$
- $v."discover" < v."finish" < u."discover" < u."finish" iff "cross edge"$

#note([
  Running DFS on a directed graph and sorting vertices by _finish time_ gives a *topological sort* for the original graph.
])

=== Strongly Connected Components

- Input: a directed graph
- Output: the strongly connected components of $G$

#def([
  A *strongly connected component* is the maximal set of vertices $C subset.eq V$ such that for all $u,v in C$, $u$ is reachable from $v$ and $v$ is reachable from $u$
])
+ Run DFS on $G$ to populate _finish time_ for each $v in V$
+ Run DFS on $G^T$, but visit the neighbours in order of descending _finish time_ from step 1.
+ For each tree in the forest produced by $"DFS"(G^T)$, output the vertices as a separate strongly connected component of $G$

=== Shortest Path Problems
- Input: directed, weighted graph with weight function $w:E to real$

#def([
  The *weight of a path* $p=v_0, v_1, dots, v_k$ is the linear sum of the edge weights.
  $
  w(p) = sum^k_(i=1) w(v_(i-1), v_i)
  $
  Which is the quantity we wanted to minimise.
])

$delta(u,v) = min_p (w(p))$, the shortest path is the $p$ where $w(p) = delta(u, v)$

Types of shortest path problems:
- Single source shortest paths
- Single destination shortest paths
- Single pair shortest paths
- All pairs shortest paths

*Bellman-Ford* runs in $O(|V||E|)$
- If there is a negative weight cycle, returns false
- Otherwise returns true

#grid2(
  algorithm-figure(
    "Bellman-Ford",
    {
      import algorithmic : *

      Function(
        "Bellman-Ford",
        ($G$, $w$, $s$),
        {
          For(
            $v "in" V$,
            {
              Assign($v.d$, $infty$)
              Assign($v.pi$, "NIL")
            }
          )
          Assign($s.d$, $0$)

          LineBreak
          Comment[Longest acyclic path is $|V| - 1$]
          For(
            $i=1 "to" |V| - 1$,
            {
              For($(u,v) "in" E$, Call("Relax", ($u$, $v$, $w$)))
            }
          )

          LineBreak
          Comment[Check for negative cycles]
          For(
            $(u,v) "in" E$,
            {
              If($v.d > u.d + w(u,v)$, Return("false"))
            }
          )

          LineBreak
          Return("true")
        }
      )
    }
  ),
  algorithm-figure(
    "Relax",
    {
      import algorithmic : *

      Function(
        "Relax",
        ($u$, $v$, $w$),
        {
          If(
            $v.d > u.d + w(u,v)$,
            {
              Assign($v.d$, $u.d + w(u,v)$)
              Assign($v.pi$, $u$)
            }
          )
        }
      )
    }
  )
)

For directed graphs that are acyclic, we can do in $Theta(|V|+|E|)$
#algorithm-figure(
  "Topological sort",
  {
    import algorithmic : *
    For(
      $u "in" V$,
      For($v "in" E."adj"[u]$, Call("Relax", ($u$,$v$,$w$)))
    )
  }
)

#hr
