# Eight-center finite EM batching pilot near height 2000

2026-11-11. **Proposed external pilot; no implementation or evaluation authorized by this note.** Independent review must precede any run. The purpose is to test the complete accepted batching construction on a small, already-covered region, not to extend spectral coverage or benchmark production speed.

## Fixed target and every requested output

Use the actual entire finite expression g from `moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md`, SHA256 `814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818`. Its independent review is `independent-feasibility/REVIEW_FINITE_EM_VERTICAL_BATCHING_2026-11-11.md`, SHA256 `B8EE7250B9E2AAEE8099A7109C08FF34FBD70E880182E99E2B3F30970C49717E`.

| Parameter | Fixed value |
|---|---:|
| sigma | 629/1250 |
| t0 | 2000-1/16 |
| Delta | -1/8 |
| J, L | 8, 32 |
| N, B=N+1 | 1024, 1025 |
| EM corrections M | 16 |
| Retained normalized jet length K | 16, orders 0 through 15 |
| Residual exponential length p | 24, orders 0 through 23 |
| Finite-g outer radius | 1 |
| Actual panel half-length rho | 1/16 |
| Proposed producer / independent precision | 192 / 224 bits |

The eight exact centers are `s_j=sigma+i*(2000-1/16-j/8)` for j=0,...,7. Panel j is the downward closed vertical segment from `sigma+i*(2000-j/8)` to `sigma+i*(2000-(j+1)/8)`. Their union is precisely the line segment at Re=sigma with imaginary part in [1999,2000]. No closed contour is requested.

Required outputs are all 128 normalized coefficients of this same finite g; all eight whole-panel images of actual zeta; and all nine distinct endpoint images at `e_r=sigma+i*(2000-r/8)`, r=0,...,8. Endpoint r uses the deterministic owner `min(r,7)`. The full panel enclosures already include both incident endpoints. There is no arbitrary choice of a sample favorable to a sign test. Every retained coefficient is consumed in its center's degree-15 whole-panel polynomial, not just the scalar coefficient.

These are normalized derivatives with respect to the complex variable s, not height derivatives. The factor i for a vertical displacement belongs in the panel offset z. The time-grid coordinate y_j=j/8 is a different variable used only to reconstruct a center's coefficients.

The reviewed principal certificate through height 2000 already covers this domain at the external-computation/paper-analysis level: `independent-feasibility/REVIEW_PRINCIPAL_SIGNS_2000_CHUNK_2026-11-11.md`, SHA `8EC2B71F288EFF6B2C4ABE01362E8A467C23D22BA1648B62EAABE89EC7F016E8`. That result is **not** used to justify any evaluator enclosure or to assume a favorable panel margin.

## Main-sum batches and exact input meaning

Use the frozen midpoint-bin rule with full signed integer q_n, residue k_n=q_n mod 32, residual `r_n=8*(Delta*log n-2*pi*q_n/32)`, and y_j=j/8. Retain the actual logarithm/pi enclosures proving each midpoint error at most 1/8. The rule implies |r_n|<55/56. Negative q_n and wrapped residues must be tested explicitly; an implementation that substitutes k_n for q_n in the residual is wrong. The coarse log bound log(1024)<7 and pi>3 imply q_n is in {-5,...,0}; nevertheless every n=1,...,1024 must have its own checked assignment. No term is removed as a presumed negligible contribution.

For every h<16, m<24, k<32, form the actual moment

`A_hmk=sum_(n:k_n=k) n^(-s0)*(-log n)^h/h!* (-i*r_n)^m/m!`.

Export a rational dyadic complex center for each moment with a certified fixed Euclidean radius 2^-110. Include finite summation and all input errors. Exact empty bins may instead be recorded as zero with radius zero. Apply the accepted normalized positive radix-two transform **to these exact centers**. Its error relative to the exact transform of these centers must be at most 2^-110 per consumed output; serialize a fixed 2^-110 arithmetic disk around that output's dyadic center. Do not run the FFT on uncertain moment balls and then misidentify the resulting width as arithmetic error alone.

Only the eight labels (-j mod 32) are consumed for each (h,m), giving 3072 normalized transform output records. The other 24 labels exist internally in the transform but are not requested function values. Recover each main-sum jet as `32*sum_(m<24)(j/8)^m*P_32(A_hm)_(-j mod32)`. The final scale is exactly 32. Horner/contraction plus that scaling must have additional absolute rounding at most 2^-100. The exact factor j/8 is dyadic.

Moment uncertainty and normalized-transform arithmetic then contribute at most `2*32*24*2^-110`; including contraction gives `(5/2)*2^-100<2^-98` per main-sum jet. Coordinate boxes must be converted to the claimed norm radii with an explicit bound; there is no uncharged square-root-of-two factor.

