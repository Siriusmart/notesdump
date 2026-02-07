#import "@local/lecture:0.1.0" : *

= Machine Learning and Real World Data

== Sentiment Classification

Is a standard task in NLP.

#defs([
  - A *type* is a unique word.
  - A *token* is an instance of a type.
  - A *tokeniser* split text into tokens.
])

#hr

=== Naive Bayes Classification

*Machine learning* is a program that adapts its behaviour after being exposed to new data: without explicit programming, and implicitly from the data alone.

#defs([
  - *Features* are observable properties of the data.
  - *Classes* are labels associated with the data (e.g. positive/negative)
  - *Classification* is a function that maps features to classes.
])

The classifier is given a set of features $O$ and classes $c_1, dots, c_n in C$, and gives $P(c_i|O)$ for each $c_i$.
- $O = {w_1, w_2, dots, w_n}$ are the words in the review.
- $C = {"pos", "neg"}$

Choose the $P(c_i|O)$ with the highest probability
$
c_(N B) &= argmax_(c in C) P(c|O) \
&= argmax_(c in C) (P(O|c) P(c))/(P(O)) \
&= argmax_(c in C) P(O|c)P(c)
$
As $P(O)$ is a constant and does not affect $"argmax"$.

$
P(O|c) &= P(w_1|c) times P(w_2|C) times cdots times P(w_n|c) \
c_(N B) &= argmax_(c in C) P(c) product^n_(i = 1) P(w_i|c) \
&= argmax_(c in C) (log P(c) + sum_(i=1)^n P(w_i|c))
$
Summing results in less floating point precision errors than multiplying. 

In training, collect information needed to calculate $P(c)$ and $P(w_i|c)$

$
P(c) &= N_c/N_"total" \
P(w_i|c) &= "count"(w_i "in" c) / (sum_(w in V) "count"(w "in" c))
$

*Laplace smoothing* prevents $P(w_i|c)$ from being zero by adding 1 to the count of each type.
$
P(w_i|c) &= ("count"(w_i "in" c) + 1) / (sum_(w in V) ("count"(w "in" c) + 1)) \
&= ("count"(w_i "in" c) + 1) / (sum_(w in V) "count"(w "in" c) + |V|)
$

#hr

#tab2(
  [Name], [Description],
  [Zipf's law], [
    $
    f_w approx k / (r_w + beta)^alpha
    $
    - $f_w$ is the frequency of the word
    - $r_w$ is the frequency rank of the word
    - $k$, $alpha$ and $beta$ are language dependent constants
    Note: $beta$ is the rank shift.
  ],
  [Heap's law], [
    $
    u_n = k n^beta
    $
    - $u_n$ is the number of types (vocabulary size)
    - $n$ is the number of tokens
    - $beta$ and $k$ are language dependent constants
  ]
)

In Naive Bayes Classification, only seen types receive a probability estimate. Adding 1 redistributes some probability mass mass to unseen types.

#hr

=== Significance Testing

- The *null hypothesis*: the two result sets comes from the same distribution.
- Rejecting the null hypothesis means the observed results is unlikely to have happened by chance.

Choose a *significance level* $alpha$, reject the null hypothesis if the probability of observing the event under the null hypothesis is less than $alpha$.

In a *binomial distribution* $B(N, q)$
$
P(X = k) &= vec(N, k)q^k (1-q)^(N-k) \
P(X <= k) &= sum^k_(i=0) vec(N, i) q^i (1-q)^(N-i)
$

A *two-tailed test* tests if the two systems performs equally well: the $alpha$ in each tail is halved.

#tab3(
  [], [Actual = same], [Actual = different],
  [*Predicted = same*], [Correct], [
    Type II error:
    - Use a more powerful test (e.g. permutation test rather than sign test)
    - Use more data
  ],
  [*Predicted = different*], [
    Type I error
  ], [Correct]
)

Significance testing cannot show two distributions are the same.

#note([
  For testing sentiment classifiers, ignoring ties will lead to the null hypothesis being incorrectly rejected. Add $0.5$ to the count of positive and negative results in case of ties.
])

#hr

=== Overtraining

Overtraining is where more training makes the classifier perform worse on unseen data.

Am I overtraining?
- If you are using large amounts of new test data, not overtraining.
- If incrementally improving the classifier on the same small test data, overtraining.

Overtraining is caused by finding characteristic features of each class that are hard to generalise.

*N-fold cross-validation*
1. Split data into $N$ equal folds.
2. For each fold $X$, train on other folds, test on fold $X$ only.
3. Average all the accuracy for the final accuracy.

It is good if each splits performs equally well, calculate the variance:
$
"var" = 1/n sum_i^n (x_i - mu)^2
$

Consider the $N$ experiments as one overall experiment.

#tab2(
  [Cross validation], [Description],
  [Stratified cross-validation], [
    Each split mirrors the distribution of classes in the overall data.
  ],
  [Jack-knitting], [Each individual data point is a split.],
  [Dependency-sensitive cross-validation], [Fold in a way that known characteristics of a data are isolated (e.g. one split per genre)]
)

Cross-validation does not solve the problem of overtraining.

Instead, a *validation corpus* (a separate set of data not used for training or testing) can be used to
- Tweak parameters before training
- Check if training is making the system perform worse on the validation corpus (is it overtraining?)

#hr
