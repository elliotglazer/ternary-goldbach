# Executable source arithmetic

The corrected integer producer was rebuilt and audited in sourceint01. RESULT_REVIEW.md is the current acceptance record. Seven executable-type checks and the exact initializer definition now supplement the three generic theorem roots. INTEGER_INITIALIZER_CORRECTION.md records the rational-coordinate type error and its repair. The current runner is run_source_int.sh through run_source_container.ps1; the older run_source.sh receipts describe the preserved earlier version. No complete analytic source or throughput benchmark is claimed.

## Code provided

The module imports the existing BlockRound rule for signed nearest division, with ties toward positive infinity. Its numerical functions use unbounded HOL integers/naturals. No floating approximation, oracle, precomputed array or supplied L-value occurs.

| Function | Exact job |
|---|---|
| source_log_horner / source_log_center | The RawLogHorner finite atanh polynomial, with explicit grid S, rational A/B and term count. |
| source_log_from_two / source_log_checked | Rational x=A/D range reduction, a supplied shared log2 center, exact integer assembly and one output rounding. The checked variant enforces positive grids and the rational range inequalities. |
| source_raw_log129 | Exact specialization to the raw integer program: 45 terms, grid137 log2/local polynomial, division by256 to grid129. |
| source_exp_step / source_exp_horner | Literal normalized complex Horner on phase i*p/d, including its terminal one and one rounding per coordinate per affine update. |
| source_raw_step | The existing 72 updates on grid131 and nine-bit reduction to grid122. |
| source_em_step_from_log_pi | The separate baseline p138 cis schedule: exact period reduction using grid161 pi, 82 updates on grid151, then grid144 and grid142 roundings. No claim that its supplied log/pi values are certified. |
| source_inverse_root / source_initial | Floor square root of floor(D*S*S/A), followed by exact embedding of the lower inverse-root numerator. The wrapper rejects nonpositive/out-of-order domains. |
| source_raw_initial / source_em_initial | Raw integer grid98 to120; separately rational (512+k)/512 grid123 to140. |
| source_mul / source_state / source_pool_tick | Exact four-product signed multiplication and nearest division, with persistent left grid and fixed right-step grid. The pool stores pairs of state and step. |

The existing logroot ROOT2 definition has proved numeral computation equations, including numeral_root2 and numeral_sqrt. It supplies an executable specification for the rational inverse-root candidate; it is not a new external square-root assumption. This candidate does not yet have a tested CV translation. If the chosen translator cannot consume those equations directly, a separate proved translation adapter is needed rather than an unverified replacement root routine.

The Holmakefile names only this generic theory. It contains no concrete evaluation driver. Parent review/build is required before treating any proposed theorem or module as accepted.

## What ports verbatim, and what changes

RawLogHorner's logHorner/logCenter are already parameterized by S,A,B,N. Their integer formulas port directly. For x=A/D and a checked power2 exponent k, the correct atanh numerator/denominator are A-2^k*D and A+2^k*D. The subtraction is natural subtraction, so the range gate must be proved before interpreting it as real subtraction. The shared log2 value must be linked to its actual producer, not merely have a plausible magnitude.

RawExpInteger's expIntegerStep/expIntegerHorner are already parameterized by S,p,d,N. They port directly, including denominator d*(k+1), the exact terminal one, and simultaneous use of the old real/imaginary pair. The existing analytic export expIntegerHorner72_error is specialized to 72 updates and error81/S; changing N does not automatically instantiate that theorem. A variable-length proof or a separately proved 82-update theorem is needed.

RawInverseRootProducer computes Nat.sqrt((S*S)/x) for integer x. The rational extension computes ROOT2((D*S*S) DIV A). Its required certificate is m*m*A <= D*S*S < (m+1)*(m+1)*A. This follows mathematically from the floor-root bounds and positive-denominator integer division. The HOL proof, then the real reciprocal-square-root interpretation, still must be supplied. The checked initialization wrapper requires 0<D<=A and amplitude_bits<=state_bits. Exact-square and x=1 endpoints remain valid. No division by m is used.

RawDyadicProduct ports directly because the left input/output grid and right-step divisor are independent parameters. The common recurrence e_next <= (1+eps)*e+eps+u also applies to rational x>=1 after the actual positive-base power identity and modulus bound are proved. The raw numeric corollary at grid120 does not prove the EM grid140 corollary.

## Two separate precision contracts

The raw branch remains unchanged in mathematical intent: integer x, log error below2^-128, the 73-term polynomial, stored step grid122 with error below2^-120, state grid120, inverse-root initialization grid98, and finite-prefix state error below2^-96. HOL still needs the analytic ports; compiled Lean statements are specifications, not imported HOL proofs.

For the rational first-band EM pool, k_pool=0..113152 and x=(512+k_pool)/512, so 1<=x<=222. Initialization is at height zero. The proposed source_em_initial uses the baseline p120 amplitude grid123, embeds it exactly to140, and should have error below2^-123, which is stronger than the retained initial allowance2^-120. No initial nonzero-height cis is needed for this particular zero-start block. Later-band introductions at nonzero height are outside this module's initialization claim.

The accepted EM recurrence requires log error at most2^-144, step error at most2^-140, state-update error at most2^-140, and a separate state-to-EM-grid122 copy. Preserve the fine state for future updates. The paper's uniform J128000 recurrence bound plus that copy remains the intended error join; only indices1 and2 are needed for the current block. No state radius may be reset at either step.

For the EM step, let L be the log center on grid145, and P the pi center on grid161 with errors at most2^-144 and2^-160 respectively. The exact approximate phase is -5*L/2^151. Its grid161 numerator is -5*L*2^10. The module obtains turns by nearest division by2P and subtracts2*turns*P. This preserves signed nearest ties; the reduced endpoint convention may put the positive tie on the negative side, but its magnitude remains bounded by the pi center. The analytic period identity and pi uncertainty must be charged as in the source.

