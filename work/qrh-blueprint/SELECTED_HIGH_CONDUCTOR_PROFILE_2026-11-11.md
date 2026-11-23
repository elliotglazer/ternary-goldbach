# Joint finite spectral profile for high conductors

2026-11-11. Research amendment proposed for adoption after independent review. This is a conditional paper implication, not a spectral certificate, a Lean declaration, or an approved proof graph. Adoption and exact evidence pins are recorded in the research ledger. No new hypothesis is permitted in either final Goldbach theorem.

## One combined profile

Keep the active primitive conductors: odd c<=150000, and c divisible by four with c<=300000, including c=1. Keep every actual primitive character, its inverse label, and its true zero multiplicities. Set

`qt(c)=2*c` for odd c, and `qt(c)=c` otherwise;

`H_old(c)=min(ceil(200+max(1000,(704/7)*(1200000/qt(c)))),100000000/c)`.

The new joint requirement is the following single pair of bounds:

| Active conductor | Upper real part b(c) | Inclusive height H(c) |
|---|---:|---:|
| c<=100000 | 111/200 = .555 | H_old(c) |
| odd c>100000 | 14/25 = .56 | 50000000/c |
| 4 divides c, c>100000 | 14/25 = .56 | 99000000/c |

For every actual nontrivial zero of every such character with `|Im rho|<=H(c)`, prove `Re rho<=b(c)`. The heights are exact rationals, not their floors or ceilings. Inverse-character reflection supplies the corresponding lower bound `1-b(c)` at the same absolute height. The genuine global [1/8,7/8] bound remains required separately.

For c>100000 the old minimum is 100000000/c, so both new heights are smaller. The upper real-part allowance is wider there. Thus the old uniform condition implies this new condition; the implication in the other direction is not required. The full family and its number of labels are unchanged. A shorter domain and wider allowed strip are not, by themselves, a measured runtime or proof-volume saving.

This amendment does not combine the standalone .565 proposal with the shorter heights. It proves a fresh joint budget at .56. The [principal-route amendment](SELECTED_PRINCIPAL_ROUTE_2026-11-11.md) is unchanged, including RH through1500, N1500=1069, Q1500<1.668, and principal height60343058. The additional narrow principal strip through one million remains unselected.

## Inputs to the joint calculation

The [height reduction](../qrh-campaign/agents/zero-sum/SHARED_HIGH_CONDUCTOR_HEIGHT_REDUCTION_2026-11-11.md) supplies new primitive plus-tail bounds t(c), with the original bounds on unchanged conductors. Its exact supported Gauss aggregates retain the same actual modulus and both character indices. Write Tq for their pointwise plus-tail energy and Sq for the original .555 low-star integrated energy envelope. The required bounds, including a conservative overcount by the old full-family totals, are

`sum_q 2Dq*Tq < .129 < 1/4`,

`sum_q Tq*Sq < 1.30e-7 < 2e-7`,

`Aplus_high < 3.511e-12 < 1e-8`.

The changed star low cutoff is `min(Hs_old(c),H(c))`, not its old value. The height argument rechecks its global tail at the new minimum330 and retains the entire scalar star error `ds=2e-12`. The scalar plus error excluding the separately aggregated high tail remains `d0=2e-15`. These analytic and exact-arithmetic assertions require the independent height review; they do not follow from the three rounded numbers alone.

The [real-part profile argument](../qrh-campaign/agents/major-constants/HIGH_CONDUCTOR_REAL_PART_PROFILE_2026-11-11.md) supplies the parametric positive-envelope scaling rule. Its standalone .565 budget is not used as a joint budget. The underlying Gram bounds hold for the actual kernels throughout the global QRH strip. Their finite low carriers may be shortened, and their coefficient upper bounds may be enlarged, within the positive envelopes. No oscillatory sum is asserted to be monotone under either operation.

