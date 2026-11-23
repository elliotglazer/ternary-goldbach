# actual sources — 2026-11-21

## 07:14:31 UTC · Final

The +640 guard schedule contains **1,787,257,220,237 small-family coarse samples**. Extending the measured two-halo layout to every label gives 1,791,987,359,885 sample occurrences.

At the four measured channels’ rates, raw-to-compressed projection adds **74,987 core-hours**, and the compressed sign and repair checks add **97,388**. Holding the prior subtotal fixed gives **800,847–801,376 core-hours**, or **847–1,376 above twice Platt’s historical figure**. This is a conditional price for the explicit full-grid route. Upstream guard costs and remaining proof obligations still need pricing.

If fusion eliminated just the measured projection numeral-construction cost, **36,324–36,853 hours** would remain. The ledger credits no savings for that fusion or for the pending witness-only route.

[Ledger and overlap analysis](../../../work/backend-costs-20261112/hol-platt/campaign-cost-ledger/README.md) · [Exact counts and budgets for all four guards](../../../work/backend-costs-20261112/hol-platt/campaign-cost-ledger/ledger.json)

## 07:27:17 UTC · Final

The sparse witnesses preserve both width-50 Turing comparisons. Independent decoding reproduced the main counts of **31,760** and **31,762**, preserved every auxiliary flip’s right endpoint, and verified the strict inequalities using the original phase bounds.

Some main right endpoints moved. The checker uses only main flip counts and auxiliary weights, so those changes do not affect either comparison. The 71,325 retained raw samples exactly covered the selected signs, endpoints and 103 interpolation stencils. Analytic transfer from the raw samples to the actual functions remains a separate obligation.

[Independent audit](../../../work/backend-costs-20261112/hol-platt/sparse-count-audit/README.md) · [Exact weights and margins](../../../work/backend-costs-20261112/hol-platt/sparse-count-audit/audit.json)

## 08:06:49 UTC · Final

Stock HOL checked the 71,325 retained raw projections and the compressed sign/count replay in 25.353526 inner CPU seconds. The independent archived coarse-sign replay overlaps this work and should be priced separately.

The end-to-end link remains open. The concrete fixture binds label 3, block 1, to original positions 105–127. HOL rejected the first proof that transports the raw enclosures through the masked lookups. The timing therefore covers the two checks separately.

## 08:11:22 UTC · Final

Stock HOL proved `projected_masked_row` and checked it on the 23 retained samples at original positions 105–127 of conductor 10000, label 3. The concrete proof checks that `SparseHead.load_row` places each compressed value at its original index and that the resulting interval encloses its corresponding raw value.

The theory built in 2.4 seconds. This closes the lookup bridge for one actual row. Full-table lookup preservation and transfer through a complete repair window remain open. [HOL build log](../../../work/backend-costs-20261112/hol-platt/sparse-head/link04.log)

## 08:37:27 UTC · Final

Stock HOL proved a strict positive raw interpolation margin for conductor 10000, label 3, repair tick 1, kernel 0. It checked all 48 original positions, 105–152, across two masked rows in the full table used by the sparse count. It also checked job membership, kernel identity, each raw sample’s enclosure, and the computed positive sign. The verified evaluation took 0.759 seconds. The theory built in 9.0 seconds. [Repair proof log](../../../work/backend-costs-20261112/hol-platt/sparse-head/actual06.log)

HOL also proved that loading any valid row or suffix of rows at base \(b\) preserves every lookup below \(b\). This allows a checked row to be reused after the rest of the table loads. The concrete margin proof covers one of the 103 selected repairs. [Preservation proof log](../../../work/backend-costs-20261112/hol-platt/sparse-head/preserve03.log)

## 08:50:23 UTC · Final

Stock HOL proved strict raw interpolation margins for **all 103 selected repairs** at conductor 10000. The four proofs covered 27, 30, 19, and 27 jobs for labels 3, 6667, 11, and 9091. Each proof matched the complete ordered job list used by the original sparse count, checked every support lookup and raw enclosure, and verified the signed raw dot product against the kernel’s error threshold. [Job-by-job audit](../../../work/backend-costs-20261112/hol-platt/sparse-head/all-window-jobs.json)

The complete standalone replay took **151.52 CPU seconds** and 199.23 seconds wall time. The four channel checks accounted for 114.05 CPU seconds, including 3.72 seconds of verified evaluation. The standalone replay repeats table loading and enclosure checks from the earlier sparse-count run. The incremental cost of combining them remains unmeasured. [Proof log](../../../work/backend-costs-20261112/hol-platt/sparse-head/all02.log) · [Process timing](../../../work/backend-costs-20261112/hol-platt/sparse-head/all02.time)

