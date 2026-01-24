#import "@local/lecture:0.1.0" : *

== P8: product of odd integers

Goal: $fa m,n in whole : (m,n "odd" imp m dot n "odd")$

Assume:
1. $m,n in whole$
2. $m, n$ odd

$
m &= 2a + 1 \
n &= 2b + 1 \
m dot n &= 2(2a b + a + b) + 1
$

== P10: rational square root

Goal: $fa x in real^+ : sqrt(x) "rational" imp x "rational"$

Assume:
1. $x in real^+$
2. $sqrt(x) "rational"$

$
sqrt(x) &= p/q \
x &= p^2 / q^2
$

== T11: transitivity of implication

Goal: $fa P_1, P_2, P_3 : ((P_1 imp P_2) and (P_2 imp P_3) imp (P_1 imp P_3))$

Assume:
1. $P_1 imp P_2$
2. $P_2 imp P_3$
3. $P_1$

$
&imp P_2 "by (1)" \
&imp P_3 "by (2)"
$

== P18: linearaity of congruence

Goal: $fa m,n in whole^+ and a,b in whole : cong(a, b, m) iff cong(n dot a, n dot b, n dot m)$

Assume:
1. $m,n in whole^+$
2. $a,b in whole$

$
cong(a, b, m) &iff a - b = k dot m \
&iff n dot a - n dot b = k dot n dot m \
&iff cong(n dot a, n dot b, n dot m)
$

== T19: 6 divisible

Goal: $fa n in whole : (6|n iff 2|n and 3|n)$

Assume:
1. $n in whole$

#grid2(
  surround(
    $
    6|n &imp n = 6k \
    &imp n = 3 dot (2k) and n = 2 dot (3k) \
    &imp 3|n and 2|n
    $
  ),
  surround(
    $
    n &= 2a \
    n &= 3b \
    3n &= 6a \
    2n &= 6b \
    n &= 6(a - b) \
    &imp 6|n
    $
  )
)

== P21

Goal: $fa k in whole^+ : ex i,j in whole and 4k = i^2 - j^2$

Assume:
1. $k in whole+$

Let $i = k + 1$ and $j = k - 1$, then $i^2 - j^2 = 4k$

== T23: transitivity of divisiblity

Goal: $fa l,m,n in whole : (l|m and m|n imp l|n)$

Assume:
1. $l,m,k in whole$
2. $l|m and m|n$

$
m &= a dot l \
n &= b dot m \
n &= (a dot b) dot l \
&imp 1|n
$

== T24: uniqueness of congruence

Goal: $fa m in whole^+ and n in whole : ex !z and 0<=z<m and cong(z, n, m)$

Assume:
1. $m in whole^+ and n in whole$

#grid2(
  surround([
    #missing([
      Goal: $ex z and 0 <= z <m and cong(z, n, m)$
    ])
  ]),
  surround([
    Assume:
    1. $0<=z<m and cong(z,n,m)$
    2. $0<=z'<m and cong(z',n,m)$

    $
    &cong(z,z',m) \
    imp &z-z' = k dot m\
    &-m<z-z'<m \
    imp &k = 0 \
    imp &z=z'
    $
  ])
)

== P25: square modulo 4

Goal: $fa n in whole : cong(n^2, 0, 4) or cong(n^2, 1, 4)$

#grid2(
  surround([
    Case $n = 2k$

    $
    n^2 equiv 4k^2 equiv 0 space(mod 4)
    $
  ]),
  surround([
    Case $n = 2k + 1$

    $
    n^2 equiv 4k^2 + 4k + 1 equiv 1 space (mod 4)
    $
  ])
)

== L27: ends of combinations

Goal: $fa p in whole^+ and m in nat : (m=0 or m=p imp cong(vec(p,m),1,p))$

Assume:
1. $p in whole^+ and m in nat$

#grid2(
  surround([
    Case: $m=0$

    $
    vec(p,0) equiv 1 space (mod p)
    $
  ]),
  surround([
    Case: $m=p$
    $
    vec(p,0) equiv 1 space (mod p)
    $
  ])
)

== L28: non-ends of combinations

Goal: $fa p "prime" and m in whole : (0 < m < p imp cong(vec(p, m), 0, p))$

Assume:
1. $p "prime" and m in whole$
2. $0 < m < p$