The genuine two-character baseline gives `Cross_low<1e-9`, hence norm `<.000032`. This is the direct same-modulus result from the reviewed family mixed proof. It is not an L4 inference from separate second moments. The earlier coarse norm .0005 is not used for this joint calculation.

## Low coefficients and all scales

Put `x0=49*10^25`, `y0=10^25`, `x>=x0`, and `y=x/49`. With `epsilon=.56-.555=1/200`, the exact positive-integer comparisons

`(11/8)^200 > x0`, and `(27/20)^200 > y0`

give endpoint norm factors `Fx=11/8` and `Fy=27/20`. The low positive envelopes have powers `x^(2b-2)`, `y^(2b-2)` and their product. At b=.56 these exponents remain negative. Evaluate at x0,y0 and then use their decreasing powers for all larger scales. Do not assert the false inequalities `x^epsilon<=Fx` or `y^epsilon<=Fy` for unbounded x,y.

The resulting finite-low bounds are

`sqrt(Aplus_low)<.00007*Fx`, `sqrt(Astar_low)<.00049*Fy`,

`sqrt(N_low)<.032*Fx`,

`integral sum Lplus<.002*Fx^2`, `integral sum Lstar<10000*Fy^2=18225`,

`sqrt(Cross_low)<.000032*Fx*Fy`.

Using the larger cap for all low terms is conservative. The actual principal estimate is kept at its unchanged stronger bound `sqrt(Ep)<.00020001`.

The high-plus/low-star positive envelope uses the new high tail and the new low-star power. Its endpoint norm is multiplied by Fy; its total power is still decreasing at every larger scale. Thus the height bound gives norm `<.00045*Fy`, since `2e-7 < .00045^2`. All actual kernels, phases, weights and multiplicities remain those in the source.

## Complete mixed error and final major constants

The four remaining tensor terms are bounded by

`d0*74000 + ds*34 + ds*274 + d0*ds*180000000000`

`= 9550009/12500000000000000 < 2e-9`.

The three square-root bounds are checked against `300000*18225`, `300000*.002*Fx^2`, and `300000/4` respectively. This accounts for plus scalar error times low star, star scalar error times low plus, star scalar error times high plus, and both scalar errors. The changed high-tail aggregate is not counted as a uniform per-character error.

Consequently

`sqrt(Aplus_c)<.00007*Fx+.0001+2e-9`,

`sqrt(Astar_c)<.00049*Fy+1.2e-6`,

`sqrt(Cross_c)<.000032*Fx*Fy+.00045*Fy+2e-9`,

`sqrt(N)<.032*Fx+.5+2e-9`.

Exact rational squaring gives

| Actual quantity | Strict upper bound |
|---|---:|
| Aplus_c | 3.8514847504e-8 |
| Astar_c | 4.3917129e-7 |
| Cross_c | 4.44758277604e-7 |
| Astar_c+Cross_c | 8.83929567604e-7 |
| N | .295937 |

These imply the required Aplus<=5e-7, Astar+Cross<=9.5e-7 and N<=1.23. The old separate allocation Astar<=2.5e-7 is not claimed or needed by the combined consumer.

The unweighted star integral in the full-sum removal must also change. The actual arc-residue weight sum remains at most7.2e11, so the star error has integrated norm below2e-6. Hence

`integral sum Estar < (135+2e-6)^2 < 18226`.

Substitute18226, rather than10001, in the [major final-consumption proof](../qrh-campaign/agents/major-constants/MAJOR_FINAL_CONSUMPTION_JOIN_2026-11-11.md). With `a=1.01`, `bp=3.03e-23`, `bs=3.03e-17`, the full combined bound is

`Qfull <= a^2*9.5e-7+.640208*2.85*bs+a*bp*18226+a*bs*1.2301+bp*bs*3.6e11`.

The existing safe caps still hold: `Afull<5.050000000000330e-7` and `Qfull<9.817952468e-7`. The unchanged stronger principal Ep gives J>8.6296, while Ep and N give J<10. The same cubic comparisons yield dynamic loss<.008778 and major lower coefficient1.040492451>1.0404. No application of the old source theorem at1.049 is made.

