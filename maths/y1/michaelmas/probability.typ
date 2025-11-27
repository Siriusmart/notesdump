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

#hr

== Combinatorics

=== Permutations and Combinations

- The number of permutations for choosing $r$ elements from $n$ elements is
  $
  ""^n P_r = n!/(n - r)!
  $
- The number of combinations (order doesn't matter) is therefore
  $
  ""^n C_r = n!/(r!(n - r)!)
  $

$""^n C_r$ is called the *binomial coefficients*.
$
(p + q)^n = sum^n_(r=0) ""^n C_r q^r p^(n-r)
$

From *Pascal's triangle* we have $""^n C_r = ""^(n - 1) C_r + ""^(n - 1) C_(r - 1)$, which we can also prove
$
(n-1)! / (r! (n - 1 - r)!) + (n-1)! / ((r-  1)!(n-r)!) &= ((n-r)(n-1)!+r(n-1)!)/(r!(n-r)!) \
&= n! / (r!(n-r)!)
$

=== Arrangements

Suppose there are $r$ identical objects $R$, $t$ of $T$, $s$ of $S$, then the number of distinguishable arrangment is
$
n!/(r! s! t!)
$
Where $n = r + s + t$, and $r!$ is the number of (non-distinguishable) arrangments for $R$, etc.

=== Balls in Boxes

How to put $p$ balls into $q$ boxes.

We can write the situation out in $square square | square | | square | cdots$, there are $p$ balls and $q - 1$ walls.
- Number of permutations of all objects is $(p+q-1)!$
- Number of distinguishable arrangment is
$
(p + q - 1)!/(p!(q-1)!)
$

== Discrete Probability Distributions

#defstable(
  [Random variable], [A variable whose value is determined by the outcome of an experiment.],
  [Discrete variable], [The variable only takes discrete values.],
  [Probability function], [$f(x)$ is the probability that $X$ takes the value $x$.]
)

If there are only $n$ values that $f(x)$ can take, is true that
$
sum_(i=0)^(n-1) f(x_i) = 1
$

The *cumulative probability function* is
$
F(x) = P(X <= x) = sum_(x_i <= x) f(x_i) \
P(a < x <= b) = F(b) - F(a)
$

=== Mean and Variance

#def([
  *Mean* is also called the expected value, denoted $E(X)$ or $"<"X">"$
  $
  E(X) = sum^(n-1)_(i=0) x_i f(x_i)
  $
])

==== Properties of Mean

$
E(a X) &= a E(X) \
E(X+Y) &= E(X) + E(Y) "where" X "and" Y "are independent" \
E(g(X)) &= sum^(n-1)_(i=0) g(x_i) f(x_i)
$

#def([
  *Variance* measures how the results spread around the mean.

  $
  sigma^2 = E((X - E(x))^2) = overline((X - overline(X))^2)
  $

  The *standard deviation* $sigma = sqrt(sigma^2)$
])

An alternative way to calculate the variance is
$
sigma^2 &= E((X - mu)^2) \
&= E(X^2 - 2 X mu + mu^2) \
&= E(X^2) - 2 mu E(X) + mu^2 \
&= E(X^2) - mu^2
$

== The Binomial Distribution

#note([
  The handout use a different way of calculating expected value and variance.
])

Expecation of value of $X$
$
E(X) &= sum^m_(k=0) k vec(m,k) p^k (1-p)^(m - k) \
&= sum^m_(k=0) q times vec(m, k) (d/(d q) q^k)(1-p)^(m-k) "where" p = q \
&= q times d / (d q) sum^m_(k=0) vec(m, k) q^k (1-p)^(m-k) \
&= q times d/(d q) (q + 1 - p)^m "by binomial theorem" \
&= m q (q + 1 - p)^m \
&= m p \
$

Variance of $X$

$
E(X^2) &= sum_(k = 0)^m k^2 vec(m, k) q^k (1 - p)^(n-k) \
&= sum_(k = 0)^m (k(k-1) + k) vec(m, k) q^k (1 - p)^(n-k) \
&= m p + sum_(k = 0)^m k(k-1) vec(m, k) q^k (1 - p)^(n-k) "by previous result"\ 
&= m p + sum_(k = 0)^m k(k-1) vec(m, k) q^k (1 - p)^(n-k) \
&= m p + q^2 times d^2/(d q^2) sum_(k = 0)^m vec(m, k) q^k (1 - p)^(n-k) \
&= m p + q^2 times d^2/(d q^2) (q + 1 - p)^m \
&= m p + p^2 times m(m-1) \
E(X^2) - E(X)^2 &= m p(1 - p)
$
