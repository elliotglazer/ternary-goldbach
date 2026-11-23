# Receipt and schedule for the bounded height-2000 EM batch

2026-11-11. Proposed external-experiment contract supporting moebius_route's pilot specification. **No implementation, moment, transform, function evaluation or build was run for this note.** Numerical allocations below match the corrected frozen scalar budget `major-constants/EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md`, SHA256 `47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23`; its independent review and the final pilot-spec review are required before execution. This note does not authorize a run or assert that a chosen precision will pass.

## Fixed scope

Use the author's proposed parameters:

```
sigma=629/1250, t0=31999/16, Delta=-1/8,
J=8, L=32, N=1024, B=N+1=1025, M=16,
K=16 (normalized derivative orders 0..15), p=24,
outer Taylor radius R=1, panel radius rho=1/16.
```

The exact centers are `s_j=sigma+i*(t0+j*Delta)`, j=0,...,7. Eight downward vertical panels join endpoints `sigma+i*(2000-l/8)`, l=0,...,8. They cover the single segment from height 2000 to 1999, with closed endpoints. This is not a closed contour or a new high-height spectral certificate.

The finite entire function is fixed structurally, not by a free string:

```
D(s)=sum_(n=1..N) exp(-s*log n),
R(s)=1/2+sum_(k=1..M) [Bernoulli_(2k)/(2k)!]*B^(1-2k)*(s)_(2k-1),
g(s)=(s-1)D(s)+exp(-s*log B)*((s-1)R(s)+B).
```

The retained outputs are all 128 coefficients `g^(h)(s_j)/h!`, all eight whole-panel images and all nine endpoint images. The eventual zeta images also require the separately proved actual-point EM remainder and full nonzero `s-1` denominator. Finite-g arithmetic alone does not establish them.

Proposed operational limits are one 192-bit producer attempt, a separate 224-bit independent attempt, 180/360 seconds respectively, 512 MiB peak working set of each single evaluator process and 64 MiB per receipt. No evaluator may spawn subprocesses or delegate work; the coordinator supervisor is outside this evaluator-process metric. The implementation must specify OS telemetry and guard points and record wall time and peak working set including serialization. An observed overshoot or inadequate telemetry prevents complete PASS; a watchdog may terminate externally. These are operational caps, not forecasts or hard real-time guarantees. No automatic retuning, precision increase, missing-output omission or new region is permitted. Parameter changes require a new version and budget review.

## Serialized values and top-level binding

Use a new versioned receipt, leaving all prior files unchanged. Each **FLINT elementary/arithmetic/FFT real-ball payload** is serialized as exact signed-exponent dyadics for `mid` and nonnegative `rad`; its complex payload has real and imaginary balls. A dyadic is an integer mantissa and integer exponent, interpreted as `mantissa*2^exponent`. Derive `lo=mid-rad` and `hi=mid+rad` by exact arithmetic; if endpoints are also stored, require exact equality. Decimal displays are optional and have no authority.

Use a distinct **exact-rational** payload for target constants, analytic pads such as E_EM, and final rectangle endpoints after exact rational Horner/padding/division: signed integer numerator and strictly positive integer denominator, in reduced form. Require gcd=1, denominator positive, and ordered endpoints. Complex exact-rational rectangles have two such endpoint pairs. Their denominators need not be powers of two; converting them to dyadics would introduce rounding and invalidate the stipulated exact-equality replay unless a new outward-rounding contract were added. Tags distinguish these rational values from internal dyadic-ball payloads.

This follows the tested lossless export pattern `x.mid().man_exp()` / `x.rad().man_exp()` in `integration/lossless_modular_two_step_20261111.py:225-231`. Do not use precision-rounded `.lower()`/`.upper()` as a surrogate for the internal input ball: the earlier modular pilot demonstrated that this can invalidate consecutive full-input operation inclusions. Reject infinities/NaNs, negative radii, malformed integers and unbounded resource fields. Exact mid/rad export preserves what FLINT computed; it does **not** prove FLINT's analytic or arithmetic correctness.

The manifest records all exact parameters above; the indexed center/endpoint formulas; finite-g expression version; moment, FFT and correction schedule versions; precision and software versions; exact Bernoulli convention; source/spec/scalar-review pins; error-unit conventions; expected array shapes; phase/run status and failure record. File hashes bind provenance. No status flag, hash or authorization field is a mathematical premise.

