# Finishing diagnostics before the worker deadline

The source worker now reserves 120 seconds inside its two-hour supervisor budget to record its final result. When Lake reaches that limit, the next diagnostic can reuse completed modules after checking the source closure, output hashes, trace, root, and the supervisor's matching final record. An interrupted worker without that record supplies no layer.

On stock Lean 4.35.0 a deliberately delayed module ran into a 61-second Lake deadline. Five completed modules survived validation. After the delay was removed, Lake rebuilt only Deep and Main and exited successfully. The test also rejected five inconsistent or incomplete records. The separate two-root and changed-ancestor regressions passed. The time-limited test ran on a small local project. It gives no timing measurement for Goldbach.

The archive contains the previous independent-root operator scripts, the changed warm_main.py, its updated hash manifest, the tests and their receipts. It retains the original instance, deadline, resource limits and active-bundle guard. Use a separate operator directory. An already-running supervisor continues to use its original version. A cold proof checker still needs a fresh build.

To reproduce the new regression on Linux, run the fixture as root with the same toolchain, available bubblewrap namespace support, and the original V2 fixture assets. The arguments are the toolchain directory, bubblewrap binary and result path.

```sh
python3 -B test_timeout_layer.py "$LEAN_TOOLCHAIN_DIR" "$BWRAP" timeout-replay-test.json
```
