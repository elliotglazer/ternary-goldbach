# Source provenance for the finite checks

## Six checked Lean milestones

`work/publish-handoffs/finite-files/milestones/` contains the six checked prefix objects and the full transitive project import closure through Band 06. The older `outputs/small-binary-goldbach-lean.zip` contains 135 source-package entries and zero Lean objects. It covers the smaller milestones through ten billion.

The new collection contains 208 project modules with their Lean sources and checked objects, six band receipts and axiom logs, the original fingerprint ledgers, the frozen input ledger, and the Lake/toolchain pins. Its 29 ZIP parts total **391,771,322 bytes**. The largest part is **20,663,992 bytes**. `work/publish-handoffs/finite-files/milestones/manifest.json` binds all 438 archive members, all parts and the project import graph. Packaging checked the source and object digests against the six original band ledgers. A separate pass decompressed every member and verified its SHA-256.

From a new checkout, run the standard-library restore script with an unused destination. Omitting the destination verifies the archive without writing any files.

```text
python work/publish-handoffs/finite-files/restore_milestones.py restored-bands
```

The restored `lib/` contains importable project objects; `src/` contains the corresponding proof sources. Use the pinned Lean 4.35.0 toolchain (commit `eb6cafb7290e8bd5f2937522d8d804f58f02bafc`), Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, and compiled dependencies matching `pins/lake-manifest.json`. Obtain the Lean search path from that Lake environment and prepend the absolute restored `lib/` path to it, keeping all existing dependency entries. Then the following consumer query can be passed to the pinned `lean --stdin`.

```lean
import GoldbachBand06Prefix
#check SmallGoldbach.GoldbachBand06.binaryGoldbachUpTo
#print axioms SmallGoldbach.GoldbachBand06.binaryGoldbachUpTo
```

The archive preserves the original checked objects. The archive verification pass checked bytes only. A fresh machine import and an independent kernel recheck were not run during archiving. `work/publish-handoffs/finite-files/pack_milestones.py` identifies the original workspace paths and reconstructs the parts from those artifacts.

## WSL working copies

An archival comparison on 22 November 2026 found one distinct Lean proof body in a temporary WSL copy of the wide binary-Goldbach pilot. Four temporary copies had the same SHA-256, `b98b6353756925ee5ed68a4b4004f5f2b12c8aa6dbdc472586b1a5e67d7908bd`. The original bytes are preserved in `work/publish-handoffs/finite-files/Cover-pre-release.lean`. The public theorem has the same statement as the later `work/grh-goldbach-20261120/team/aws-pilot/wide/Cover.lean`. The earlier proof extracts the two Boolean conditions using explicit projections. The later proof simplifies the list and Boolean conditions first. Its dated pilot receipts belong with the later source. The archival check did not compile the earlier version.

Two extracted wide-pilot trees and an endpoint-pilot tree were compared with the workspace pilot sources and release archives. All inspected Python, shell and Markdown files matched workspace copies byte for byte. The remaining differing files were generated workload metadata and a checksum list. The portable releases are `work/grh-goldbach-20261120/team/aws-pilot/goldbach-endpoint-linux.tar.gz` and `work/grh-goldbach-20261120/team/aws-pilot/wide/goldbach-4e15-wide-linux.tar.gz`.

The running WSL distribution's native root filesystem had no matches for the named Band 06 prefix source, weighted selection manifest, or their respective project directory names. The HOL4 run wrapper resolves its compiler, libraries and exports on the mounted workspace. The Lean extension refers outside the project for the toolchain and Mathlib package cache. The original upstream statement is present at `work/ternary-goldbach/TernaryGoldbach/Statement.lean`; its SHA-256 matches the pinned input, `3f61837d2c3a0dde3a1997f05af21c20c7fe6ee13e29891125495f6947596bf8`. The separate small-prefix release is `outputs/small-binary-goldbach-lean.zip`.
