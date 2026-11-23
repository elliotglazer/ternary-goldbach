# One sufficient prime envelope for the remaining four prime producers

Coordinator research derivation, 2026-11-11. Source pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build or source edit. The envelope below is UNPROVED. This note proves its numerical/analytic sufficiency for P1/P4/P5/P7 using the reviewed P6 repair and existing finite sieve. It is not a new permitted premise of Goldbach.

The integration worker's Mobius calculation proposes the same integer envelope:

    E: for every integer v>=10^9,
       |psiN(v)-v| <= .01*v/log(v).

If proved, E would supply the remaining four prime contracts as follows. P2, P3 and P6 have separate complete reviewed elementary paper replacements. The implication from E to the relaxed Mobius profile is a separate calculation requiring its own review.

## Real cutoffs and a uniform coarse bound

Write psi(t)=sum_{1<=n<=floor(t)} Lambda(n), A=10^6 and epsilon=.002. The existing sieve gives, for A<=t<10^9,

    t-2sqrt(t) <= theta(t) <= t+.1sqrt(t).

The full P6 paper replacement gives `0<=psi(t)-theta(t)<1.4262sqrt(t)`. Hence on this finite interval

    (1-epsilon)t <= psi(t) <= (1+epsilon)t.

At real t>=10^9, let N=floor(t). Then N>=10^9 and psi(t)=psiN(N). Since u/log(u) increases for u>e, E gives

    psi(t)-t <= .01*t/log(t),
    t-psi(t) < 1+.01*t/log(t).

The extra 1 cannot be silently discarded. Since log(10^9)<21, monotonicity gives `.001*t/log(t)>1`, so the safe real envelope is

    |psi(t)-t| <= .011*t/log(t), t>=10^9.                    (ER)

Also log(t)>20, and .011/20<.002. The same coarse bound therefore holds for every real t>=A, including the junction at10^9:

    (1-.002)t <= psi(t) <= (1+.002)t.                       (C)

All logarithm comparisons can be obtained from the source elementary exponential bounds and exact rational powers. No prime estimate below10^9 is inferred from E.

## P1 and P4

For t>=A, (C) gives psi(t)<=1.002t, strictly below both 1.03883t and1.0064t. Below A, the already reviewed finite helper from SmallPsi700 and SmallTab supplies P1's original coefficient. This yields the entire P1 domain t>0.

P4 begins at2.5e7>A, so (C) immediately yields its unchanged conclusion psi(t)<=1.0064t on the entire required domain.

## P5: weighted von Mangoldt sum

For y>=2.5e7, the exact Abel identity is

    sum_{n<=y} n Lambda(n) = y psi(y)-integral_0^y psi(t)dt.

Use nonnegativity below A and the lower estimate in(C) above it. Then

    sum n Lambda(n)
      <=(1+epsilon)y^2-(1-epsilon)(y^2-A^2)/2
      =[(1+3epsilon)+(1-epsilon)(A/y)^2]*y^2/2.

The bracket is at most `1+.006+.998/625=1.0075968<1.022`. Thus the original strict P5 coefficient is preserved for every real y>=2.5e7. The real Abel identity includes an integer upper endpoint, as in the earlier reviewed finite P5 derivation.

## P7: dyadic prime logarithm-square moment

Combine the finite theta sieve, (ER), and P6 to obtain deliberately coarse bounds valid for every real t>=A:

    theta(t) <= t+.011*t/log(t)+.1sqrt(t),
    theta(t) >= t-.011*t/log(t)-2sqrt(t).                    (T)

On the finite part, the new logarithmic terms only weaken the original sieve. On the large part, theta<=psi and psi-theta<1.4262sqrt(t) give(T). Thus no interval straddling10^9 needs a special assertion.

For y>=2e6, the entire interval[y/2,y] lies in(T). Exact Stieltjes summation gives

    sum_{y/2<p<=y} log(p)^2
      =log(y)theta(y)-log(y/2)theta(y/2)
       -integral_(y/2)^y theta(t)/t dt.

Insert the upper bound only at y and the lower bounds at y/2 and in the integral. The main term is

    y log(y)/2 + (log2-1)y/2.

The new logarithmic-error contribution is at most

    .011y+.0055y+.011*(y/2)/log(y/2) <= .01705y,

because log(y/2)>=log(10^6)>10. The square-root error is at most

    .1sqrt(y)log(y)+2sqrt(y/2)log(y/2)
      +4(sqrt(y)-sqrt(y/2))
    <=1.6sqrt(y)log(y)+4sqrt(y).

The ratio log(y)/sqrt(y) decreases for y>=2e6. Using sqrt(2e6)>1400 and the existing elementary bound log(2e6)<=14.51, this last error divided by y is at most

    (1.6*14.51+4)/1400 < .02.

All positive errors together are below .03705y, whereas `(log2-1)y/2<-.15y`. Therefore the source P7 bound by `y log(y)/2` holds with slack, for every y>=2e6. Its prime interval is the exact open-lower/closed-upper interval `floor(y/2)<p<=floor(y)`.

## Scope and next step

This is a single uniform reduction for P1/P4/P5/P7, preserving their original constants and domains. It handles real floors explicitly and uses no new finite prime enumeration. Its formal ingredients are the source finite sieve, the reviewed P6 replacement, finite Abel/Stieltjes identities and elementary inequalities.

It does not prove E. In particular, global QRH or a finite zero-free strip does not supply E merely by being available. The low-zero sum, high-zero tail, smoothing/desmoothing losses and the finite-to-asymptotic junction all need a separate quantitative derivation. Independent review of this reduction is requested before treating it as an accepted blueprint edge.
