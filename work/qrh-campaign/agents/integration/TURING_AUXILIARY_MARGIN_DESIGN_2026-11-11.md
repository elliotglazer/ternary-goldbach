# Conditional auxiliary-height budgets for the elementary Turing bound

2026-11-11. This is a symbolic design and bounded exact arithmetic experiment. It supplies sufficient auxiliary lengths under explicit conditions on future measured data. It computes no characters, L-values, Gamma integrals, zeros, signs, FFT outputs, or complete family certificates. No Lean/Lake, canonical edit, or frozen-package change occurred. The report is submitted for independent review.

The central distinction is that making the Turing allowance small per unit height does not make the count certificate pass. The measured Gamma integral, main count, and weighted auxiliary signs must satisfy a separate inequality. This note keeps that inequality explicit throughout.

## Accepted inputs and pins

Paths are relative to `work/qrh-campaign/agents/` unless otherwise stated.

| Input | SHA256 |
| --- | --- |
| `integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md` | `72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C` |
| `mellin/REVIEW_ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md` | `2238E4C56B808F9034DCE86ECA834A785BA5DF4E09F2F68935C287BD9CA5AAE3` |
| `zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md` | `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4` |
| `major-constants/REVIEW_FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md` | `3033D761A2FE3F1B140A750CD1261D640EF8D1E98FA81711A438EB899A8AFE58` |
| `zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md` | `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54` |
| Root `work/qrh-blueprint/turing-scalars/AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md` | `45E848935AC76C8450550DFE02279C697514BF227B37EA6FD25221B3F7C37F47` |
| `zero-sum/REVIEW_AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md` | `5EB56E2F86C5CE05CCA3491C237FE66F4C0053F656AD1401211A47406833DA21` |

The last independent review supersedes the producer's frozen pending-review wording. It accepts general-height parameter implications, not actual coefficient rounding, FFT outputs, signs, or practical cost. The Turing result has reviewed paper and external-scalar scope, not Lean scope.

The allowance for each primitive nonprincipal character of conductor c>1 is

```
B(c,H) = 42 + (693/100)*log(c*H/(2*pi)), H>50.
```

It applies to either parity and to the inverse character, with the same canonical Euler-normalized S and exceptional-height convention. The conductor-one principal row uses its separate count normalization and is outside this design.

## The exact measured deficit

Fix rational T>=Hcert(c)>50, h>0, and H=T+h. The actual certificate must supply:

- A certified integer K of main zeros, including the required central contribution, with K<=C_chi(T). Here C is the closed two-sided count with multiplicity, including real zeros.
- Disjoint certified auxiliary sign intervals (u_j,v_j) strictly inside (T,H), tagged by chi or its inverse. Let W=sum_j(H-v_j), with the two-channel convention below.
- A rational upper enclosure Abar of `integral_T^H G(t) dt`, where G=2*theta_a/pi uses the correct analytic Gamma phase.
- A rational upper enclosure b of B(c,H), proved from an elementary log/exponential certificate.

For a real character the same positive auxiliary channel contributes twice to W, and its Turing allowance contributes twice as well. For a nonreal pair use each member's positive channel once. The exact measured deficit, in count units, is

```
D = (Abar-W)/h - K.
```

It can have either sign. It is not an estimate of a typical zero density and is not supplied by choosing h. Once the data are certified, D is a rational number. The count upper enclosure satisfies

```
U-K = D + 2*b/h.
```

Therefore the sufficient and directly checkable condition is

```
D + 2*b/h < 1.                                          (C)
```

All approximation errors in the Gamma integral must already be included in Abar. W is a lower weight obtained from certified interval endpoints, not an approximate sum of root ordinates. Using midpoints as exact roots would invalidate (C).

For a fixed measured D<1, condition (C) can be written `h>2*b/(1-D)`. This is not a license to reuse D after changing h: both Abar and W depend on the new interval. If D>=1, no positive allowance can make that particular measured packet pass.

## A design budget with a fixed margin

Choose a rational design parameter 0<rho<1. It is enough to arrange

```
2*b/h < (8/9)*rho,       and then actually certify D <= 1-rho.
```

These conditions give `U-K<1-rho/9`. The factor 9/8 in the length construction below is an explicit safety choice, not an analytic assumption. Without it, one can use `2*b/h<rho`, but a length chosen just above the threshold may leave a very small strict rounding margin.

