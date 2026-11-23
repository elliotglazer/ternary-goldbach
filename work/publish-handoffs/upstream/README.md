# Upstream checkout restore guide

The [manifest](manifest.json) records five workspace Git roots, their upstream URLs, exact commit and tree IDs, local and remote-tracking branches, and the complete untracked file inventory with SHA-256 digests. This is a provenance-based archive. Two locally held HEADs have offline bundles described below. The three clean or remote-tracked base revisions require their pinned Git objects from the corresponding upstream or an existing mirror. No upstream was contacted during archiving.

| Checkout to omit when copying the workspace | Archived local changes |
| --- | --- |
| `work/goldbach-lean` | Clean |
| `work/openai-math` | Clean |
| `work/ternary-goldbach` | Two untracked Lean files, `QrhMellin.lean` and `QrhNumeric.lean` |
| `work/qrh-dependencies/PrimeNumberTheoremAnd` | Eight modified tracked files and 47 untracked proof, source and notice files |
| `work/qrh-dependencies/rellich-kondrachov` | Fifteen modified tracked Lean files |

Keep the loose files at the root of `work/qrh-dependencies`, including both module-closure inventories and the historical compatibility patches. The new checkout-specific patches reflect the actual working trees at archive time.

1. For each manifest entry, restore or clone its `origin` and check out the exact `commit`. Check that `git rev-parse HEAD^{tree}` gives the recorded tree. All five original checkouts were shallow. The recorded local HEAD can differ from the recorded `origin/main`. In particular, the ternary Goldbach checkout used the `codex/qrh-replacement` branch at the recorded pin.
2. If the archive contains `<checkout-name>/tracked.patch`, run `git apply --check <absolute-patch-path>` and then `git apply <absolute-patch-path>` from that checkout. The archive used byte-preserving Git binary patches and checked reverse application against each original modified tree.
3. Copy the contents of `<checkout-name>/untracked/` into the checkout root, preserving relative paths. Their SHA-256 hashes must match the manifest. All 49 untracked files were byte-compared to their originals during archiving.
4. Compare `git diff --name-only HEAD` and `git ls-files --others --exclude-standard` with the manifest. The original indices had no staged deltas. The five checkouts had no stash entries, submodule entries, or ignored untracked paths. Hooks, reflogs, build caches and Git object databases are outside this source archive.

The WSL directory `/verification/lean` is an extracted GRH source provider without a Git root. The separate [large-case handoff](../large-case.md) records the generated WSL consumer build and its portable proof overlays.

## Offline Git bundles

| Bundle | Bytes | Archived commits |
| --- | ---: | --- |
| `ternary-goldbach-HEAD.bundle` | 3,222,260 | HEAD `23b2d68` and its 33 locally available ancestors |
| `PrimeNumberTheoremAnd-HEAD.bundle` | 2,125,809 | Shallow HEAD `c39a751` |
| `ternary-goldbach-earlier-pins.bundle` | 1,794,431 | Two otherwise-unreferenced shallow snapshots, `4632d49` and `c7c10af` |

The two HEAD bundles were created with `git bundle create <bundle> HEAD`. Every bundle passed `git bundle verify` and `git bundle list-heads`. Testing imported each into an empty repository, installed its recorded shallow history boundary, created refs, and ran `git fsck --full`. Both HEAD trees also checked out and matched their original tree IDs. These packages preserve the history present in the shallow working clones. Older history beyond a recorded boundary was absent there.

For offline restoration, initialize a new repository with `git init`, copy the selected bundle’s matching `.shallow` companion to `.git/shallow`, and run `git bundle unbundle <absolute-bundle-path>` inside the new repository. For a HEAD bundle, use `git checkout -b restored <full-commit-from-manifest>`, then apply the corresponding patch and untracked files as above. For the earlier-pins bundle, use `git branch <name> <commit>` for each listed ID before checking one out. For independent integrity checking, run `git fsck --full` after assigning refs.

The five repositories were checked for local refs and reflog commits outside their remote-tracking refs. Only the two bundled HEADs added commits. A separate object-store scan found the two unreferenced ternary commits above. They were bundled from temporary refs without changing the source checkout.
