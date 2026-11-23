# Q90090 middle-twist diagnostic map

Research diagnostics, 2026-11-11. The scripts `base_gap_90090_middle.py` and `base_gap_90090_middle_yscan.py` use the full source formulas recorded in `BASE_GAP_90090_PARAMETERS.md`. Their JSON outputs are floating Simpson calculations. They are not interval certificates or proofs over a continuum of scales.

For q=90090, u=q|Delta|, y>=1e25, the small-twist Type I2 formula is available on

    .05 <= w <= min(8, q/(2*c2*u)),
    c2=6*pi/(5*sqrt(32)).

The cutoff constant q/(2*c2) is approximately67591.2474355. Below this cutoff, the model uses the complete parameterized Type I1, Type I2 and Type II estimates with V multiplied by m and U divided by m. Above it, it uses the old raw first-choice bound with t=max(2q,wu/4). Both tails use17. The two Fourier minima are constant throughout the permitted small-twist interval. Therefore evaluating those branches at delta=0 preserves their values. The phase restriction is checked separately through the cutoff.

The actual source definition gives ghatY(1e25,150000) approximately.0601840070688, replacing the earlier rough .06027. For m=128, the diagnostic passes at the starting scale below u approximately47067.78 and above u approximately483216.64. For m=16 the corresponding crossings are43374.47 and483252.01.

| u | cutoff | integrated diagnostic, m128 | allowance minus bound at y1e25 |
|---:|---:|---:|---:|
|26000|2.599663|.055700177|.004483830|
|35000|1.931178|.057677797|.002506210|
|40000|1.689781|.058821955|.001362052|
|50000|1.351825|.060648574|-.000464567|
|100000|.675912|.063669849|-.003485842|
|150000|.450608|.064137352|-.003953345|
|300000|.225304|.063855305|-.003671298|
|450000|.150203|.061027910|-.000843903|
|500000|.135182|.059746113|.000437894|

The failure in the middle cannot be fixed merely by making the central formula smaller. At u150000 the raw-above contribution alone is.06217892878, above the entire allowance. Even replacing the central contribution by zero leaves failure. Numerically, raw-above plus the fixed tails exceeds the allowance for approximately103608<u<481735. These endpoints are diagnostics only.

Scale sampling also rules out inferring an all-scale result from the initial scale. At u40000,m16, the sampled slack is negative at y1e35. At u35000,m16, the smallest sampled slack over y=10^k,25<=k<=80 is.0005535503 at k37. At u35000,m128 it is.0008721146 at k46. At u500000,m128 it is.0003541875 at k28. Agreement after increasing Simpson panels is only a numerical consistency check.

The subsequent `RESUME_MINOR_2026-11-11.md` replaces part of this exploratory work by an exact compact-scale certificate. It does not certify the full middle band. The reviewed high-twist raw branch begins at u=26400000/49, approximately538775.5102. No all-twist denominator count is increased by these partial rectangles.