The following three choices illustrate the tradeoff:

| Design rho | Required future measured D | Guaranteed count margin once that condition holds |
| --- | --- | --- |
| 1/4 | D<=3/4 | greater than 1/36 |
| 1/2 | D<=1/2 | greater than 1/18 |
| 3/4 | D<=1/4 | greater than 1/12 |

The required D is a proposition to prove from actual data. None of these rows asserts that any character will satisfy it.

For fixed c,T, the true allowance term `A(h)=2*B(c,T+h)/h` is strictly decreasing and tends to zero. Indeed

```
A'(h) = 2/h^2 * ((693/100)*h/(T+h) - B(c,T+h)) < 0,
```

because B>42>693/100. The limit follows from log(T+h)/h tending to zero. This proves that the allowance alone can be made small. It says nothing about the behavior of D(h). In particular a hidden main zero makes K<C_chi(T), so every sound upper bound U remains at least K+1 and no h can make that unchanged incomplete main count pass.

## Exact rational construction of length witnesses

To avoid accepting floating logarithms, use pi>3 and exp(1)>8/3. For an integer k>=1 satisfying

```
(8/3)^k >= c*(T+h)/6,
```

we have `log(c*(T+h)/(2*pi))<k`. Thus `b_k=42+(693/100)*k` is a certified rational upper bound for B. For each k, propose

```
h_k = floor((9/8)*2*b_k/rho)+1,
```

and accept it only if the preceding exponential inequality holds with h=h_k. Then `2*b_k/h_k<(8/9)*rho`. This resolves the occurrence of h inside the logarithm. Exponential growth in k dominates the linear growth of h_k, so a witness exists for every fixed positive c,T,rho. The bounded experiment below searches only k=1,...,100 and finds all listed witnesses within that range. It does not claim the resulting h is minimal or computationally optimal.

The script `turing_auxiliary_margin_design_20261111.py` checks 24 witnesses with exact Fraction/integer arithmetic. It verifies the selected height formula, log witness, allowance bound, and conditional strict margin. Every row explicitly records that measured D, Gamma enclosures, and signs have not been supplied.

## Representative selected heights

The unchanged profile is

```
c_tilde = c if c is even, otherwise 2*c,
Hp(c) = 200 + max(1000, ceil(704*1200000/(7*c_tilde))),
Hcert(c) = min(Hp(c), 100000000/c).
```

Set T=Hcert(c) exactly, without rounding upward. The closed-count consumer permits this rational endpoint even if a zero lies there. It still requires the full count and main evidence described above.

The table gives sufficient integer h for each conditional D target. No signs or measured D values were computed.

| c | T | h when D<=3/4 | h when D<=1/2 | h when D<=1/4 |
| ---: | ---: | ---: | ---: | ---: |
| 3 | 20,114,486 | 1,439 | 720 | 480 |
| 4 | 25,000,000 | 1,439 | 720 | 480 |
| 40 | 2,500,000 | 1,439 | 720 | 480 |
| 101 | 597,655 | 1,439 | 720 | 480 |
| 1,000 | 100,000 | 1,439 | 720 | 480 |
| 10,000 | 10,000 | 1,501 | 751 | 501 |
| 150,000 | 2000/3 | 1,564 | 751 | 501 |
| 300,000 | 1000/3 | 1,564 | 782 | 501 |

For the middle column, k is 17 through c=1000, 18 for c=10000 and 150000, and 19 for c=300000. The resulting allowance ratios are respectively 5327/12000, 8337/18775, and 17367/39100, each strictly below 4/9. If the certified D is at most 1/2, the resulting saturation margin is therefore greater than 1/18.

At c=4 the middle design enlarges the range from 25,000,000 to 25,000,720, a small relative increase. At c=300000 it enlarges the range from 1000/3 to 3346/3, and h/T=1173/500. The auxiliary range is more than twice the main target height. Similar absolute lengths can therefore have very different evaluator consequences at low and high conductors.

## What the measured deficit exposes

Condition (C) gives exact improvement rates for a fixed h:

- Tightening Abar by epsilon lowers D by epsilon/h.
- Increasing a certified auxiliary lower weight by epsilon lowers D by epsilon/h.
- A new certified interval with upper endpoint v contributes (H-v)/h to the reduction in D, counted once per channel.
- Refining a certified interval to a smaller valid upper endpoint v' improves D by (v-v')/h. Its containment of a zero must be proved again by the interval's certified signs or another valid argument.

