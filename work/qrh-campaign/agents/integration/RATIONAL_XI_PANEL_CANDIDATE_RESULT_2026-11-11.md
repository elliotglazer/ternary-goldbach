# One rational xi-panel candidate: completed producer, independent replay pending

2026-11-11. **The fixed external rational producer completed with `POSITIVE_REAL_DISK`. Independent numerical verification is pending.** This note reports one small rectangle and its containing disk. It does not report a Lean proof, a spectral zero count, a high-height computation, or production coverage.

## Frozen candidate and inspected files

All files below are under `work/qrh-campaign/agents/` unless noted otherwise.

| File | SHA256 |
|---|---|
| `integration/rational_xi_panel_candidate_20261111_01.json` | `1B55E8A2665EF872056DE9747670E6F47017863A49D9E2C9A2D6604B6F74D09F` |
| `integration/rational_xi_panel_backend_20261111.py` | `DEE8AC9AA39F25023C77003BC2AAA5970388A016207AD5A8EE0DF8F6D912F84A` |
| `integration/coordinator_rational_panel_run_20261111_01.json` | `CD6FDC2976D70BD0A7C98E67FC7C3F470E78843DBC454E3645FB29D0E1677243` |
| `integration/inspect_rational_xi_panel_candidate_20261111.py` | `D38DB33ADD038C24278CBF91BE0ABC9542C6EEF8FDD236A5AD32179D0A39A88F` |
| `integration/inspect_rational_xi_panel_candidate_20261111.json` | `6C2C8C20E7F62180C721D936F64C441BCC75AA634FCE1DF745E22B14CE0D9101` |

The candidate contains 77,741,605 bytes. The coordinator reported producer process exit 0. The run record authorized a 600-second cap; the backend did not record a stopwatch duration, so this note makes no runtime or throughput claim. Frozen producer code, candidate data, and run record were only read during this inspection.

## Exact target and result

The target is the actual source-normalized unhalved xi function through

`F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`, with `b=pi/4-1/33`.

`T_input=32` determines this shift; the independent work-height parameter is `T_work=14`. The center is `3/5+14i`, disk radius `1/64`, and the closed rectangle is

`[379/640,389/640] + i*[1791/128,1793/128]`.

The five recorded vertices traverse the rectangle counterclockwise and repeat the initial vertex. Every corner's squared distance from the center is `1/8192`, less than the disk radius squared `1/4096`. Convexity then gives containment of the whole rectangle in the disk.

The signed quadrature grid has `h=1/256`, `K=928`, and `V=29/8`; seven coefficients approximate `F_b^(j)(3/5+14i)/j!`, for `j=0,...,6`. The exact assembly yields

```
U = 5036321197660915222794245251845311766369
    / 2722258935367507707706996859454145691648,

Re(c0)-U = 38298917929334686432095733439357895762079
           / 2722258935367507707706996859454145691648
         > 14.0688.
```

Here U bounds the nonconstant polynomial on the entire disk using the L1 norm of each rational complex coefficient and powers of `1/64`. The exact scalar-budget receipt gives

`E = 91500568239/1000000000000 = 0.091500568239 < 1/10`.

Thus the candidate's combined mathematical implication is

`Re(F_b(s)) >= Re(c0)-U-E > 13.977299`

throughout this disk, provided its arithmetic enclosures are correct and the reviewed analytic interfaces are supplied. The strict positive-real conclusion implies nonvanishing on the disk and rectangle. Multiplication by the nonzero exponential transfers nonvanishing to xi. Passing from xi to zeta on this rectangle uses the separate source identity and nonzero Gamma/polynomial factors; it is not an independently executed zero-count computation.

The recorded constant image polygon consists of five copies of 1, with four zero crossing contributions and winding zero. This surrogate is justified by the positive-real whole-disk implication, not merely by sampled endpoint values. It does not establish any claim outside the specified disk.

## What this inspection checked

The new inspection uses standard-library integers and fractions and does not import the producer or evaluate a node or weight. It read and hashed the entire frozen candidate, checked all source pins, and established:

* Exactly 929 ordered nonnegative node indices, all at 320 bits. No 512-bit retry was needed. Terminal types were theta2: 120, theta4: 387, theta3: 422.
* The S-step distribution was zero: 687, one: 236, two: 6. All words start with theta3, end without a further S, and record a terminal imaginary lower bound at least `2/5`. These structural checks are not a fresh proof of every word operation.
* Each stored P rectangle is ordered; its exact L1 distance to its `2^-32`-grid center equals the recorded radius and is at most `2^-24`. Every center satisfies the required norm budget. Every terminal jet includes the recorded `2^-277` tail.
* Exactly 1857 signed weight rows and 12,999 coefficient weights, with integer centers on the `2^-64` grid and recorded radii at most `2^-48`. The zero-node weights have their exact required values.
* Reconstructing negative P centers by conjugation and multiplying every signed weight reconstructs all seven integer coefficient pairs on the `2^-96` grid exactly. No doubling of positive-node contributions was used.
* Recomputed U, margin, error budget, rectangle distances, assembly geometry, success label, constant polygon, crossings, and winding agree with the receipt.

The inspection checked stored radius allocations and their consistency with stored P boxes. It did **not** independently certify that those boxes contain the true P values, or that the weight centers enclose the true transcendental weights. These are exactly the obligations of the separate independent replay now in progress. A stored radius assertion alone is not sufficient evidence for either obligation.

## Analytic and formal acceptance boundary

The specification is `prime-estimates/NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md`, pin `92E778B5D9C767D18461CD0B239F94FD38B15023B13576FFBBC2EFFE8D00E957`, reviewed at `zero-sum/REVIEW_NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md`, pin `2F05928D57B1E76F513095FE5CCA4D5930EF314EB658EE748016E52FBE84CC97`. It includes the derivative quadrature and spatial bounds, Cauchy remainder, rounding allocations, and the sharper sixteen-mode analytic tail. The general two-fifths tail review is pinned separately in the candidate.

Static backend review `audit/REVIEW_RATIONAL_XI_PANEL_BACKEND_2026-11-11.md`, pin `91DA66968EE08FD35E50A31B39405ACFA9EC063234833D9E5A0085964621D7EA`, found no blocking correction. It checks the T/S conventions, actual theta derivatives and P reconstruction, full-input root/reciprocal arithmetic, endpoint-wise small-exponential enclosure, signed weights and final comparison. That review is source inspection, not behavioral acceptance of this receipt.

The source Fourier evaluator and modular-node substitution remain reviewed paper interfaces at pins `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99` and `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571`. Their future formalization, elementary analytic lemmas, rational-checker soundness and exact finite Lean acceptance remain necessary for a kernel proof. Python execution is not an axiom or a proof substitute.

The current candidate is reproducible by source-pinned recomputation. It is not a standalone operation-proof trace: the initial Machin event is not retained per node, and weight elementary events are not serialized. The separate reviewer uses different rational precision/series parameters and independently accumulated derivative matrices. Its verdict, when complete, should be attached as a new pinned review; this report intentionally stops at **candidate success pending independent verification**.