## Complete g corrections and exported coefficient boxes

The finite g remains

`g(s)=(s-1)*D(s)+B^(-s)*((s-1)*R(s)+B)`,

where D sums all n<=1024, and R includes the half term and all 16 Bernoulli corrections. Compute each center's complete correction block by the finite polynomial formula in the frozen batching note. Its error per retained g coefficient, including B base/step phases, geometric recurrence, all polynomial products, the B^(1-s) pole-cancellation term and rounding, must be at most 2^-80. The error of final main/correction assembly and rounding to its exported dyadic midpoint is separately at most 2^-80. No term is covered merely by stating that the main Fourier sum is accurate.

The residual Taylor truncation has a bound for **every** jet, not just h=0. The scalar support gives `W_h=sum_(n<=1024)n^(-sigma)*(log n)^h/h!<2^14` for all h<16. Since |s_j-1|+1<2002, multiplication by s-1 and the previous-jet term give full-g truncation less than `2^25/24!<2^-54`. Thus the complete finite-g coefficient error is less than

`2^-54 + 2002*2^-98 + 2*2^-80 < 2^-53`.

Export each full g coefficient as the rectangle with coordinate half-width exactly 2^-52 about its dyadic midpoint. The extra room is intentional: the independent replay must prove full containment of its direct finite-g coefficient enclosure in this exported box. This is stronger than an overlap test. It is not a claim that g coefficients equal actual zeta or zetaF derivatives; g is the exact finite entire expression.

## Whole-panel semantics and error budgets

For the fixed parameters, finite-g outer disks have real floor at least -1/2 and modulus at most 2003. Actual panel points have real part sigma>1/2 and imaginary part between 1999 and 2000. The outer bound is for finite g only; actual EM is used only on those actual points.

Use a rational outer bound `Mout=2^27` and Cauchy tail

`E_Taylor=2^27*(1/16)^16/(1-1/16)=2^-33/15`.

An allowed rational actual zetaF EM bound is

`E_EM=4*2003*33/(63/2)*(2034/(6*1025))^32`.

The full denominator has |s-1|>=1999>1024. The weighted coordinate-box coefficient allowance, converted with sqrt(2)<3/2, is bounded after division by `(3/2)*(16/15)*2^-52/1024<2^-60`. The separately proved EM and finite-g Taylor errors are larger; they must not be replaced by that batching-only estimate.

Reconstruct each whole image using **exact rational rectangular interval arithmetic**: Horner-evaluate the exported coefficient boxes on z=i*[-1/16,1/16], add E_EM+E_Taylor to each coordinate radius, then divide by the whole nonzero s-1 rectangle. The coefficient uncertainty is already in Horner; do not add it a second time. Endpoint images use the corresponding exact singleton offset and owner model. No elementary transcendental function is needed in this final image reconstruction.

Specify the rectangular complex operations, squaring interval rule, and reciprocal formula before implementation. A safe reciprocal is `(x-i*y)/(x^2+y^2)` with a proved positive lower bound for the interval denominator; independent dependency widening is harmless. Store exact rational image endpoints. The independent replay repeats these same finite rational operations and requires exact equality. If a later implementation instead rounds final boxes outward, it must require full containment of the independent exact-rational reconstruction, not mere overlap. This pilot fixes the exact-rational option.

The complete exact scalar support is `major-constants/EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md`, corrected SHA256 `47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23`. Its exact script is `13E200EDFF99D2C44CFA19EEE8CC83C071488362E2DF3997D71E7A79BB65B59D`, receipt `41FF7A626495159CCEB34C19ED6426F480DEB9759962784885120E8B4E76E931`. It verifies all domains, the sixteen Bernoulli bounds, the all-jet and arithmetic inequalities, and

`(3/2)*[2^-38+2^-33/15+(16/15)*2^-52]/2^10+2^-64 <2^-44`.

Our exact-rational image reconstruction uses no final arithmetic rounding, so the optional 2^-64 allowance is unused and is not another pad. The coordinate-square polynomial bound applies directly to the actual purely imaginary offsets, whose powers only permute/sign the coordinate axes. For arbitrary complex offsets the same final norm estimate follows by a Euclidean triangle inequality, not by asserting that a rotated square preserves its coordinate radius. A bound for total approximation error concerns the distance from the center polynomial to the actual function; it is not a bound for the width or nonvanishing of a full interval image, whose polynomial range can legitimately be large.

## Independent replay and acceptance