Early auxiliary zeros carry more weight than late ones. Raw auxiliary counts without their endpoint weights are insufficient. If the exact Gamma integral is A, its upper-enclosure error is e=Abar-A>=0. Let L be the actual integrated added-zero count and let s be the sum of the two S integrals. The count identity gives

```
D = (C_chi(T)-K) - s/h + (L-W+e)/h.
```

The first term is a possible missing main count. The second is bounded by Turing but not known from h alone. The third contains missed auxiliary weighted zeros, interval localization losses, and Gamma error. For selected actual roots gamma_j in the certified intervals, the localization part is sum(v_j-gamma_j), bounded by the sum of interval widths; unrepresented auxiliary zeros contribute additional nonnegative weight. This identity is explanatory, not a new assumption of completeness or access to the unknown roots.

If h is enlarged but only old auxiliary intervals are retained, each old weight increases by the length increment. However Abar must be recomputed and new zeros may enter the enlarged zone. There is no monotonicity theorem for the measured D in this operation. The safe loop is to choose a new h, certify its actual data, recompute D, and test (C).

## Required enlargement of the evaluator window

The spectral target remains T>=Hcert(c). The numerical evaluator used to obtain auxiliary signs must additionally cover every sample endpoint used inside (T,T+h). For a global Fourier evaluation on |t|<=H_eval, choose H_eval at least T+h, or larger if grid rounding causes any evaluated node to lie beyond it. The count weights still use the actual auxiliary top T+h, and only intervals wholly inside (T,T+h) may be included in W.

The old product-cap envelope cannot be reused merely because the main target has c*T<=10^8. In the middle design, c*(T+h) equals 100,002,880 at c=4 and 334,600,000 at c=300000. Every listed middle-row example except c=3 and c=101 exceeds the old cap. These examples need the reviewed arbitrary-height envelope, or a different rigorously bounded evaluator.

The accepted arbitrary-height adapter supplies analytic parameter implications with C=c*H_eval, eta=1-1/H_eval, a time period P>2H_eval, suitable frequency and Gaussian cutoffs, and explicit future rounding targets. Its review does not supply coefficient balls, character transforms, FFT error certificates, or signs. A later radix-two precision rule restricted to a stage cap must be revalidated if the new transform length exceeds that cap. Increasing H_eval is not permission to keep old truncation or precision constants unchanged.

A uniform grid is only one way to obtain the needed intervals. Sparse certified intervals suffice for W; no complete auxiliary zero list is required. Conversely, an arbitrarily fine grid does not by itself guarantee enough sign changes, especially without simplicity assumptions. The actual count test decides completeness. There is no off-grid interpolation claim here. Previously proved sign facts about the same actual character function can be reused when their normalization is preserved; raw floating or interval FFT output from a different tilt/parameter set needs its own valid transfer.

This is a sound sufficient certificate route, not a terminating producer for every possible true beta<=.555 instance. Saturation by ordinary critical-line main sign intervals proves the stronger finite-RH conclusion and simplicity for those noncentral intervals. A hypothetical off-line zero satisfying beta<=.555, or an unaccounted even-multiplicity zero, could prevent this particular sign-based consumer from succeeding. The height-budget arithmetic does not remove that restriction.

## Reproduction and acceptance boundary

Run `python work/qrh-campaign/agents/integration/turing_auxiliary_margin_design_20261111.py` from the repository root. It exited 0. All proof-relevant arithmetic is exact; no approximate logarithms or root values are used.

| Artifact | SHA256 |
| --- | --- |
| `integration/turing_auxiliary_margin_design_20261111.py` | `5C49EE7A33C86186ADA1A7F11AC2CE424124A2065623D8366C81ADAA684DBAC1` |
| `integration/turing_auxiliary_margin_design_20261111.json` | `25B7183974DFBFE3018A8FB0011D7BD942758DFFE602957BC6E3105D2FA59A35` |

The witnesses certify only sufficient lengths conditional on the displayed future measured D inequalities. No character in the table has been certified by this experiment. The family, Hcert, binary input, and final no-new-premise Goldbach target are unchanged. Actual function enclosures, main and auxiliary signs, Gamma integrals, exact consumer checks, and all Lean proofs remain required.
