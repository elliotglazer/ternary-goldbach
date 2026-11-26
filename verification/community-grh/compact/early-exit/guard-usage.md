# Original AWS build interruption guard

These scripts apply to attempt `d69a0b0ad9464dbc84198f6c547221c7`, with source `0b68b493791e5f7569021f0cd13454151af47584` and tree `6d8764b58d1a41584cd5d43fd3e400f6ee55d18e`. Keep the two scripts together in an administrator-owned directory on the worker. The probe requires permission to read the worker processes’ namespace roots, executables, and file descriptors. It performs no AWS calls.

Run the readiness check on the worker.

```sh
python3 -B ready_0b68.py
```

A successful probe prints a JSON diagnosis and exits zero. Exit 2 gives the first failed guard. The bare `python3 -B interrupt_0b68.py` invocation also performs a read-only check. Inspect the recorded nine original failures, later failures, current log-prefix hash, runner and process identities before making a decision.

### Explicit operator decision

Only after deciding to interrupt this particular build, run the following on the worker.

```sh
python3 -B interrupt_0b68.py --interrupt-after-recording d69a0b0ad9464dbc84198f6c547221c7
```

The command rechecks the live attempt, pins the uniquely identified inner Lake process with a Linux pidfd, and writes and syncs `operator-interrupt-joint-lake-intent-v1.json` in the attempt directory. It revalidates the running receipt, process ancestry, captured log prefix, memory marker and Git state before signaling. The intent records the information available before the signal. The original supervisor writes the terminal receipt. If the final recheck fails, the intent stays on disk as evidence and repeated requests refuse.

Allow the original driver to write the raw step status, logs, hashes, and `driver.exit`, then sync and power off. Report a verified operator interruption after a genuine source failure separately from a naturally completed build. Inspect the original terminal receipt before counting completed objects. The data volume and shutdown deadlines remain under the original supervisor.

### Local verification

```sh
python3 -B test_interrupt_0b68.py
```

The tests build an isolated filesystem/process-identity fixture around an actual Git repository. The positive pidfd test signals a short-lived local child created by that test. Earlier independent Linux testing exercised stock Lake under bubblewrap with a timing wrapper and a real in-progress Lean compilation.
