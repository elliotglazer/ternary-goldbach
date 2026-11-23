# Two adjacent high grid points at conductor 10004

A 32-residue pilot at j=84199 used 0.125 CPU seconds and 0.256 wall seconds. Sampling every 150th input in tensor order projected 76.8 wall seconds for the 9,600 Hurwitz evaluations. The full one-thread run took 46.469 CPU seconds and 61.605 wall seconds for its source stage. This compares with 1.609 CPU seconds and 1.752 wall seconds for the two low-height source stages, roughly 28.9 times the CPU and 35.2 times the elapsed time. High source timing includes streaming the TSV rows. Low timing includes formatting but excludes file writes.

The signed value is exp(pi t/4) times the phase-fixed conductor-completed Hardy value documented in ../c10004-real-transform/README.md. The positive exponential offsets the gamma magnitude decay at large positive t. Each Arb interval starts with the computed rounded character spectrum, enclosed by the independently bounded direct DFT on the same input. Input coordinates are nearest p81 representatives of direct 176-bit Arb Hurwitz enclosures. Every input enclosure fit strictly in its claimed rounding cell. Shared Gauss sums, paired phases, parity, and gamma factors follow the low-height convention.

| Grid index | Height | Positive | Negative | Inconclusive | Lower bound for smallest scaled absolute value | Channel (k41,k61) |
|---:|---:|---:|---:|---:|---:|---|
| 84198 | 6577.968750 | 1493 | 808 | 0 | 0.001867768720 | (29,6) |
| 84199 | 6578.046875 | 1598 | 703 | 0 | 0.002725689110 | (29,50) |

453 channels changed sign. The other components used 0.328 CPU seconds for Gauss sums and phases, 0.203 for both rounded transforms, 0.641 for both independent direct transforms and 0.078 for both completion passes. The maximum complex errors in the unnormalized spectra were bounded by 20,763 and 20,596 grid units, respectively. One grid unit is 2^-81.

The receipt binds source and result files by SHA-256. The completed TSVs store integer spectra, unnormalized spectral error bounds, scaled real balls and signs. These measurements concern two direct-source native evaluations. Historical P20 source evaluation, HOL checking and a completeness count require separate evidence.