## 09:05:20 UTC · Final

Checking all 103 raw interpolation margins added **33.415 seconds of inner CPU** and **42.87 seconds of complete process CPU** across the four conductor-10000 channels. Both stock HOL runs proved the original pair counts using the same input tables. The fused run also checked every signed raw margin against the repair code consumed by the count.

| CPU seconds | Count only | Count with margins | Increase |
|---|---:|---:|---:|
| Inner worker | 13.362 | 46.777 | 33.415 |
| Complete HOL process | 35.38 | 78.25 | 42.87 |

At the sample density used for the existing **37,066 core-hour** estimate, the matched inner increase projects to **48,852 additional core-hours**, or **85,917 total**. Replacing the old count timing outright with the new fused timing gives **82,700 core-hours**, including the previously measured projection. The difference comes from the new count-only baseline running faster than the original.

Reading and encoding the packed raw windows accounted for **25.884 seconds** of the increase. Verified evaluation added **2.715 seconds**. The extrapolations assume the four sampled channels represent campaign repair density and input costs. [Timing receipt](../../../work/backend-costs-20261112/hol-platt/sparse-head/fused-cost.json)

## 09:22:03 UTC · Final

**The 103 separate raw-margin evaluations can be eliminated** once the retained sample and interpolation bounds are established. Stock HOL proved a generic theorem that transfers either compressed repair sign to the strict sign of the true Hardy value. It derives the consecutive sample lookups from the successful repair itself. The proof used no raw-window literals and built in 2.5 seconds. [Theorem source](../../../work/backend-costs-20261112/hol-platt/sparse-head/RetainedTransferScript.sml) · [Successful build](../../../work/backend-costs-20261112/hol-platt/sparse-head/transfer10.log)

Two obligations remain for the campaign. Every populated head must enclose its original raw code, with the corresponding true scaled sample within two units of that code’s center. The true interpolation residual \(R\) must satisfy \(R+10\,\mathrm{den}\leq\mathrm{den}\,\mathrm{err}\) for the checked kernel. The theorem charges the two-unit sample error once. The existing compressed sign threshold covers head quantization.

Under those premises, the sparse projection-and-count estimate is **43,401–44,496 core-hours** across the three-conductor pricing scenarios. The separately measured **48,852 core-hour** raw-window increment drops out. The cost of establishing the two remaining obligations is outside that estimate. [Three-conductor pricing](../../../work/backend-costs-20261112/hol-platt/sparse-hol-panel/three-conductor-price.json)

## 10:32:12 UTC · Final

Stock HOL proved that **every one of the 17,883 retained lookups** in conductor 10000, label 3, encloses the raw value from its original archived tile. The proof uses the same `HeadPairEven.raw_3` table as the saved sparse pair count. It took 26.69 inner CPU seconds and 77.82 complete process CPU seconds. The remaining channel-wide analytic premise is a two-unit error bound at each retained source sample. [Channel proof log](../../../work/backend-costs-20261112/hol-platt/sparse-head/cinv06.log)

For the two-stream producer, HOL proved that its emitted digit encloses its generated raw center and that the existing sparse loader recovers in-range digits at their original mask positions. Once the producer’s packet-order, range, and analytic accuracy proofs are supplied, the separate **16,669–17,109 core-hour** archived projection can be omitted. The measured downstream count and table-loading estimate is then **26,731–27,387 core-hours**. Additional serialization or reload work remains unpriced. [Proofs and accounting](../../../work/backend-costs-20261112/hol-platt/sparse-head/CHANNEL-TRANSFER.md)

The historical QRH strip comparison reported a **27.5% reduction in height-weighted workload** against its contemporary partial-RH baseline while retaining the same 5.54 billion character labels. It supplied no CPU conversion. The published conditional full-GRH route’s **300 core-hour** planning figure covers only finite binary certification through \(1.615\times10^{12}\), excluding GRH validation and the analytic formalization. [QRH comparison](../../../work/qrh-blueprint/SPECTRAL_BASELINE_COST_COMPARISON_2026-11-11.md) · [Conditional finite-cost model](../../../work/grh-goldbach-20261120/finite_cost.json)

## 10:33:17 UTC · Finding

