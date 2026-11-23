# Mixed ladder versus the Q-frontier: a break-even screen

2026-11-11. Conditional cost arithmetic, not a Fermi forecast or a route selection. No primality search, zeta evaluation, FFT, benchmark, Lean/MM0 build, or new certificate was run. The companion JSON contains exact integer divisions for explicitly chosen model constants. Its outward intervals are intervals for the model, not confidence intervals for runtime.

## 1. Two historical anchors, with different meanings

The pinned target README:119–129 reports about15 microseconds of native search and55 microseconds of Lean kernel checking per rung of its original base3, width2048, 32-factor product-modulus ladder. It reports about5 one-core hours overall,4 for checking, for254638308 rungs. These figures do not measure the proposed width128/256 mixed-base ladder, general-prime fallbacks, ordinary MM0, new hardware, or their proof/import/storage overheads. [Pinned source](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/README.md#L119).

Platt–Trudgian report about7.5 million core-hours on3.6GHz Xeon processors for rigorous interval verification through H*=3000175332800. Their program used shared evaluation, strict sign changes and completeness rather than uniformly high-precision zero isolation. This is native rigorous computation, not ordinary Lean/MM0 acceptance or this campaign's independently checked certificate. Neither clock frequency nor core-hour totals provide a portable speed conversion. [Primary paper, §2](https://arxiv.org/pdf/2004.09765).

We use the nominal constants70 microseconds and27000000000 core-seconds only to expose the scale of an unknown bridge. We do not assume the two measurements used equivalent processors or acceptance workloads.

## 2. The exact comparison before any timing model

Fix a proof system/implementation s and an admissible mixed-ladder binary cutoff B_L. Let:

- K_L be its exact required rung count; c_L its **complete average** cost per rung, including failed searches, successful witness generation, arithmetic acceptance, proof generation/checking, per-rung data handling and amortized batch layout.
- L_fixed be its non-amortized ladder library, import and final coverage cost.
- C_bin,s(B) be complete binary certificate generation and verification at B, with source primes, anchors, exceptions, sharding and root assembly. Optimize its own parameters at each B.
- P_s(Q) be the **additional** principal spectral production and acceptance cost through H(Q), after cancelling only a genuinely shared principal prefix.
- A_s(Q) be the additional analytic/scalar/head proof generation, checking, imports and assembly, less any genuinely eliminated fixed work other than L_fixed.

Then the principal route is cheaper than this particular ladder candidate exactly when

    K_L*c_L > P_s(Q) + C_bin,s(B(Q))-C_bin,s(B_L)
                         + A_s(Q)-L_fixed.                 (1)

Define the right side divided by K_L as T_s(Q;B_L). This is the break-even **complete seconds per rung**. Every positive million core-hours in the non-spectral difference adds between39645 and39646 microseconds per rung for K_L=90804183483. Negative differences are allowed, but must have a justified eliminated workload.

For the already specified mixed geometries:

    B_L=1e16: K_L=181029996372;
    B_L=2e16: K_L=90804183483.

At unchanged historical70 microseconds these would give about3520 and1766 core-hours respectively. These are reference multiplications, not predictions that their much narrower windows are populated or have the old checking/search cost.

Equation(1) compares one pair. A global selection must compare the best principal Q against the best complete ladder design over B, window geometry, batching and fallback. Beating a deliberately poor ladder candidate is not a win against the optimized family. At a common B, binary cost cancels exactly; at different B it does not.

There are also two different theorem objectives. If the original `BinaryGoldbachInput` remains an allowed premise and no binary certificate is being produced, the corresponding binary generation/checking term is absent; do not advertise a binary compute saving in that objective. If it is to be discharged computationally, C_bin is real work. The finite gap route changes neither the original large ternary theorem nor the nonprincipal spectral family.

## 3. The current Q family and a deliberately simple sensitivity table

The frozen fresh analytic proposal gives A=1e16, X=1e27,

    H(Q)=4e10 Q,  a(Q)=.031+2.261/Q,  1<=Q<=50.

Its proof and finite spectral evidence remain distinct gates. The newer author version replaces the original Johnston5000-head calculation with the already available1500 head plus analytic zero-count bounds and a relaxed explicit-formula remainder<3. This reduces an incremental certificate obligation; it does not make the existing head or new analytic joins free kernel theorems.

Use the exact sufficient allocation from the separate Q-selection note,

    U=125539470000000000,
    B(Q)=2 max(1e16, ceil(a(Q)*U+3)).                (2)

It has gap margin B-4-2aU>=2. Q47 is the first integer Q at the floor B=2e16; Q48 and Q50 give no further binary reduction under this allocation. Their height may still have block-cost or other-consumer value, but cannot be chosen merely for a better B.

For sensitivity only, take a common prefix H0=1e8 and the **linear-height model**

    P_nom(Q)=27000000000*(H(Q)-H0)/H*.             (3)

This interpolates a historical cumulative time by height; it is not a measured prefix distribution. H0 is a common obligation, not an already free proof. Subtraction is valid only when the two actual architectures can share that prefix and its acceptance. Otherwise use their actual incremental difference.

The table sets all hardware/algorithm/formal transfer factors to1 and sets the binary and fixed differences in(1) to0. It therefore shows a coefficient in the cost equation, **not** the cost of the complete route. All displayed microsecond intervals enclose the exact rational result of(3)/K.

| Q | Sufficient B(Q) | Nominal added core-hours | Per rung, B_L=1e16 (microseconds) | Per rung, B_L=2e16 (microseconds) |
|---:|---:|---:|---:|---:|
|1|575472930480000006|[99744,99745]|[1983,1984]|[3954,3955]|
|2|291628188810000006|[199738,199739]|[3972,3973]|[7918,7919]|
|4|149705817975000006|[399726,399727]|[7949,7950]|[15847,15848]|
|8|78744632557500006|[799703,799704]|[15903,15904]|[31704,31705]|
|16|43264039848750006|[1599656,1599657]|[31811,31812]|[63419,63420]|
|32|25523743494375006|[3199563,3199564]|[63627,63628]|[126849,126850]|
|47|20000000000000000|[4699475,4699476]|[93454,93455]|[186314,186315]|

At Q1 the spectral coefficient is already56–57 times the historical70-microsecond reference for the B_L=2e16 comparator. But B(Q1) is almost28.8 times that binary cutoff, so zeroing the binary difference is particularly favorable to Q1. At Q47 the binary difference is zero for that comparator, and the spectral coefficient is2661–2662 times the historical reference. For B_L=1e16, Q47 requires twice the binary cutoff; its smaller per-rung coefficient is not a same-binary comparison.

No row is a lower bound on the actual spectral cost. A different batched evaluator, hardware or proof representation could move it substantially in either direction.

### Restore hardware, shared FFT work and formal acceptance

Let w(Q) be the ratio of actual native workload to the historical full-height workload, before hardware and implementation effects. Alternatives include linear height, a height-log-height law, or an integral of actual window costs with variable cutoff, Taylor order, FFT length, precision and repairs. None is established by a single historical endpoint. In particular, treating every node as an independent Riemann–Siegel sum would discard the sharing that made the historical algorithm competitive.

Write

    P_s(Q)=27000000000*w(Q)*(r_gen,s(Q)+r_proofgen,s(Q)+r_verify,s(Q))
            + C_aux,s(Q).                         (4)

The r terms are separate normalized cost factors. Native interval generation is not a formal verifier, so r_verify cannot silently be zero. Conversely, r_verify is not forced to be a universal multiplier greater than1: its implementation, sharing and hardware must actually be specified. C_aux covers work not represented by the calibrated workload, without charging the same historical completeness work twice.

Relative to(3), combine the unknown factors into kappa_s(Q), and retain the remaining additive difference D_s in(1):

    T_s = kappa_s(Q)*P_nom(Q)/K_L + D_s/K_L.       (5)

For Q47 and B_L=2e16, D_s=0 gives:

| kappa | Spectral break-even microseconds/rung | Relative to70 microseconds |
|---:|---:|---:|
|1|[186314,186315]|about2662|
|1/10|[18631,18632]|about266|
|1/100|[1863,1864]|about26.6|
|1/1000|[186,187]|about2.66|

To beat a hypothetical ladder still costing70 microseconds per rung with D_s>=0, the complete spectral bridge must improve on the nominal anchor by more than a factor between2661 and2662. This is a requirement under the model, not a claim such improvement is impossible. The smaller Q rows lower that factor but increase binary work.

## 4. How much ladder premium would change the answer?

A useful accounting form, after fixing a batch policy, is

    c_L = 15us*g_search + 55us*g_check
          + c_layout + f*Delta_fallback.          (6)

Here g_search includes failed ordinary searches; g_check includes the changed ordinary arithmetic/proof engine. c_layout pays extra grouping/index/storage/assembly work not already included. f is the fraction of slots actually requiring the priced fallback, and Delta_fallback is its **incremental complete cost**, including additional search/witness generation/checking, above the ordinary allocation. Do not double-charge failed search in both terms. If fallback placement changes batch efficiency, that dependence belongs in c_layout or in a conditional average Delta, not in an assumed independent rate.

Combining(5) and(6), for Delta_fallback>0 the required condition is

    f > [T_s-15us*g_search-55us*g_check-c_layout]/Delta_fallback. (7)

A nonpositive numerator needs no fallback premium; a threshold above1 cannot be met by that specified fallback cost. Residue-class coverage by six bases is not an observed fallback probability. Arbitrary-base Proth and direct singleton checks can be cheaper than general primality certificates, so a base3 failure must not automatically receive the general-fallback price.

As one transparent scenario only, set Q47, B_L=2e16, kappa=1, D_s=0, g_search=g_check=1, c_layout=0. The extra average cost required beyond70 microseconds is in[186244,186245] microseconds per slot. Then:

| Incremental complete cost of each fallback | Required f, approximately |
|---:|---:|
|1 millisecond|over186; impossible for this scenario|
|10 milliseconds|over18.6; impossible|
|100 milliseconds|over1.86; impossible|
|1 second|over18.6244%|
|10 seconds|over1.86244%|
|100 seconds|over0.186244%|

If only search worsens while checking stays55 microseconds, the average search factor must exceed about12417 relative to15 microseconds. If only checking worsens while search stays15 microseconds, the checking factor must exceed about3387 relative to55 microseconds. These are intentionally demanding diagnostic numbers. They neither bound actual mixed-ladder search nor assume inexpensive ordinary-MM0 proofs. At kappa=1/100 the required extra average becomes about1.793 milliseconds instead; equation(7), not the headline table, is the reusable test.

The two important unresolved distributions are (i) windows with no accepted ordinary certificate after the allowed base/shape search, and (ii) group sizes/positions producing large-modulus proof work. A mean native modular multiplication time alone does not determine either distribution or the total proof cost.

## 5. Decision rule and architecture neutrality

This screen argues against selecting the gap route solely because it eliminates a visible ladder. Under the nominal historical bridge it needs a substantial mixed-ladder premium; under a sufficiently improved complete spectral bridge the threshold changes. The unknown binary difference can itself outweigh either. The proper objective is

    min_Q [C_bin,s(B(Q))+P_s(Q)+A_s(Q)]
    versus
    min_valid_ladder [C_bin,s(B_L)+K_L*c_L+L_fixed].

Use the same standard of acceptance and account for generation, proof construction, verification, imports, rechecking, storage and final assembly on both sides. Analytic theorem development effort is an additional planning dimension; it should not be silently converted to core-seconds or omitted from feasibility. The missing Logan library identified by the source inventory is real work even if its eventual fixed checking cost is small compared with spectral generation.

For Lean, the historical55-microsecond kernel path is one concrete architecture, not an invariant of Lean arithmetic. For ordinary MM0, PA limb witnesses, product batching, DAG sharing, sharding, and mechanically widened64-bit or garbage-collected/streaming same-rule implementations remain valid candidates. Fixed32-bit metadata limits do not force the cost comparison. The correctness assurance demanded of such an implementation should match the conventional implementation trust afforded to Lean's kernel. Arithmetic axioms, a trusted special-function accelerator, or a native certificate oracle are distinct extended-verifier alternatives; label and price them separately.

Before promoting any row to a forecast, the missing bridge is a complete comparable cost profile: a populated mixed ladder block including failures/fallbacks and ordinary proof acceptance, and a high-height spectral window including coefficient preparation, transforms, error proofs, signs, repairs and completeness acceptance. Account for source-table reuse and final import/root costs. A low-height toy value or bare native FFT is insufficient. This report authorizes no experiment and claims no winner.

## Pins and exact arithmetic record

The scalar JSON `integration/ladder_zeta_cost_screen_20261111.json` has SHA256 `2F25C3D1F3F8CB54BAA74170ECDAEC84E9A68F7411DB732325B00A3E480E48C4`. It stores the nominal constants and floor/ceiling integer brackets for all table rows, including Q48/50. Computation used integer products and Euclidean division only; no logarithm or analytic evaluator was called. The selected B formula is exact rational arithmetic from the communicated analytic coefficient, not a proof of that coefficient.

Paths below are relative to `work/qrh-campaign/agents/`, except the README. Analytic/frontier status remains as recorded by their authors; no independent acceptance of those proofs is inferred here.

| Source | SHA256 |
|---|---|
| `work/ternary-goldbach/README.md` | `D884FCAD91275B30AED6A96223503EF1ED5E3B234B8FAFD85D095CDCE7C5C3D7` |
| `independent-feasibility/EFFICIENCY_MIXED_LADDER_2026-11-11.md` | `9AACAF7FC0B5DCD9145AB3006D40248A2C7D57319677C57600890D21E5F75783` |
| `moebius/EFFICIENCY_Q_FRONTIER_SELECTION_2026-11-11.md` | `9905D47D869D8E6C568C7A1EFA7E4C8D5523FE47B4F4167B9E838C363211F64B` |
| `major-constants/EFFICIENCY_JOHNSTON_FINITE_RH_FRONTIER_2026-11-11.md` | `0305EF19674FF97D13C2FA3F897E1106B5B0C4618287C9002842B87233F617DF` |
| `zero-sum/PRINCIPAL_EXTENSION_VERSUS_LADDER_COST_2026-11-11.md` | `CE5139A66022791E362117330291F8FA3DA670B778355EA61B2CF9737CF813E2` |
| `integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md` | `3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227` |
| `integration/FINITE_RH_LOGAN_SOURCE_FEASIBILITY_2026-11-11.md` | `BAC6EA85A6F9A0B5E3501BA3731C1CA748496AC2C59C20ECBAA7738BE4CE5DC1` |

The last source inventory predates the new1500-head replacement; its earlier5000-head requirement is superseded conditionally by the newly proposed frontier, not silently treated as completed formal work.
