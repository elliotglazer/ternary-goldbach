"""Emit and check one Lean module proving every finite binary Goldbach bound up to 10^k."""
import argparse
from hashlib import sha256
import json
import os
from pathlib import Path
import subprocess
import sys
import time

from replay import run_lean


ROOT = Path(__file__).resolve().parent
AXIOMS = "[propext, Classical.choice, Quot.sound]"
LEAN_COMMIT = "eb6cafb7290e8bd5f2937522d8d804f58f02bafc"


def sources(power, certificate_dir):
    pilot = ROOT.parent / "aws-pilot"
    bitmap = ROOT / "PrimeBitmap.lean"
    table = ROOT / "Table.lean"
    if not bitmap.is_file():
        bitmap = pilot / bitmap.name
    if not table.is_file():
        table = pilot / "wide" / table.name
    inputs = certificate_dir or (ROOT / "compact-prefix" if power >= 7 else ROOT)
    certificate = inputs / f"Power{power}.lean"
    files = [bitmap, table, ROOT / "PrefixCheck.lean", ROOT / "PrefixSource.lean"]
    if power >= 7:
        files.append(ROOT / "PrefixJoin.lean")
    with certificate.open(encoding="utf-8") as source:
        imports = []
        for line in source:
            if not line.startswith("import "):
                break
            imports.append(line.strip().split()[1])
    if "FastHex" in imports:
        files.append(ROOT / "FastHex.lean")
    if power >= 9:
        files.append(ROOT / "PrefixFactorial.lean")
    return [*files, certificate]


def emit(power, path, certificate_dir):
    files = sources(power, certificate_dir)
    # PrimeBitmap imports PrimeSupport for a different certificate format. None
    # of the declarations in this proof use its Lucas primality theorem.
    local_imports = {"PrimeSupport", *(f.stem for f in files)}
    imports, bodies, hashes = [], [], {}
    for file in files:
        data = file.read_bytes()
        hashes[file.name] = sha256(data).hexdigest()
        lines = data.decode("utf-8").splitlines(keepends=True)
        while lines and lines[0].startswith("import "):
            module = lines.pop(0).strip().split()[1]
            if module not in local_imports and module not in imports:
                imports.append(module)
        bodies.append("".join(lines).strip())
    body = "\n".join(f"import {mod}" for mod in imports)
    body += "\n\n" + "\n\n".join(bodies)
    body += f"""

namespace SmallGoldbach.Power{power}

theorem binaryGoldbachUpToPower {{k : Nat}} (hk : k ≤ {power}) :
    ∀ n : Nat, Even n → 4 ≤ n → n ≤ 10^k →
      ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n := by
  intro n he h4 hn
  exact binaryGoldbachUpTo n he h4
    (hn.trans (Nat.pow_le_pow_right (n := 10) (by decide) hk))

end SmallGoldbach.Power{power}
"""
    path.write_text(body, encoding="utf-8", newline="\n")
    return hashes


def run(power, args):
    build = args.out.resolve() / str(power)
    build.mkdir(parents=True, exist_ok=True)
    module = f"GoldbachThroughPower{power}"
    src = build / f"{module}.lean"
    if not args.recheck_only:
        start = time.process_time()
        inputs = emit(power, src, args.certificate_dir)
        emit_cpu = time.process_time() - start
    if args.emit_only:
        print(src, flush=True)
        return
    if args.packages:
        paths = [p / ".lake/build/lib/lean" for p in sorted(args.packages.resolve().iterdir()) if p.is_dir()]
    else:
        raw = subprocess.check_output(["lake","env",sys.executable,"-c",
            "import os;print(os.environ['LEAN_PATH'])"], cwd=ROOT, text=True).strip()
        paths = [(ROOT/p).resolve() for p in raw.split(os.pathsep) if p]
    if args.lean:
        lean = str(args.lean.resolve())
    else:
        prefix = subprocess.check_output(["lean","--print-prefix"], cwd=ROOT, text=True).strip()
        lean = str(Path(prefix) / "bin" / ("lean.exe" if os.name == "nt" else "lean"))
    version = subprocess.check_output([lean, "--version"], text=True).strip()
    if LEAN_COMMIT not in version:
        raise ValueError(version)
    env = dict(os.environ, LEAN_PATH=os.pathsep.join(map(str,[build,*paths])))
    cmd = [lean, "-t0", "-j1", f"-M{args.memory}"]
    obj = src.with_suffix(".olean")
    if args.recheck_only:
        receipt = json.loads((build/"receipt.json").read_bytes())
        digest = sha256(obj.read_bytes()).hexdigest()
        if digest != receipt["olean_sha256"] or version != receipt["lean"]:
            raise ValueError("compiled module or toolchain differs from the build receipt")
        checker = Path(lean).with_name("leanchecker.exe" if os.name == "nt" else "leanchecker")
        result = run_lean([str(checker), "-v", module], dict(env, LEAN_NUM_THREADS="1"), cwd=build)
        if result["output"].splitlines() != ["replaying "+module]:
            raise ValueError(result["output"])
        result.update(module=module,mode="replayFromImports",olean_sha256=digest,
                      executable_sha256=sha256(checker.read_bytes()).hexdigest())
        (build/"kernel-replay.json").write_text(json.dumps(result,indent=2)+"\n",encoding="utf-8")
        print(module,result["cpu_seconds"],flush=True)
        return
    proof = run_lean([*cmd, "-o", str(obj), src.name], env, cwd=build)
    names = [f"SmallGoldbach.Power{power}.{n}" for n in ("binaryGoldbachUpTo", "binaryGoldbachUpToPower")]
    query = f"import {module}\n" + "".join(f"#print axioms {n}\n" for n in names)
    audit = run_lean([*cmd, "--stdin"], env, query, cwd=build)
    if audit["output"].splitlines() != [f"'{n}' depends on axioms: {AXIOMS}" for n in names]:
        raise ValueError(audit["output"])
    receipt = dict(power=power, lean=version, emit_cpu_seconds=emit_cpu,
                   inputs=inputs, source_sha256=sha256(src.read_bytes()).hexdigest(),
                   olean_sha256=sha256(obj.read_bytes()).hexdigest(), olean_bytes=obj.stat().st_size,
                   proof=proof, audit=audit, cpu_seconds=emit_cpu+proof["cpu_seconds"]+audit["cpu_seconds"])
    (build / "receipt.json").write_text(json.dumps(receipt, indent=2)+"\n", encoding="utf-8")
    print(power, receipt["cpu_seconds"], audit["output"], flush=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("power", type=int, choices=range(1,10), nargs="+")
    parser.add_argument("--out", type=Path, default=ROOT/".standalone")
    parser.add_argument("--certificate-dir", type=Path, help="directory of compatible generated PowerK.lean files")
    parser.add_argument("--packages", type=Path)
    parser.add_argument("--lean", type=Path)
    parser.add_argument("--memory", type=int, default=3500)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--emit-only", action="store_true")
    mode.add_argument("--recheck-only", action="store_true", help="replay this build's declarations with leanchecker against the pinned imports")
    options = parser.parse_args()
    for k in options.power:
        run(k, options)
