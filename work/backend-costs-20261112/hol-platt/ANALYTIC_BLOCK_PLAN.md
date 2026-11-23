# HOL4 actual source-to-sign block: bounded implementation plan

13 November 2026 UTC. Read-only source inspection; no Lean/HOL builds, values, unit enumeration or new timing. This plan is not a claim that a HOL analytic provider exists. The next useful target is the existing **c=10004, two positive-height, 4800-input/2301-channel block**, not another small-character positivity example. First close the current raw-state analytic bridge as a dependency, then run that actual transform. Retain p81 for the matched priced contract; p75 is a separately proved mean-input successor, not a free precision substitution.

## Existing support, and what it does not prove

The inspected HOL checkout is commit `1de64f8521b4758508bd875fbaf11d1768261b92`. Paths in this table start at its `src/real/analysis/` directory. These are **source APIs**, not a claim that their compiled theories are present in the current runtime heap.

| Inspected source | Concrete reusable support | Missing bridge for this task |
|---|---|---|
| `complexScript.sml:1365–1476,1664` | `RE_IM_LE_MODU`, `MODU_MUL`, `MODU_DIV`, `MODU_CONJ`, `MODU_REAL`, complex triangle/algebra | Integer pair divided by a positive grid scale must be connected explicitly to this complex type and norm. |
| `complexScript.sml:1861–1948` | `complex_exp z = exp(RE z)*(cos(IM z),sin(IM z))`, `EXP_IMAGINARY`, `COMPLEX_EXP_ADD`, `COMPLEX_EXP_N`, `COMPLEX_EXP_NZ` | It is marked `nocompute`; a definition is not a certified finite evaluator. Prove polynomial tails and integer-rounding transport. |
| `transcScript.sml:626–817` | real `ln`, `LN_EXP`, `EXP_LN`, `LN_MUL`, `LN_DIV`, `LN_POW`, `DIFF_LN` | Port the exact range-reduced atanh-series remainder, rather than infer accuracy from a floating logarithm. |
| `transcScript.sml:3034–3195` | `TAYLOR_ALL_LT`, `MCLAURIN_ALL_LE`, real `MCLAURIN_EXP_LE` | Real Taylor theorems are not the complex 73-term bound. Derive the imaginary specialization from sin/cos derivatives/series, or prove complex series componentwise. |
| `seqScript.sml:1252–1281`; `real_topologyScript.sml:21001,21047` | real series scaling and `SERIES_DIRICHLET_BILINEAR`/`SERIES_DIRICHLET` | The latter is a convergence test, **not Dirichlet characters or a Dirichlet L-function library**. |
| `integrationScript.sml:9399,12511–12519,15020` | integral absolute bound, componentwise integrability, integration by parts | Actual infinite integrals/complex derivatives/endpoint limits needed by EM, Gamma and continuation remain proof work. |

A bounded symbol search of `src/real/analysis`, `src/algebra`, `examples/algorithms`, and `examples/algebra` found no ready Dirichlet-L/Hurwitz/Gamma/FFT implementation for this block. This is an absence of a located usable API in those inspected roots, not a theorem about the entire ecosystem. The installed dependent butterfly experiment is explicitly a rotate-and-pair network, not an FFT. Do not import HOL Light complex-analysis names as if they were HOL4 declarations.

`raw-state-handoff/RawStateHandoffScript.sml` already specifies exact signed `raw_mul`, `raw_trace`, `raw_head`, shape checks and `raw_pipeline`. Its input pairs are supplied integers. `raw_head` uses c*conj(Bc)*Ba and division by 2^140 to deliver grid100. It has no log, power or source-enclosure theorem. The read snapshot has failed `handoff02_generic.log` at `raw_pipeline_join`; the README/review are pre-execution design documents. No successful handoff performance result was found in that snapshot. Future root-run receipts supersede this status only when inspected; a repaired integer join still does not close analytic semantics.

## First implement the reusable analytic raw-state bridge

Use the existing Lean source proofs as mathematical specifications, **not imported HOL theorems**. Define positive-base power in HOL as exp((-1/2-it)*ln x); for x>0 this avoids an unnecessary branch-sensitive complex-log API. Prove its agreement with the positive-base powers used in the later L/EM definitions.

