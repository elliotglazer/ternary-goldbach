# Rational acceptance for the finite-EM batching pilot

2026-11-11. Paper blueprint only. This note creates no Lean declaration, anchor, checker implementation, certificate, or new numerical evaluation. It specifies how to replace FLINT as an acceptance dependency for a bounded actual-function result. Existing external success does not discharge any of the Lean obligations below.

## 1. One first result, with the full target retained

The first end-to-end slice is the **last complete panel**, j=7, of the completed experiment. Fix independently of certificate fields

`sigma=629/1250, s0=sigma+i*31999/16, Delta=-1/8, s7=sigma+i*31985/16`;

`N=1024, B=1025, M=16, K=16, p=24, J=8, L=32, rho=1/16`.

The required conclusion is that the actual `riemannZeta(sigma+i*t)` lies in the specified rational panel rectangle for **every** t in the closed interval `[1999,15993/8]`. Also prove its membership in the two specified singleton endpoint images at t=15993/8 and t=1999. These are existing candidate panel 7 and canonical endpoints 7 and 8, both owned by model 7. The center is 1999.0625, not 1999 or the first center. This choice exercises y=7/8, the negative-time transform label 25, all residual powers and the seven B-phase recurrence steps. It avoids making a degenerate j=0 calculation stand for the batching construction.

All sixteen normalized finite-g coefficients at s7 are required. Proving only h=0, a midpoint value, a finite polynomial identity, or a conditional enclosure with unproved elementary inputs does not complete this slice. The result is an enclosure, not nonvanishing: a sound rectangle may contain zero.

This is a preflight for the complete completed-pilot statement: all 128 coefficients, all eight closed panel images and all nine canonical endpoint images. It does not replace that objective. The extension uses j=0,...,7 with the same generic proof; all missing finite acceptance instances must actually be supplied. Endpoint r has owner min(r,7), and the union of the panels is exactly `[1999,2000]`. These are evaluator statements, not a closed contour or a polygon-seam theorem.

## 2. Exact analytic objects

Every positive-base power below means `exp(-s*(Real.log n : Complex))`; its equality with the source complex power is a theorem using n>0. Define the mathematical expressions in prose as follows, not as new approved Lean definitions:

```
D(s) = sum(n=1..1024) exp(-s*log n)
R(s) = 1/2 + sum(k=1..16) B_(2k)/(2k)! * B^(1-2k) * (s)_(2k-1)
g(s) = (s-1)*D(s) + exp(-s*log B)*((s-1)*R(s)+B)
G(h,j) = iteratedDeriv h g s_j / h!,   s_j=s0+i*j*Delta.
```

Here ordinary Bernoulli numbers have B_1=-1/2, `(s)_r=product(v=0..r-1)(s+v)`, and the empty product is one. The last correction has rising length 31, whereas the EM remainder has length 32. The half term is multiplied by s-1; the pole-cancellation term `B^(1-s)` is not multiplied by s-1 again. Every G is a derivative in complex s, not in height t. The local vertical variable is z=i*(t-Im(s_j)), so Horner uses the coefficients as stored, without another h! or i^h factor.

These objects are entire finite expressions. Their source relationship is to `TernaryGoldbach.Explicit.zetaF`, which equals `(s-1)*riemannZeta s` away from 1. Neither an arbitrary analytic function with asserted coefficient values nor a user-supplied g may replace this expression.

## 3. What the old packet can supply

The completed producer and independent evaluator share FLINT elementary functions. Their accepted saved-data review establishes exact containment among saved boxes, full coefficient/image coverage and provenance, not a rational proof that log or exp lies in any box. The full internal diagnostic balls are not a complete formally verified operation trace.

Use the old packet as **untrusted proposed targets and scheduling data**: exact dyadic moment centers, fixed radii, signed bin integers, consumed transform centers, the sixteen coefficient squares, and rational final images. Supply NEW rational witnesses for the actual elementary values and arithmetic needed to justify those claims. The new internal boxes may be wider, narrower or organized differently from old FLINT diagnostic boxes. They must prove the chosen consumed outputs; overlap with an old box is never enough.

