# Analytic estimates and stock HOL4 proofs

All paths below are relative to the workspace root. The HOL project directory is `work/backend-costs-20261112/hol-platt`. Paths in the HOL sections are relative to that directory. The results describe finite computations or conditional theorems. They do not establish a full Hardy sign certificate or all-n ternary Goldbach.

## Zinoviev at 10²⁰

`work/grh-goldbach-20261120/team/zinoviev-totient-repair.md` contains a proof that φ(q)>14.1√q for q≥3991, the list of 33 exceptions above 2330, and a stand-alone Python check. The last failure is 3990. The corrected inequality validates this step directly for N≥exp(√(3990/1.1)). The note gives near- and far-arc error budgets for recovering the original 10²⁰ threshold. The downstream analytic inequalities remain unverified. The source module's header records a proposed repair. I could verify the journal metadata and the authors' open outline, but the publisher denied access to the full PDF. Existing Lean sources are `work/goldbach-lean/entries/languascozaccagnini2012/LeanLab/Zinoviev1997/{Arith,Lemma15}.lean`. These were inspected, not rebuilt. [Journal article](https://doi.org/10.1006/jnth.1997.2141) · [Authors' outline](https://www.maths.tcd.ie/EMIS/journals/ERA-AMS/1997-01-015/1997-01-015.tex.html)

## Sign archives

At conductor 10,000, four frozen TSV streams with 339,562 signs yielded 5,814 runs and a byte-identical reproduction of the 181,872-byte text archive. Run `grid-sign-join/benchmark_run_archive.py` with standard Python. The fixed-width binary version occupies 76,214 bytes. `grid-sign-join/benchmark_binary_archive.py` reproduces `packets-q10000.bin` and `binary-archive-results.json` in that directory. It checks complete row equality with the historical text and independently recomputes sign changes and weights. This layout uses 32-bit positions.

`archive-loader/ArchiveLoaderScript.sml` reads both formats inside stock HOL4 and checks all eight HOL run lists against the historic CountReceipt definitions. The first and reversed-order processes are recorded in `archive-loader/{loader01.log,loader01.time,loader02.log,loader02.time}`. The source retains the second run's ordering. `archive-loader/pricing.md` gives measured phases and extrapolation assumptions. At 41,029,096,839,823 signs and the observed occupancy, the median separate binary ingest estimate is 3,105 core-hours. The upper observed pass gives 6,545. These figures include construction and comparison of HOL terms. The historical scan and the transpose evaluator have different input boundaries.

## Mask decoding and temporal counts

`sector-mask/SectorMaskScript.sml` exports `packet_masks`: both accepted natural masks decode to the ordered fast-or-fallback terminal codes, with the alternating coefficient sets preserved. Its count is the number of lanes whose two codes differ. `sector-mask/SectorScanScript.sml` exports `sector_lane_scan`: for an accepted lane at two interior ticks p<q, FullCount.scan_between returns (0,0) for agreeing signs and (1,upper−q) otherwise. The build receipts are `sector-mask/{mask.log,scan.log}`. These theorems establish the representation and two-sample scan semantics. Connecting the codes to the analytic Hardy function and joining arbitrary adjacent packets requires additional proofs.

## Rounded endpoint checks

`endpoint-export/prepare.py` reconstructs the strict and rounded cases from the hash-checked TSVs and the two guard-repricing endpoint manifests. Run it before building `endpoint-export/EndpointExportScript.sml`. `endpoint-export/{receipts.json,selected-packets.txt,endpoint.log}` preserve the results. Fourteen distinct pair decisions and 56 scans were checked. All five original pairs passed the rounded inclusive, zero-edge-probe test. Under the strict geometry only one passed without edge probes. All five passed with the selected probes; one selected row duplicated its control.

`endpoint-export-panel/prepare_panel.py` independently reconstructs eight more rounded pairs from `work/grh-goldbach-20261120/team/gaussian-panel-q{65536,180180,65537,132899}`. Run it before building `endpoint-export-panel/EndpointPanelScript.sml`. Its input receipts and HOL output are `endpoint-export-panel/{receipts.json,selected-packets.txt,endpoint.log}`. All eight passed, for 13/13 rounded pairs across seven conductors. The eight main counts in the four directories' stated order are (5726,5726), (2753,2754), (3248,3249), and (2117,2118). Receipts identify label order. HOL checks the supplied signs and phase/allowance comparison, with every inclusive tick translated by +1, upper limit by +2, and auxiliary weight corrected by subtracting its sign-change count. The proof gives no analytic provenance for the input signs or phase.

## Mild tilt and interpolation

`guard-repricing/low-tilt-analytic.md` derives the continuous Fourier-moment bound from the inherited majorant. Run `guard-repricing/{low_tilt_selector.py,low_tilt_moment.py}` to reproduce `low-tilt-selector.json` and `low-tilt-moment.json`. At q=265800,V=505, θ=2,4,8 pass the stated rational selector tests with Δ=5/64. The 48-node continuous remainder is below 4.8e−11, 3.0e−12, and 1.9e−13 respectively in tilted-function units. The continuous method needs the analytic Fourier identity, majorant, and a phase-aligned sample enclosure. These are paper derivations and rational calculations, not kernel-checked analytic transfers.

## Stencil arithmetic and one genuine midpoint

All files for these results are in `guard-compact`. `CompactSignScript.sml` exports `stencil_sign` with integer dot Σkv and the separate ceiling bounds for unit input radii. `CompactRadiiScript.sml` exports `target_error` and `stencil_r_sign` for arbitrary real radii. Its bound is scale·R + Σ|kᵢ|rᵢ + ½Σ(|vᵢ|+rᵢ). `SpectralNodeScript.sml` exports `scaled_table_cons`, deriving a node enclosure from signed raw center/radius and a positive rational gain interval in output/input units. It proves the half-tie convention floor(x+½). Logs are `compact.log`, `radii.log`, and `spectral.log`.

Run `guard-compact/emit_q131071.py` to reproduce `Q131071NodeScript.sml` and `q131071-node.json`. It reads `dispatched-score/{precision-fine-hidden.json,precision-gain-packet.json}` and `guard-repricing/gamma-magnitude-p24.bin`. The phase-only packet for q131071, k266, even parity, tick 5694, p24 uses table bytes fef33d11 at offset 45552. The rounded center is −12,358,590 in 2⁻²⁴ output units. The fully completed archive row already contains gamma magnitude and uses identity gain. `Q131071Node.midpoint_11389_2_positive` proves the positive sign from the ten-node stencil, conditional on the nine other input intervals, the phase-only interval, true gamma-cell membership, and an interpolation remainder ≤1/4. The exact arithmetic lower bound exceeds 0.3629. `q131071.log` records successful export.

## Replaying the HOL theories

Use the pinned checkout `work/backend-costs-20261112/hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92` with its existing dependency artifacts. From each HOL experiment directory, inside the workspace-mounted docker-desktop WSL distribution, run:

```sh
../../hol4-setup/run.sh ../../hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/bin/Holmake --no_prereqs --no-project --no_preexecs --no-cache -j1 NAMETheory.uo
```

Replace NAME with ArchiveLoader, SectorMask, SectorScan, EndpointExport, EndpointPanel, CompactSign, CompactRadii, SpectralNode, or Q131071Node. Build prerequisites first in the order given within each section. Real-valued proofs import the local staged real theory under `raw-analytic/dependency-build-win01`. Existing up-to-date artifacts can cause Holmake to skip execution; the retained logs record the original proof runs. Pricing trials should use a fresh experimental output directory if a new timing receipt is required.

## Unfinished material

The proposed HOL4 uniform centered twelve-node remainder was interrupted before a theory was written. The pair identity follows by subtracting (k+x)(k+1−x) from (k+½)² to obtain (x−½)². The six-pair product, physical spacing 5/64, ρ=3/2, and connection to the per-conductor mass/shift certificates have no verified HOL4 result from this work. The previously completed paper-level pair bound is in `guard-repricing/low-tilt-analytic.md`. The historical agent identified `guard-repricing/strip-shortcut.json` and `strip_packet_parameters.py` as the related packet records. No fresh inspection or replay of the 270-conductor shortcut was performed for this handoff. Exploratory HOL tactic logs and saved proof heaps are debugging material. The successful source and build logs listed above are the archival results.
