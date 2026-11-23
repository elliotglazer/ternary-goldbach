# Isolated dependencies for RawPairRound

Prepared 2026-11-13. No copying, dependency graph invocation, HOL process or build has been run. This is a bounded execution plan. Existing installation files and existing experiment artifacts stay unchanged.

## Isolation choice

Use a fresh flat source staging directory under `hol-platt/raw-analytic/dependency-build-01`. Copy only the 45 source/interface files listed below and the existing owned `RawPairRoundScript.sml`. Reuse existing compiled upstream modules through read-only include paths. Build explicit targets only.

This avoids copying the whole HOL checkout and avoids executing its directory-level `all`, `install`, `link-to-sigobj`, self-test or OpenTheory targets. Do not copy the upstream Holmakefiles. Do not set `HOLBUILD`.

Holmake does not expose a general alternate output-root option in the inspected core CLI. The Poly implementation fixes `HOLOBJDIR` to `.hol/objs`; the Moscow implementation uses `.`. Consequently, changing the working source directory is the isolation mechanism. Merely assigning `HOLOBJDIR` in a Holmakefile would not redirect every filesystem operation.

`-C` changes the working directory. `--holdir` selects another installation; it is not an object-output setting and should remain the existing installation here. `--cache-dir` selects a build cache, not the output directory. Use `--no-cache`, `--no-project`, `--no_preexecs` and `--no_prereqs`. The last flag prevents recursive builds in `INCLUDES`; it still permits local staged prerequisites to be built. Keep every missing dependency source local and reject any graph proposing a build in the original installation.

## Missing closure established by source inspection

There are **19 missing theory modules** in the ordinary source/library dependency closure, not just `real`, `intreal`, `transc` and `complex`:

| Layer | Modules |
|---|---|
| Real construction and arithmetic bootstrap | `hrat`, `hreal`, `realax`, `real_arith`, `real` |
| Real interfaces | `intreal`, `RealFieldContext`, `real_sigma` |
| Support and topology | `res_quan`, `topology`, `metric`, `nets`, `real_topology` |
| Analysis imported by complex | `derivative`, `seq`, `lim`, `powser`, `transc`, `complex` |

The **14 missing support modules** are `hol88Lib`, `Cond_rewrite`, `res_quanLib`, `res_quanTools`, `realPP`, `realSyntax`, `RealArith0`, `RealArith`, `realSimps`, `RealField`, `isqrtLib`, `realLib`, `complexPP` and `Diff`.

This is the minimal source-level closure found for the unchanged modules, not a claim that HOL can prove complex multiplication only after this much mathematics. The existing `complexScript.sml` imports `transc`, which imports real topology, derivatives and series even though this helper only needs multiplication and modulus. Splitting that library is a different source-maintenance task and is not proposed here.

The 19 theory scripts plus 14 module implementations and their 12 existing signatures total **45 files and 2,756,114 bytes**. No integration, measure-theory, polynomial-analysis, FFT, Gamma or Dirichlet-L files are requested. `real_topologyScript.sml` alone is 1,048,749 bytes; it is the conspicuous potential one-time build cost.

Exact minimality is bounded by static dependency inspection. The first staged `--json` graph is a required validation gate: it must resolve all dependencies to this list or already compiled upstream modules. A newly discovered missing module stops the run for a specific amendment; it is not permission to copy or rebuild whole directories.

## Existing modules to reuse

Most base theories and tactics are installed in the selected HOL checkout's `sigobj`. The inspected ancestor boundary includes arithmetic, numbers, pair/list/option/sum, predicate sets, cardinality, permutation, iteration, well-order, quotient, marker and normalizer. The existing proof libraries include `DecimalFractionPP`, `pred_setLib`, `hurdUtils`, `Canon_Port`, `liteLib`, `AC`, `Arbrat`, `Sub_and_cond`, `Normalizer`, `Grobner`, `normalForms` and `PairedLambda`.

Two important modules are compiled outside `sigobj`:

- `src/integer/.hol/objs/integerTheory.uo` and `intLib.uo` exist, with interfaces. Reuse `src/integer` as an include directory.
- `src/res_quan/src/.hol/objs/jrhUtils.uo` and `.ui` exist. Reuse that directory for `jrhUtils`; its other missing support modules are copied into the local stage.

Reuse `hol4-setup/.hol/objs/BlockRoundTheory.uo` and its existing StageCheck dependency through `hol4-setup`. This retains the exact integer rounder. No new BlockRound build is needed.

