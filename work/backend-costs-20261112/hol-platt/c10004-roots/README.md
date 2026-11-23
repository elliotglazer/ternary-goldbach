# Roots for the conductor-10004 transform

`make_roots.py --verify` checks every complex integer in `table.json`. At length $n$, row $k$ is the nearest grid point to the real and imaginary parts of the positive-exponent root $e^{2πik/n}$ at scale $2^{81}$. The tensor requires 185 pairs across nine lengths dividing 120.

For each of the 29 descending positive centers $c$, the verifier constructs the interval with endpoints $(2c-1)/2^{82}$ and $(2c+1)/2^{82}$. It checks that all intervals lie strictly inside $(0,1)$, are disjoint, and that $U_{59}$ changes sign across each interval. Generation uses the three-term recurrence for $U_n$. The verifier evaluates the explicit integer binomial expansion independently at both endpoints.

The 59 distinct numbers $\cos(jπ/60)$, with $1≤j≤59$, are roots by the sine identity for $U_{59}$. They exhaust its degree. Exactly 29 are positive. Continuity and strict ordering therefore identify the root in each bin, in decreasing cosine order. Quarter-wave reflection recovers the full 120-vector, and a quarter-period shift gives sine. Thus each coordinate differs from its claimed value by at most half a grid unit, and the complex error is below one grid unit. [Chebyshev sine identity](https://dlmf.nist.gov/18.5.E2)

The finite HOL4 checks, including rejection of reversed and perturbed inputs, are in [c10004-root-check](../c10004-root-check/). The HOL4 sine identity and the cosine-root theorem are in [c10004-root-analytic](../c10004-root-analytic/). Those theorem files track progress on connecting the integer checks to the trigonometric statement.
