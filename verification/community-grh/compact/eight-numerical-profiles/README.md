# Profile audit for Lean 4.35

At commit `e0722a0e5d3ebac13fba180599f4dd4551e98921`, Lean compiled eight numerical profile data modules. A separate import checked 44 row theorems and 44 cap theorems. Every row theorem uses `propext`, `Classical.choice` and `Quot.sound`. Every cap theorem uses only `propext`.

`receipt.json` records the source and public `.olean` hashes for the eight profile modules and their ten transitive project imports, along with their direct import names. It also records the Lean and Mathlib commits, the audit source and output hashes, and the timings for each profile. The eight successful module checks took 607.17 seconds summed over separate single-thread Windows runs with their project dependencies already compiled. The independent audit took 3.01 seconds. Peak working set is reported where measured.

With the eight modules and their dependencies on the pinned Lean search path, run the following command from this directory.

```sh
lean -j1 profile-audit-all.lean
```

The command prints the 88 declaration-level axiom lists reproduced in `audit.log`. This evidence covers the eight numerical profile modules. The complete Ternary Goldbach theorem requires additional modules.
