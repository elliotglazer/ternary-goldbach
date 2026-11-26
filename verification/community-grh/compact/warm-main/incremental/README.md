# Reusing a completed warm run

This helper builds the compact GRH `+Main` target in a fresh diagnostic work directory on the existing worker. Each accepted prior job contributes modules whose source, import ancestry, build trace and artifact hashes match the requested source. A failed warm run can supply its successfully built modules when its supervisor and Lake receipts are complete.

After the current v1 service finishes and the instance has stopped, run the following from the verified, unpacked v2 directory on the next authorized boot. Supply the 40-character Git commit and tree of the next repair and the 32-character job token printed for the preceding run.

```sh
sha256sum -c SHA256SUMS
python3 -B warm_dispatch.py --start-existing --commit "$commit" --tree "$tree" --previous-job "$previous_job"
```

Later repairs can be queued while that same v2 service runs. Omit `--start-existing` if the host is already running. To retain changes from several successive repair runs, repeat `--previous-job` for each completed layer, oldest first, up to eight. The program checks each prior job against its root-owned records and records which modules it actually reused. Omit `--previous-job` to use only the original failed cold run’s verified artifacts.

A v1 service keeps the worker lock until it powers off after eight idle minutes. The dispatcher refuses to replace it while active. Both versions keep the original fixed EC2 deadline, 16-CPU quota, 48 GiB memory pressure threshold, 64 GiB maximum and zero swap. The source build runs with four Lean threads. The warm receipt describes a developer build of `+Main`. End-to-end acceptance still requires a clean Goldbach build, trusted statement comparison and successful replay by both required kernels.

The Linux fixture uses stock Lean 4.35, two successive repair commits and a reader running as UID 65534. The second repair reused two modules from the original run and three additional modules from the first repair. Only its repaired dependent module and `Main` required compilation. Changing a parent invalidated its child, and changing a saved log caused rejection. The supplied JSON records the observed fixture outputs.