Absence checks covered `sigobj`, the real/analysis object directories and flat source paths. The proposed closure's real/analysis theory objects are absent there. Existing `.uo` manifests may themselves name original source/object paths; reading these is intended. They must not be rewritten or relocated by editing their contents.

## Exact preparation sequence

The following commands are for the same Linux environment used by the current HOL runner. They are not executed. Start at the repository root. The original checkout remains `HOLDIR`; all new output paths are under the exclusive new stage.

```sh
set -eu
set -C
repo=$(pwd -P)
base="$repo/work/backend-costs-20261112"
setup="$base/hol4-setup"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
owner="$base/hol-platt/raw-analytic"
stage="$owner/dependency-build-01"
test ! -e "$stage"
mkdir "$stage"
mkdir "$stage/logs"
cat > "$stage/source-list.txt" <<'EOF'
src/real/hratScript.sml
src/real/hrealScript.sml
src/real/realaxScript.sml
src/real/real_arithScript.sml
src/real/realScript.sml
src/real/intrealScript.sml
src/real/real_sigmaScript.sml
src/real/metricScript.sml
src/real/netsScript.sml
src/real/RealFieldContextScript.sml
src/pred_set/src/more_theories/topologyScript.sml
src/res_quan/src/res_quanScript.sml
src/real/analysis/real_topologyScript.sml
src/real/analysis/derivativeScript.sml
src/real/analysis/seqScript.sml
src/real/analysis/limScript.sml
src/real/analysis/powserScript.sml
src/real/analysis/transcScript.sml
src/real/analysis/complexScript.sml
src/hol88/hol88Lib.sml
src/hol88/hol88Lib.sig
src/res_quan/src/Cond_rewrite.sml
src/res_quan/src/Cond_rewrite.sig
src/res_quan/src/res_quanLib.sml
src/res_quan/src/res_quanLib.sig
src/res_quan/src/res_quanTools.sml
src/res_quan/src/res_quanTools.sig
src/real/realPP.sml
src/real/realSyntax.sml
src/real/realSyntax.sig
src/real/RealArith0.sml
src/real/RealArith0.sig
src/real/RealArith.sml
src/real/RealArith.sig
src/real/realSimps.sml
src/real/realSimps.sig
src/real/RealField.sml
src/real/RealField.sig
src/real/isqrtLib.sml
src/real/isqrtLib.sig
src/real/realLib.sml
src/real/realLib.sig
src/real/analysis/complexPP.sml
src/real/analysis/Diff.sml
src/real/analysis/Diff.sig
EOF
while IFS= read -r source; do
  name=${source##*/}
  test -f "$hol/$source"
  test ! -e "$stage/$name"
  cp "$hol/$source" "$stage/$name"
  cmp "$hol/$source" "$stage/$name"
  sha256sum "$hol/$source" >> "$stage/original-sources.sha256"
done < "$stage/source-list.txt"
cp "$owner/RawPairRoundScript.sml" "$stage/RawPairRoundScript.sml"
sha256sum "$owner/RawPairRoundScript.sml" >> "$stage/original-sources.sha256"
cat > "$stage/Holmakefile" <<EOF
INCLUDES = $hol/src/integer $hol/src/res_quan/src $setup
all: RawPairRoundTheory.uo
EOF
# Validate the three non-sigobj read-only boundary modules.
for object in "$hol/src/integer/.hol/objs/integerTheory.uo" \
              "$hol/src/integer/.hol/objs/intLib.uo" \
              "$hol/src/res_quan/src/.hol/objs/jrhUtils.uo" \
              "$setup/.hol/objs/BlockRoundTheory.uo"; do
  test -f "$object"
  sha256sum "$object" >> "$stage/upstream.sha256"
done
sha256sum "$setup/run.sh" "$hol/bin/Holmake" "$hol/bin/hol.state" \
  >> "$stage/upstream.sha256"
cd "$stage"
unset HOLBUILD
# Graph generation may create LOCAL dependency metadata, but proves nothing.
"$setup/run.sh" "$hol/bin/Holmake" --no_prereqs --no-project \
  --no_preexecs --no-cache -j1 --json RawPairRoundTheory.uo \
  > logs/graph.json 2> logs/graph.stderr
```

Stop here and inspect the graph before theory execution. Check that all proposed source compilations are in the stage; the 19 theory and 14 support names above bound new modules. Imported existing modules are not new compilation targets. Reject a missing theory, a new external build node, a target under the original checkout, or a recursive directory action. Keep graph output and source hashes as part of the build record.

The preparation command copies bytes without changing their contents. It deliberately creates no symlinks, so a generated file cannot overwrite original source through a shared link. It copies no upstream Holmakefile and invokes no global install/link target. The local `all` target is never needed; all invocations name explicit outputs.