$
vec(p, m) &equiv p!/((p-m)!m!) \
&equiv p dot (p-1)!/((p-m)!m!) \
&equiv 0 space(mod p)
$

As $p$ is only cancelled if a prime factor of $p$ is in $(p-m)!m!$, the only prime factors of $p$ are $1$ and $p$, all prime factors of $(p-m)!m!$ are less than $p$.

== P29: ends and non-ends of combinations

Goal: $fa p "prime" and m in whole and 0 <= m <= p : cong(vec(p, m), 0, p) or cong(vec(p, m), 1, p)$

Assume:
1. $p "prime" and m in whole$
2. $0 <= m <= p$

#grid2(
  surround([
    Case: $m=0 or m=p$

    $
    cong(vec(p, m), 1, p)
    $
  ]),
  surround([
    Case $0 < m < p$

    $
    cong(vec(p, m), 0, p)
    $
  ])
)

== C33: the freshman's dream

Goal: $fa m,n in nat and p "prime" : cong((m+n)^p, m^p+n^p, p)$

Assume:
1. $m,n in nat and p "prime"$

$
(m+n)^p &equiv sum_(k=1)^p vec(p, k) m^(p-k)n^k \
&equiv m^p + n^p space(mod p)
$

== C34: the dropout lemma

Goal: $fa m in nat and p "prime" : cong((m+1)^p, m^p + 1, p)$

Special case of (C33), $n=1$

== C35: the many dropout lemma

Goal: $fa m, i in nat and p "prime" : cong((m+i)^p, m^p+1, p)$

Assume:
1. $m,i in nat$
2. $p "prime"$

$
(m+i)^p &equiv (m+i-1)^p + 1 \
&equiv (m+i-2)^p + 1 + 1 \
&vdots \
&equiv m^p + i space (mod p)
$

== T36: Fermat's little theorem (clause 1)

Goal 1: $fa i in nat and p "prime" : cong(i^p, i, p)$

Special case of (C35), $m=0$

== T36: Fermat's little theorem (clause 2)

Goal 2: $fa i in nat and p "prime" and p divides.not i : i^(p-1) equiv 1 space (mod p)$

Assume:
1. $i in n and p "prime" and p divides.not i$

$
cong(i^p, i, p) &imp ex k in whole and i^p - i = k p \
&imp i^(p-1) - 1 = (k slash i) p quad "as" p divides.not i \
&imp cong(i^(p-1), 1, p)
$

== C40: the contrapositive

Goal: $(P imp Q) iff (not Q imp not P)$

#grid2(
  surround([
    Assume:
    1. $P imp Q$
    2. $not Q$

    Suppose $P$, then $Q$. By contradiction: $not P$
  ]),
  surround([
    Assume:
    1. $not Q imp not P$
    2. $P$

    Suppose $not Q$, then $not P$. By contradiction: $Q$
  ])
)

== C41: irrational square root

Goal: $fa x in.not rat : sqrt(x) in.not rat$

Assume:
1. $x in.not rat$

Suppose $sqrt(x) in rat$, then $x in rat$. By contradiction: $sqrt(x) in.not rat$

== C42: rational lowest terms

Goal: $x in rat iff ex m,n in whole^+ and x = m slash n and not (ex p "prime" and p|m and p|n)$

Assume:
1. $x in rat$

Suppose $fa m,n in whole^+ and x = m slash n : ex p "prime" and p|m and p|n$

$
&x = m/n quad "by (1)" \
imp& ex p_1 "prime" and p|m and p|n \
imp& m = p_1 m' and n = p_1 n' \
imp& m = p_1 p_2 m'' and n = p_1 p_2 n'' quad "by running the same argument on" x' = m' slash n' \
vdots
$

Then $m$ and $n$ are products of infinitely many primes. All positive integers are product of finitely many primes. So by contradiction: $ex m,n in whole^+ and x = m slash n and not(ex p "prime" and p|m and p|n)$

== P47: equality of inverses

Goal: For a monoid $(e, dot)$, an element $x$ admits an inverse if its left and right inverses are equal.

$
r &= (l dot x) dot r \
&=l dot (x dot r) \
&=l
$

== T53: division theorem

