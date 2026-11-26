# Local protected rehearsal with a shorter wall-clock cutoff

This optional operator package runs the same stock Palomar source preparation, capacity check and protected comparison as the full-window package. The original full-window archive has SHA-256 `cde3dd335ba392553e4b4416e653fc372ac960ae718279cf04aa418406c7c33d`. Its latest admitted start remains 11:10 UTC. Both packages target the 26 November 2026 window ending at 17:00 UTC.

## Timing

`--outer-seconds N` counts from the original trusted timestamp, including setup and fresh qualification. The local cutoff must be at least 60 seconds after the origin, at most 19,800 seconds after it, and no later than 16:57 UTC. The final three minutes allow the existing systemd controller to stop work, restore its shared cgroup and preserve records before the independent host stop. Choose an interval that leaves time for the actual proof. For example, a 12:00 UTC origin and 14,400 seconds give a 16:00 UTC local cutoff.

Both stock commands keep `PALOMAR_JOB_STARTED_AT` pointed at the original timestamp. Stock `execute` receives `--execution-budget-seconds 19800`. The launcher qualifies the aggregate 32-vCPU, 64-GiB, zero-swap profile before the protected work and again in the same user session. The two host-stop readbacks, inactive-work checks, restart handling, source fetch and allowed kernel dispositions follow the full-window implementation.

## Run

Use the already-authorized host and its reviewed verifier and Lean/Licensee runtime. `STAGED` is the trusted, root-owned directory containing this verified archive’s unpacked files. `ORIGIN` and `JOB` are fresh paths beneath trusted root-owned parents. `PREVIOUS_STOP` and `SEPARATE_STOP` are saved, root-owned AWS Scheduler readbacks for the same host. Keep these operator-specific paths and all service identifiers in the private environment.

Record the original timestamp **before** trusted setup or fetching the package for this attempt. The machine may already contain dependencies from an earlier rehearsal. In that case retain the timing label `preprovisioned`. Use `original-before-trusted-setup` only when the timestamp actually precedes the whole trusted setup. The first shell block creates a write-once file and records the current boot identity.

```bash
set -eu
( set -C; umask 077; printf '%s %s\n' "$(date -u +%s)" "$(cat /proc/sys/kernel/random/boot_id)" > "$ORIGIN" )
chmod 0444 "$ORIGIN"
```

Confirm the archive’s published SHA-256 before unpacking into `STAGED`. These commands start the rehearsal for the reviewed Goldbach candidate. Set `OUTER_SECONDS` to the selected local duration and `BASIS` to the applicable timing label.

```bash
( cd "$STAGED" && sha256sum -c SHA256SUMS )
C=cb1dffe10fd5a86ab53fb71a4812eb73786ed530
T=3b85151bc9d0c03b0a36db5cd19dcebd67db85d8
/usr/bin/python3 -I "$STAGED/protected_window.py" begin \
  --commit "$C" --tree "$T" --job "$JOB" --setup-basis "$BASIS" \
  --origin-record "$ORIGIN" --outer-seconds "$OUTER_SECONDS"
/usr/bin/python3 -I "$STAGED/protected_window.py" run \
  --job "$JOB" --staged "$STAGED" \
  --aggregate-sha256 2fce0fb9bd3436303aa017d9b94383689a21fe5f152f0679266b3d908407d28a \
  --previous-stop "$PREVIOUS_STOP" --separate-stop "$SEPARATE_STOP"
```

## Verdict and recovery

`limited-outcome.json` records the immutable source, original timestamp, selected cutoff, official budget, last readable stock stage and mechanical-report digest. The entire verifier work tree remains on the evidence volume. Preserve the root clock, aggregate probe reports, console logs, mechanical report, stock-completion marker, hashes and exports.

- `pass` requires an authentic `pass/complete` stock report with the required kernel outcomes. If the cutoff interrupts export hashing, the launcher can recognize a complete stock result from a matching timestamped report digest, source identity, verified job clock and qualified host.
- `inconclusive-local-cutoff` means the local cap expired without evidence of a complete stock result; the operator command returns 2. A full-budget failure cannot be inferred.
- `incomplete-or-error` records an early error. The original stock report and logs distinguish a proof failure from environment or setup problems.

After a hard interruption, run the following against the same retained job directory after its original cutoff. It does not launch a proof. It preserves and returns an already-recorded verdict.

```bash
/usr/bin/python3 -I "$STAGED/protected_window.py" recover --job "$JOB"
```

The local tests exercise the genuine pinned policy’s deadline arithmetic and CLI, and positive/negative operator controls including a real timed-out child process. The stage outputs used in the operator tests are fixtures; they do not certify Goldbach or establish a hosted Palomar result. See `stock-operator-control.json` and `limited-controls.json`.
