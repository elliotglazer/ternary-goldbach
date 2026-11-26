# Ternary Goldbach protected replay

The immutable candidate is [f85040a7](https://github.com/elliotglazer/ternary-goldbach/tree/f85040a7a5263b32cce873ac345010a7d0f1f2b9), Git tree `728ed945f3e4e2a7c48d7ff0c01412cf43cc2ff9`. Stock source preparation checked 1,529 Lean files and found zero errors or warnings. The SHA-256 of that [preparation report](stock-palomar-prepare-f85040a7.json) is `b716e15988e4dc341ff17fe5d3704ba2220dc29cc95aa24642f7429f63ad9c5e`. Cold source compilation and protected execution remain pending for this exact candidate.

The challenge asks whether every odd natural number greater than five is the sum of three primes. It imports Mathlib's definitions of primality and parity. Its SHA-256 is `f9e6190b4c77c9bf474c6d36748278af41140237432fff72e8084a4c572a382a`. The Comparator configuration names `PalomarTernaryGoldbach.ternary_goldbach` and permits `propext`, `Quot.sound` and `Classical.choice`. Its SHA-256 is `073582e85645abd6e5949deb0531c11797ac9c1266073bf913b02d86173ebdcb`. [Package digests](stock-palomar-prepare-f85040a7-audit.json)

## Running on a separate Linux host

Use the [pinned Palomar workflow](https://github.com/PalomarRegistry/PalomarSubmission/blob/14aa8d6b3c2f14a8540605e37144560b9a00e7e7/.github/workflows/submission.yml) to install the trusted tools and prepare the candidate into a fresh directory. Record the actual start epoch before trusted job setup. The 32 × 64 profile checks for 32 effective CPUs and at least 60 GiB effective RAM. The unprivileged replay user needs the pinned bubblewrap and a systemd user manager with cgroup delegation. Pass the digest of that host's own fresh preparation report. Its timestamp can differ from the recorded local receipt.

```sh
python3.11 run_stock_palomar.py execute \
  --verifier "$policy_dir" --work-dir "$work" \
  --prepared-report "$prepared" --report-sha256 "$prepared_sha256" \
  --bwrap "$pinned_bwrap" --job-start "$job_started_at" \
  --output "$evidence/stock-execute.json"
```

Stock Palomar builds and exports a randomly named copy of the challenge using the trusted dependency tree. Its candidate stage invokes `lake build GoldbachSolution`. The verifier exports the solution to its own directory, checks the two exports with Comparator's Lean and NanoDa kernels, then runs con-ron on the solution. A recognized con-ron support or capacity decline is recorded in the final JSON. Any unclassified disagreement prevents a pass. The final fields identifying a successful run are `status = pass` and `stage = complete`. [Protected verification stages](https://github.com/PalomarRegistry/PalomarSubmission/blob/14aa8d6b3c2f14a8540605e37144560b9a00e7e7/scripts/verify_submission.py#L6264-L6518)

## An extended window

Both published hardware profiles allow 19,800 seconds (5½ hours) of verification and 350 minutes for the overall job. For a separately timed local 10-hour trial, pass `--execution-budget-seconds 36000` to the wrapper. This leaves the proof and official checker code unchanged and records the local budget in `stock-execute.json.timing.json`. A registered run under such a window requires Palomar to approve it and to provision an outer job with enough time. The pinned checker also limits an individual build/export/mandatory-judgment stage to 12 hours and the supplementary con-ron replay to 30 minutes. [Profiles](https://github.com/PalomarRegistry/PalomarSubmission/blob/14aa8d6b3c2f14a8540605e37144560b9a00e7e7/execution-profiles.json) · [Deadline implementation](https://github.com/PalomarRegistry/PalomarSubmission/blob/14aa8d6b3c2f14a8540605e37144560b9a00e7e7/scripts/verify_submission.py#L424-L482) · [Local command and clock checks](stock-palomar-window-tests-f85040a7.json)

## Evidence for a maintainer

Send the source commit and tree, the stock verifier commit, the preparation report and the protected theorem/configuration digests. When execution finishes, add the raw stock execution JSON, the pre-bootstrap start and completion times, the actual profile and window, the hardware allocation, and `work/resource-metrics.jsonl`. Record SHA-256 digests of both files in `work/exports/` and retain the exact export files for independent replay. The official report contains the Comparator log tail and con-ron decision. Those artifacts distinguish theorem acceptance from the separate question of fitting the published hardware and clock.
