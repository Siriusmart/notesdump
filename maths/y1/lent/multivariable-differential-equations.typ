#import "@local/lecture:0.1.0" : *

= Multivariable Differential Equations

== Partial Derivatives

For $f = f(x, y)$
$
(partial f)/(partial x) &= lim_(h to 0) (f(x+h, y) - f(x,y))/h \
(partial f)/(partial y) &= lim_(h to 0) (f(x, y+h) - f(x, y))/h
$

Are the gradients of $f$ if we travel along the $x$ or $y$ direction.

For functions of more variables, you can calculate $partial f slash partial x$ by treating all other variables as constants.

=== Higher Derivatives

There are four 2nd order partial derivatives for a function $f(x, y)$

$
(partial^2 f)/(partial x)^2 &= partial/(partial x) ((partial f)/(partial x)) \
(partial^2 f)/(partial x partial y) &= partial/(partial x) ((partial f)/(partial y)) \
(partial^2 f)/(partial y partial x) &= partial/(partial y) ((partial f)/(partial x)) \
(partial^2 f)/(partial y)^2 &= partial / (partial y) ((partial f)/(partial y))
$

For any well defined function
$
(partial^2 f)/(partial x partial y) &= (partial^2 f)/ (partial y partial x)
$

For $f(x_1, x_2, x_3, dots, x_n)$, the gradient of $f$ is a vector.
$
gradient f = ((partial f)/(partial x_1), (partial f)/(partial x_2), (partial f)/(partial x_3), dots , (partial f)/(partial x_n))
$

#hr