## Bounded build after graph review

Initial engineering envelope, not a time prediction: one process/job, **4 GiB virtual-memory limit**, **3 hours cumulative wall time**, no retry or cap increase within this plan. Limit `real_topology` to 60 minutes and each other phase to 30 minutes, with every phase also bounded by the remaining 3-hour total. Stop after any failure; preserve logs and partial stage outputs. Do not delete or overwrite a failed stage to retry.

Use a maximum 2 GiB stage size, checked before and after each phase; no individual log should exceed 64 MiB. A resource supervisor should stop the current process tree if these storage limits are crossed while running. If that supervisor is unavailable, the storage checks are only checkpoints and must be described as such, not claimed as a hard in-flight cap. A failed cap is evidence to assess, not an invitation to rebuild at larger limits silently.

Suggested explicit phases:

1. `realTheory.uo intrealTheory.uo RealField.uo realLib.uo` (construction and arithmetic bootstrap).
2. `topologyTheory.uo real_sigmaTheory.uo metricTheory.uo netsTheory.uo`.
3. `real_topologyTheory.uo`.
4. `derivativeTheory.uo seqTheory.uo limTheory.uo powserTheory.uo`.
5. `transcTheory.uo complexTheory.uo`.
6. `RawPairRoundTheory.uo`.

Each target builds only its staged prerequisite subset; an already accepted object is reused. Local library prerequisites such as `hol88Lib`, restricted-quantifier support, pretty printers and `Diff` are discovered from the staged sources. Do not execute all 33 modules as independent fresh jobs if explicit targets can share their accepted prerequisites.

A phase command, after graph review, is:

```sh
# Still in the exclusive stage, with setup/hol variables from above.
ulimit -v 4194304
# Root's supervisor supplies the remaining total-wall bound and fresh phase name.
"$setup/run.sh" /usr/bin/time -v -o logs/core.time \
  timeout 1800 "$hol/bin/Holmake" --no_prereqs --no-project \
    --no_preexecs --no-cache -j1 \
    realTheory.uo intrealTheory.uo RealField.uo realLib.uo \
  > logs/core.log 2>&1
sha256sum -c original-sources.sha256
sha256sum -c upstream.sha256
```

Equivalent fresh names and remaining-wall limits apply to later phases. The original input hashes must match after each phase. Keep all generated `.uo/.ui/.dat`, theory source/interface outputs, dependency metadata and logs under the stage. No `--fast`, oracle-backed tactic substitution, axiom replacement or source patch is allowed by this plan.

If any original installation artifact changes, stop and report it; the task's isolation condition has failed. The intended prevention is local-only graph acceptance plus `--no_prereqs`, not just a post-hoc hash check. Source/input checks cover the named boundary, not an assertion that every unrelated file in the installation was hashed.

## Acceptance and next use

First validate all new theory exports under the existing kernel, then compile `RawPairRound` and inspect its exact type and hypotheses. Keep generic dependency construction cost separate from arithmetic throughput and from measured first-admission/replay costs. A successful real/complex build is reusable engineering infrastructure, not proof of a transcendental input enclosure or an L-function sign.

The next semantic work still includes log/root/exp source proofs, recurrence errors, source/head assembly, the actual c10004 CT block and completion/sign. This plan changes none of those obligations.

## Source-control evidence

- Core CLI source `tools/Holmake/core/HM_Core_Cline.sml`, SHA256 `88552782929DBF04A2D76C20B36151A7F1325890DD0EC10FD365264220B7C9ED`: `--no_prereqs`, `--no-project`, `--no_preexecs`, `--no-cache`, `-j`, `--json`, `-C`, `--holdir` and cache options.
- Poly path implementation `tools/Holmake/poly/HFS_NameMunge.sml`, SHA256 `8C4AA7E650789661ED461B02B47FDDA68233F6A4F9EFAACD3A04C8ABF4919D8F`: fixed `.hol/objs` path.
- Existing `jrhUtils.uo`, SHA256 `F3656554A634FD229628256FB64904EB5A57C97E8FB531102F0BF6A41A160FF9`.
- Owned helper remains `FE67132187C0E3C07FD256BB3B475A41333BAB49C70B7E49CB5B2CFCA946F0D1`.

The future preparation records every one of the 45 original file hashes and verifies the copies. The source-level dependency counts above were obtained by bounded reads of their ancestor/library declarations and imported module interfaces, plus existence checks against the current compiled boundary. No build tool was run to produce this plan.
