# Independent review of the high-conductor real-part profile

2026-11-11. **PASS as a conditional paper implication and exact scalar calculation.** No correction is required. With the current heights and all low-conductor conditions retained, the proposed `.565` upper bound above conductor 100000 suffices for the stated major, J, cubic, and pointwise base-gap consumers. It does not prove that finite spectral assertion or adopt it into the selected strategy.

The review read the complete author note, script and receipt, the prior weighted-excess and density reviews, the family mixed and second-moment arguments, the common-height review, and the actual final-consumption and base-gap joins. Small independent Fraction and integer-power checks reconstructed the new values without importing or executing author code. No spectral evaluator, sieve, build, source change, or new Lean declaration was used. Only this review file was created.

## Frozen inputs

Paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `major-constants/HIGH_CONDUCTOR_REAL_PART_PROFILE_2026-11-11.md` | `B303BB457716C986128BDFA2F9D3C3A8418C55E5E6D754C7FEC20A4049E1C270` |
| `major-constants/high_conductor_real_part_profile_20261111.py` | `7A3DFA5D5029D10E714F1A91E2E11FC1EC1578A0636D2DAB7F4B48FF6AB39A73` |
| Its JSON receipt | `D6268B4F4CC7E980F4A25D0833EDE4C7787971773B9EEA6C3B8ABA943E324966` |
| `major-constants/RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md` | `79833F8D5D5856E000A96D3F5CCA9FC9E26CB3BAF637CDE089FEFDD703436BA7` |
| `zero-sum/RESUME_FAMILY_MIXED_2026-11-11.md` | `5E7FB33EDF2A65F058DC605A3054FE37DFDF14E9ACDCB8409A8211DCF1F9D09D` |
| `major-constants/MAJOR_FINAL_CONSUMPTION_JOIN_2026-11-11.md` | `280FDC53E61066E050DD98D4A004A9435510CC67686A59354750E0F7DE188F64` |
| `integration/BASE_GAP_ACTUAL_SOURCE_JOIN_2026-11-11.md` | `F0BC1D7899044C27E819743BBA4B157D51F42848B87A51D37764CDB8B3B6C9E0` |
| `major-constants/RESUME_FAMILY_CAPS_2026-11-11.md` | `2990B5B5D7ABA1B8262FB18800CA5CE61DC347B7C5748405A5886D9EE45BBAF3` |

