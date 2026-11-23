# Principal upper count at the selected ceiling

At T = 100,000,000, a native interval computation returned the unique integer 248,008,025 from the principal Riemann–von Mangoldt argument formula. top.py uses ζ and logΓ evaluations from Python-FLINT 0.9.0. It never calls the ζ zero-count primitive. This agrees with the native zeta_nzeros value in the separate principal-ceiling-count benchmark.

| T | Whole panels proposed | Nonvanishing panels accepted | Shared endpoint evaluations | Max bisection depth | Native upper-count CPU s |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 100 | 7 | 4 | 5 | 3 | .015625 |
| 1,000 | 43 | 22 | 23 | 7 | below CPU timer resolution |
| 100,000,000 | 7,049 | 3,525 | 3,526 | 15 | 26.125 |

At the ceiling, 3,524 coarse panels failed the certificate criterion and were split. Each accepted whole horizontal ζ image lies strictly in one of four open half-planes. Each contribution to the continuous argument is consequently the principal argument of the endpoint ratio: a continuous branch of argument on a half-plane has range of width π. The path starts at σ=2 and terminates at σ=1/2, at fixed T. On the preceding vertical segment σ=2, absolute convergence bounds |ζ(2+it)−1| ≤ 1/4+∫₂^∞ u⁻²du = 3/4. Hence the initial principal argument agrees with the normalized lift from ζ(2)>0.

The formula used is N₊(T)=1+(θ(T)+arg ζ(1/2+iT))/π, with θ(T)=Im logΓ(1/4+iT/2)−(T/2)log π and the continuous logΓ on the right half-plane real on the positive axis. Its integer constant is specific to principal ζ. With no boundary zero, the ordinary argument formula supplies the closed positive count. The 96-bit enclosure gave 248,008,025 ± 2.95×10⁻²⁰ in 26.33 wall seconds.

branch_check.py followed every accepted dyadic panel at 128 bits, verified exact seam equality across the entire interval, and independently computed the argument lift from crossings of the negative real branch cut. This recheck used one final endpoint argument and the net crossing number rather than thousands of ratio arguments. It found net crossing zero and the same integer within 4.26×10⁻³⁰ in 19.45 CPU seconds. The two numerical methods share FLINT and the analytic count formula.

## Stock HOL4 bridge

The principal carrier units m top contains triples (β,γ,i) with 0<β<1, 0<γ≤top and 0≤i<m β γ. line_from_principal_upper proves that if finitely many true multiplicity units are present, real-part reflection preserves their orders, w is a subset of units on β=1/2, and the carrier size is ≤U<|w|+2, then every positive zero through the closed height is on the line. Any off-line zero supplies two distinct units outside w by reflection. A single spare unit on the line is allowed, including extra multiplicity at an already witnessed point.

weighted_upper handles a second possible principal strategy. A finite list xs enumerates multiplicity units with ordinates g x through top. An optional auxiliary right endpoint e x=SOME r credits top−r when main<g x≤r≤top. The step-area mass is top−main for g x≤main and top−g x above main. Given total mass ≤A, the theorem bounds the closed lower-height multiplicity count by (A−total credit)/(top−main). All assumptions are displayed in the source. Using this with ζ still needs a complete enumeration property and injection from disjoint bracket witnesses into eligible units; a unit may receive at most one credit. Positivity of window width and the endpoint convention are included.

## Remaining dependencies

The finite HOL bridges use an abstract multiplicity function. A full instantiation must identify it with analytic zero order, prove finite support and symmetric orders from the ζ functional equation, and certify the Hardy-line witnesses with disjointness and seam handling. For the horizontal strategy, HOL also needs certified full-interval ζ and logΓ evaluation, continuous argument lifting, and the meromorphic argument-principle formula with the pole and Γ normalization. For the weighted strategy, it needs the identity between integrated N₊ and finite step-area mass and an actual principal integrated upper allowance A. These are alternative strategies. The separate eta theorem still needs the analytic-continuation identity and conjugation for the real axis and negative ordinates. The native upper receipt does not provide the missing global lower witnesses.

Raw panel certificates, points and increments are in top-panels.tsv. The native summaries are in top-counts.json and branch-check.json. The real count uses positive ordinates; there is no doubling of N₊ inside either formula.
