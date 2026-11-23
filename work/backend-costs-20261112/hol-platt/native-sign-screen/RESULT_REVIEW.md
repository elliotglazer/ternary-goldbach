# Screen04 result review

13 November 2026. Independent read-only source and receipt audit. No evaluator, build, benchmark, or process-control action was run for this review. Only stored JSON, source, hashes, and exact rational arithmetic were inspected.

## Verdict

The numerical evidence is admissible as a native eight-point modulus-margin diagnostic. All eight planned comparisons pass independently reconstructed exact rational tests. The whole supervised attempt remains FAILED: `receipt.json` records `success: false`, `RuntimeError: final process-role rejection`, and child exit code 0. The coordinator reports runner exit code 1. This review does not amend that receipt or classify the run as a successful supervised execution.

The failure occurs after the numerical worker's complete event. The evidence supports a terminal process-identity handling defect, but does not identify the failing Windows API. That distinction matters: numerical completion and successful supervision are separate claims.

## Exact experiment and numerical checks

The reviewed worker is `worker_v2.py`; the runner is `run_screen_v5.py`. The old README describes an earlier runner, so its active-process limit 1 and original launch command do not describe screen04.

The worker fixes conductor 10000 and Conrey labels 1877 and 2813. Before any L evaluation it checks the conductor, primitiveness, nonprincipality, odd parity, order 500, group size 4000, group exponent 500, nonunit values, and the three CRT-generator exponents. The two character events record exponents `(0,125,1)` and `(0,375,499)` modulo 500 on residues `(8751,2501,9377)`. These residues represent `(-1,1)`, `(5,1)`, and `(1,2)` modulo 16 and 625. The checked local orders 4 and 500 and the inverse-character test bind the requested character descriptors. These remain native exact-metadata checks, not HOL character theorems.

Both characters are evaluated at exactly `0, 5/64, 3290, 6580`, in that order. The corresponding grid indices are `0, 1, 42112, 84224`. No point was substituted, retried, or omitted. The event sequence is start, backend, two character records, threshold, eight alternating point-start/point records, then complete. The complete event lists all eight labels and explicitly sets actual FFT, canonical signs, and finite RH to false.

The reference uses 512-bit interval arithmetic and one FLINT thread. Every analytic input is an exact integer/rational or an interval constant. With `w=3/4+it/2` and `b=pi/4-16/1645`, it evaluates

```
Q = exp(-3 log(pi)/4 + b t + i t log(10000/pi)/2 + logGamma(w))
    * L(1/2+it, chi).
```

This matches the pinned proposal. `Re(w)=3/4` stays in the positive half-plane. Combining the exponent does not change the Gamma/conductor normalization. The unit root-number phase is intentionally absent.

I reconstructed the threshold from `eps=1/(2^80*4*3^64)`, `L0=6/40960`, `H0=44/(7*40960)` and

```
R = 3 eps/(4 L0) + 524288*42*(2*1250000^2+2)/2^160,
T = 2 H0 R.
```

It exactly equals the event's rational value

```
T = 1239345253887621905893688092613709332842334951
    / 85762552924899799024554863200715791306577169916280229097160948496696103403520.
```

For orientation only, `R` is about `4.708363e-29` and `T` about `1.445089e-32`. All acceptance decisions here used exact fractions, not these decimals. The following deliberately rounded-down rational bounds are strictly below the stored dyadic lower bounds:

| Character | t | Verified lower bound for the native ball's modulus | Point CPU seconds | Point wall seconds, rounded |
| --- | ---: | ---: | ---: | ---: |
| 1877 | 0 | >1.75 | 0.203125 | 0.219 |
| 1877 | 5/64 | >1.99 | 0.421875 | 0.430 |
| 1877 | 3290 | >2.27e-13 | 63.296875 | 64.332 |
| 1877 | 6580 | >2.57e-27 | 58.656250 | 58.840 |
| 2813 | 0 | >1.75 | 0.156250 | 0.164 |
| 2813 | 5/64 | >1.64 | 0.312500 | 0.315 |
| 2813 | 3290 | >2.95e-13 | 61.828125 | 62.076 |
| 2813 | 6580 | >1.67e-28 | 75.203125 | 76.269 |

Every exported lower bound exceeds T. The smallest ratio is strictly greater than 11597, at character 2813 and t=6580. I also checked, using exact exported midpoint/radius dyadics, that each lower bound squared is no greater than

```
max(0, abs(real_mid)-real_radius)^2
+ max(0, abs(imag_mid)-imag_radius)^2.
```

Thus the acceptance follows from the stored rectangular Q ball itself; it is not merely a replay of the Boolean `strict_comparison` flag. The analytic assertion that those rectangles enclose the actual Q still relies on the native interval implementation and the reviewed normalization.

Under the proposal's separately required real-normalization, coefficient, root, and gate-error hypotheses, `|Q|>2 H0 R` and `omega<H0` imply `|F_b/omega|>2R`. A correctly generated real transform center within R then excludes zero by more than R. No such transform center, coefficient array, or root-number phase was generated here. These are phase-free magnitude margins at eight points, not eight canonical signs and not a uniform precision theorem. Neither opposite signs, zero counts, central multiplicity, simplicity, nor finite RH follows.