Goal: $fa m in nat, n in whole^+: (ex !q,!r in whole and q >=0 and 0<=r<n and m = q dot n + r)$

Assume:
1. $m in nat and n in whole^+$

$
& imp ex!n in whole and 0 <= r < n and cong(m,r,n) quad "by (T24: uniqueness of congruence)" \
& imp ex!q in whole and m = q dot n + r
$

== T56: correctness of ```ml divalg```

```ml
let rec divalg m n =
  let diviter q r =
    if r < n then (q, r)
    else diviter (q + 1) (r - n)
  in diviter 0 n
```

#surround([
  Goal: ```ml diviter``` terminates

  `r` decreases in the natural numbers, this cannot continue forever.
])

#surround([
  Goal: ```ml diviter``` outputs $(q_0, r_0)$ satisfying $r_0 < n and m = q_0 dot m + r_0$

  All calls to ```ml diviter``` satisfies $m = q dot m + r$

  1. ```ml diviter 0 n```
  2. ```ml diviter 1 (n - m)```
  3. ```ml diviter 2 (n - 2 * m)```
  4. $vdots$
  5. ```ml diviter q_0 r_0```

  The last call satisfies $r_0 < n$
])

== P57: uniqueness of ```ml rem```

```ml
let rem m n = let (_, r) = divalg m n in r
```

Goal: $fa m in whole^+ and k,l in nat : (cong(k, l, m) iff rem(l,m) = rem(k,m))$

Assume:
1. $m in whole^+ and k,l in nat$

#grid2(
  surround([
    2. $cong(k, l, m)$

    $
    k &= q_k dot m + r_k \
    l &= q_l dot m + r_l
    $
    $
    imp &cong(r_k, r_l, m) \
    imp &r_k - r_l = a dot m
    $
    Again by $-m < r_k - r_l < m$ we have $a=0$ so $r_k = r_l$.
  ]),
  surround([
    2. $r_k = r_l$

    Trivial.
  ])
)

== C58: existence of modular integer (clause 1)

Goal: $fa n in nat : cong(n, rem(n, m), m)$

$
&n = q dot m + rem(n, m) \
imp&n - rem(n,m) = q dot m \
imp&cong(n, rem(n, m), m)
$

== C58: existence of modular integer (clause 2)

Goal: $fa k in whole : (ex! [k]_m and 0 <= [k]_m <m and cong(k, [k]_m, m))$

Assume:
1. $k in whole$

Existence: let $[k]_m = rem(k, m)$

Uniqueness:
$
&-m < [k]_m - [k]_m ' < m \
&cong([k]_m, [k]_m ', m) \
imp&[k]_m = [k]_m '
$

== P62: the modular integers is a commutative ring

Goal: $fa m > 1:(whole_m, 0, +_m, 1, dot_m) "is a commutative ring"$

Assume:
1. $m > 1$

- $(whole_m, 0, +_m)$ is a commutative group (trivial)
- $(whole_m, 0, dot_m)$ is a commutative monoid (trivial)
- $dot_m$ distributes over $+_m$ (trivial)

== P63: existence of reciprocal

Goal: $fa k in whole_m : (k "has reciprocal" iff ex i, j in whole and k dot i + m dot j = 1)$

Assume:
1. $k in whole_m$

$
ex a in whole_m and a dot_m k = 1 &iff (a dot k) mod m = 1 \
&iff ex j in whole and a dot k = m dot j + 1 \
&iff a dot k - m dot j = 1
$

== L71: key lemma

