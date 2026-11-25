# Compact Goldbach AWS verification

This package runs the joint source build on the existing stopped `tg-grh-source-replay` EC2 instance in us-east-1. Use an immutable public Goldbach commit containing the integrated compact source and its reviewed Git tree. The pilot reuses the original 600 GiB encrypted evidence volume and existing scheduled stop. The launcher validates both pins before changing AWS state.

```sh
python3 compact_joint_stack.py --commit REVIEWED_COMMIT --tree REVIEWED_TREE --profile palomar-32x64
```

The default build submits the compact Main and GoldbachSolution roots together. Lake continues independent work when one module fails. Use `--shard-main` for a separate compact-GRH timing. With that option, a failed compact compile stops the run before GoldbachSolution is submitted. Failed-run summaries include up to twelve source locations, the number of source-error headers and affected files, separately counted compact and Goldbach objects with Lake completion traces, and the location of the full build log on the retained volume. A later clean run starts with fresh project objects.

The worker imports the pinned Mathlib cache, compiles all 794 converted compact GRH modules and the full Goldbach solution, validates the proof edges and three axioms, exports the separate challenge and solution, and judges the exports with stock Lean 4.35 and NanoDa. It then attempts the pinned con-ron override using the registry's exit classifier. `--extra-paranoid` requests a separate additional Lean paranoid pass after baseline timing.

The profile uses 32 vCPUs, 95% pressure and 98% hard memory limits based on 64 GiB, zero swap, and the registry's file and task limits. The driver records observed elapsed time against 19,800 seconds while continuing mathematical verification until the account's hard stop. A run over 330 minutes records `profile_outcome=over-simulated-budget` even when the mathematical check completes. This trial uses EC2, a separate Mathlib-only challenge built from a fixed trusted statement, and a source audit of the original and converted proof. Palomar additionally runs its own source-provenance, challenge-alias and judge controls.

Each attempt uses a new immutable workspace under `/work/compact-joint-runs`; old source and evidence remain available. A corrected commit starts a fresh build and reuses the authenticated toolchain and compressed Mathlib downloads. A shortened or unavailable Git pin, active host, wrong data volume, disabled deadline or timing window outside the original reservation stops dispatch before paid restart. The worker stops the instance when the attempt finishes. The existing scheduled stop covers interrupted setup and lost CloudShell sessions.

The driver emits `TG435_RECEIPT_REF` with the retained path and SHA-256 of the full JSON receipt. The following `TG435_RECEIPT_V1` line carries the SHA-256 of the uncompressed summary JSON and base64 of its gzip bytes. Stage records include elapsed and aggregate CPU seconds, sampled cgroup working-set peaks and lifetime cgroup peak. The summary stores the proof SHA/tree, both export hashes, check outcomes and timing classification. The Linux VM retains full object manifests, hashes, logs, per-process GNU time reports and exports. A forced account stop can preserve an incomplete receipt on disk before a terminal console marker is produced.
