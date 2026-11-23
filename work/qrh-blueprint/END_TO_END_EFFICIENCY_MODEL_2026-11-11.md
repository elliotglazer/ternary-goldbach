# End-to-end efficiency comparison

2026-11-11. Research integration by the coordinator. This is a cost model and a selection policy, not a completed proof or a runtime estimate. The previous goal turn made progress by activating the full team and recording new coverage and common-witness designs. This turn inspected the resulting reports, verified source pins and exposed a batch-size tradeoff that changes how the designs should be compared.

The target is an unconditional proof that every odd natural number greater than five is a sum of three primes. A reduced finite-RH proposition and a binary Goldbach cutoff are intermediate obligations to discharge. Neither may remain as a mathematical assumption in the eventual end-to-end result. The reduced-RH refactor report deliberately preserves the old binary hypothesis at its local boundary; the finite-coverage work must close that boundary or replace its consumer with the generalized smaller-cutoff ladder.

## Mathematical choices and accounting

Use parameters N for the start of the analytic theorem, B for the inclusive binary cutoff, L for binary outer-block length, D for its source halo, and a spectral profile R. The current conservative analytic comparison is N=10^27 with the reduced original-RH domain. QRH is an alternative only if its complete analytic and finite-certificate costs are lower. Its provider is not assumed to be already built or axiom-validated in the target toolchain.

For each proof system s, compare the following nonoverlapping terms:

    C_s = G_search + G_witness + G_proof,s
          + V_library,s + V_source,s + V_anchor,s
          + V_binary,s + V_ladder,s + V_spectral,s
          + V_assembly,s + I_s.

G_search includes failed candidate, sign and coverage-plan attempts. G_witness includes exact certificate construction and its preparatory tables. G_proof is any additional production of proof terms or ordinary MM0 proof steps. Verification terms concern the actual accepted mathematical objects, including their provenance. I includes serialization, linking, decoding and imports not already charged. An implementation that fuses two phases should report their joint measurement once, rather than charge the same work twice.

Initial binary coverage, final short blocks, exceptional primes, complete character enumeration, central/top-height spectral cases and completeness checks belong in these terms. A principal certificate belongs in V_spectral even when it uses a different producer. Shared tables are charged once per actual construction and once per actual load/check, not once per hypothetical use and not zero times.

Separate cumulative CPU work, parallel critical-path time, proof bytes, witness bytes, peak working memory and temporary disk. A lower operation count in one category does not prove a lower total or a lower wall time. For example, a smaller spectral height-weighted volume is not a count of FFT butterflies, and a sparse sieve hit is not a wide-mask operation.

The stock Lean scenario uses standard kernel-checked declarations and complete checked dependencies. Cached imports are not a new independent proof check. Ordinary MM0 must check actual arithmetic derivations and the final proof stream in the chosen foundation. Its existing PA arithmetic examples do not supply the complete analytic library. A foundation-preserving extended checker is a separate scenario for either system and must include its concrete execution/acceptance bridge. Give the two systems equivalent implementation choices.

## Choices that interact

| Proposed change | Possible saving | Coupled cost or mathematical obligation |
|---|---|---|
| Smaller B | Fewer binary targets | More ladder rungs, narrower candidate windows, different fallback and witness costs |
| Larger L | Fewer anchor pools | Larger certified source bitmap and initial range; possible cache and coverage changes |
| Smaller selected anchor span | Smaller packed operands | Different source extraction origin; restricted anchor search may cost more or leave more residuals |
| Structured anchors | Cheaper primality certificates | Larger spacing can require a larger halo and source bitmap; existence cannot be inferred from a residue count |
| Shared common-X Proth batch | One progression for heterogeneous bases, fewer base tags/checks | Wider arithmetic, full-width startup, CRT production, gcd and witness payload |
| More/smaller arithmetic groups | Narrower modular arithmetic | More initializations, references and fixed evaluator overhead |
| Larger logical proof packs | Fewer global declarations and range joins | Larger proof scratch and literal/traversal costs; arithmetic modulus need not change |
| Larger N | More decay in some analytic errors | More finite coverage; high-zero and admissibility terms need not improve |
| Lower spectral heights | Less potential spectral work | New bounds for every consumer, including principal and minor-arc estimates |