## Required packet sections

| Section | Exact meaning and required fields |
|---|---|
| Elementary inputs | Actual log(n) balls for 1..N and log(B), pi ball, the N phase/weight balls `exp(-s0*log n)`, and exact rational Bernoulli/factorial/B-power constants. n=1 is treated exactly. |
| Bin witnesses | For every n: its original integer label; a rational enclosure of `x_n=L*Delta*log n/(2pi)` of width <=1/4; midpoint; full integer `q_n=floor(mid+1/2)`; residue `k_n=q_n mod L`; actual-residual enclosure `r_n=J*(Delta*log n-2pi*q_n/L)`. Keep both full and reduced labels. |
| Moment input lines | For every `(h,m)`, a length-32 array enclosing the actual `A_(h,m,k)`. Each entry also has an exact dyadic complex center `ahat` and a fixed claimed Euclidean radius `2^-110` relative to A, except certified exact-zero entries may use zero. Require the computed enclosure to fit; the fixed claim provides room for independent containment. Record the complete finite partition into bins and accumulation order. |
| Transform output lines | For every `(h,m)`, the eight consumed normalized positive-transform output disks at labels `(-j) mod32`, computed from the **exact centers ahat**. Their dyadic centers and fixed claimed Euclidean radius `2^-110` enclose the exact normalized transform of those centers; certified exact zeros may use zero. Require computed containment rather than assuming the allowance. Record positive twiddle balls, bit-reversal convention and scale 1/2 at every butterfly. Unused internal FFT entries are not claimed outputs. |
| Contracted main jets | All 128 centers `Shat_(h,j)` with separated residual-Taylor, moment-input, transform-arithmetic and Horner/final-L errors. Record the actual output index `(-j) mod32` and exact `y_j=j/8`. |
| Correction data | Exact Bernoulli coefficients, B-phase base/step enclosures, all eight B-phase recurrence outputs and propagated errors; the degree-15 arrays R_j,Q_j,C_j; arithmetic radii for their retained coefficients. |
| Full g jets | All 128 final dyadic centers and proposed fixed coordinate halfwidth `2^-52`, with a checked containment of the entire producer-derived error enclosure. The scalar proof must support this allocation; it is not assumed from precision192. |
| Panel/endpoint outputs | Complete input geometry, polynomial evaluation enclosures, finite-g Taylor and actual EM errors as distinct fields, full denominator boxes and origin-exclusion checks, then zeta image boxes. Store all eight panels and nine endpoints, regardless of whether their images contain zero. |

There are 12,288 entries in the moment arrays and 3,072 consumed transform outputs. The complete length-32 FFT still runs internally; only its eight consumed labels are serialized as output claims. No packet needs to retain every elementary multiplication edge. Such a compact packet is a source-pinned recomputation experiment, **not a standalone proof trace**.

## Minimal deterministic execution order

1. Read and verify fixed inputs and all accepted pins; set precision before constructing any balls. Form exact Bernoulli numbers independently of any zeta oracle, for example by the finite rational recurrence, and verify the convention `B_2=1/6`. Produce pi/logs, N base phases and all bin witnesses. Stop on any unproved domain or witness.
2. Store `W_n=n^(-s0)`. For each h=0,...,15 allocate 24 length-32 zero moment lines. In increasing n order, use the residual recurrence `v_0=1`, `v_(m+1)=v_m*(-i*r_n)/(m+1)` and add `W_n*v_m` to its unique bin. After completing h, update `W_n <- W_n*(-log n)/(h+1)` if another row remains. All interval uncertainty is propagated; no rounded residual replaces its actual real meaning without an error allowance.
3. Freeze each line's exact dyadic centers and its actual-input radii. On those centers run the explicit bit-reversed, positive, normalized radix-two butterflies. Read both old operands before writing either output. A generic library FFT cannot replace this schedule without a proved/refereed convention adapter.
4. For each j, contract moment outputs in descending m by Horner at the exact dyadic `y_j=j/8`, then multiply by exact integer L. The input-uncertainty and FFT-arithmetic radii are added in the units below. Store the h row and release its working arrays. This h-streamed schedule retains only `pL=768` working moment entries in addition to shared inputs and outputs.
5. At each center form rising-factorial polynomials successively modulo `z^16`, accumulating odd lengths through 31. Form `Q_j=(s_j-1+z)R_j+B`; multiply by the degree-15 exponential series for `exp(-z log B)` to obtain C_j. This exact truncation preserves all retained coefficients; it does not supply the omitted Taylor remainder.
6. Produce `b_0=exp(-s0 log B)` and `w=exp(-i*Delta log B)` once. Use the declared recurrence for `b_j`, with its accumulated error, rather than treating a rounded w as an exact unit. Assemble `ghat_(h,j)=(s_j-1)*Shat_(h,j)+Shat_(h-1,j)+bhat_j*Chat_(h,j)`, with the h-1 term exactly zero at h=0. Check that each final claimed jet box contains the whole assembled enclosure.
7. Use **exact rational rectangular Horner** on the exported fixed coefficient boxes, with `z=i*[-1/16,1/16]` for each entire closed panel. Add the finite-g Taylor error and separately applicable actual-point EM error in the precise units below, then divide by the full `s-1` box. Unary real squares use their correct interval range; division requires a strictly positive squared-norm lower bound. Repeat at all nine endpoints using owner `o(l)=min(l,7)` and that owner's exact offset. Preserve every result. The coefficient boxes already include batching and finite arithmetic error; **do not add those coefficient errors again** during Horner. Both incident closed panels contain a shared endpoint, but no intersection of image boxes is required for the nine canonical endpoint outputs.