Goal: $fa m,m' in nat and n in whole^+ and cong(m, m', n): CD(m, n) = CD(m', n)$

Assume:
1. $m, m' in nat and n in whole^+$
2. $cong(m, m', n)$

$
m' = m+q dot n 
$
$
d|m and d|n imp &d|(m+q dot n) \
imp &d|m' and d|n
$

Same for reverse.

== L73: Euclid's algorithm for all divisors

Goal: For all positive $m$ and $n$:
$
CD(m,n) = cases("D"(n) &"if" n|m, CD(n, rem(m, n)) quad &"otherwise")
$

#grid2(
  surround([
    Case $n|m$

    $
    d|n iff d|m and d|n
    $
  ]),
  surround([
    Otherwise

    Special case of (L71: key lemma)
  ])
)

== P75: uniqueness of gcd

Goal: $fa m,n,a,b in nat : (CD(m, n) = "D"(a) and CD(m,n) = "D"(b) imp a = b)$

Assume:
1. $m,n,a,b in nat$
2. $CD(m, n) = "D"(a) and CD(m,n) = "D"(b)$

$
"D"(a) = "D"(b) &imp a|b and b|a \
&imp a = b
$

== P76: definition of gcd

Goal: the two statements are equivalent
- $CD(m,n) = "D"(k)$
- $k|m and k|n and (fa d in nat: d|m and d|n imp d|k)$

#grid2(
  surround([
    Assume:
    1. $CD(m,n) = "D"(k)$

    $
    k in CD(m,n) &imp k|m and k|n \
    d|m and d|n &imp d in "D"(k) imp d|k
    $
  ]),
  surround([
    Assume:
    1. $k|m and k|n and (fa d in nat : d|m and d|n imp d|k)$

    $
    d in CD(m,n) &imp d in "D"(k) \
    d|k &imp d|m and d|n quad "by transitivity" \
    &imp d in CD(m,n)
    $
  ])
)

== T78: Euclid's algorithm gives the gcd

Goal: $fa m, n in whole^+: "gcd terminates, and"$
- $gcd(m,n)|m and gcd(m,n)|n$
- $fa d in whole : d|m and d|n imp d|gcd(m,n)$

Assume:
1. $m,n in whole^+$

#surround([
  $r$ decreases in natural numbers, this cannot continue forever, so gcd must terminate.
])

#surround([
  Euclid's algorithm selects the greatest element of $CD(m,n)$
  $
  CD(m,n) = D(gcd(m,n))
  $
  The two statements become trivial.
])

== L80: properties of gcds

*Goal: commutativity*
$
"D"(gcd(m,n)) &= CD(m,n) \
&= "D"(gcd(n,m)) \
therefore gcd(m,n) &= gcd(n,m)
$

*Goal: associativity*

Let $d_1 = gcd(l, gcd(m,n))$ and $d_2 = gcd(gcd(l, m), n)$

$
d_1|gcd(l, gcd(m, n)) &imp d_1|l and d_1|gcd(m,n) \
&imp d_1|l and d_1|m and d_1|n \
&imp d_1|gcd(l, m) and d_1|n \
&imp d_1|d_2
$

By same process, show $d_2|d_1$ so $d_1 = d_2$

*Goal: linearity*

Let $d_1 = gcd(l dot m, l dot n)$ and $d_2 = l dot gcd(m,n)$

$
d_1|gcd(l dot m, l dot n) &imp d_1|(l dot m) and d_1|(l dot n) \
&imp d_1 '|m and d_1 '|n "where" d_1 = d_1 ' dot l \
&imp d_1 '|gcd(m,n) \
&imp d_1|d_2 \
d_2|(l dot gcd(m,n)) &imp d_2 '|gcd(m,n) "where" d_2 = d_2 ' dot l \
&imp vdots quad "same steps in reverse" \
&imp d_2|d_1 \
therefore d_1&=d_2
$

== T82: divisiblity of product with coprime factor

Goal: $fa k,m,l in whole^+: k|(m dot n) and gcd(k, m) = 1 imp k|n$

Assume:
1. $k,m,l in whole^+$
2. $k|(m dot n) and gcd(k,m) = 1$
$
k|(m dot n) &imp k|gcd(k dot n, m dot n) \
&imp k|(n dot gcd(k,m))) \
&imp k|n
$

== C83: Euclid's theorem

Goal: $fa m,n in whole^+ and p "prime": (p|(m dot n) imp p|m or p|n)$

Assume:
1. $m,n in whole^+ and p "prime"$
2. $p|(m dot n)$

#grid2(
  surround([
    Case $p|m$

    Goal closed.
  ]),
  surround([
    Case $p divides.not m$

    $
    gcd(m,n) = 1 &imp p|n
    $
  ])
)

== C85: inverse of modular integers

Goal: $fa p "prime" and i in whole_p and i != 0 : [i^(p-2)]_m dot_m i = 1$

Assume:
1. $p "prime" and i in whole_p and i != 0$

$
cong(i^(p-1), 1, p) "by Fermat's little theorem" : p "prime" and p divides.not i
$
