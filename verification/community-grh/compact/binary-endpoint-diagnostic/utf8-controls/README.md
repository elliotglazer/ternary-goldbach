# Bind the binary verifier to a finite source revision

Run these commands from `binary-endpoint-diagnostic`. The `scheduled` profile covers the 415 finite source files at proof commits `dafa3e64`, `cb1dffe1` and `8e9b8aef`. The `bitmap` profile covers `b6535e79`.

```sh
python3 bind_binary_source.py scheduled /tmp/tg-binary-scheduled.py
python3 /tmp/tg-binary-scheduled.py --help
```

The binder verifies the published source verifier, replaces one ASCII fingerprint field, checks the digest of the resulting file and checks the UTF-8 bytes of the entire Lean statement. The scheduled worker's SHA-256 is `c99727b5e03b78c59b8c33cbc0afb20958adccfa59e98a3bac698d27641718a2`. The binary theorem states that every even natural number from 4 through 564,386,325,504 is the sum of two primes. [Independent Lean statement](TrustedBinaryEndpoint.lean)  [Finite source measurements](../../finite-interval-scheduling/)

## Full statement regression

An earlier local copy of the scheduled verifier, SHA-256 `65609245d4427c36c6b5abc0e82405a441fead78cbaee32a4ac93020d3e176c4`, read UTF-8 through Windows code page 1252. The Python file still parsed, and its ASCII control theorem passed. Lean rejected its actual binary Goldbach statement at line 9, column 5. The corrected helper compiled the full statement under stock Windows Lean 4.35 and reproduced the independent 1,134,989-byte challenge export byte for byte. Its separate small control also passed the stock protected Linux Lean and NanoDa kernels. [Compiler, exporter and checker results](receipt.json)

To repeat the source integrity checks, run the command below. Add `--lean /absolute/path/to/lean --leanexport /absolute/path/to/leanexport` with the pinned Mathlib on `LEAN_PATH` to compile both the historical negative control and the corrected full statement, and to regenerate the independent challenge export. That challenge uses the comparator's statement placeholder. Acceptance of the production theorem requires the solution export and its own pair of kernel verdicts.

```sh
python3 utf8-controls/check_transport.py
```
