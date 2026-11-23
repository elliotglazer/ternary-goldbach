# Binary Goldbach endpoint pilot on Linux

This directory contains the complete input for checking the last 1,024 even natural numbers through 10^16 in Lean. Copy the directory, or unpack the accompanying tarball, on Linux. Run from its root.

```sh
python3 run.py --smoke
elan toolchain install leanprover/lean4:v4.35.0
python3 run.py --bootstrap --run-dir run01
```

The prerequisites are Git, Python 3.10 or later, GNU coreutils, a C toolchain for building the Mathlib cache utility, and elan on PATH. The bootstrap needs HTTPS access to the Lean release, Git repositories, and Mathlib's official cache. A machine which already supplies the pinned Linux Lean and Lake binaries can omit the elan command. The initial build fetches the four required Mathlib import closures. Later runs can use `python3 run.py --run-dir run02` in the same directory. Each run takes a fresh output directory and leaves the dependency objects available for reuse. A Linux-native filesystem avoids the WSL Windows-mounted filesystem's overhead.

The bootstrap pins Lean 4.35.0 to source commit `eb6cafb7290e8bd5f2937522d8d804f58f02bafc` and Mathlib to `56a005855ea17e0b0958f73ec801ae140b0a1679`. The Lake lockfile fixes every transitive Git checkout. The runner checks the pinned input file hashes and regenerates the Lean certificate text from the JSON before building. It compiles the project-owned Lucas and coverage lemmas and the endpoint theorem in separate single-thread Lean processes, using trust level zero. The independent audit imports the theorem and verifies its inclusive upper endpoint.

Results appear in `run01/receipt.json` and `run01/Audit.log`. A successful receipt has `passed: true` and reports precisely `propext`, `Classical.choice`, and `Quot.sound`. The receipt records CPU time, elapsed time and maximum RSS in KiB for each subprocess. Bootstrap has its own row. Peak RSS measures one process's high-water mark for sequential proof stages. For a bootstrap stage with concurrent children, it does not measure their simultaneous memory use.

The Windows kernel run on these proof inputs took 33.25 CPU seconds and 96.94 elapsed seconds with warm dependency objects. This includes the endpoint compilation and axiom check. These numbers exclude the generic lemmas' earlier builds. The local WSL2 x86-64 smoke run passed input hashing, all 1,024 witnesses, recursive Lucas verification and Lean source regeneration with Python 3.12.3. The installed Linux release in that distro was 4.33.1. An end-to-end Linux build using 4.35.0 and a fresh cache remains unmeasured.
