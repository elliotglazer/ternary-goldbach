# Independent review of the principal long outer rectangle

2026-11-11. **PASS as a paper/source design conditional on a complete new boundary certificate with winding zero.** No mathematical correction to the frozen author note is required. Existing horizontal evidence is reusable within its external-arithmetic scope. The long left edge, shared image vertices, complete winding computation and formal proofs remain unproduced. No values, models, transforms, scans, or Lean builds were run for this review.

## Frozen inputs

Paths are relative to `work/qrh-campaign/agents/` except the height-2000 receipt.

| Input | SHA256 |
|---|---|
| `mellin/PRINCIPAL_LONG_OUTER_RECTANGLE_2026-11-11.md` | `5B3F2776C576F9716693EBE0F814D7A5A694BDDAD8637CDE6E7D36CFD5AB59DC` |
| `moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md` | `814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818` |
| `zero-sum/EM_TOP_HORIZONTAL_2026-11-11.md` | `C8062D1BB197EF9A2FD8450BEAAF7E093B1448865751D0DB30623394C76F13BF` |
| `independent-feasibility/REVIEW_EM_TOP_HORIZONTAL_2026-11-11.md` | `6E2E1C0F3283F62CF68FCCC8E90AB67F5626288353E7B9A6921BCE695425CA4E` |
| `work/qrh-blueprint/principal-chunk-2000/em_top_2000.json` | `477BD15B17326BCE7333346491BA820C98DB2FE2B07DBDB7A0D11278CD2AE252` |
| `prime-estimates/REVIEW_TOP_COUNT_2000_2026-11-11.md` | `C3CA2ABA8EDA4CE9158CB4BD22203DFBEEE0CEC145A54FC8F0D630346B3FC89D` |
| `mellin/HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md` | `C9C4CD0156CA987D5200DA3F4AACCF3C8F1B64BD0FEADCC3F6F12F5F10ED9ED5` |
| `independent-feasibility/REVIEW_PRINCIPAL_SIGNS_2000_CHUNK_2026-11-11.md` | `8EC2B71F288EFF6B2C4ABE01362E8A467C23D22BA1648B62EAABE89EC7F016E8` |
| `moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md` | `0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491` |

All table hashes were checked locally. I read these source arguments and relevant existing reviews, the height-2000 producer's whole-block image routine, and the actual Lean interfaces below. Frozen files were not changed. No earlier numerical run was repeated.

## Horizontal reuse and the right side

Both saved horizontal certificates cover all six closed quarter-unit blocks from real part 1/2 to 2. Their independent reviews establish whole-block positive real parts for actual zeta, not merely endpoint positivity or an integer count. At height 2000, the producer's `image(lo,hi)` evaluates the finite entire-g jet on the entire real offset interval, adds both the finite-g Taylor and actual-point EM errors, then divides the complete box by s-1. Its whole-block positivity assertion precedes endpoint processing. The independent review separately recomputed all six complete blocks with different parameters.

Consequently restriction of the first block to `[629/1250,3/4]` is valid at both heights. No new analytic estimate is needed for that restriction. This does not manufacture a stored endpoint image at 629/1250: the old endpoint at 1/2 is different. Any chosen rational image vertex at the clipped corner must satisfy both incident panel half-planes. Overlap of endpoint boxes alone is not this vertex certificate.

The stored coefficients are for the finite entire approximation to zetaF. They are not Taylor coefficients of zeta. Reuse must retain the errors before the full denominator division; the note correctly preserves that distinction.

For every real t, absolute convergence at real part 2 gives `Re zeta(2+it)>=2-zeta(2)>1/4`. This supplies one analytic right panel of arbitrary finite length. The source series is available as `zeta_eq_tsum_one_div_nat_add_one_cpow` in pinned Mathlib `NumberTheory/LSeries/RiemannZeta.lean:214`. The bound is uniform, and requires no sampled right-edge values. Compatible rational vertices at its two ends remain part of the closed polygon.

## Geometry, batching and winding

The proposed rectangle is `Q=[629/1250,2]+i[2000,1000000]`. Its counterclockwise traversal matches `RectResidue.rectInt`: bottom rightwards, right upwards, top leftwards, left downwards.

For m=8*(1000000-2000)=7984000, panel j with center `629/1250+i*(1000000-1/16-j/8)` and half-length 1/16 covers exactly `[1000000-(j+1)/8,1000000-j/8]`. The first endpoint is 1000000 and the last is 2000. There are no gaps in this proposed geometry. This is not evidence that any panel passes a numerical test.

The frozen batching identity permits signed Delta=-1/8. Each finite batch must use its own actual first center, J, transform length and error parameters. Its accepted finite transform reindexing and algebra remain paper results: no input moments, transforms or model arrays are supplied by this note. All residual, moment, transform, contraction, B-phase, correction, coefficient and final model errors remain necessary. The actual-point EM domain is distinct from the outer disk used to bound finite entire g.

A single outer boundary needs no internal horizontal crossbars. Computational batch boundaries only subdivide the left side. They still require exact shared rational image vertices and compatible incident half-planes. The generic polygon proof uses one identical vertex at every join, including the closing join, and the actual function image and both surrogate endpoints in each panel's strict rotated half-plane. A list of zero-free samples or arbitrary overlapping boxes cannot replace those requirements.

