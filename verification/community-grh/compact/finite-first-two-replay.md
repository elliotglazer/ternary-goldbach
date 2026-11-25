# Adjacent binary Goldbach blocks on Lean 4.37

The single export selects `SmallGoldbach.Power10.block0`. The pair export selects the one checked conjunction `GoldbachBenchmark.firstTwo`, containing the actual block 0 and block 1 proof terms. The half-open ranges are [6, 1,258,291,206) and [1,258,291,206, 2,516,582,406). Both checkers accepted both exports with the same stock binaries and settings.

| Phase | Single wall s | Pair wall s | Single CPU s | Pair CPU s | Added CPU s | Single RSS KiB | Pair RSS KiB |
|---|---:|---:|---:|---:|---:|---:|---:|
| export | 207.649 | 90.140 | 101.496 | 83.161 | -18.335 | 2,695,420 | 2,709,348 |
| leanchecker | 154.505 | 250.304 | 143.294 | 245.115 | 101.820 | 1,777,964 | 1,786,916 |
| nanoda | 126.202 | 219.243 | 121.815 | 214.144 | 92.330 | 1,147,184 | 1,150,948 |

The exports contain 20,337,444 and 25,478,920 uncompressed bytes. Adding the adjacent block and conjunction added 5,141,476 bytes and 902 theorem declarations. The only axiom declarations in each export were `propext`, `Classical.choice`, and `Quot.sound`. The marginal wall time is sensitive to competing jobs and cache state. Neither measurement covers later binary blocks, the final join, or the analytic and GRH dependency closure.

The portable JSON binds both inputs and exports by SHA-256 and records UTC start times, commands and individual process accounting. It excludes the large exports. On this shared machine the paired export ran faster after the first pass. The additional block cost 101.820 CPU seconds in the stock kernel and 92.330 CPU seconds in NanoDa. These observations establish neither the cost of later certificate families nor whether the full finite prefix fits 330 minutes.
