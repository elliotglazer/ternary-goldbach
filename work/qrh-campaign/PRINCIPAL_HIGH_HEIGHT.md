# High-height quartet bound for the principal L2 route

Status: paper derivation with exact rational arithmetic checked by
`principal_high_height.py`. The signed-contour estimate in `agents/mellin/TwistBounds.md`
is a prerequisite paper result, not a compiled Lean theorem. This note does not
establish the compact-height estimate or the full principal approximation.

Let beta be in [1/2,7/8], gamma >=250, x>=10000, and |delta|<=4. All four zeros in
the conjugation/reflection quartet have real part in [1/8,7/8]. Write E(gamma)
for a common upper bound on their actual etaPlus Mellin transforms. The quartet
sum after extracting x^(7/8) has L2([-4,4]) norm at most

    2 sqrt(8) [x^(beta-7/8)+x^(1/8-beta)] E(gamma).

The bracket is at most 1+x^(-3/4)<=1.001. One proof sets
a=x^(beta-7/8), c=x^(-3/4), observes sqrt(c)<=a<=1, and uses
(1-a)(a-c)>=0 to obtain a+c/a<=1+c.

The quartet's positive mass at s=2 is

    w=2[(2-beta)/((2-beta)^2+gamma^2)
        +(1+beta)/((1+beta)^2+gamma^2)]
      >=6/(gamma^2+225/64).

At beta=1/2 this expression double-counts the two distinct roots; both numerator
and mass must then be divided by two, leaving the same ratio.

Use theta=17/100 in the contour formula. The elementary bounds cos(2theta)>=.94,
sin(theta)<=theta and pi<=22/7 give b<=8*(22/7)*theta and b^2/(2c)<10.
Since exp(10)<22027 and sqrt(2pi/c)<2.59, the whole-Gaussian option gives

    U <=22027*2.59,
    R <=1/.94 + [8*(22/7)*theta/.94]*(22027*2.59).

The global Fourier L1 bound W<=3.01 therefore gives WR<800000.
These use the actual etaPlus contour representation; no compact-smoothing
approximation error is introduced in this height range.

For 250<=gamma<=400 choose B=gamma/2. The contour formula implies

    E(gamma)<=4 sqrt(184)/gamma^2 +800000 exp(-.085 gamma).

Multiplication by gamma^2+225/64 preserves monotonic decrease of both terms on
this interval. For the exponential term this follows from
2gamma<.085(gamma^2+225/64). Using exp(21.25)>1690000000, sqrt(184)<13.565,
sqrt(8)/3<.943 gives the rational upper bound

    ||quartet||_2 / w
       <=.943*1.001*(250^2+225/64)
           *(4*13.565/250^2+800000/1690000000)
       <79.151<80.

For gamma>=400 choose B=200. The Fourier tail is empty, hence

    E(gamma)<=800000 exp(-.17(gamma-200)).

The weighted expression decreases for gamma>=400. Even the loose estimate
exp(34)>exp(21.25)>1690000000 gives

    ||quartet||_2 / w
       <=.943*1.001*(400^2+225/64)*800000/1690000000
       <71.496<80.

The script verifies the rational inequalities and the exponential Taylor
certificates. Analytic identities, L2 inequalities, monotonicity, and the
contour prerequisites still require Lean proofs. This leaves the proposed
uniform bound85 to be certified on the compact height interval [2.39,250].