## Separate pointwise base-gap verification

For the source original modulus m and reduced denominator `q=m/gcd(m,2)`, use the original twist-dependent cutoff

`Hbase=max(250,ceil(242U/(7q)))`, with `U<=1200000`.

Every supported odd conductor satisfies c<=q; every supported even conductor satisfies c<=2q. For c>100000, the two elementary margins

`50000000-290400000/7 > 150000`,

`99000000-580800000/7 > 300000`

absorb the ceiling error. The new heights also exceed250 at their largest conductors. Thus Hbase<=H(c) for every supported high conductor. The old containment proof remains for low conductors. This covers the full twist interval, including its endpoint as a conservative extension.

If q<=50000, then m<=100000 and every supported conductor is unchanged. More generally, if no high conductor occurs on the support, use the unchanged base-gap proof. In the affected case m>100000 and q>50000; Hbase<=831 and its multiplicity count is below200000. The exact all-character Gauss identity and Cauchy-Schwarz give `Wm<=sqrt(phi(m))<=sqrt(m)<548`.

The wider reflected strip does not retain the standalone13/8 bound for the etaU Mellin transform. Instead use its actual affine envelope `M(beta)=1.922-.6686*beta`. On the global strip M>1 and log y>8, so `M(beta)*y^(beta-1)` is increasing in beta. Every low term is therefore bounded by `M(.56)*y^(-.44)<(13/8)*y^(-.44)`. At y0 the latter power is exactly `10^(-11)` and decreases afterwards.

The source reconstruction, including its principal Fourier term, both removals and the unchanged high/vertical/zero0 allowance, is bounded by

`1.2534*(21/4)/100000+548*(13/8)*200000*1e-11+548*3e-14+549*2e-9`

`= .00184790151644 < .0026 < .04712 < ghatY(y,150000)`.

This is a separate pointwise estimate, not a consequence of the major averages. The unaffected q=1,2,3 prefixes and high-twist joins remain unchanged. The larger remote-totient ghat envelope only weakens the required bound.

## Status, evidence and final contracts

The [joint scalar script](joint_high_conductor_budget_20261111.py), SHA256 `8EAE514545383324B756A3284C5B485BC299DA96ECFF71F4CAD6E1D5FEAA150E`, checks26 exact rational/integer comparisons. Its [receipt](joint_high_conductor_budget_20261111.json) has SHA256 `27BF982A5F106406F2A20B3EF8D59F6BA51EE157DE14A601BD57DDB498570701`. It assumes the three high-tail aggregate caps from the separately checked height calculation; it is not a spectral evaluator or proof of those analytic premises.

The standalone real-part argument has SHA256 `B303BB457716C986128BDFA2F9D3C3A8418C55E5E6D754C7FEC20A4049E1C270`; its [independent review](../qrh-campaign/agents/independent-feasibility/REVIEW_HIGH_CONDUCTOR_REAL_PART_PROFILE_2026-11-11.md) has SHA256 `E34BA87276D76FAA091BB22867690ECBC8D86B30FAFAA5C8AB78EFA98DF4E184`. The independently reviewed height evidence and this amendment's own independent review must be bound in the ledger before adoption.

Upon adoption this single joint profile supersedes the old high-conductor uniform .555/H_old requirements. It also supersedes the old high-conductor low-star and mixed-error intermediate allocations only where recomputed above. It does not invalidate the historical standalone calculations or change the active characters. All other selected analytic proofs, finite replay and global-provider validation remain necessary.

The target remains unconditional `TernaryGoldbachFrom (10^27)`, and full `Statement` with only the original inclusive `BinaryGoldbachInput` through4*10^18. Major1.0404, minor1.0376 and nonprime.00271 leave `.00009*x^2/49`. All finite spectral facts in this note are internal obligations to discharge. No new spectral data, Lean proof or completed PlattGRH removal is claimed.