These savings cannot all be multiplied together. In particular, normalizing the span of one anchor subset does not shrink the global source halo D. A short residual list is useful only when a checked partition proves that every omitted obligation has already been discharged.

## Common witnesses do not settle the best batch size

The independent common-X review validates this acceptance contract. Put F=2^45 and Dp=2^44. For each ordinary slot, require a positive integer k_i=S*i-t_i, p_i=k_i*F+1, p_i dividing the actual batch product M, p_i<(F+1)^2, gcd(X,M)=1, and

    p_i divides X^(Dp*S*i) + X^(Dp*t_i).

Cancellation at every prime divisor produces the existing power-plus-one primality criterion. Per-factor small-base labels, Jacobi tests and CRT residue equations are unnecessary for this acceptance contract. A producer can use them to find X. The checker must still establish that its initial residue is the actual X^Dp modulo M; supplying an arbitrary initial residue is unsound. General-prime slots retain independent certificates and interval proofs.

This removes genuine checks, but does not establish a time saving over grouped bases. Suppose a batch has q factors of about b bits and is partitioned into g equal groups. In a simplified arithmetic model with modular-squaring cost proportional to n^alpha, the width-dependent cost of one square across all groups is

    g*(b*q/g)^alpha = (b*q)^alpha / g^(alpha-1).

For alpha greater than one, narrower groups reduce this component despite having more chains. If the initialization count is approximately A for every group, the model becomes

    A * [g*h_s + c_s*(b*q)^alpha/g^(alpha-1)],

where h_s is fixed per-operation overhead and c_s prices width-dependent work. This is a sensitivity model, not a fit to either prover. The actual chain lengths, small-base startup, quotient proofs, reductions and division algorithms must replace these coefficients before estimating time.

For q=32, b=90 and alpha=2, the width component is 8,294,400 for one group and 8,294,400/g for g equal groups. Its ratio is 1/g, while the fixed-overhead component grows by g. These exact arithmetic ratios show why counting initializations alone can select the wrong algorithm. They do not show that 32 singleton groups are fastest.

The encoding X=a0+M0*y may reduce serialized witness size when M0 contains most default-base candidates. Even one nonzero y can make X nearly full-width, so short payload does not imply small startup arithmetic. The all-default y=0 case can retain the original small-base fast path. Compare that case separately from mixed blocks.

Arithmetic batch size q, logical proof-pack size k and physical shard size f must remain separate parameters. Increasing k can reduce declaration and import overhead while retaining whichever q minimizes actual arithmetic. No proof requires q=k.

## Current decisions and open comparisons

Keep N=10^27 as the baseline. The threshold report proves no spectral saving from raising N. Uniform half-height, tenth-height and hundredth-height substitutions fail actual etaPlus admissibility at conductor 300000. Keeping the old spectral inputs at larger N adds finite work without the claimed saving. This rejects those substitutions, not all improved analysis. The constants worker is now examining a lower N with all consumers retained.

Keep both grouped-base and common-X mixed ladders in the candidate set. Mathematical soundness of common-X has independent review; its net cost has not. The arbitrary-base Proth tier is worth pricing before unstructured prime certificates because it retains the known 2^45 factor, but producer success and search cost remain unknown.

Keep wide residual updates, span-normalized packed terminals and explicit residual witnesses as interchangeable binary leaves. The certificate's exact residual invariant permits this choice without changing the theorem. Backend choice should use complete leaf-plus-parent costs, including source extraction and prime provenance.

