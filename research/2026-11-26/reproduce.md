# Replaying the proof and checking the research record

## Identify the proof before comparing results

The default branch preserves the November 24 Lean 4.33.1 project, with compiled RH/GRH dependencies. For the November 26 source build, check out the exact candidate and use its toolchain and Lake manifest. The two versions have different timings, different package layouts, and separate receipts. [November 24 build instructions](https://github.com/elliotglazer/ternary-goldbach/blob/b37fd3e56064346ff058edb45f81cebf5ce39474/proof/README.md) · [November 26 candidate](https://github.com/elliotglazer/ternary-goldbach/tree/3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b)

```sh
git clone https://github.com/elliotglazer/ternary-goldbach.git
cd ternary-goldbach
git switch --detach 3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b
git rev-parse 'HEAD^{tree}'
lake --version
lake build GoldbachSolution
```

The tree is `d310a9b71577cc7225486e5ea39c913e411473ca`. A local build requires the pinned Lean toolchain and dependencies. Palomar builds and exports the independently specified challenge and the solution in separate steps, compares the declarations, and invokes independent checks. The local Lake command reproduces the source target. The stock comparator and its execution profile define the protected rehearsal. [Candidate configuration](https://github.com/elliotglazer/ternary-goldbach/blob/3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b/comparator.json) · [Pinned verifier](https://github.com/PalomarRegistry/PalomarSubmission/tree/046554302064b2c83c2b924bea6db87fc5900c68)

## Read a failed attempt against its source

Each row of [the source-run ledger](source-runs.md) links to the revision that ran. The accompanying [JSON](evidence/source-attempts.json) gives the original receipt or captured log hash, module list where available, and source-located Lean error headers. Several messages can follow a single failed definition. Later rows show which previously blocked imports compiled after the repair.

The [commit table](evidence/published-history.tsv) contains one row per distinct commit reachable from the sixteen recorded branch tips, including merge commits. It lists parents and branch membership. Author timestamps retain their original offsets. A branch containing a commit can include a change first developed elsewhere. The [file index](evidence/public-artifacts.tsv) records repository paths, Git blob hashes and permanent links. It covers the older notes, archived text records and proof receipts, and the later verification tree, including older branch-tip versions at the same path. The original [archive manifest](https://github.com/elliotglazer/ternary-goldbach/blob/34cd851ef26540d17db766a274076485f702bc58/archive/manifest.tsv) also identifies large data stored in release assets.

## Compare compilation measurements

The [source timing model](evidence/source-build-timing-model.json) records one timing per source-matched module and its direct project dependencies. It includes 794 GRH modules, 732 finite and analytic modules, and the two final connecting modules. The recorded seconds are elapsed times of individual Lake tasks. Adding them charges overlapping work more than once. Measures of processor time, estimates based on reserved cores, and the elapsed time of a complete run answer different questions.

The [protected checkpoint](evidence/performance-1240.json) lists all 655 completed modules and the concurrent compilers observed at 12:40 UTC. It also records the memory limits, actual usage, pressure and event counters. The snapshot forecast in the timing model removes the already completed modules. It charges active modules their full measured duration and excludes the subsequent solution export and kernel checks. A fraction of completed modules alone cannot give a finish time.

## Check the handoff

The [ZIP](../../handoff/ternary-goldbach-research-2026-11-26.zip) contains this edition's chapters, working notes and machine-readable evidence. Its top-level `SHA256SUMS` covers the other members. After extraction, run the following commands from the directory containing the manifest.

```sh
sha256sum -c SHA256SUMS
python evidence/verify_evidence.py
```

For a local copy of the earlier indexed files, use a full clone of the Goldbach repository and a new output directory. The program asks Git to resolve each file at the recorded commit. It then verifies the content against the indexed Git blob, keeping versions from different commits in separate directories.

```sh
python restore_public_notes.py /path/to/ternary-goldbach /path/to/new-research-archive
```

The [older archive](https://github.com/elliotglazer/ternary-goldbach/releases/tag/research-2026-11-22) has its own restore program and data manifests. Its large generated certificates remain in their original release. The archive commit `97a45946f7d31239ecd466e637116a774f24b7d3` also retains the early agent journal, historical forecasts, proof attempts and correspondence prepared for publication. Each historical estimate should be read with its original verification scope.
