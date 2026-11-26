# Protected Goldbach replay on the retained host

This package runs the public Palomar verifier at `14aa8d6b3c2f14a8540605e37144560b9a00e7e7` on a caller-supplied commit and tree from `elliotglazer/ternary-goldbach`. It binds the challenge, solution wrapper, axiom allowlist and Lean 4.35.0 by content hash. The package contains the operator scripts and tests. It does not include any Lean objects or proof exports.

## Window and timing

The proposed UTC window on 26 November 2026 opens at 10:30 and ends at 17:00. The original stop is 10:17:24. This package uses the live schedules' saved readbacks and never contacts AWS APIs. The operator must have independent approval for the second window and enough remaining budget, verify the original stop completed, verify the identity of the retained instance and mounted evidence volume, allow no overlapping proof work, and independently read back the new enabled account stop before starting the host. Securely copy both unmodified `aws scheduler get-schedule` JSON results to the host under root-owned paths. Preserve the original readback before expiration if the scheduler deletes it after completion.

The latest start is **11:10 UTC**. Starting at 10:40 leaves until 16:10 for stock verification and 16:30 for the entire 350-minute job. Palomar's 330-minute clock covers trusted setup, the source fetch, dependencies, both builds, exports and judging. The extra 20 minutes let the job record its outcome and collect evidence. A completed verdict from any earlier development job does not extend either clock.

## Start the job

Run the following in the authorized root shell on the intended host. Choose `C` and `T` from the reviewed candidate. Set `JOB` to a distinct, previously absent directory immediately under a trusted root-owned evidence parent that the verification user can traverse. Set `STAGED` to the release extracted as root under a trusted prefix such as `/opt/tg-stock-protected`. Use physical paths owned by root with no group or other write permission at any ancestor. Set `PREVIOUS_STOP` and `SEPARATE_STOP` to the two distinct readbacks described above. No personal AWS credentials are needed by the proof job.

For a time that includes *all* trusted provisioning, make the following write the first operation of the verification job. Use an existing trusted root-owned parent for `ORIGIN` and an absent filename. Then fetch and authenticate the review-pinned release and provision the original toolchain and verifier prerequisites inside this clock. Reusing already-installed job tools or dependencies calls for the `preprovisioned` label. The helper records which basis the operator selected.

```bash
set -euo pipefail
( set -C; umask 077; printf '%s %s\n' "$(date -u +%s)" "$(cat /proc/sys/kernel/random/boot_id)" > "$ORIGIN" )
```

For the host already provisioned during the earlier rehearsal, use `BASIS=preprovisioned`. For a genuine whole-job rebuild begun at the marker, use `BASIS=original-before-trusted-setup`. Check the archive SHA-256 against the independently published value before extracting it. Then run:

```bash
( cd "$STAGED" && sha256sum -c SHA256SUMS )
/usr/bin/python3 -I "$STAGED/protected_window.py" begin \
  --commit "$C" --tree "$T" --job "$JOB" --setup-basis "$BASIS" --origin-record "$ORIGIN"
/usr/bin/python3 -I "$STAGED/protected_window.py" run \
  --job "$JOB" --staged "$STAGED" \
  --aggregate-sha256 2fce0fb9bd3436303aa017d9b94383689a21fe5f152f0679266b3d908407d28a \
  --previous-stop "$PREVIOUS_STOP" --separate-stop "$SEPARATE_STOP"
```

The operator must retain the real clock on a retry. The fresh proof directory and write-once clock stop the same attempt being overwritten. Each fresh authorized attempt gets its own resource and time window. The command enforces a 32-vCPU CPU quota, a shared 64-GiB maximum and zero swap at `user@1001.service`. It runs an independent qualification, then repeats the official resource probe in the same user-manager subtree and continuing process as proof execution. It refuses unrelated active work in that user manager. The named controller's reversible needrestart exception lasts through those commands. The comparison models Palomar's published profile on EC2. The hosted Palomar runner uses a different provider and CPU.

## Runtime and results

The unprivileged user is `grhreplay` with UID 1001. The reviewed host setup provides Python 3.11.10 at `/opt/palomar-verifier-14aa8d6b/venv/bin/python`, bubblewrap v0.12.0 at `/opt/palomar-verifier-14aa8d6b/bwrap-bin/bwrap`, and the Elan/Ruby/Bundler environment at `/opt/palomar-verifier-14aa8d6b/lean-license-runtime/activate.sh`. Stock input inspection runs Licensee from its pinned policy Gemfile. Stock pulls and authenticates the Lean 4.36.0-rc1 archive for its con-ron override, even with a locally installed checker. That operation needs HTTPS from the host to GitHub and its release-asset redirect, working CA roots, curl, GNU tar, zstd and writable scratch. Git and the public dependency and package fetches must also work. Source intake and this exact fresh checker fetch passed independently in local Linux. Only an actual protected run can establish remaining host and project behavior.

The worker invokes the unmodified stock `prepare`, `check-capacity` and `execute` commands. `PALOMAR_JOB_STARTED_AT` is the original Unix timestamp, and `execute` receives `--execution-budget-seconds 19800`. Stock compares the independent challenge and solution. A completed `pass/complete` requires the internal Lean checker and NanoDa. The external kernel list records NanoDa and, if accepted, con-ron. A stock-recognized con-ron decline remains visible in the warning and in `kernel_attempts`. A rejection fails the run.

Preserve the raw `origin.json`, `clock.json`, both qualification logs and probe reports, `protected-console.log`, and `proof-scratch/proof/{prepared-report.json,mechanical-report.json,SHA256SUMS}`. The underlying `work/resource-metrics.jsonl` and both proof exports support audit. A local `pass/complete` with a qualifying shared cap and recorded elapsed time supplies reproducible evidence about this hardware. Palomar publishes its own hosted verdict separately.

The attached `operator-control.json` records the stock CLI and timeout test, hash checks, and positive and negative control fixtures. The scheduler, cgroup and kernel examples in those particular controls are synthetic. `stock-intake-333aa9bb.json` is an actual independent source-intake receipt. `stock-checker-download-control.json` is an actual independent pinned checker materialization. Neither claims a completed end-to-end proof. The initial EC2 aggregate probe refused admission before changing resource settings. This release requires fresh success from the corrected aggregate probe every time.
