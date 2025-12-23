#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Self Reading Notes]
    #h(1fr) _Classical Mechanics (Imperial College Press)_
  ],
)

#import "@local/lecture:0.1.0" : *

== 2. Linear Motion

#tab3(
  [ Symbol ], [ Meaning ], [ Definition ],
  $V$, [ potential ], $int_(x_0)^x F(x') dx'$,
  $F$, [ force ], $- dV / dx$,
  $T$, [ kinetic energy ], $1/2 m dot(x)^2$,
)


From $T = 1/2 m dot(x)^2$, we find:
- $dot(T) = m dot.double(x) dot(x) = F(x) dot(x)$
- $T = int F(x) dx$

Conservation of energy states $V + T = E$ which is constant.

=== The Harmonic Oscillator

#tab3(
  [ Symbol ], [ Meaning ], [ Definition ],
  $f$, [ frequency ], $omega / (2pi)$,
  $tau$, [ time period ], $(2pi) / omega$
)

The harmonic oscillator at equilibrium $x=0$ satisfies $V'(0) = 0$. Choose constant $E$ so $V(0) = 0$.
$
V(x) &= V(0) + x V'(0) + 1/2 x^2 V''(0) + dots \
&approx 1/2 k x^2 "where" k = V''(0)
$
Then $F(x) = -k x$.
- A conservative force depends only on $x$
- A dissipative force additionally depend on variables other than $x$, such as velocity.
- All forces are conservative at microscopic scale.

Undamped oscillator:
$
m dot.double(x) &= -k x \
dot.double(x) + k / m x &= 0 \
    x &= 1/2A e^(p t) + 1/2B e^(- p t)
$
where $p = sqrt(-k slash m)$

#grid2(
  [
    If $k < 0$, it is an unstable equilibrium.
    $
    $
  ],
  [
    If $k > 0$, it is a stable equilibrium.
    $
    x = 1/2A e^(i omega t) + 1/2B e^(- i omega t) "where" omega = sqrt(k/m)
    $

    For $x$ to have no imagniary component, let
    - $A = a e^(-i theta)$
    - $B = a e^(i theta)$

    Then
    $
    x &= 1/2 a e^(i(omega t - theta)) + 1/2 a e^(-i(omega t - theta)) \
    &=a cos(omega t - theta)
    $
  ]
)

Note if $a dot.double(z) + b dot(z) + c z = 0$ is a solution, where $z = x + i y$, then so is $a dot.double(x) + b dot(x) + c x = 0$ and the $y$ equivalent.

=== The Damped Oscillator

$
m dot.double(x) + lambda dot(x) + k x = 0
$
Let $gamma = lambda / (2 m)$ and $omega_0 = sqrt(k / m)$.

#grid2(width: 50%,
  [
    Large damping if $gamma > omega_0$
    - Let $gamma_pm = gamma pm sqrt(gamma^2 - (omega_0)^2)$
    $
    x = 1/2 A e^(-gamma_+ t) + 1/2 B e^(-gamma_- t)
    $

    The leading term is $1/2 B e^(-gamma_-)$, so the characteristic time is $1/gamma_-$
  ],
  [
    Small damping if $gamma < omega_0$
    - Let $omega = sqrt((omega_0)^2 - gamma^2)$
    $
    x &= 1/2 A e^(-gamma+omega_0 t) + 1/2 B e^(-gamma-omega_0 t) \
    &=a e^(-gamma t) cos(omega_0 t - theta)
    $
    where $A=a e^(-i theta t), B = a e^(i theta t)$

    - The relaxation time is $1/gamma$
    - The amplitude reduction in a single period is $e^(pi slash Q)$ where $Q = omega_0 slash 2 gamma$
  ]
)

Critical damping when $gamma = omega_0$
$
x = (a + b t)e^(-gamma t)
$

=== Resonance

Under a periodic force $F(t) = F_1 cos(omega_1 t)$, solving the differential equation gives solution the equation for an undamped, forced oscillation.
$
x &= a_1 cos(omega_1 t - theta_1) \
italic("amplitude") a_1 &= (F_1 slash m)/sqrt(((omega_0)^2 - (omega_1)^2)^2 + 4 gamma^2 (omega_1)^2) \
italic("phase") tan theta_1 &= (2 gamma omega_1)/((omega_0)^2 - (omega_1)^2)
$

- When $omega_1$ is low, $theta_1 approx 0$, and $x$ satisfies $F(t) - k x = 0$.
- At resonance $omega_1 = sqrt((omega_0)^2 - 2 gamma^2)$, $theta_1 = pi/2$, $a_1 = F_1 slash 2 m gamma omega_1$.
- When $omega_1$ is very high, $theta_1 approx pi$ (out of phase), $x approx 0$.

So the damping constant $lambda$ only matters when near resonance.

=== General Periodic Forces

Any periodic force can be written as a sum of harmonics.
$
F(t) &= sum_(n=-infty)^infty F_n e^(i n omega t) \
F_m &= 1/tau int^tau_0 F(t) e^(-i m omega t) dt \
$

The position is the sum of the general solutions for each harmonic.
$
x = sum_(n = -infty)^infty A_n e^(i n omega t) + "transient"
$

=== General Forces

Define impulse delivered in $Delta t$ be $I = Delta p = F(t) Delta t$.

An oscillator at rest when given impulse $I$ has $dot(x) = I/m$, solving for small damping:
$
x(t) = cases(
  0 quad quad quad quad quad quad quad &"when" t < 0,
  I/(m omega) e^(-gamma t)sin omega t &"when" t >= 0
)
$

For a series of impulses $I_r$ at $t_r$
$
x(t) = sum_r G(t - t_r) I_r + "transient"
$
where the Green's function $G$ is defined as
$
G(t') = cases(
  0 quad quad quad quad quad quad quad &"when" t' < 0,
  I/(m omega) e^(-gamma t')sin omega t' &"when" t' >= 0
)
$

Then for any force $F(t)$
$
x(t) = int^t_0 G(t' - t) F(t') dt' + "transient" \
$