The retained source formula p138 gives n=83 terms, inner grid151, final cis grid144, then the recurrence step's separate grid142 rounding. Both roundings are explicitly in the code. Under the actual log/pi/cis proofs, the complete step error has the source bound (5/64)*2^-144 + 2^-142 + 2^-142 < 2^-140. Replacing this by the raw grid131/73-term result, or omitting the second rounding because the phase is small, is not this contract. Although the pool has small phases, no new no-pi optimization is adopted here.

## Missing logarithm producer, explicitly

The retained efficient EM source uses the reviewed grid-anchor logarithm method, with degree21 at target144 bits. That is not RawLogAssembly's 45-term integer logarithm. SourceArithmetic supplies a reusable rational atanh kernel and checked range assembly, but does not silently replace the selected grid-anchor algorithm or its cost counts.

A direct elementary baseline could instantiate the general atanh recipe with target144, N50, inner grid152 and output grid145. Its paper allocation follows the existing elementary-leaf formula, not a new numerical evaluation. It would require the corresponding HOL proof and would be a different log schedule from the selected anchor-reuse producer. No fixed EM log wrapper or price substitution is made here. The next concrete producer task is to implement the selected anchor/log-update program and bind its returned grid145 center to the required error, or explicitly authorize and price that direct baseline instead.

## Interface for the two pools and transform

Raw entries contain state on grid120 and step on grid122; call source_pool_tick with T=2^122. EM entries contain state on grid140 and step on grid142; call it with T=2^142. The list order and exact argument map are external invariants to prove, not encoded by the integer pair type. source_em_initial's caller must enforce its pool index range. Initialization of each step must bind the same rational argument, direction and exact height increment5/64 as its state.

The transform author expects exactly4800 grid81 pairs in order2*(40*j61+j41)+j4. Neither pool directly supplies those pairs. The intervening program must construct the finite EM coefficients, shifted P20/Horner output, raw head, exact grid100 sum and one grid81 conversion, retaining each error component. This module returns no pretend transform input and proves no source norm/radius from a coordinate range check.

## Focused proof/build sequence

1. Build this definition-only numerical core and its small arithmetic theorems. Check exact types and ordinary axiom closure. Separately add bounded CV translations without evaluating a full pool; the ROOT adapter may need its own proved equations.
2. Finish the existing RawPairRound analytic bridge. Transport positive-denominator signed residuals to coordinate error, then complex error and the persistent recurrence, retaining the cross term.
3. Port the rational atanh identity/tail and fixed-grid log error; implement and prove the selected anchor-reuse producer. Bind the log2 cache and every exact A/D argument.
4. Port the variable-N normalized Horner identity and exponential remainder at N83, plus signed phase reduction, pi enclosure and both regrids. Supply the actual pi producer. The pinned HOL real MCLAURIN/TAYLOR results are proof ingredients, not callable certified numerical functions.
5. Prove ROOT2 rational adjacent-square inequalities and inverse-root initialization. Join the two pool contracts with their actual programs and accumulated errors, then supply EM/Horner/raw-head and finally transform/completion semantics.

No missing analytic result is placed as a hypothesis of a purported closed source producer. The current module simply does not state such a theorem. Source truncation, grids and raw arithmetic remain visible for the later proof.

## Source pins

Lean paths below are under work/lean-pilots/raw-head. These are source correspondences, not a HOL trust mechanism.

| Source | SHA256 |
|---|---|
| RawLogHorner.lean | B8F3D80805063D22C653D1949732DE0B67E92BE329512EABD1198A88E8A67AAD |
| RawLogAssembly.lean | BDF4C5DABB9F68EA9E5754452CE0C228EDA801A9F144A4648F415E7C900485D7 |
| RawLogTail.lean | 2D6E8E9A38086653661FF06A263164BF04B077E41C7EFBDD96011466EB52AB55 |
| RawExpInteger.lean | F4964C22363D290F96A17900CD72D2F193DBBD211F52651A1E2A49D5F78CB53B |
| RawExpTail.lean | 2E0CCA220F498DDA3C552E84A15652DF2DC2550F307921ADF029E5115A3DB7DC |
| RawInverseRootProducer.lean | AB4B5B6721C03D37E87DC09732865B27A42161C8B7B686EEC50EEF48B676353B |
| RawStepProducer.lean | A30763650701C171C20B3EB6908F0918A95F1A64A2F0BEBB557D0D42070F53AE |
| RawStateProducer.lean | E5335116BA0B90DD92D500FCD0EFA5A89586D08C334D64C0F9EC01AB12D9B961 |
| RawDyadicProduct.lean | 95C2BB6F0D336646DA77C29BECF76655EC14AE4B66CFBED06CCEBEB1B7E4214A |
| work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md | 8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413 |
| work/qrh-campaign/agents/moebius/ELEMENTARY_HURWITZ_LEAF_BASELINE_2026-11-11.md | 0541F20C55B843683E3C496F8AEA63036A8A7AAF55A49C4F2B97ACC3FAC17C9D |
| work/qrh-campaign/agents/zero-sum/GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md | E564A8DDEC5F0AD69F5CF22DFC89147F81EA165B6E6D17B4CF0EFB0EEA3824AF |

The selected HOL checkout is HOL-1de64f8521b4758508bd875fbaf11d1768261b92. Its logrootScript.sml supplies the integer-root specification/computation equations; its transcScript.sml supplies the real Taylor and logarithm analysis ingredients. No existing source or dependency file was edited.