The author's proposed exact analytic fields are `outer_finite_g_bound=2^27`, `E_Taylor=2^-33/15`, and `E_EM=4*2003*33/(63/2)*(2034/(6*1025))^32`. E_Taylor bounds the omitted finite-g Taylor series; E_EM bounds the actual zetaF-minus-g error on the target segment. Both are added to **each coordinate before division** as safe square enclosures of norm errors. They are not already-quotiented zeta errors. The separately computed `2^-60` quotient contribution from coefficient uncertainty is a budget cross-check only, not another pad. The final scalar/source review must justify these constants and their actual-point versus outer-disk domains before execution.

The coefficient-square propagation used here is restricted to pure-imaginary offsets on the stated vertical panels and endpoints: each power of z is a real or imaginary scalar, so it preserves square axes up to sign/permutation. Do not apply that coordinate-halfwidth rule unchanged to arbitrary complex disk offsets. A disk extension must use the separately valid Euclidean norm bound and appropriate square conversion.

Each of the nine canonical endpoint images uses exactly the recorded owner `o(l)=min(l,7)`. At a shared internal endpoint it does not independently replay both incident endpoint evaluations, nor does it supply a common half-plane image vertex for a future polygon. Both incident whole-panel enclosures still cover their own closed endpoints. This evaluator-only pilot makes no polygon-join assertion.

The declared main work is 393,216 bin contributions and 384 length-32 transforms, with 30,720 butterflies; direct independent finite main sums use 131,072 normalized coefficient contributions. These are structural loop counts, not equal-cost operations or a timing estimate. This proposal does not invoke the production 256-million-contribution schedule.

## Input, transform and output errors

If `|A_k-ahat_k|<=epsilon_k`, the actual normalized transform differs from the exact transform of ahat by at most `(sum_k epsilon_k)/L`. If alpha bounds the FFT arithmetic relative to that center transform, a consumed normalized output has combined radius

`eta_(h,m,j)=(sum_k epsilon_(h,m,k))/L + alpha_(h,m,-j)`.

Consequently the main jet error is bounded by

`E_(h,j)=E_residualTaylor,h + L*sum_(m<p)y_j^m*eta_(h,m,j) + beta_(h,j)`.

Here beta includes Horner and final-L rounding. This separates input uncertainty from transform arithmetic; it neither drops the former nor charges it twice. If interval FFTs are instead run directly on uncertain A balls, their output radii already include source input error, and adding that source term again would double count it. The proposed schedule deliberately avoids that ambiguity.

With proposed Euclidean allocations `epsilon<=2^-110`, `alpha<=2^-110`, and `beta<=2^-100`, L=32 and p=24 imply the arithmetic part is at most `(5/2)*2^-100<2^-98`. This excludes residual Taylor error, EM corrections and final assembly. A box with each coordinate radius `2^-110` does not meet the stated Euclidean allocation; use the sum of coordinate errors or a checked squared-norm conversion. The proposed full-g box halfwidth `2^-52` similarly has norm radius up to `2^-51`, not `2^-52`.