There are two distinct proof constructions:

| Construction | Closed claim it establishes | Additional obligation it does not establish |
|---|---|---|
| Batch certificate | Actual moment disks, exact-center transform disks, their error-composed finite-g boxes, then actual-zeta images | Arbitrary internal FLINT R/Q/C or elementary boxes unless separately certified |
| Direct-g certificate | Actual G(h,j) in the same fixed coefficient squares, then the same actual-zeta images | Old bin, moment, FFT or residual-error claims |

Both are legitimate. A direct-g proof may avoid every FFT claim because those records are not hypotheses of the actual-function theorem. It must not be described as validating the batching computation. The first batch slice is specified below so its exact obligations remain visible; choose between the two implementation constructions only with proof-representation evidence, not an alleged runtime advantage. The separate cost comparison and elementary precision allocation are research tasks in progress when this note is written.

Do not demand that a new rational calculation reproduce or fit every narrow FLINT intermediate. Conversely, if someone elects to certify those old internal balls, each needs a proved semantic interpretation and full-input containment or an explicitly proved correlated-expression rule. Point agreement, intended operand identity, hash equality and final overlap do not supply those proofs.

## 4. Typed finite data and graph semantics

Use a finite, typed, earlier-reference graph with a fixed expression template. Types needed here are exact rational scalar, real closed interval, complex closed rectangle, complex norm disk, and length-indexed finite arrays. A stored dyadic means exactly m*2^e. For this bounded packet a checked conversion to rational endpoints is permissible after exponent/size guards; it is not a solution for the huge-exponent historical theta receipts.

Every interval has ordered endpoints, positive rational denominators and nonnegative radius. Quotient witnesses reject zero or sign-crossing denominator intervals. Exact integer/rational operations are checked by ordinary kernel reduction or explicit arithmetic proofs. Directed rounding may be expressed as rational endpoint inequalities, so no trusted floating-point rounding routine is required. A square crossing zero uses the unary square range, not an independently multiplied interval lower bound. Complex multiplication follows its coordinate identities; the final reciprocal uses `(x-i*y)/(x^2+y^2)` with a certified positive norm-square lower endpoint. This EM slice needs no complex square root or modular-root branch checker.

Each node records its operation tag, operand indices/types, proposed rational enclosure and finite witness data. References must be earlier; every referenced value has a unique expression meaning. Allowed analytic leaf tags are only the following certified operations: real log of a positive bound input, real exp, sin/cos with certified pi reduction, and complex exp obtained by their proved identity. Pi itself is certified from fixed Machin arguments. No tag means “FLINT said so”, “given analytic ball”, or “accepted numerical value”.

Sharing means several nodes refer to the same already-proved input value or lemma. It does not mean arithmetic may silently reuse a ball for a different log, center, sign, exponent or branch. A pure arithmetic soundness lemma may quantify over assignments satisfying leaf enclosures; the final closed theorem must discharge all those enclosures with elementary-function soundness and finite acceptance.

The trusted semantic input is an independently fixed literal target record: parameters above, selected j=7, exact final coefficient/image endpoints and the required index sets. An untrusted converter can import the old JSON into typed Lean data. The theorem is about that typed value and the fixed mathematical input, not automatically about file bytes. If byte-level identity is required, add a verified decoding theorem; a SHA string is not a semantic proof. Review the literal target data separately so a converter cannot replace the intended narrow boxes with easier claims without detection.

## 5. Elementary leaves, all with actual-function meaning

**Log.** For n=1 certify exact zero symbolically. For each n=2,...,1024 and B=1025, supply an exact positive-base reduction `n=2^k*u`, `1<=u<=2`, and finite atanh sums for log(u) and shared log(2). With v=(u-1)/(u+1), the lower sum is `2*sum(a<q) v^(2a+1)/(2a+1)` and the upper pad is `2*v^(2q+1)/((2q+1)*(1-v^2))`. Source `RamPf.log_one_add_inv_bounds` gives this after the stated substitution; log(u)=0 at u=1 is a separate exact case. Verify every denominator and all finite sums. For a varying positive interval, certify both endpoints and invoke monotonicity. No complex log is used.

