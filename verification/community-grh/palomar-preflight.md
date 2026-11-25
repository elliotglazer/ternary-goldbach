# Palomar source and challenge preflight

The source publication commit c9ef5cbc995320af9b559143612b9221ffff4dc5 (Git tree 440cb8a22321b58aabcf3d18a842b2abbf13ea28) yielded 751 regular files totaling 357,025,168 bytes in a fresh git archive. The checks below ran on that archive. All 735 Lean files match their SHA-256 entries in source-manifest.json, whose digest also matches the earlier staging receipt. Palomar checked all 735 Lean files with zero source-policy issues. Its comparator, formalization metadata, and Git manifest readers accepted the snapshot. The manifest listed ten pinned GitHub packages. The submitted-tree cap is 524,288,000 bytes.

The isolated challenge compilation ran on the earlier 748-file staging snapshot (357,002,750 bytes, fingerprint d44b4c215e34f690952662a24a95f264708610aed1f4675171d46a4ac46e89c6). The archived publication commit has identical challenge, comparator, toolchain, Lake configuration and dependency pins. The protected configuration mapped GoldbachChallenge to a fresh PalomarCanonical namespace, retained GoldbachSolution and PalomarTernaryGoldbach.ternary_goldbach, and registered nanoda and con-ron. Lean resolved three distinct challenge sources: Init, Mathlib.Data.Nat.Prime.Defs, and Mathlib.Algebra.Ring.Parity. The official source audit classified Mathlib as allowlisted with high trust and returned zero untrusted sources. Independently importing the compiled original and canonical challenge produced identical printed declarations, SHA-256 48982ffcfa8a657a9b2185f3224c4dcd5477aa89df69e77fd57dd4094b35cda3. The challenge contains its expected sorry stub. Solution compilation, external kernels, network provenance checks, and hosted resource limits are outside this receipt.

## Inputs and reproduction

Run the commands below on Linux with Python 3, Palomar's Python requirements, and the pinned Lean and Mathlib build already installed. Set PKG, POLICY and MATHLIB to absolute paths for the unmodified candidate snapshot, Palomar Git checkout and Mathlib Git checkout. Use the Lean toolchain pinned below on PATH. Store this receipt outside PKG when checking the snapshot fingerprint.

~~~sh
set -eu
# SOURCE_REPO is the Git checkout containing the publication commit.
PKG="$(mktemp -d)"
git -C "$SOURCE_REPO" archive c9ef5cbc995320af9b559143612b9221ffff4dc5 | tar -x -C "$PKG"
export PKG POLICY MATHLIB
test "$(git -C "$POLICY" rev-parse HEAD)" = 14aa8d6b3c2f14a8540605e37144560b9a00e7e7
test "$(git -C "$MATHLIB" rev-parse HEAD)" = 31ce06eaadf4a200c0e1407c5f10953cf606b8f8
test "$(lean --githash)" = 0b77e12952ad39077d80d8bd6b66d601f225c321
export PYTHONPATH="$POLICY"
python3 - <<'PY'
from pathlib import Path
import hashlib, os
from scripts import submission_contract as c, verify_submission as v
from scripts.source_requirements import inspect_lean_sources
p = Path(os.environ["PKG"])
files = []
for folder, subs, names in os.walk(p):
    subs[:] = [s for s in subs if s not in {".git", ".lake"}]
    files.extend(Path(folder)/n for n in names)
digest = hashlib.sha256()
for f in sorted(files, key=lambda f: f.relative_to(p).as_posix()):
    assert f.is_file() and not f.is_symlink()
    digest.update(f.relative_to(p).as_posix().encode() + b'\0' + hashlib.sha256(f.read_bytes()).digest())
assert len(files) == 751 and sum(f.stat().st_size for f in files) == 357025168
assert digest.hexdigest() == "be0817113f5a4d23f08eb81e34cdf4837ab1c3f3005f0032dbd7d9dfb49aa51e"
import json
manifest = (p/"source-manifest.json").read_bytes()
assert hashlib.sha256(manifest).hexdigest() == "7254876452b3e10e50992005af4dd24982a005aad4d43ec38586dc9286e299e6"
rows = json.loads(manifest)["sources"]
assert set(rows) == {f.relative_to(p).as_posix() for f in files if f.suffix == ".lean"}
assert all(hashlib.sha256((p/k).read_bytes()).hexdigest() == row["sha256"] for k,row in rows.items())
stats, issues = inspect_lean_sources(p)
assert stats["files_checked"] == 735 and not issues
assert len(v.manifest_packages(p)) == 10
v.load_comparator_config(p/"comparator.json")
c.load_formalization_metadata(p/"formalization.yaml")
PY
export LEAN_PATH="$(cd "$MATHLIB" && lake env printenv LEAN_PATH)"
export LEAN_SRC_PATH="$(cd "$MATHLIB" && lake env printenv LEAN_SRC_PATH)"
export PREFIX="$(lean --print-prefix)"
work="$(mktemp -d)"
cd "$work"
mkdir -p .lake/packages
git clone -q --no-checkout "$MATHLIB" .lake/packages/mathlib
git -C .lake/packages/mathlib checkout -q HEAD -- Mathlib/Data/Nat/Prime/Defs.lean Mathlib/Algebra/Ring/Parity.lean
cp "$PKG"/GoldbachChallenge.lean "$PKG"/lake-manifest.json .
export LEAN_SRC_PATH="$PWD/.lake/packages/mathlib:$LEAN_SRC_PATH"
lean --deps-json GoldbachChallenge.lean > header.json
lean --src-deps GoldbachChallenge.lean > resolved
python3 - <<'PY'
import json,os
from pathlib import Path
from scripts import verify_submission as v
p=Path(os.environ["PKG"]); d=Path.cwd(); t=Path(os.environ["PREFIX"])
assert v.parse_lean_header(Path("header.json").read_text()).is_module
ks={a:[str(t/"bin"/b)] for a,b in v.PROTECTED_KERNELS}
cfg=v.protected_comparator_config(p/"comparator.json",d/"protected.json",kernels=ks)
name=json.loads(cfg.read_text())["challenge_module"]
alias=Path(*name.split(".")).with_suffix(".lean")
alias.parent.mkdir()
alias.write_bytes((d/"GoldbachChallenge.lean").read_bytes())
Path("alias").write_text(name)
src=sorted({Path(x).resolve() for x in Path("resolved").read_text().splitlines()})
r=v.audit_challenge_sources(d,checkout=d,dependency_sources=src,lean_prefix=t,
    allowlist={"mathlib":("leanprover-community/mathlib4","high")},writable_directories=[])
assert r == {"source_count":3,"dependencies":[{"repository":"leanprover-community/mathlib4","provenance":"allowlisted"}],"untrusted_sources":[],"trust_level":"high"}
PY
for name in GoldbachChallenge "$(cat alias)"; do
    path="$(echo "$name" | tr . /)"
    lean -o "$path.olean" "$path.lean"
    printf 'import %s\n#print PalomarTernaryGoldbach.ternary_goldbach\n' "$name" > Check.lean
    LEAN_PATH="$PWD:$LEAN_PATH" lean Check.lean > "$name.type"
done
cmp GoldbachChallenge.type "$(cat alias).type"
echo '48982ffcfa8a657a9b2185f3224c4dcd5477aa89df69e77fd57dd4094b35cda3  GoldbachChallenge.type' | sha256sum -c -
~~~

The trust mapping in this local check uses the official Mathlib root at the stated revision. Palomar's hosted verifier additionally authenticates the official revision and its dependency closure. The local run used the pinned verifier functions and Lean CLI directly.