1. Connect `BlockRound.round_scaled_residual` to coordinate real error at most half a grid unit, including negative operands/ties. Prove four-product complex update error by the inspected complex algebra and triangle inequality. Port the exact source definition/tie convention, not only its informal intent.
2. Prove the actual integer log program: 45-term logPartial on 0<=v<=1/3; v=(x-2^k)/(x+2^k), k<=18; actual rounded Horner and final grid129 error <2^-128. `LN_DIV`, `LN_POW`, derivative/integral facts are ingredients. The specific geometric-series remainder lemma remains to be written in HOL.
3. Prove inverse-root initialization from two adjacent integer square inequalities, including nonnegativity, and bind the actual chosen integer producer or its proved witness. Port the grid98-to-grid120 exact shift.
4. Prove the actual 72-update integer exponential Horner equals the 73-term polynomial up to81/2^131, then grid122 re-round error<=2^-122, log-phase transport and tail. Target actual step error<2^-120; generic affine-error assumptions must be discharged by integer division.
5. Prove all retained states, starting from that source initializer, approximate B_x(5j/64) with error<2^-96 through j<=90000. No radius reset at chunk seams. Then prove actual head error and nonnegative conductor-scaled H/J0 sums. Exact grid100 polynomial-plus-head addition can give J0=0 only after both centers' grid membership is proved.
6. Cache C_c=c*conj(B_c) once per conductor/height and multiply by B_a per residue. Charge cache production, width, storage and source association; current `raw_head` scales by c inside every output and is not this cache optimization. Keep old materialized/fused integer fixtures as regression controls, not as the final analytic measurement.

The immediate deliverable is a HOL theorem about the **same supplied literal states and heads** and their actual positive-base complex powers, with all initial/step facts proved. It is a reusable checkpoint, not completion of the transform-to-sign goal.

## Fixed real transform block and acceptance target

Consume `forecast-audit-20261113/C10004_PARAMETER_PACKET.md` unchanged. c=10004=4*41*61, phi=4800, primitive count2301, ordered axes2,40,60; positive times5/64 and5/32, height zero for initialization. Every unit input and primitive output is included, both inverse channels. The plan uses radix2/direct3/direct5 and ordered CT, **no Bluestein**. A later separate plan is required to calibrate Blue cache production; this block must not be advertised as doing so.

The source recipe is first-band V500, source/output D512, EM N220/m64, source P27, delivered P20. Preserve the saved full-K20/b94 degree grids, original coefficient conversion, exact grid100 export/head assembly, then one p81 input conversion and the old safety guards. Do not replace this by thousands of independent Dirichlet-series sums: that would prove a sign but miss the architecture being calibrated.

Required constructive layers, in dependency order:

- Bind actual primitive generators modulo41/61, the 4800-entry CRT bijection and positive-exponent character labels. The saved packet does not supply those witnesses. Prove multiplicativity, periodicity, character orthogonality and primitive restrictions. Retain labels(1,k41,k61), k41=1..39,k61=1..59 and inverse pairing.
- Define actual nonprincipal L(s) on Re(s)>0 using its convergent periodic character series (componentwise convergence/partial summation), and prove the finite Hurwitz/EM formula used by the producer equals it. Show agreement with the absolutely convergent L-series for Re(s)>1. A later general analytic-continuation/FE bridge cannot be assumed from this definition. Prove the uniform EM remainder, derivative jets, shifts, full coefficient uncertainty and target-cell remainder for the specified grids. Raw B states alone supply neither jets nor the L input.
- Build checked elementary/rational coefficient producers, including EM constants/Bernoulli data, and exact root/twiddle enclosures. Reuse certified values only under exact argument/grid identity. Generate the source arrays once, reuse the two successive heights and both consumer paths; output integer equality plus derived analytic radii.
- Prove the actual ordered CT decomposition and pruning equivalent to the character transform, including flattening/permutations and all roots. Compose local rounded arithmetic bounds into p81 intrinsic error, separately from transported input uncertainty. Existing butterfly residual theorems are useful local lemmas only.
- Multiply by c^(-s), certify parity/root-number phase and the Gamma completion factor, and prove the completed Hardy quantity is real through the actual functional equation and conjugation. No Gamma/Dirichlet FE provider was located in the inspected HOL sources: this is a substantial named prerequisite, not an allowance that makes the theorem available. A theta/Poisson proof is a possible implementation route but must supply all convergence and normalization lemmas. A positive real part of unnormalized L is not this result.
- Export all4602 channel/time center-radius records with actual function/label identities and strict signs where zero is excluded. Report unresolved intervals explicitly. For a closed sign benchmark, predeclare a channel-selection policy and prove at least one positive-height strict Hardy sign from this same fully produced block; do not assume all intervals succeed. Preserve the rest of the block as enclosures, rather than dropping hard outputs from timing. If no interval succeeds, refine with separately charged work; no sign margin is guaranteed by the metadata.

