# Binary Goldbach at the trillion endpoint

Lean 4.35 accepted every even integer from 999,998,951,426 through 1,000,000,000,000 inclusive. The prespecified interval has 524,288 even integers. Its 80 prime anchors and the certified source bitmap fit in one existing proof row. `TrillionEndpoint.log` records the theorem's three dependencies: `propext`, `Classical.choice` and `Quot.sound`. The interval leaves a gap above the contiguous prefix.

| Phase | CPU seconds | Wall seconds | Peak RSS, KiB |
|---|---:|---:|---:|
| Generate endpoint witnesses and 1,593-byte Lean source | 0.422 | 0.459 | — |
| Independent FLINT primality and bitmap union check | 0.109 | — | — |
| Import-only Lean control | 15.250 | 15.54 | 1,442,252 |
| Compile and audit the endpoint theorem | 13.422 | 13.52 | 1,472,740 |

Both Lean runs used a single worker and a 1,750 MiB Lean memory limit. The import-only run used more CPU than the endpoint proof. This pair measures standalone acceptance; it does not resolve the incremental cost per row in a large batch. The producer used 0.219 CPU seconds for the bitmap and cover and 0.203 for the native factorial and inverse. Its source write took 0.0007 wall seconds.

The source bitmap had already cost 62.531 CPU seconds to certify. The million-factorial certificate is shared with the disjoint mid-band experiment. Its generation, nine-module verification cost, and the final endpoint object size appear in `summary.json`. `dependency-io.json` records the size and digest of each shared artifact and the elapsed time to read, hash, and hard-link cached files into this proof directory. Filesystem-cache state affects that timing.

Reproduction uses `produce.py`, `audit_native.py`, and `verify.py` in order. The verifier reads the checked million-factorial artifacts from the neighboring `finite-midband-batch` directory and the certified bitmap from `finite-interval-sample`. The source hash is 48af482098d0f0f8eb48ce52fe10b3d777f005c844bf9f8b04162b0bf09fa7b2.