gAAAAABrAXNrZwG02dIhRZUSq0hYjyzR_33gADQfE-p2vFCXTZIhNUTDLkRF5Wpf5B_gAgikCi9P9GtrBdQlzlGJVgqWcO9tLtjCPm817UlD-8Kw3Iq_GwXwLeNBUbeN4SLFoTvz0WAaEYDfFOPk_s17cWr8sO9ica1O-G4t99hrXOJ7bS1yeMGeWOQr3sbRnVLC2CDeLGGvJxqMlRdWs6EvMGgKhwFDoj75jkHBw1ot8kWtxc1zYGLjhkOsqlar2fN76VdTYY_BhAkdUCG5QCBrHATOnskLWFnorsFKo3l1e_LuuwEdOhhZdoKOSjWtQck5s2KYqkf1C7ONBZQAf6_q6kaxOEBrFMisYOSr76FW6OlYBVxffm3nh0lBetAVXIWgLimy0cy0kR_mSz-1bGxuasw2bmrEY_-8cQ5ju2EUjUi6nsG2Q5dLPyUrxEdBxtTm9fXfkM0ZAy2OOAnUjQH6D6qFU50JQVWefuFXu9UugAlDZUCPbcK4dwMXyhuV1ZyONEdyhBdifQYf0a9ET49Hv0gB3wK_MPZM2TyfIazezADh2xvdwG0Tm0ULMpGMnKC9x8Lp6gUStzOcbqh9A4jTrA5JL21ttlUuIAPi_WZ3zQdW9dgcBSSbyZo-RHsXttxV0Uq9cy8gRwBI4H1iI7R9l1tzacJ0a3XRp6Eoofr4gCn2KR7UB21sSUPlj5ztKOr_ajK18ZdaP796Et8Xriml62IbszGMPfXjHmIueujNGGjHVOWyzfe5ZdIVYaYETQt5HgIoSmCHsPebx8fkxOIpOyI8uLXJ0aFEIrdOQwXaOCVwl-v7RBLBnpLs5iNhurlkOQ9yrGnTXS4ERaiPqozYDv83zhbhn2u8uROflc1sX7_4BvJRnWBszjvkfaX2tX-Z56VqW9hwRGUhwUbqy09wUryJERU3IgK93CByGxeMnb5sJvjOIAr9OLZfv_6Fh3rw69QxHYEgGUR4XcpZOZll64g_NCjfTb9D-GrAGQm6I8cdvF8xe2iZF9cGYmO48xOO2CeTECLuOhbOreflvsbBlJEGockjHFr_dGbpkXd5xV4qz9DhuvN8Hc8jKnQ2LG17w7uS_EfQKa0x7em2FsCy6LADaDtUg8V4vDKxm9u4SqwLQZ6i_vLRDlus3d0hRJGcSF42kNUBYH9aP1JTAgGvTVNP_RYbp9-vwc-V3_zE6Y4t1iqs2wdsHGaEexAmxsympvTWlVt5vBgP8R0OjLEfk0D1lhGwk9SlSkdUnHfzbQby9d0dI_EyBUDEZlwMQ8Xoz8NOThpHp2c5_zl7j2GHnn60yvruCgg8uiSpsVj7jv4GeOUemA_JDeumZuQItWOzAf-Go2WUJ348VY83qk1MvvLJWxcoHh6yxh5FQppJnCPvov-gRpV_DVDkg3tFYvxdTVkEaXKd6jFK9jM9rqMG__zj2M80RQvuS5sq2UZLFl4Sk4KUfyY_a1UnyEK7JQ818U0-sILnmKVAicRONjgEY2jY16pHws-fhtEGAdLrCW13ErCF7_DMvN97SUHEPxrvul1yHAyQKzyMRBBouU-diAq268KoGg==

## 10:34:19 UTC · Final

| Route | Recorded price | Scope |
|---|---:|---|
| Custom verified-native checker, binary Goldbach through \(4\times10^{18}\) | **100 core-years** planning, **50–300** per independent verification | Requires a new checker and a proof that its executable implements the certified rules. A separate full production pass followed by verification gives an illustrative **100–600 core-years**. The native prototype’s 21.5–93.5 core-years covers parsing and coverage alone. [Optimized checker model](../../../work/mm0-efficient/SCOPE.md) |
| Original finite cutoff with Platt supplied externally | Same \(4\times10^{18}\) binary obligation, plus the existing ladder | The repository reports about **5 one-core hours** for its 254,638,308-rung ladder, including about 4 hours of kernel checking. The full theorem takes both Platt and binary Goldbach as explicit hypotheses. The large theorem above \(10^{27}\) takes only Platt. [Original theorem and ladder](../../../work/ternary-goldbach/README.md) |
| Reoptimized finite cutoff \(10^{16}\), with a denser ladder | HOL **26.27 core-years** planning, Lean **24.40**, Candle **36.08** | Includes finite certificate production and first acceptance. Favorable/stress values are **5.16/803.62** for HOL, **6.64/759.85** for Lean and **6.09/1,490.91** for Candle. The planning case needs 118.68 billion rungs. [November 13 finite model](../../../work/backend-costs-20261112/forecast-audit-20261113/END_TO_END_MODEL.md) |