After all these conditions, the exact signed crossing sum must be computed and equal zero. Boundary nonvanishing alone does not imply this. Neither the top total count nor N(1000000)-N(2000) determines the winding of this right-hand rectangle.

The edge counts are correct: m+13=7984013 initial outer edges, comprising m left edges, six bottom, six top and one right. A stacked closed-slab construction with shared crossbars would use 6(m+1)=47904006 distinct horizontal blocks; this outer design uses twelve. The batching costs NKp, KpL*log2(L)/2 and JK(p-1) match the pinned schedule's units, with the remaining correction and elementary work still added. These counts establish no runtime ratio, memory feasibility or success probability.

## Local zeta and the source entire-function theorem

The target source is `work/ternary-goldbach` at the campaign pin. Directly inspected files are:

| Source | SHA256 |
|---|---|
| `Explicit/ZetaGrowth.lean` | `ED2158522FECDF70720AF464B28DE6E101666A3ED6AB7568729A5A8EA591E9E4` |
| `Explicit/RectResidue.lean` | `6B9C3236C2B4470AA37D3948DAB163573A1A7AFDDE8E963EF127F815EB0B88CF` |
| `Explicit/WeilBridge.lean` | `285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E` |

`ZetaGrowth.zetaF` is `(s-1)*riemannZeta(s)` updated to value 1 at s=1. `zetaF_of_ne` and `differentiable_zetaF` give the product identity away from 1 and global entirety. Actual zeta is holomorphic on a neighborhood of Q, which is wholly above the real axis.

The polygon/log proof only needs local holomorphy along these panels. Its local form yields the zeta logarithmic-derivative integral from the half-planes and shared vertices. On the boundary, product differentiation gives

`zetaF'/zetaF = zeta'/zeta + 1/(s-1)`.

The principal log of s-1 is holomorphic throughout the upper half-plane. Its derivative integrates to zero around Q by sidewise FTC and exact endpoint cancellation. Therefore the same winding integer applies to entire zetaF. No pole term is lost; the pole is outside Q. These local adapter lemmas are paper obligations, not claims of already compiled APIs.

`RectResidue.rectInt_logDeriv_mul:391` explicitly requires global `Differentiable`, a nonzero center value, positive R, strict half-radius inclusion, and `NoZerosOnSides`. Applying it directly to globally non-entire zeta would be invalid. The note instead takes zetaF, constant h=1 and open set all of C. The center c=2+501000i is nonzero by the right-line bound and c!=1. Every point of Q satisfies

`norm(s-c)<=499000+1871/1250=499001.4968<500000=R/2`

for R=1000000. Thus the strict source ball hypothesis holds. No value on the large circle is required.

Source `Landau.factor_ball` uses the nonzero center to exclude infinite analytic order throughout C and obtains a nonnegative analytic divisor. Its `zerosIn` carrier is the divisor support restricted to the half-radius ball. Every interior zero of Q belongs to that carrier and has positive finite order. The residue sum therefore cannot cancel positive and negative multiplicities. Winding zero excludes all interior zeros, and the panel tests separately exclude the boundary.

## Closed join, real axis and reflection

The low-height result must include more than positive-ordinate sign changes. The exact missing-looking case gamma=0 is already supplied by the accepted head certificate: `moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md` certifies the complete real bottom `[-.1,1.1]+0i` as nonzero for zetaF. Its full replay includes that bottom; its separate alternate Taylor calculation also includes every bottom block. On 0<beta<1, division by beta-1 transfers this to actual zeta. No real-axis exclusion is inferred from conjugation. The same review's zero count at 14 and boundary nonvanishing cover the remaining low positive ordinates. The subsequent sign/count reviews consume these facts.

The 449-point chunk establishes 448 distinct critical-line zeros between nonzero endpoints 1500 and 2000. The complete multiplicity-count difference 1517-1069=448 gives saturation and simplicity. Joined with the head result and conjugation, this supplies the reviewed external conclusion through inclusive absolute height 2000, including the real-axis case just identified.

For the new high rectangle, the carrier must be nontrivial zeros with `0<beta<1`; no statement about trivial negative-real zeros is intended. For a zero with 2000<=gamma<=1000000, beta>=629/1250 would place it inside closed Q, contradicting successful exclusion. Reflection and conjugation produce the opposite inequality beta>1-629/1250=.4968. Source `Xi.xiF_one_sub`, `xiF_eq_zero_iff`, `xiF_ne_zero_of_one_le_re` and `xiF_ne_zero_of_re_nonpos` supply the relevant source carrier/reflection route; conjugation must preserve the actual zero and its order in the formal adapter. Both H=2000 and T=1000000 are included by closed boundary geometry.

`WeilBridge.multRectD_eq_mult:87` requires both strict ordinate inequalities and 1<=T' for its second carrier. Choose both auxiliary carrier heights strictly above 1000000 when transporting multiplicities. This does not weaken the closed spectral conclusion.

## Final disposition

The route correctly removes internal crossbars while preserving one complete boundary and one exact winding obligation. It preserves the narrow principal target through one million and makes no claim about height60343058 or other characters. A zero on beta=.5032 would obstruct this stricter boundary strategy even though the requested closed strip permits it. Unknown margins, unresolved panel certificates, incompatible vertices, or nonzero winding remain genuine failures of this proposed exclusion. The frozen note states these limitations accurately.
