# Independent review of the conductor 40 and 120 transform pilot

2026-11-11. **PASS for all retained actual-data cases, with the stated paper/source interpretation.** I found no error in the character labels, primitive extraction, centered Hurwitz coefficients, tensor stages, selected output enclosures, or the source interpretation at s=1. No producer correction is requested.

The check covers both conductors at both exact samples, all 96 coefficient records, all 352 retained tensor-stage entries, and all 24 selected primitive outputs. It does not substitute a few overlapping output balls for those checks. It remains external arithmetic evidence with reviewed paper soundness, not a Lean proof, certified contour, zero count, or finite spectral theorem.

## Frozen artifacts and new independent evidence

Paths are relative to `work/qrh-campaign/agents/`.

| Producer input | SHA256 |
|---|---|
| `prime-estimates/UNIT_GROUP_TRANSFORM_PILOT_2026-11-11.md` | `9857F80EA37AAD0134A0C588841CD22D82424B201DFF980ED7C6B4AE01812225` |
| `prime-estimates/unit_group_transform_pilot_20261111.py` | `9C0739E966109EC71A251182668A4A6670174C2248CADE3C3D271033CD2E2800` |
| Its same-stem JSON | `0630A8FBCB5C20A191D4DA8AEF5FE367F6FBE090FE8463C5CD0A4E2D5987EFEC` |
| Its reused `principal_k0_point_certificates_20261111.py` helper | `9A84F801745C8F9DD7CAD2F0E41F7633F8AFB850895C68845D4119E675543A22` |

The independent implementation imports neither producer nor helper. Its files are:

| New review artifact | SHA256 |
|---|---|
| `independent-feasibility/review_unit_group_transform_pilot_20261111.py` | `1AE73BB7EA9C446C3D1EDBD4EC3C63DDDE4729BB03DDB26DAC5558754D609B28` |
| Its same-stem JSON | `436A4B380C500365C56674EC137C9F40569AE0D4476BC9369F72738CCE6CC84E` |

The final run passed 1730 complex-rectangle containment checks, 50 exact rational-value checks, exact reproduction of all 352 stage entries, all 24 selected rows, and all four recorded mutation cases. It also independently classifies every character label at each modulus and records proper-divisor nonfactorization witnesses for every selected character. These counts describe finite checks, not generic Lean theorems.

The final independent run took about 0.42 seconds internally. No builtin L-function, zeta, Gamma, Riemann–Siegel or zero helper was called. The independent coefficient evaluator uses external Arb elementary log/exp/root balls; the producer uses only exact rational elementary certificates. The source-semantic argument and finite arithmetic checks below are essential: neither external library reliability nor numerical overlap replaces them.

## 1. Actual characters, not a cyclic transform of the wrong group

For each actual unit residue a, the reviewer decodes its coordinates directly from its residues modulo 8, 3 and 5. The mod-8 table is

```
1 -> (0,0), 5 -> (0,1), 7 -> (1,0), 3 -> (1,1),
```

the mod-5 table is `1,2,4,3 -> 0,1,2,3`, and the mod-3 table is `1,2 -> 0,1`. This construction does not obtain a from the producer's flattened array. The reviewer verifies that the decoding is bijective, and for every pair of unit residues that multiplication adds the coordinates modulo (2,2,4) or (2,2,2,4). Thus these are the actual unit groups, with the prescribed generators, not a cyclic length-16 or length-32 substitute.

The producer CRT idempotents (25,16) and (105,40,96) satisfy their exact congruences. Every retained residue decodes back to its retained coordinate, in the stated last-coordinate-fastest order. In particular, the zero coordinate gives residue 1. Swapping a coordinate convention without also proving the corresponding source-character permutation would fail these checks.

Characters are defined on these actual residues by the positive Gaussian-integer roots:

```
chi_r(a)=i^(2*r_e*x_e+2*r_f*x_f+r_5*x_5)              (c=40),
chi_r(a)=i^(2*r_e*x_e+2*r_f*x_f+2*r_3*x_3+r_5*x_5)   (c=120).
```

They are zero on nonunits. Unit-group multiplicativity, value 1 at residue 1, and the nonunit extension give actual Dirichlet characters. The accepted manifest establishes that these coordinate labels enumerate all source characters; the finite group checks here verify the concrete instances. No approximate root identification is needed: the only roots are 1,i,-1,-i.

For each selected row I verify multiplicativity on every pair of units, exact zero character sum, parity at residue c-1, and the inverse-label relation on every unit. The parity is (-1)^(r_e+r_5) at 40 and (-1)^(r_e+r_3+r_5) at 120. The five-power coordinate modulo 8 does not enter parity. Negating all coordinates gives the inverse character; conjugating its value is valid on residues, not a same-sample conjugation identity for L at nonreal s.

