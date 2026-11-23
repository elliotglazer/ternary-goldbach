# Review of the completed numerical screen and failed terminal check

13 November 2026. Reviewed the saved `screen04` receipt, all seven job observations, all eight numerical records and the exact V5 code path. No numerical evaluator, benchmark, process monitor or screen runner was rerun. One small pure-policy test was executed, together with exact-integer checks of the already saved comparison operands.

## What happened

The worker published eight `pass` records in the prescribed order, followed by `complete`. Its reported total CPU was 260.15625 seconds. The parent's retained process handle reported exit code 0. The final job observations show lifetime process count 2, active count 0, no limit-terminated processes and an empty current PID list. The original process handle still reports PID 46232 and membership in the job. The parent wall receipt is about 264.4 seconds.

The earlier observations bind PID 46232 to the expected base Python executable with creation FILETIME 134390344095168834, and PID 16672 to System32 conhost with creation FILETIME 134390344095279811. All five pre-terminal saved role observations are valid. The two terminal observations have only the error `original Python identity mismatch`.

The empty terminal PID list is not itself the rejecting condition. V5 only requires the original PID in that list while both nearby process-status observations say it is live. Both terminal statuses here are 0, so that condition is skipped. Instead, V5 lines 167-170 unconditionally call `win.identity` again and demand its aggregate `valid` flag, expected PID and image path, even after process exit. That rejection makes line 269 raise `final process-role rejection`. The finally-block repeats the same check and preserves failure.

V5 unfortunately did not store that particular `current_original` result. Consequently the saved record does **not** identify whether its image query or time query failed, or another component differed. A post-exit image-query failure is a plausible explanation, not an observed API error code. The separate retained-handle PID, exit and membership queries did succeed. V6 explicitly saves the complete current-original query and the adjacent exit-query result, so that ambiguity will not recur.

## Numerical evidence that remains usable

The saved numerical output is not erased by the supervisor's terminal rejection. The exact threshold reconstructed from the prescribed rational formula equals the saved threshold. Each of the eight saved dyadic lower bounds is strictly greater than that threshold. The point labels, character order and final completion list also agree exactly. These checks recompute only integer fractions from existing records; they do not independently recompute an L-value or prove FLINT's ball enclosure theorem.

Thus this run supplies eight native interval margin comparisons under the stated backend/normalization assumptions. It is evidence that the conditional 2^-160 time-gate margin test passed at those eight sites. It supplies no actual FFT, canonical phase signs, zero count or HOL proof. There is no need to repeat the expensive numerical workload merely to establish what those already saved comparisons say.

The original overall receipt remains **failed**. Do not rewrite `success:false` or call this a clean supervisor pass. The exception occurred before V5's final memory query, post-run worker-hash check and final event-file digest/sequence validation. This review checks the current saved event sequence and pins below, but cannot retroactively produce the missing peak-memory measurement or a file-hash observation at the original exit instant. The earlier configured hard memory cap and observed lifetime identities remain distinct evidence from those missing terminal fields. Any stronger acceptance must state that qualification explicitly.

## Narrow future correction

`run_screen_v6.py` leaves the worker, caps, permissions, hidden-console handling and strict unknown-process policy unchanged. It adds the pure function `original_identity_errors` and logs its inputs. While the original worker is live, full image/PID/creation identity remains required. After an exit status is independently available and matches `GetExitCodeProcess`, the retained original handle must still return the same PID and creation time. A failed fresh image query is then tolerated because the earlier image was bound to that same never-replaced handle. A successful wrong or incomplete image query still rejects. Failed creation-time queries, changed PID, changed creation time, absent prior identity and inconsistent exit queries reject.

This is not permission to reopen a PID after exit and trust its former identity. The relaxation applies only to the original Popen handle, retained continuously throughout the run. Listed unknown or console-host processes keep their existing strict identity rules. A nonzero worker exit can satisfy identity continuity but still fails the runner's independent success requirement.

`test_post_exit_policy.py` ran once under the installed base Python with `-I -S -B`, exit 0. It imports V6 only to call the pure policy function; no Windows API, FLINT import or child process is invoked. Fourteen synthetic cases passed, covering valid live/terminal states, failed live images, changed PID/creation time, unavailable time queries, missing/contradictory exit status and successful wrong terminal images. The same test then checked the eight saved rational comparisons and confirmed that the historical success flag is still false. This is a focused policy test, not a test of the complete Windows runner.

## Pins

| Artifact | SHA256 |
|---|---|
|screen04/receipt.json|3A5AE78330C70C0B8039430551455CCBD113F18E46E50F330400FB655DA246D5|
|screen04/events.jsonl|97EFF26D747057A442D1E2B07C75BF5AFE719F1C6C2ED94DFEC5215C66324795|
|screen04/job_diagnostics.jsonl|63D184F238AA760270097C9F9F229AC7D039510B2CD6262DD1CF1A38577ECC0F|
|run_screen_v5.py, unchanged|07B7B64D58135BC6D0C33C2CF362EADE0D74CFEE3F4663509194CF5565B6CDB2|
|worker_v2.py, unchanged|517333F06458759348B5098EB58466B8A82AE2D97143054E34E49F2B7409483D|
|run_screen_v6.py|EB906F5091367DB7B11BD866F5D6F6891E381AC325BC996B733E6BA0A11B43EA|
|test_post_exit_policy.py|6CA70866AAD933C453C8CAA0A6A956AFF738159D2A48D39F5AF3B42903B019BF|

All paths are relative to this `native-sign-screen` directory, with `screen04` under `runs`. No historical file was changed. V6 has not launched a worker and requires coordinator review before future use.
