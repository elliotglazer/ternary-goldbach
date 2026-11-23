# Two primitive real-character counts

Each quadratic character was run once through the native Gaussian spectrum, positive-height grid and repair search. The normalized Gauss sum enclosed (+1) for both. Independent Dirichlet L-value checks verified the gauge at coarse indices −1, 0, 1, the main cutoff and the auxiliary cutoff. The central L-values were strictly positive.

| Conductor and Conrey label | Parity | Main cutoff | Positive brackets, coarse → repaired | Closed lower count | Repaired upper count minus lower count |
|---|---|---:|---:|---:|---:|
| 65,537 and 65,536 | Even | 690 | 1,621 → 1,623 | 3,246 | 0.945 |
| 132,899 and 132,898 | Odd | 442.03125 | 1,056 → 1,058 | 2,116 | 0.914 |

At each conductor, one interior probe certified two new positive brackets. Each auxiliary interval had width 50 and used already certified coarse endpoint signs. Conjugation takes every positive-ordinate root to a distinct negative-ordinate root of the same character. Thus both the main bracket count and the auxiliary weight enter twice. The two-channel allowance is 36. The strict integer bound (U<K+1) passed for both repaired runs. Coarse-only excesses exceeded four in both cases. [Even character receipt](real-q65537/real-count.json) · [Odd character receipt](real-q132899/real-count.json)

The supplementary parity rule follows because nonreal zeros pair under conjugation, real zeros away from the center pair under reflection (β ↦ 1−β), and the observed center is nonzero. These checks are native interval evidence conditional on the analytic Turing and Fourier error bounds and their transfer to the closed count. Two characters are insufficient to estimate a family repair rate. [Driver](real_character_scan.py)
