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

== T19

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

== T36: Fermat's little theorem

Goal: $fa i in nat and p "prime" : cong(i^p, i, p)$

Special case of (C35), $m=0$