Use the smaller original-RH family as the spectral comparison baseline. The coordinator has read the concrete refactor blueprint and checked all 27 pins. It explains the parity-witness repair and principal-only propagation. This is sufficient source guidance for a future implementation, not an elaborated dependency-closure verdict or a proved finite certificate.

For source certification, the author proposes immutable proposed-bitmap checks at every required composite position, with a wheel and a dense/sparse split. Independent mathematical review passes at design scope. The coordinator read both reports and inspected the underlying minimum-factor proof. The complete base list needs a stronger contract than the one-sided source bitmap; the same checked source must reach the coverage consumer. Do not credit native mutable-array costs as kernel or ordinary-MM0 costs. For spectral arithmetic, choose schedules per conductor and tile rather than assuming a time FFT is uniformly superior; the spectral worker is pricing those schedules.

A further comparison is now assigned: replace explicit ladder rungs by a uniform prime-gap theorem obtained from a larger conductor-one finite-RH certificate. This might trade many prime certificates for one extended spectral computation. The needed height, constants, complete range and net cost are not established. The prime-gap theorem researcher, coverage researcher and spectral researcher have distinct tasks to resolve those questions. It is not part of the accepted baseline.

## Evidence and bounded next measurements

The following author reports were read by the coordinator in this continuation. All their listed source pins matched: 27 for reduced RH, 15 for composition, and 15 for threshold analysis. Hash checks bind evidence; they do not establish theorem correctness.

| Report | SHA256 |
|---|---|
| `../qrh-campaign/agents/audit/EFFICIENCY_REDUCED_RH_REFACTOR_2026-11-11.md` | `727DD8FD825FE1089FFED3B9E69AAD34528F2F8B37AC1741B238708A7E40DAE1` |
| `../qrh-campaign/agents/integration/EFFICIENCY_PROOF_COMPOSITION_2026-11-11.md` | `FE62515193754C19CDB4A34728765CFA09DD5BEDD1694E5D575DCC79EE7D4E9B` |
| `../qrh-campaign/agents/major-constants/EFFICIENCY_ANALYTIC_THRESHOLD_2026-11-11.md` | `0CA1FF45F59E4AB5C95702C9041DDFC6643E7C9669247768CBC4BA5BEA09192C` |

The common-X review is `../qrh-campaign/agents/audit/REVIEW_COMMON_X_PROTH_ACCEPTANCE_2026-11-11.md`, SHA256 `3F126257BAD43CE7F3827943E77F8C0A7173F91B1F1E00B491CA3EAA7D63DF13`. The coordinator read it, checked its hash and both source pins, and inspected the actual generic criterion and base-three specialization. Its mathematical contract is accepted at source/research scope.

The source-sieve review is `../qrh-campaign/agents/audit/REVIEW_EFFICIENCY_SOURCE_SIEVE_2026-11-11.md`, SHA256 `14CF4667B624DCADADDBE341E2849FB974AA42CD5DC25C84E18A67DCA8325CB7`. The author report has SHA256 `55052C31D2DEFD00CAB9DB99CC1E947C4E14E509FDF0ED376E20374A1F6C0F54`. The coordinator read both, verified their hashes and seven available artifact/source pins, and inspected the minimum-factor consumer. The saved full numeric table was not independently recomputed; the accepted result is the mathematical acceptance design.

The most useful future measurements are complete matched arithmetic groups at several q values; a complete binary leaf and parent with genuine source and prime proofs; a spectral input-to-sign tile with all enclosure terms; and two distinct proof packs plus final assembly. Each must include generation, checking, actual proof bytes and memory. The current research-only scope performs none of these builds or prime/analytic evaluations. Existing component timings remain evidence only for their original operands and acceptance contracts.

    DRAFT_ANCHORS: 0 created
    UNREGISTERED_SORRIES: 0 introduced
    DRAFT_IMPORT_VIOLATIONS: 0 introduced
    SEALED_THIS_TURN: 0
