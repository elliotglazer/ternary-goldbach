# Full GRH to PlattGRH

The adapter takes a proof of the published all-character GRH statement and supplies the bounded zero-location hypothesis used by Goldbach. The import of the upstream GRH proof is a separate dependency.

The audit driver reads the whole local `FullGRH.lean` and the two pinned proposition bodies. One Lean process imports the existing Goldbach statement cache, typechecks the adapter, compares the cached `PlattGRH` definition to the repository source using `rfl`, and specializes the adapter to the published input type. It prints the axioms of both the adapter and that specialization.

Run `python check.py` from this directory on the project workstation. `receipt.json` contains the process status and hashes. `audit.log` contains Lean's diagnostics and axiom output. A successful check requires exit code zero and both axiom lines.

Goldbach source commit: `23b2d68ca344203d4384e0aff7affa4ec034bef9`. GRH statement mirror commit: `e7c8972c701d3396947808ab20cc16dc14623d33`. The consumer uses Lean 4.35.0 and the GRH release pins Lean 4.33.1.

## Native 4.33.1 port

The Linux pilot compiled the original Goldbach statement and `FullGRH.lean` unchanged, using the GRH checkout's toolchain, Mathlib, and installed `Statements.olean`. The final module imported the two real libraries and proved `DirichletLZerosOnLine → TernaryGoldbach.PlattGRH`. Lean reported `[propext, Classical.choice, Quot.sound]` for this conditional theorem. The unconditional version needs `LFunction_eq_zero_re` from the completed GRH `Main` module in this environment.

| Module | CPU seconds | Elapsed seconds | Exit |
|---|---:|---:|---:|
| TernaryGoldbach.Statement | 179.48 | 332.60 | 0 |
| FullGRH | 308.17 | 473.21 | 0 |
| PortAudit | 125.94 | 231.51 | 0 |

The three commands used `-t0` and an 8192 MB memory ceiling on the shared WSL host. `linux_port_8g.json` pins the inputs and outputs. The first 4096 MB run reported an interpreter memory exception. A single ordinary Statement build under a later, different load hit its deadline at 602.19 elapsed seconds (439.83 CPU seconds), without diagnostics. The ordinary timing remains open.

The driver is `linux_port.py`. From WSL run `python3 linux_port.py --high-memory` in this folder. It fetches no dependencies and writes Lean outputs to a fresh native temporary directory.