The independent primitive classification considers **all** 16 or 32 labels. For every proper divisor d of c it groups units by their residue modulo d and checks whether their character values agree in each group. It also verifies surjectivity onto the units modulo d. Therefore agreement gives a genuine descended character, while a pair with the same residue and different values disproves descent. Exactly six labels have no proper descent:

```
c=40:  (e,1,r),       e=0,1, r=1,2,3;
c=120: (e,1,1,r),     e=0,1, r=1,2,3.
```

For each selected label and every proper divisor, the receipt retains an explicit pair disproving descent. This verifies the selected primitive rows rather than relying only on their count. The flattened output indices, parity bits and inverse labels also match every stored row.

## 2. Euler–Maclaurin formula and exact remainder allocation

I read the complete producer code and the relevant reconstructed EM proof, `major-constants/EM_SOURCE_PROOF_PLAN_2026-11-11.md`, pin `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485`, and its review `moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md`, pin `5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1`.

For q=a/c in (0,1), N=64, p=12 and B=N+q, the finite head is exactly k=0,...,63. The endpoint term is B^(-s)/2. The rth correction has coefficient B_(2r)/(2r)!, rising factorial length 2r-1, and power B^(1-s-2r). The last correction has length 23; the remainder has length 24. The code agrees with these indices and signs. I independently construct B_n/n! by reciprocal formal-series recurrence and check equality with all 25 stored ordinary Bernoulli numbers after multiplying by n!.

The reviewed finite-cell integration-by-parts formula yields the remainder

```
R_q(s)=-(s)_24/24! * integral_64^infinity B_24(fract x)*(x+q)^(-s-24) dx.
```

Its valid half-plane is Re(s)>-23. The Bernoulli Fourier bound and pi>3 give |B_24(fract x)|/24!<=4/6^24; the elementary power integral gives

```
|R_q(s)|<=4*|(s)_24|*B^(-Re(s)-23)/(6^24*(Re(s)+23)).
```

At the two exact samples, sigma+j and |Im(s)| are nonnegative, so |s+j|<=sigma+j+|Im(s)|. Since B>64 and the exponent is negative, replacing B by 64 gives precisely the producer's rational uniform bound. At sigma=1/2 the numerator power is 8/64^24; at sigma=1 it is 1/64^24. The positive denominators are 47/2 and 24 respectively. I independently recompute both exact uniform bounds and check each coefficient record uses the corresponding value.

Adding [-E,E] in each coordinate encloses the analytic error disk. No factor sqrt(2) is needed in this direction. The subsequent algorithm carries rectangles, not a claimed disk of radius E, so it does not accidentally reverse that implication. At s=1 the finite part and the remainder integral are real; replacing the imaginary interval by exactly zero is valid there.

## 3. Source identity at s=1

The pole issue is handled correctly. The relevant actual Mathlib source at revision `56a005855ea17e0b0958f73ec801ae140b0a1679` was read directly:

* `LSeries/HurwitzZeta.lean` gives the usual positive-shift series only for Re(s)>1, and explicitly regularizes individual source values at 1 with `1/(s-1)/GammaR(s)`.
* Its `differentiable_hurwitzZeta_sub_hurwitzZeta` theorem makes every source Hurwitz difference entire.
* `LSeries/ZMod.lean:85` defines LFunction by the finite sum `c^(-s)*sum chi(a)*hurwitzZeta(a/c,s)`.
* `LSeries/DirichletContinuation.lean:60` uses that definition for actual characters; the nonprincipal function is differentiable everywhere. The raw `LSeries` cannot be substituted at Re(s)<=1.

Let H_q be the ordinary deflation constructed from the finite EM expression and its remainder:

```
H_q(s)=F_q(s)+(B^(1-s)-1)/(s-1)+R_q(s),
H_q(1)=F_q(1)-log B+R_q(1).
```

The exponential quotient has the indicated removable value. The EM remainder is holomorphic on Re(s)>-23 by the locally uniform power/log majorant in the reviewed EM proof. Therefore H_q is holomorphic there. On Re(s)>1, H_q equals the classical Hurwitz series minus 1/(s-1).

It is **not** necessary, and would be wrong without an additional constant adjustment, to identify each H_q(1) with Mathlib's individual totalized Hurwitz value. Instead, on Re(s)>1, H_q-H_(1/c) equals the corresponding source difference. Both sides are holomorphic on the connected half-plane Re(s)>-23, so analytic uniqueness proves equality throughout it, including s=1.

Every selected character has exactly zero sum, already checked over Gaussian integers. Consequently its weighted sum of H_q equals its weighted sum of H_q-H_(1/c), and then equals its weighted sum of source Hurwitz values. Multiplication by the retained c^(-s) is exactly the actual DirichletCharacter.LFunction. This argument applies at s=1 without appealing to a conditionally convergent Dirichlet series or silently changing the source's pole convention.

Setting the reference centered coefficient to exactly zero is justified by its identity as a function. For every other coefficient, subtracting the two interval boxes retains both errors. There is no assumed independence or unjustified cancellation of interval uncertainty. The centered principal transform row is only an intermediate array entry; neither the producer nor this review calls it the principal L-value at 1.

