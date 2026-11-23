# Fixed native sign-margin screen

Prepared source only. Neither program has been run, imported or syntax-tested by its author. This implements the phase-free eight-point margin screen in `../NATIVE_SIGN_EXPERIMENT.md`, not its optional canonical-sign stage. It produces no FFT, zero count, canonical sign or HOL proof.

After source review, the coordinator can launch exactly one attempt from the repository root:

```powershell
& 'work/qrh-campaign/interval-env/Scripts/python.exe' 'work/backend-costs-20261112/hol-platt/native-sign-screen/run_screen.py' --run --label screen01
```

The label must be new. Both files and the pinned native helper should be included in the coordinator's source snapshot. The runner creates `runs/screen01` exclusively. The worker waits for GO before importing FLINT; the runner sends GO only after Windows job assignment and membership verification. The interpreter's standard-library startup precedes assignment. No claim of a suspended-process launch is made.

The runner reuses the inert `Win` definitions from the pinned `rational_j7_supervision_20261111_native.py`. It imports neither that campaign's supervisor nor its analytic evaluators. Its new job has active-process limit 1, kill-on-close, and hard 2 GiB process/job committed-memory limits. The parent enforces a 300-second whole-attempt wall deadline and samples job user-plus-kernel CPU against 300 seconds. These are not a bound on all OS memory or on the parent's memory. Failure to establish or query containment rejects the attempt. There is no unbounded fallback, retry or precision change.

`worker.py` fixes precision 512 and one FLINT thread. Exact integer checks bind Conrey 1877/2813 to the proposed CRT characters. It constructs rational inputs through `fmpq`, uses interval pi/logGamma/exp and actual `l_function`, exports exact midpoint/radius dyadics, and compares the exported modulus lower bound against the exact rational threshold using Python integer arithmetic. A finite positive margin is required at all eight fixed labels. Character mismatch, nonfinite output, unavailable API or inconclusive comparison stops before the next point. The candidate tolerance 2^-160 is not the FLINT working precision.

`events.jsonl` is exclusively opened and flushed plus fsynced after every record, before its matching stdout print. It records all planned labels initially, a start before each L-function call, and the individual result before the next call. Its cap is 256 KiB, with 32 KiB per record. Errors after opening are recorded when possible. A process kill or native crash may leave a start without a result; this remains failure evidence. The parent also preserves `stderr.log` and a bounded `receipt.json`, and checks the exact eight-label result sequence before declaring native-screen success. Files are never removed on failure.

The named extension-module hashes and Python hash identify part of the numerical backend. They do not constitute a complete transitive DLL trust audit. Decimal timing fields are observational; all analytic inputs, exported enclosures and acceptance comparisons avoid binary floating-point conversion.

Source preparation deliberately makes no claim that the FLINT constructor or exact-dyadic export API has already succeeded for these inputs. A first-run interface error must be reported and fixed in a separately reviewed revision. A failed Conrey binding must not be replaced by different characters inside the same attempt.