The detailed serialized-value and deterministic schedule contract is `integration/SMALL_EM_BATCH_RECEIPT_CONTRACT_2026-11-11.md`, SHA256 `DA2740C39148A2F1AB2291E6581B5C55A75BF33456E8006CB148B34B516178AF`. Elementary/FFT interval payloads use lossless exact dyadic midpoint/radius fields; exact-rational parameters, analytic pads and final image endpoints use integer numerator and positive denominator fields. The latter are not forced into dyadic encoding. The producer and independent implementation must bind this exact contract together with this specification and the corrected scalar support.

The independent program must not import or execute the producer. Use 224-bit elementary interval arithmetic and separately coded finite expressions, with no builtin zeta, Hurwitz zeta, Gamma, theta, Riemann–Siegel or zero oracle.

1. Recheck the exact parameters, all 1024 bin witnesses and complete assignment. Independently rebuild the actual bucket moments and prove their enclosures are contained in the producer's moment disks. Labels are frozen by the rational witness rule, not reselected to make outputs agree.
2. For every consumed (h,m,j), directly sum the 32-term normalized positive DFT of the stored **rational moment centers**, without radix-two butterflies. Its independently proved enclosure must be contained in the producer's arithmetic-output disk. This checks the FFT arithmetic separately from correctness of the actual moments.
3. Independently evaluate all 128 normalized finite-g coefficients by direct main sums at all eight centers, using manual exponential coefficient recurrence and the full finite corrections. This path uses neither bins nor FFTs. Prove every direct coefficient rectangle is wholly contained in its exported producer rectangle. Actual finite g is identified by the displayed analytic finite formula; similarity or overlap of outputs is not the proof of either enclosure.
4. Reconstruct all eight whole-panel images and nine canonical endpoint images by the fixed exact-rational interval operations above. Check exact equality, all denominator lower bounds, the exact downward mesh, closed endpoints and no omitted interval.

PASS means every one of these checks and every arithmetic budget succeeds. No nonvanishing test is required for this evaluator-only pilot. A whole-panel image containing zero must be reported honestly and does not invalidate a sound enclosure. Optional signed-coordinate margins may be recorded, but cannot be substituted for any enclosure check or presented as new closed-contour coverage. There is no polygon or winding result in this specification.

## Bounded work, storage and stop rules

The producer has 1024 main baseline exponentials, two B base/step exponentials, 393216 moment contributions, 376832 residual recurrence steps, 15360 main log-weight updates, 384 length-32 transforms and 30720 butterflies. The output Horner stage has 2944 steps and 128 final L scalings. Complete correction and final assembly have the frozen dense upper bounds of 7488 multiplications and 7488 additions, plus seven B-phase recurrence products, 15 common log-B exponential-coefficient updates, 16 exact Bernoulli/power weights and all bin/logarithm preparation.

The h-streamed moment workspace is only 24*32=768 complex slots; the declared main complex-slot bound is `1024+768+2*8*16+8+2*16=2088`, plus twiddles, input interval/witness records and output serialization. This is not a byte or runtime estimate. The complete moment input has 12288 indexed entries including exact zero bins; only 3072 transform outputs are externally consumed.

Independent bucket rebuilding has the same 393216 contribution count. Direct DFT verification of the consumed labels has 98304 terms. Direct finite-g main coefficient construction has 8*1024*16=131072 contributions and 8192 main phases, with separately counted finite corrections. These counts are small fixed checks, not an assertion that Python or any interval implementation will finish within a chosen time.

Before any run, freeze the producer, independent program, exact elementary-arithmetic semantics, source/support pins and output schema; obtain the coordinator's authorization. Proposed caps are one producer attempt of 180 seconds and one independent attempt of 360 seconds, each with 512 MiB peak working-set for the single evaluator process and a 64 MiB receipt limit. No subprocess evaluator or delegated work is permitted; an external supervisor is not part of this process measurement. The implementation must document OS peak-working-set telemetry and guard points, include serialization in elapsed time, and reject complete PASS on an observed cap overshoot or inadequate telemetry. These are measured stop/acceptance rules, not a hard OS resource guarantee or demonstrated feasibility. The coordinator may terminate an unresponsive attempt externally.

No automatic precision increase, replacement center, parameter change, mesh refinement, omitted failed output or repeated attempt is permitted under these caps. On a limit, inadequate enclosure, containment failure or parameter mismatch, save a bounded incomplete/failure record.

This small J intentionally does not amortize every moment operation: 393216 moment contributions exceed the 131072 separate-center coefficient contributions. It exercises the batching identity and complete error pipeline at bounded cost; it is not a speed demonstration. Any larger-block or high-height proposal must separately justify resource use and actual panel margins.
