# actual hol tensor — 2026-11-20

## 19:38:18 UTC · Final

HOL4 proved both concrete conductor-10004 integer transforms. All **4,602 complex outputs** matched the independent native spectra exactly, with 2,301 channels at each height.

The fresh HOL process took **46.06 seconds wall time** and peaked at **1,611,960 KiB RSS**. Transform execution used 0.660 and 0.650 CPU seconds. The wall time also includes encoding, decoding, proof checks and export. These proofs start from the supplied rounded integer inputs and roots. The analytic justification for those values remains separate.

[Replay report](../../../work/backend-costs-20261112/hol-platt/c10004-hol-replay/RESULT_REVIEW.md)

## 19:58:45 UTC · Final

HOL4 checked all **4,602 integer sign decisions** using one saved phase table. Reusing it reduced CPU time per height from **9.40 to 4.24 seconds** and **9.91 to 4.65 seconds**. The fresh process checked both heights and exported the theorems in **27.55 seconds wall time**, compared with 47.60 seconds for the earlier representation.

Building the reusable phase theory took **63.00 seconds wall time**. Both benchmarks were single runs. The kernel proved the integer inequalities. Connecting their inputs and error bounds to the exact completed L-values remains open.

[Shared-phase benchmark](../../../work/backend-costs-20261112/hol-platt/c10004-hol-shared-phase/RESULT_REVIEW.md)
