#import "@local/lecture:0.1.0" : *

#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Mathematics Lecture Notes]
    #h(1fr) _Probability Theory_
  ],
)

= Probability Theory

== Sets

#defstable(
  [Sample space $S$], [The set of all possible outcomes.],
  [Event $A$], [An event $A$ is a subset of $S$.],
  $A inter B$, [$A$ and $B$ occured.],
  $A union B$, [$A$ or $B$ occured.],
  $overline(A)$, [$A$ did not occur.]
)

Properties of set operations.
#grid2(
  [*Commutative*],
  $
  A inter B &= B inter A \
  A union B &= B union A
  $,
  [*Associative*],
  $
  (A inter B) inter C &= A inter (B inter C) \
  (A union B) union C &= A union (B union C)
  $
)

#def([
  $A$ and $B$ are *mutually exclusive* iff $A inter B = emptyset$
])

The following identities are true.
$
A inter overline(A) &= emptyset \
A union overline(A) &= S \
S - B &= overline(B) \
A - B &= A inter overline(B) \
overline(A union B) &= overline(A) inter overline(B) \
overline(A inter B) &= overline(A) union overline(B)
$

== Probability

The probability $P(A)$ of $A$ happening is defined as
$
P(A) = lim_(N to infty) N_A/N
$
Where $N_A$ is the number of events in $N$ experiments.

Properties of probabilities.
- $0 <= P(A) <= 1$
- $P(A inter overline(A)) = 0$
- $P(A union overline(A)) = 1$
- $P(overline(A)) = 1 - P(A)$

The union of two events $P(A union B) = P(A) + P(B) - P(A inter B)$
- If $A$ and $B$ are *mutually exclusive*, then $P(A union B) = P(A) + P(B)$
- Extending for three events:
  $
  &P(A union B union C) \ &= P(A) + P(B) + P(C) - P(A inter B) - P(B inter C) - P(A inter C) + P(A inter B inter C)
  $
  This can be proved using the rule for two events on $P(A union (B union C))$

#def([
  *Conditional probability*: $P(B|A)$ is the probability of $B$ occuring given $A$.
  $
  P(B|A) = (P(A inter B))/P(A)
  $
])

Because $P(A inter B) = P(A) P(B|A)$, we have
$
P(A)P(A|B)P(A|B inter C) &= P(A inter B)P(A|B inter C) \
&= P(A inter B inter C)
$

=== Bayes Theorem

It is obvious that
$
P(A|B) &= P(A inter B)/P(B) \
&= (P(A)P(A|B))/(P(B))
$

Provided $P(B) != 0$

It is also true that
$
P(A|B) = (P(A)P(B|A))/(P(A)P(B|A) + P(overline(A))P(B|overline(A)))
$