**Pi and trigonometry.** Use Machin's identity and alternating arctangent bounds at 1/5 and 1/239. A cis certificate supplies an integer period reduction but proves the entire reduced input interval lies in a rational bounded interval, including the uncertainty of pi multiplied by that integer. Finite complex Taylor polynomials on i*y, plus `Complex.exp_bound'`, give sin/cos coordinate bounds. Do not assume monotonicity or choose a phase from proximity to a root of unity.

**Exp.** Reduced real endpoint inputs use finite Taylor sums, proved tail bounds, checked squaring and positive reciprocal operations. Complex exp uses `exp(x+i*y)=exp(x)*(cos y+i*sin y)`. An alternative proved small-complex-argument Taylor/squaring implementation is admissible, but has a separate error schedule; it is not a new oracle. Finite Taylor lengths, range-reduction integers and dyadic rounding witnesses are data, not trusted search decisions.

These shared leaves enclose all `log n`, `log B`, `exp(-s0 log n)`, positive FFT twiddles, and the B base/step phases. Actual source input intervals can be handled universally, even if correlated; independently widening them is safe but can fail the desired output precision. Correlation-aware improvements need a proved expression rule. Exact empty bins, n=1 factors and any claimed zero-radius output require exact algebraic zero proofs; shrinking a transcendental interval to zero is not allowed.

## 6. Batch layer and its exact error accounting

For each n retain the **full** signed q_n and k_n=q_n mod32. Certify a rational xhat within1/8 of `x_n=32*Delta*log n/(2*pi)` and check the rational floor relation `q_n=floor(xhat+1/2)`. This gives a label without deciding an exact half-integer tie. The residual is `r_n=8*(Delta*log n-2*pi*q_n/32)` and must satisfy the proved bound `abs r_n<55/56`. Substituting k_n for q_n inside r_n is forbidden. Prove that all n=1,...,1024 occur once and empty bins contribute zero.

For h<16,m<24,k<32 the actual coefficient is

`A(h,m,k)=sum(n:k_n=k) exp(-s0 log n)*(-log n)^h/h! * (-i*r_n)^m/m!`.

Fresh rational witnesses must put this actual A in the old proposed disk of radius2^-110, or prove exact zero where zero radius was claimed. Every finite addition and input uncertainty is included. This requires all12,288 moment claims even for the single selected j. It is the main shared setup cost, not sixteen isolated scalar checks.

On exact stored moment centers, the normalized positive transform is

`P32(a)[ell]=(1/32)*sum(k<32) a[k]*exp(2*pi*i*k*ell/32)`.

Either certify its required labels by direct finite sums or prove the five-stage bit-reversed radix-two schedule with simultaneous `(u+w*v)/2,(u-w*v)/2` butterflies and exact positive twiddle meaning. The graph may use rational interval rounding at each stage with checked enclosures. The first slice consumes only ell=25, one per(h,m), hence384 transform-output disks. The full pilot consumes3,072. A proof of the selected label does not claim all other internal outputs. The finite transform identity is distinct from the error theorem for its rounded implementation.

Recover at y=7/8 the main jet approximation `32*sum(m<24) y^m*P32(A(h,m,*))[25]`. Its exact sign and scale follow from the new finite-bin exponential identity, not merely from the character-DFT API. Source coefficients have h! and residual moments m! once each.

For proposed moment norm errors epsilon, exact-center normalized transform errors alpha, and contraction rounding beta, the arithmetic bound is

`sum_m y^m*sum_k epsilon(h,m,k) + 32*sum_m y^m*alpha(h,m,7) + beta`.

There is **no extra32 on the first term**. With the fixed2^-110 disks and beta<=2^-100, this is below2^-98. To certify a rectangle inside a norm disk, use a checked L1 or squared-distance bound; equal coordinate radii do not by themselves imply that same Euclidean radius.

The analytic residual tail must use the real-argument estimate

`norm(exp(-i*theta)-sum(m<24)(-i*theta)^m/m!) <= abs(theta)^24/24!`.

Prove it by the real integral Taylor remainder, including theta=0 and negative theta. The derivative has unit modulus on the whole real segment. A generic complex Taylor bound with an extra2 or exp(abs theta) cannot be substituted without changing the ledger. The weighted bound is `64*7^h/(h!*24!)`, using the separately proved all-index sum estimate, and is below `2^14/24!`. This is an error between the batch approximation and the actual normalized derivative of the finite Dirichlet polynomial, not an EM error.

## 7. Full correction and normalized derivatives

Certify the rational Bernoulli recurrence against source Bernoulli numbers, retaining signs. At s_j build the truncated polynomial for `(s_j+z)_r` by the old-array recurrence `P_(r+1)[h]=(s_j+r)P_r[h]+P_r[h-1]`. An omitted negative-index coefficient is zero. Only lengths1,3,...,31 enter R. Truncation above degree15 cannot affect lower coefficients, by finite convolution.

Let `R_j(z)=1/2+sum_k b_k*B^(1-2k)*(s_j+z)_(2k-1)` and `Q_j(z)=(s_j-1+z)*R_j(z)+B`. The correction coefficients are those of

`exp(-s_j log B)*exp(-z log B)*Q_j(z)`.

One allowed schedule uses a certified base `exp(-s0 log B)` and step `exp(-i*Delta*log B)`, then seven checked products. Another directly certifies `exp(-s7 log B)`. Either must establish the same exact phase, without an asserted library value. Each exponential coefficient is `(-log B)^h/h!`; finite convolution supplies C_h. The complete correction error includes phase error, every polynomial/input uncertainty and final product rounding, and must satisfy the selected bound2^-80 if using the old batching ledger.

Assemble `G(h,j)=(s_j-1)*D_h(j)+D_(h-1)(j)+correction_h(j)`, where D_h here is the actual main Dirichlet jet and D_-1=0. Charge final assembly/midpoint error separately, at most2^-80. The accepted scalar ledger proves a total midpoint error below2^-53. The published coefficient claim is a coordinate square of halfwidth exactly2^-52. A fresh rational calculation can prove full containment in that square directly, rather than replay the exact old internal errors; it still must include every term of the displayed source expression.

Prove these finite coefficient recurrences equal `iteratedDeriv h g s_j / h!` for all retained indices. The ordinary product Leibniz identity, factorial cancellation and the affine exponential derivative suffice. Alternatively prove the absolutely convergent scalar power series and its coefficient identity. A finite array tagged “jet” is not itself a derivative theorem.

## 8. From finite g to actual zeta on the closed panel

Three analytic bridges remain to be implemented and proved, even after all elementary certificates accept:

1. The reviewed complex Euler–Maclaurin derivation identifies this g with zetaF up to its remainder. It requires the finite-cell Bernoulli integration-by-parts identity, convergence and analyticity of the remainder, and analytic continuation from Re(s)>1 to Re(s)>-31. The principal source value at s=1 is handled by zetaF; the present panel stays away from1. No RH, finite zero certificate, or Platt assumption occurs.
2. On each **finite-g** radius-one outer disk, prove the source bound `norm g<=2^27`. Cauchy coefficient estimates and the power-series identity yield a degree15 remainder at radius1/16 of `E_Taylor=2^-33/15`. Holomorphy/continuity on the closed outer disk and summability/geometric-tail passage must be supplied, not inferred from a numerical outer bound. Do not apply the actual-point EM estimate indiscriminately over that disk.
3. On the actual vertical panel, prove the uniform zetaF error

`E_EM=4*2003*33/(63/2)*(2034/(6*1025))^32 <2^-38`.

Then rational Horner on the sixteen certified coefficient squares over z=i*[-1/16,1/16], followed by adding E_EM+E_Taylor once to each coordinate, encloses actual zetaF throughout the panel. Coefficient uncertainty is already inside the Horner boxes and is not added again. Divide by the **whole** s-1 rectangle; its imaginary part lies in[1999,1999.125], so its norm-square lower bound is strictly positive. Source `zetaF_of_ne` identifies the result with actual `riemannZeta`.

Reconstruct the exact existing rational image by the fixed four-corner products, unary square, positive norm-square division and Cartesian multiplication. Check equality to the independently fixed target rectangle, or a proved inclusion into it. Endpoints use singleton offsets and the same owner7. No winding, order, derivative of zeta, or nonvanishing lemma is needed for this conclusion. The optional2^-64 rounding allowance from the scalar estimate is not an extra pad in these exact rational images. The error ledger below2^-44 is not a bound on total image width.

## 9. Direct-g alternative and the extension to all eight centers

A direct-g certificate evaluates `E_n(h,j)=exp(-s_j log n)*(-log n)^h/h!`, sums all n, and combines the same complete correction. This avoids binning, residual Taylor truncation and FFT soundness in the **actual-panel theorem**. The log table is shared; phases can be supplied separately at each j or proved by base/step products. It neither needs nor proves the old moment/transform disks. Its closed target remains the same sixteen G squares and panel/endpoint images, so it cannot silently enlarge output boxes.

For all eight centers, the actual-image route requires all128 G inclusions and all17 exact image reconstructions. If the intended conclusion additionally certifies the completed batching records, it also requires all1,024 labels, all12,288 actual moments and all3,072 selected exact-center transform disks, plus the complete error identities. Direct-g acceptance alone is not that stronger result. Independent proof-cost evidence should select a construction or justify keeping both; the Python operation counts and timings do not rank Lean kernel costs.

## 10. Concrete standard-axioms acceptance

The generic theorem must say, in mathematical prose: for every well-formed finite typed certificate for the independently fixed template, acceptance implies its stated actual-value enclosures. Its graph proof is induction over earlier references. Elementary and analytic wrapper theorems discharge semantic leaves. A second, closed proof must show that the **actual chosen finite certificate** accepts, using kernel-checked finite computation or explicit checked arithmetic witnesses. Neither theorem alone supplies the result.

Required negative controls at that real boundary include changed center/index, raw rather than normalized derivatives, omitted n=1024 or B pole term, wrong Bernoulli sign, q replaced by q mod32 in a residual, positive output label7 instead of25, missing final32, FFT applied to uncertain rather than exact centers without its changed error accounting, unproved exp/log leaf, reversed/empty intervals, division through zero, missing tail, or a narrower final box. A different mathematically valid graph for the same fixed claims may accept. Matching one producer's bytes is not the definition of mathematical correctness.

Finite lists, finite polynomial lengths and bounded earlier references make the checker terminate structurally. Resource fuel can reject oversized data. This does not prove a producer will find witnesses fitting every old tight box, or that their proof terms fit any practical cap. Elementary approximation convergence and strict output slack can support eventual witness existence only after the relevant margins are proved; exact-zero outputs require algebraic treatment. No generic fixed precision is assumed here. The proposed scalar precision schedule is separate and is not accepted by this note before its independent review. That proposal uses exact rational algebra between selected rounding gates; it does not justify an implementation that rounds after every operation without a new accumulated-error proof. Exact rational denominator growth is itself an unresolved proof-representation cost.

The future proof's exact theorem type and transitive axioms must be checked. Only permitted standard axioms such as propext, Classical.choice and Quot.sound may remain. No sorry, newly introduced axiom, native-generated correctness axiom, FLINT Boolean, Python output, “certificate correct” hypothesis or unproved analytic premise may survive in the closed panel theorem. No such Lean check has run for this blueprint.

## 11. Source locations and reviewed dependencies

Target source is `work/ternary-goldbach` commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`; Mathlib is commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, inspected under `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. These are existing source ingredients, not an elaborated checker integration. Source references below were checked directly during this task; wrappers described above remain proof work.

| Source location | Existing role |
|---|---|
| Target `TernaryGoldbach/Prelim/RamareHarm.lean:31` | `RamPf.log_one_add_inv_bounds`, atanh log sum and exact geometric tail under positive a. |
| Mathlib `Analysis/SpecialFunctions/Log/Basic.lean:133,297` | Positive-product log and integer-power reduction; domain side conditions retained. |
| `Analysis/SpecialFunctions/Complex/Arctan.lean:144`; `Analysis/SpecificLimits/Normed.lean:1007,1021`; `Analysis/SpecialFunctions/Trigonometric/Arctan.lean:336` | Actual arctan series, alternating bounds and Machin identity. |
| `Analysis/Complex/Exponential.lean:249,407,517,523`; `Analysis/Complex/Trigonometric.lean:522,526` | Positive real exp sums, complex/real Taylor errors, actual complex exp coordinates. |
| `Analysis/SpecialFunctions/Pow/Complex.lean:40`; `Analysis/SpecialFunctions/Complex/Log.lean:71` | Positive-real-base complex-power identity. |
| `Analysis/Fourier/ZMod.lean:106,114,122` | Negative unnormalized dft, positive normalized inverse, output reversal. Radix-two arithmetic correctness is a new finite proof. |
| `Analysis/Calculus/Taylor.lean:535` | Integral Taylor remainder for a complete real normed target, applicable to Complex; signed interval and within-derivative adapters remain. |
| `NumberTheory/Bernoulli.lean:224,212`; `NumberTheory/ZetaValues.lean:86,274,302` | Bernoulli recurrence, odd vanishing, polynomial derivatives, periodic representative and Fourier bound. |
| `Analysis/Calculus/IteratedDeriv/Lemmas.lean:309,366,418`; `Defs.lean:339` | Addition/scaling/product derivatives and normalized analytic scalar coefficients. |
| `NumberTheory/LSeries/HurwitzZeta.lean:73`; `MeasureTheory/Integral/IntervalIntegral/IntegrationByParts.lean:110`; `Analysis/Calculus/ParametricIntegral.lean:284`; `Analysis/Analytic/Uniqueness.lean:224` | Convergent Hurwitz half-plane, cell integration by parts, dominated complex differentiation and continuation. These do not already state the combined EM evaluator theorem. |
| Target `TernaryGoldbach/Explicit/ZetaGrowth.lean:17,19,30` | Actual zetaF definition, off-pole equality and entire differentiability. |
| `Analysis/Complex/CauchyIntegral.lean:693`; `Analysis/Complex/Liouville.lean:42` | Power series on a ball and derivative bound from a sphere bound, with their full domain hypotheses. |

Selected source-file SHA256 values:

| File | SHA256 |
|---|---|
| Target RamareHarm | `C3B8A2152965C022E8D2D1C7AC6871742D71E6954FE8B891EB6F50A291BBA688` |
| Target ZetaGrowth | `ED2158522FECDF70720AF464B28DE6E101666A3ED6AB7568729A5A8EA591E9E4` |
| Mathlib Complex/Exponential | `564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0` |
| Fourier/ZMod | `012663E2EB3A3F3196C6BCE04CB530D04E29C8DE8C65AFE703F2D707484EFE10` |
| Calculus/Taylor | `0AB79A53A36F87AB2A69D907D7999D2516CC4C085799E306F97D8480AE8CA18A` |
| IteratedDeriv/Lemmas | `C13084E379CA06DBACAC91178684F774DEB353C460E13AA61A05F0AC766B4182` |
| IteratedDeriv/Defs | `4158C93973F704EF8269598489BE824DFC8599D80AC60C90808D14591228654A` |
| NumberTheory/Bernoulli | `4D5D9A8014146DB73E191F56BCCC06D24F2AF2FEC86B0C925230822659AAAC6E` |
| Complex/CauchyIntegral | `2E0F2F6115C4BF7BE921A92774C63681A9282C60EF51CD8D31D4D0823DFF464A` |
| Complex/Liouville | `A8DAEC908763D110FF049AF9096D9AFF1AB57916E056FC644CBDA7A621013171` |

All report paths in this final table are relative to `work/qrh-campaign/agents`; hashes bind the reused paper scope, not proved Lean theorems.

| Paper or data | SHA256 |
|---|---|
| `integration/EXACT_INTERVAL_EVALUATOR_PROOF_BLUEPRINT_2026-11-11.md` | `E3ACCCDAB3D3A6F34D51702843A4D7A6807D0CD4DE52DA7AA2485BB3C0835398` |
| `independent-feasibility/REVIEW_EXACT_INTERVAL_EVALUATOR_PROOF_BLUEPRINT_2026-11-11.md` | `C2116898F368FE9275A0B2D6EC4E37C5D5472C1B46627258AB166C0EB2961384` |
| `integration/NEXT_AFTER_RATIONAL_PANEL_2026-11-11.md` | `F9C3588E2BFC0A2DA7AF278F645E402C181FF6549E5455DDEDDE2FB4AE32D823` |
| `audit/REVIEW_NEXT_AFTER_RATIONAL_PANEL_2026-11-11.md` | `10B81EC97C70D984115DA19256FFA07D01402B77A73FF0C984A2207D581B43EB` |
| `prime-estimates/INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md` | `BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC` |
| `independent-feasibility/REVIEW_INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md` | `4C773E1497C2C6F2D99D0A1F5A060A8029E9CC5EBCD85D5F3265914A13547181` |
| `major-constants/EM_SOURCE_PROOF_PLAN_2026-11-11.md` | `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485` |
| `moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md` | `5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1` |
| `major-constants/EM_FINITE_COEFFICIENT_SEMANTICS_2026-11-11.md` | `ADE7149EE7D5C3586A2AA7267C39363828747D801DE5EF1F4508A21B737F69D3` |
| `prime-estimates/REVIEW_EM_FINITE_COEFFICIENT_SEMANTICS_2026-11-11.md` | `3A9150606721D555C130B29EB3AB5E324286925D76FB2F638105A846BDB8758E` |
| `moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md` | `814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818` |
| `independent-feasibility/REVIEW_FINITE_EM_VERTICAL_BATCHING_2026-11-11.md` | `B8EE7250B9E2AAEE8099A7109C08FF34FBD70E880182E99E2B3F30970C49717E` |
| `integration/FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md` | `170C8F976A8AF8B299E4AB737E6924260B3B1D8328FA54C0F2BF7F6E9720F997` |
| `audit/REVIEW_FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md` | `F2DC3A12F4474E8469D45C741E0F1A7FBA5A1CAF61AEF6A1509749FDE8BFD406` |
| `moebius/SMALL_EM_BATCH_PILOT_SPECIFICATION_2026-11-11.md` | `3977881D20CFE9F948E850AC9A83CF50084AA1EF7D0B7023E5D1A95DE845B929` |
| `major-constants/EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md` | `47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23` |
| `integration/small_em_batch_candidate_20261111_01.json` | `2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E` |
| `audit/REVIEW_SMALL_EM_BATCH_COMPLETED_2026-11-11.md` | `A276BF8B60ADA46BB4C618E50EC8E26CDBF4922258AD407DC6C3F9335C3CF697` |

## 12. Completion boundary

An implementation task would first prove arithmetic and elementary certificate soundness, then finite coefficient semantics, the selected batch or direct-g construction, actual EM/Taylor attachment, and closed finite acceptance for the j7 targets. The full pilot subsequently requires every remaining output and, if claimed, every batching record. No declaration or implementation is authorized or performed by this paper task.

This bounded panel result would remove FLINT from its own acceptance path. It would not prove production-height feasibility, the principal or nonprincipal spectral certificates, global7/8 provider closure, or the downstream Goldbach repairs. The large-range target remains `TernaryGoldbachFrom (10^27)` with no mathematical premise. Full Statement retains only the original inclusive `BinaryGoldbachInput` through4*10^18. No checker-correctness, numerical, analytic, or spectral assumption is added to either root.