## 4. Elementary powers and complete independent coefficient check

At s=1 the producer's positive-base powers are exact rational reciprocals. At s=1/2+10i, it evaluates x^(-s)=x^(-1/2)*exp(-10*i*log x). The reused log and root routines are the previously reviewed exact rational ones. The new sine routine contains all odd terms through degree 47; the cosine contains the even terms through degree 46. Thus both are the relevant coordinates of the same degree-48 exponential truncation and have the full tail 2*4^48/48!, after certifying the reduced interval lies in [-4,4]. Both input-radius additions use their valid global Lipschitz bound 1. Pi uncertainty is retained in every reduction.

The complex reciprocal of s-1 in the off-pole deflation is computed from its exact rational real and imaginary parts. Its squared norm is strictly positive. The quotient is `(B*B^(-s)-1)/(s-1)`, with the correct minus sign and common pole subtraction. At s=1 the code uses -log B directly. Rising factorials and integer-shifted powers of B are exact rational or Gaussian-rational calculations before the certified interval multiplication.

For independent numerical assembly I use **N=96, p=28, 256-bit Arb elementary balls**, and the actual residue-defined characters above. I evaluate raw classical Hurwitz at the nonreal sample and ordinary finite parts at s=1. I form each selected L-value directly from these raw values and exact character values, without the producer's centering or tensor order. The same zero-sum/source argument in section 3 identifies this direct assembly with the actual L-function.

All 96 alternate centered differences lie within the producer's retained centered rectangles. For a separate check of the retained internal steps, I also evaluate their **N=64,p=12** finite expressions with independent elementary ball arithmetic: every head, half term, all twelve corrections, pole difference and ordinary deflated output is checked against its retained box, with a separately bounded analytic remainder. This checks the internal record rather than only its final transformed consequence.

At s=1 the B^(-1) and c^(-1) fields are exact point rationals. Those 50 fields are checked by exact rational equality, not by asking a nondegenerate Arb enclosure to fit inside a zero-width rectangle. An initial harness made that overly strong containment test; it was corrected to the exact-value check before acceptance. This was a reviewer test-interface issue, not a failed producer enclosure.

Every one of the 24 alternate direct L rectangles lies inside both the producer's tensor rectangle and its direct raw-deflated rectangle. These are containments, not merely nonempty intersections. The numerical comparison supports the source and arithmetic audit; the source argument in section 3 and explicit primitive formulas are what establish the objects being compared.

## 5. Exact tensor replay and mutations

Independently implemented Fraction rectangle operations reproduce each centered subtraction and every retained tensor stage **exactly**, including the producer's 128-bit outward rounding. Multiplication by roots uses only coordinate permutation and sign changes. Finite distributivity identifies the successive axis sums with the positive character kernel. There is no normalization by phi(c), and no replacement by an additive transform on all residues modulo c.

The replay covers 96 entries from the two conductor-40 runs and 256 from the two conductor-120 runs, totaling 352. It reproduces all final centered transform outputs, then the exact rectangle multiplication by c^(-s). Independently summing the stored raw-deflated boxes in increasing actual residue order reproduces every retained direct rectangle. Thus a final-ball comparison is not the only evidence for the actual transform schedule and rounding.

All retained corruption results are reproduced:

* Reversing the twiddle sign with labels fixed gives disjoint rectangles at the four nonreal selected characters in every run. The two real labels remain unchanged, as expected.
* Swapping the residues at flattened indices 1 and 2 fails the exact residue-coordinate check. Replaying the corrupted coefficient permutation gives disjoint rectangles at all six selected labels in each run.
* The retained f=0 mutation is not selected. The independent actual-character test additionally proves it descends to c/2, so the rejection has conductor content rather than merely duplicating a Boolean filter.

The reviewer also supplies exact delta-input tests for the positive order-four sign and normalization, an axis-swap character witness, and a collapsed-generator cardinality failure. These additional tests are bounded regression evidence; they are not a proof that every possible malformed executable or corrupted certificate is detected.

The exact output-width checks confirm the producer's stronger reported bounds: below 2*10^(-37) in each coordinate at s=1 and below 1.367*10^(-29) at s=1/2+10i. At the nonreal sample, inverse-character rows are not assumed to be complex conjugates at that same sample.

## Disposition and remaining boundary

The four sampled cases pass the complete independent review. No unproved spectral hypothesis enters their coefficient construction or transform. The source-safe s=1 adapter is a valid paper derivation using the reviewed EM identity and actual entire-difference theorem.

Formal use still requires the elementary checker, EM and deflation adapters, concrete CRT/source-character identification, primitive/conductor facts, and tensor/rounding correctness to be implemented and checked in Lean. The finite data do not prove any open contour nonvanishing statement or any multiplicity count. No full-family runtime or proof-size estimate follows from this small pilot.