These hashes were checked from current bytes. The old finite base-gap note and both weighted/density review pins quoted by the author also matched. The directly inspected `TernaryGoldbach/MinorArcs/Bombieri.lean` has SHA256 `F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79`, in the target source at revision `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

## Profile, kernels, and all-scale interpretation

The finite condition remains over all actual primitive characters of the active conductors, with actual analytic multiplicities and inclusive cutoff `Hcert(c)`. It changes only the upper real-part bound to `113/200` when `c>100000`. The `.555` condition below that threshold, the principal conductor, the exact rational minimum height, the smaller star cutoff, and global reflected QRH remain unchanged. No height-shortening proposal is combined with it.

The new profile implies a uniform `.565` cap on every finite low set. It is therefore legitimate to reapply the existing positive Gram, count, and two-character envelopes with that cap. Their actual Mellin kernels are bounded on the global QRH strip; they are not evaluated at fictitious displaced zeros. The argument compares positive envelopes, not norms of oscillatory sums after changing coefficients.

At `x0=49*10^25`, `y0=10^25`, the exact comparisons are

`15^100 > x0*8^100`, and `9^100 > y0*5^100`.

They give endpoint norm factors `Fx=15/8`, `Fy=9/5`. They do not bound `x^.01` or `y^.01` for unbounded scales. The new low envelopes instead have powers `x^(-.87)`, `y^(-.87)`, or their product, which decrease for all larger scales. The high-plus/low-star envelope also remains decreasing: its high part retains the old negative power and its new low part has the new negative power. The scalar remainder bounds already hold uniformly. Thus every displayed endpoint bound persists for all `x>=x0`, with `y=x/49`.

Actual inverse characters preserve conductor, so the profile remains compatible with the inverse-label convention. Reflection is available in the unchanged global strip; no same-character quartet or simple-zero assumption is needed.

## Gauss weights and the mixed fourth moment

The source `Bombieri.norm_sq_gaussSum` gives weight `c` only when `q/c` is squarefree and coprime to `c`; otherwise the weight is zero. Character energy has the factor `c/phi(q)` on that support. The weighted Aplus/Astar integrals also retain their external `mu(q)^2/phi(q)^2`, whereas N and Cross do not acquire that squarefree restriction. These weights are inherited unchanged.

For Cross, the stronger prior bound is the same-modulus product of a plus L2 envelope with a star pointwise envelope. It retains two independent character indices. Its old `.555` bound is below `1e-9`, so `.000032` is a valid old low norm upper bound. Changing both positive low envelopes gives `.000032*Fx*Fy`, without inferring a fourth moment from two separate L2 estimates.

The dominant high-plus/low-star norm must increase by `Fy`; the report correctly changes it to `.00016*Fy`. The four other tensor terms are separately bounded by

`2e-15*100000 + 2e-12*46 + 2e-12*87 + 4e-27*180000000000`

`= 5825009/12500000000000000 < 1e-9`.

The square-root bounds behind 100000, 46, and 87 were checked against `300000*32400`, `300000*.002*Fx^2`, and `300000*.025`. This accounts for low-plus/star-error, plus-error/low-star, high-plus/star-error, and the two-error term. It does not reuse the old entire remainder unchanged.

Independent exact reconstruction agrees with every changed receipt value:

| Quantity | Rational upper value |
|---|---:|
| Aplus | `1722711375441/100000000000000000000` |
| Astar | `4761/6103515625` |
| Cross | `156816792001/1000000000000000000` |
| Astar + Cross | `936859032001/1000000000000000000` |
| N | `12100000220000001/250000000000000000` |

The joint slack below `9.5e-7` is exactly `13140967999/10^18`, positive. Astar alone exceeds the former optional `2.5e-7` allocation. That separate allocation is not retained: the actual final consumer requires the combined cap, which passes. N includes its low piece, the current high-tail norm, and the non-tail error. Principal Ep uses its unchanged actual conductor-one bound rather than the inflated global low envelope.

## Full-sum removal and J

The old unweighted star bound 10001 cannot be carried over. The new low norm is below 180, and the unchanged per-character error has integrated norm below `2e-6`, using the actual arc-residue measure `W<=7.2e11`. Thus `(180+2e-6)^2<32401` is valid and is substituted into the removal formula.

The independent calculation reproduces

`Qfull <= 2422737500234803699858326281 / 2500000000000000000000000000000000`

`< 9.817952468e-7`.

The Aplus transfer retains its prior safe full cap. Consequently the same dynamic cubic-error comparisons and lower major bound remain available. The upper J bound uses N below 1.23 and Ep below its retained cap; the lower J argument uses the stronger unchanged principal norm. There is no circular appeal to the cubic bound. This profile does not claim the source's stronger old major theorem with its hypothesis erased.

## A separate pointwise base-gap proof

The pointwise conclusion is not deduced from any major average. Retain original modulus `m`, reduced denominator `q=m/gcd(m,2)`, and actual etaU twist. For `q<=50000`, every supported conductor divides `m<=100000`, so the old profile suffices. This includes all exceptional small-q joins. If `q>50000` but no high conductor occurs on nonzero Gauss support, the same old proof applies. Otherwise `m>100000`.

For the affected case, the independent exact worst-integer check gives `H=830` at `q=50001`, with count proxy `191605`. The author's looser bounds `H<=831`, `N(H)<200000` are valid for every larger q. The original two height-containment arguments apply unchanged to the same cutoff, and the high/vertical/zero-at-zero allowance remains `3e-14` per primitive character.

On the global real-part interval the actual transform bound is `M(beta)=1.922-.6686*beta`, with `M>1`. The derivative of `M(beta)*y^(beta-1)` is positive when `log y>8`. It follows that every low summand is at most `M(.565)*y^(-.435)<(13/8)*y^(-.435)`. This proof handles the widened left side of the reflected strip; it does not incorrectly assert the old standalone `13/8` transform bound there.

The exact all-character Gauss identity and Cauchy-Schwarz yield `Wm<=sqrt(phi(m))<=sqrt(m)<548`. The principal Fourier coefficient is at most `1.2534*(21/4)/100000` in the affected case. Both source removal errors are retained. The power comparison `(1.4e-11)^8*10^87>1` verifies the endpoint ordinate factor; its exponent is negative, so it holds at all larger y. The independent reconstruction gives

`1.2534*(21/4)/100000 + 548*(13/8)*200000*1.4e-11`

`+548*3e-14 + 549*2e-9 = 64007537911/25000000000000`

`= .00256030151644 < .0026 < .04712`.

This proves the required pointwise envelope conditional on the spectral inputs and the retained source joins, uniformly over the full relevant twist range. It uses no phase cancellation, omitted character row, aggregate-to-pointwise implication, or extra conductor decay.

## Scope of acceptance

The profile closes its own changed budgets. It does not rely on the unproved `K<=6` weighted-excess alternative, nor on an unavailable density estimate. The earlier weighted argument is used only for already proved kernel and monotonicity observations. Its historical principal narrow-strip status is not reintroduced; conductor one and the subsequently accepted principal deductions are unchanged here.

This is a weaker request for finite location information, not evidence of actual zeros between `.555` and `.565` or a measured reduction in verification cost. The active labels, finite heights, and completeness requirements remain. No new census or runtime comparison was performed.

Before adoption or theorem completion, the new finite condition would have to be proved for all actual active characters, global-provider closure validated, and the source/Gram/limit/arithmetic/consumer proofs formalized. The large root receives no new hypothesis. The current selected profile and all frozen artifacts were preserved by this review.