The older **2,000 Lean / 20,000 ordinary-MM0 core-year** estimates target the same \(4\times10^{18}\) binary statement as the custom checker, but use different proof representations and include construction and checking. Their **147** and **729** native core-year figures price individual arithmetic implementations. The historical **770 core-years** also included producing partitions and statistics. None of these figures prices a formal Platt replay. [Historical forecast and measurement boundaries](../../../work/formal-goldbach-bench/FORECAST.md)

## 10:48:44 UTC · Final

Stock HOL proved the exact digit range for the two-stream producer. For width \(w>0\) and exponent \(e\), the digit fits precisely when the generated raw center lies in \([-2^{e+w-1},\,2^{e+w-1})\). [Range proof](../../../work/backend-costs-20261112/hol-platt/sparse-head/prange01.log)

The guarded producer preserved the original packed value and count on arbitrary inputs and passed all 140 retained sites in the genuine four-channel pilot. A closed HOL counterexample shows why the guard matters: at width one, digits \(2\) and \(-1\) pack to zero and pass the original packet equality, while the guarded producer rejects them. [Pilot receipt](../../../work/backend-costs-20261112/hol-platt/sparse-head/guarded-sites.json) · [Counterexample](../../../work/backend-costs-20261112/hol-platt/sparse-head/digitcontrol01.log)

The matched pilot took 93.906 CPU seconds with the guard and 88.142 without it. Literal conversion and garbage collection dominated these measurements, so the 5.764-second difference does not establish a campaign-wide guard cost.

## 11:13:54 UTC · Final

The large-family transform and Platt’s real function have the same sign when they use the same character phase. The fixture computes the unnormalized positive-frequency sum \(D_\chi=q^sL(s,\chi)\). Platt’s normalization differs from the completed fixture value by the strictly positive factor \(e^{\pi t/4}(q/\pi)^{-1/4-a/2}\). Changing the square-root branch reverses every sign for that character and preserves its sign changes. [Source alignment](</work/backend-costs-20261112/hol-platt/large-coordinate-sources/README.md>)

The last Bluestein diagonal can be absorbed into the static character phase. The audit gives a direct pre-diagonal error bound and a transfer bound for implementations that certify only the rounded post-diagonal output. Across the four guard schedules, phase setup covers **1.528–1.608 billion conductor-height rows**, with at most **169,762 shared gamma factors**. The setup price remains conditional on stock-HOL replay costs. [Error bounds and census](</work/backend-costs-20261112/hol-platt/large-coordinate-sources/DIAGONAL-AND-SCHEDULE.md>)

A native Arb check enclosed 2,048 normalized gamma factors at genuine low and high heights. Every coordinate radius was below \(2^{-145}\). The two 1,024-factor panels took 0.0625 and 0.015625 CPU seconds. The campaign-wide functional-equation and gamma-enclosure links still require formal proof. [Measurement receipt](</work/backend-costs-20261112/hol-platt/large-coordinate-sources/gamma-panel.json>)

## 11:22:27 UTC · Final

Stock HOL4 proved the pre-diagonal error transfer. If \(c\) is the exact unit chirp, \(h\) approximates it within \(d\), \(|U|\le b\), and the terminal rounding and output errors are at most \(r\) and \(e\), then \(\lvert U-\bar cD\rvert\le db+r+e\). [Proof](</work/backend-costs-20261112/hol-platt/large-coordinate-sources/PreDiagonalScript.sml>)

Two independent native computations agreed on **all 339,524 rounded gamma-phase coordinates** in the maximum guard schedule. Direct log-gamma took 4.73 CPU seconds. A 19-term Stirling calculation took 12.56 CPU seconds.

Stock HOL4 checked 4,096 coordinate bins at genuine low and high heights. The slower panel rate projects to **0.875 core-hours** for checking supplied bins across the full schedule. The stock proofs cover the interval-to-rounding step and the numerical tail bound. Deriving the input intervals from the analytic gamma function remains open. [Receipts and scope](</work/backend-costs-20261112/hol-platt/large-coordinate-sources/STOCK-RECEIPTS.md>)