For B phases, use `e_(j+1)<=(1+epsilon_w)e_j+B^(-sigma)*epsilon_w+nu_j`. For correction product `b_j*C_(h,j)`, use `e_j*|Chat_(h,j)|+B^(-sigma)*gamma_(h,j)+product_rounding`; the mixed term is already covered by this decomposition. Final g error includes `|s_j-1|E_(h,j)+E_(h-1,j)` plus correction and assembly errors. All such bounds must be checked before asserting containment in the proposed fixed output boxes.

The scalar ledger specifically requires **the complete correction block**, including multiplication by s_j-1 and the H term, to have radius at most `2^-80`; this is not an allowance on an unmultiplied correction coefficient alone. Final main/correction assembly and midpoint rounding have a separate `2^-80` allowance. Together with residual truncation they give actual full-g midpoint error `<2^25/24!+2002*2^-98+2*2^-80<2^-53`, with room inside the fixed coordinate-halfwidth `2^-52` squares. The final exact rational image schedule adds zero arithmetic rounding, which is within the scalar note's optional `2^-64` allowance; do not add that unused allowance as another analytic pad. Its `<2^-44` total quotient error bounds approximation error, not the width or variation of the actual panel image.

## Independent acceptance and meaning of PASS

The independent implementation must not import the producer's arithmetic or batching code. At its own precision it must bind the same exact N/M/K and sample grid, then:

* Recheck every bin witness and rebuild every actual bucket moment independently at 224 bits; require all 12,288 resulting boxes to be fully contained in the claimed moment disks, including exact-zero bins. For a disk, use a certified norm or the sum of maximal coordinate deviations from its exact center. A box intersecting the disk is insufficient.
* Independently evaluate the complete finite g jets by **direct main sums and finite correction products**, without bins or FFTs, at all eight centers. Each of its 128 rigorous coefficient boxes must be fully contained in the producer's claimed fixed box. Mere intersection or matching printed digits is insufficient.
* Independently compute the direct positive DFT of every stored rational moment-center line at its eight consumed labels, and verify full containment in the claimed normalized-output disks. This checks 384 lines times eight outputs, with 98,304 direct DFT terms. It certifies transform claims about the exact stored centers; the separately rebuilt actual moments certify the source-input claims.
* Recompute all eight whole-panel and nine endpoint images from the now independently verified fixed g-jet boxes by the declared **exact rational** Horner, padding and rectangle-division schedule. Require exact equality with the serialized rational output endpoints. If a later version rounds these images outward, it must instead prove full containment of this exact result. No comparison based only on overlapping images is accepted. The same already-certified coefficient boxes make this an independent reconstruction of the whole-image implication, not a claim based on independently sampled function values.
* Reject target changes, missing/duplicate n or j records, wrong full bin versus residue, wrong transform sign/normalization, factorial duplication, omitted correction or residual tail, zero-containing division, narrowed claimed g boxes and a falsely asserted complete status.

A successful first test means all required finite-expression and image enclosures pass at **external FLINT interval plus reviewed analytic-proof scope**. It need not mean any image excludes zero or admits a strict half-plane; those are separate optional observations and must not be required to hide a failed accuracy experiment. The interval library's exp/log/cis enclosures remain external trust, even though its payloads are exact dyadics. This is not the preceding rational-only xi certificate, a verified numerical library, a standard-axioms Lean checker or a new spectral theorem.

The generic finite batching proof, main input/FFT contracts and scalar ledger must have final independent reviews before execution. The support transform note is `integration/FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md`, SHA `170C8F976A8AF8B299E4AB737E6924260B3B1D8328FA54C0F2BF7F6E9720F997`, reviewed at `F2DC3A12F4474E8469D45C741E0F1A7FBA5A1CAF61AEF6A1509749FDE8BFD406`. The scalar author pin is given above; its exact script and receipt pins are `13E200EDFF99D2C44CFA19EEE8CC83C071488362E2DF3997D71E7A79BB65B59D` and `41FF7A626495159CCEB34C19ED6426F480DEB9759962784885120E8B4E76E931`. The new small-pilot specification/reviews are being finalized; their accepted pins must be inserted into the future run manifest, not guessed from the production note. This support note's pending-review wording is a historical freeze status, not permission to execute without those later gates.