A sign record alone proves no zero. Interpolation, disjoint sign-change brackets, true multiplicities, closed-boundary handling, and Turing upper-count/surplus proofs are separate requirements for finite RH. This two-height block does not establish them, high-height throughput, principal RH through1e8, small-family theta transforms, or finite Goldbach coverage.

## Measurement and stop gates

Measure two matched implementations only after the analytic specification is fixed: materialize the shared arrays versus keep them inside proved computation. Both must export identical full integer outputs, radii, source labels and successful-sign statements. Include all concrete arithmetic theorems in the measured acceptance closure; no hidden precomputed result imports. Generic analytic theorem compilation is a separately charged reusable library cost. Existing successful source imports must be pinned, and their construction must not silently disappear from first-admission totals.

Record separately: untrusted proposal generation; elementary/jet/root production and first proof acceptance; dependent state/head/CT evaluation; conversion/translation and cache hits; completion/strict-sign work; full output binding/export bytes; process CPU/wall/RSS; independent replay and corruption controls. Do not add diagnostic phase replay to a full replay that already contains it. Corrupt a source literal, root/permutation, interior state, label/parity and final output; reject through ordinary proof checking, not timeout. Failed attempts remain recorded.

The existing HOL dependent-network measurement is 73.960ms median CPU for8192 butterflies, versus3.747830ms native GMP, with64.013–123.944ms HOL range and4.269485s named-representation preparation per fresh process. It has418-bit maximum coordinates and a different network. These numbers motivate fusion and measuring translation, but cannot price p81 CT/source/sign production. The earlier Platt ~400000 native core-hours covers a different family/height program and includes native rigorous numerics, not HOL analytic-library/receipt construction. No ratio near that target follows yet.

Stop before a throughput extrapolation unless: the full actual block theorem has no numerical/source-enclosure assumptions; both paths match outputs; all proved sign claims have strict margins; full production/acceptance/output costs are measured at this boundary; the scope of reused generic theory is explicit. There is no honest completion date or historical-hours claim from current arithmetic measurements alone. The largest immediate risk is the missing HOL L/EM/completion theory, not whether integer arithmetic can be evaluated quickly.

## Inspected evidence pins

Hashes below identify this read snapshot; no source files were changed.

| File | SHA256 |
|---|---|
| `work/backend-costs-20261112/raw-state-handoff/RawStateHandoffScript.sml` | `455CFBD26F17FDFC7B206F1735B8E66676C7D9048FC51AD5F6205A708C4FAECB` |
| `work/backend-costs-20261112/raw-state-handoff/README.md` | `AFFF2FF99024AD2C9C8E009F4F34C4926BD475614767C0222D94849E243FFCC2` |
| `work/backend-costs-20261112/raw-state-handoff/handoff02_generic.log` | `63F8F83E09AADE86F43C8F50EA75F21D51022390C5BF8A5E2D93FFA358953816` |
| `work/backend-costs-20261112/hol4-setup/DEPENDENT_BLOCK_REPORT.md` | `E24815D2D36AA4EDAF929FC12CB0541D1B31E26A1606C110D654CBCCBA788908` |
| `work/backend-costs-20261112/forecast-audit-20261113/C10004_PARAMETER_PACKET.md` | `2B8102E8134B8BC9DA5BD93DD2105673EE6614B2D3D721B7E701F3A38C09F8EF` |
| `work/backend-costs-20261112/hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/real/analysis/complexScript.sml` | `8ECCC7980AC18D66CECE52D203A973E6DB945EF6994465CC4CDE3701BFE28B2E` |
| `work/backend-costs-20261112/hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/real/analysis/transcScript.sml` | `9B3C9D25F8E9014AB51784EE2639F1CC41FFAB0C9CFF0BD3A03426AD5D627C23` |
| `work/backend-costs-20261112/hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/real/analysis/integrationScript.sml` | `15261E76DFBB3C46B5D25D32F214BAAEF5663C33C45A2335C5F57993197827AB` |
| `work/backend-costs-20261112/hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/real/analysis/real_topologyScript.sml` | `DA04B9CEB9D8CA3D42F9326AF64B0CC1A325DFF78D5DB13D998A4B8A333B54C0` |
| `work/lean-pilots/raw-head/RawStateProducer.lean` | `E5335116BA0B90DD92D500FCD0EFA5A89586D08C334D64C0F9EC01AB12D9B961` |
| `work/lean-pilots/raw-head/RawStepProducer.lean` | `A30763650701C171C20B3EB6908F0918A95F1A64A2F0BEBB557D0D42070F53AE` |
| `work/lean-pilots/raw-head/RawLogTail.lean` | `2D6E8E9A38086653661FF06A263164BF04B077E41C7EFBDD96011466EB52AB55` |