## Identity, limits, and the terminal failure

The runner fixes the direct Python 3.14.7 executable with `-I -S -u`. The worker waits for a PID-bound GO before loading FLINT. The pre-GO observation binds the original retained process handle, PID 46232, executable image and creation time. A later System32 conhost, PID 16672, is the only additional permitted identity. The active-process limit is 2 for those roles; the combined job and each process have 2 GiB committed-memory limits, not two independent 2 GiB allowances for total job usage. The runner reads back the configured limits before GO. Its 300-second wall and job-CPU limits are sampled, not exact hard CPU-time limits.

All five saved pre-terminal observations have valid roles: the empty job, assignment, and first three polls. Source inspection confirms later polls also execute role checks, although ordinary later observations are not all persisted. Both final observations show lifetime process count 2, active count 0, no listed PIDs, zero limit-terminated processes, retained handle PID 46232, successful membership query with membership true, and poll/raw exit code 0. Their sole role error is `original Python identity mismatch`.

`observe` calls `win.identity` unconditionally even after exit. That helper requires a complete fresh image-path query as well as PID and creation time. The new `current_original` result is not copied into the observation record. Consequently the logs cannot distinguish a failed image query from another failed identity subfield. They do establish that the rejection is in the final fresh-identity branch, rather than a reported extra process or missing live worker. A successor should retain the complete raw terminal identity result and distinguish retained-handle exit confirmation from live-process image admission. It must not weaken live identity checks or silently approve unknown processes. Such a repair cannot retroactively change screen04's status.

Rejection happens before the normal final memory query, worker posthash, event validation, and success assignment. Therefore the receipt has no measured peak-commit values or normal `events_sha256`/point-status summary. The hard configured caps and recorded absence of limit terminations remain evidence; a particular peak-memory value does not. This review separately hashes and validates the completed event file and current source bytes. Empty stderr alone is not evidence of supervisor success.

## Timing and interpretation

The worker complete event records 260.156250 CPU seconds and 264.171286 wall seconds measured after GO. Final job accounting records 259.250000 user seconds plus 1.015625 kernel seconds, totaling 260.265625 seconds for the worker and console host. Runner elapsed time is 264.404131 seconds. These distinct clocks are all below the declared 300-second thresholds. Runner-parent CPU and a measured peak memory are not available in the receipt.

These timings cover eight direct scalar L/Gamma interval evaluations and worker setup. They do not price the intended full transform, shared coefficient generation, phase certification, repair distribution, or formal certificate acceptance. Low and high heights have very different observed costs; no per-point extrapolation or universal backend multiplier is justified. The eight-point result supports testing the declared 2^-160 time-gate candidate under unchanged source/error contracts. It does not reduce the Gaussian source budget or establish success at the remaining grid points.

The failed supervisor result should remain visible beside the numerical evidence. A separate runner repair review is appropriate before a subsequent run; no numerical rerun was needed to perform this audit.

## Source and artifact pins

The original start event's worker hash matches the final current worker hash. Current runner, helper, interpreter/runtime and four recorded package fingerprints match their pinned bytes. The fingerprints cover the package entry and three selected extension modules, not the complete transitive DLL/Python-module closure. No stronger backend validation is claimed.

| File | SHA256 |
| --- | --- |
| worker_v2.py | 517333F06458759348B5098EB58466B8A82AE2D97143054E34E49F2B7409483D |
| run_screen_v5.py | 07B7B64D58135BC6D0C33C2CF362EADE0D74CFEE3F4663509194CF5565B6CDB2 |
| ../NATIVE_SIGN_EXPERIMENT.md | 52B4442E3F44B2CC28AC37DC1043865A18DC60FC75E66A6C63694E9AFB216B70 |
| runs/screen04/events.jsonl, 15,876 bytes | 97EFF26D747057A442D1E2B07C75BF5AFE719F1C6C2ED94DFEC5215C66324795 |
| runs/screen04/receipt.json, 4,863 bytes | 3A5AE78330C70C0B8039430551455CCBD113F18E46E50F330400FB655DA246D5 |
| runs/screen04/job_diagnostics.jsonl, 15,516 bytes | 63D184F238AA760270097C9F9F229AC7D039510B2CD6262DD1CF1A38577ECC0F |
| runs/screen04/stderr.log, empty | E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855 |
| Native Windows helper | CFC956B179C45AFAEAB5EA1DB42B05C06C643D0A10EC1682CBE0433248248E13 |
| Base Python executable | 4942B86A6597E5AEE0128DAA00050ED79BC21F6E709A78EB19CBFEB0C2F39AC9 |
| python314.dll | 0F9857FFDFE010FE6B99328D58C2E3C7472CE75F336BF9C2AD9BD5BCA3BCE700 |

The helper path is `work/qrh-campaign/agents/integration/rational_j7_supervision_20261111_native.py`. Package paths and their hashes are preserved in the backend event and literal worker pins. The source review `WORKER_SOURCE_REVIEW.md` and its `BASE_INTERPRETER_SOURCE_REVIEW.md` successor describe the versioned API semantics; this review adds the actual fixed-result and terminal-failure audit.
