"""Replay the finite binary Goldbach evidence with a protected Linux judge."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("checkout", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    repo = args.checkout.resolve()
    out = args.output.resolve()
    bundle = Path(__file__).resolve().parent
    receipt = json.loads((bundle / "receipt.json").read_text())
    def git_head(path):
        return subprocess.check_output(["git", "-C", str(path), "rev-parse", "HEAD"], text=True).strip()
    def sha(path):
        return hashlib.sha256(path.read_bytes()).hexdigest()
    if git_head(repo) != receipt["project_commit"]:
        raise SystemExit("Select the pinned project commit recorded in receipt.json.")
    # Read the tracked manifest from the pinned Git object, independent of local edits.
    manifest = json.loads(subprocess.check_output(["git", "-C", str(repo), "show", "HEAD:lake-manifest.json"]))
    if (repo / "lake-manifest.json").read_text() != subprocess.check_output(
        ["git", "-C", str(repo), "show", "HEAD:lake-manifest.json"], text=True
    ):
        raise SystemExit("Restore the pinned lake-manifest.json before replay.")
    packages = manifest["packages"]
    if {p["rev"] for p in packages if p["name"] == "mathlib"} != {receipt["mathlib_commit"]}:
        raise SystemExit("Mathlib revision differs between the project manifest and receipt.")
    libdirs = []
    for package in packages:
        path = repo / manifest["packagesDir"] / package["name"]
        if not path.is_dir() or git_head(path) != package["rev"]:
            raise SystemExit(f"Restore manifest dependency {package['name']} at {package['rev']}.")
        lib = path / ".lake/build/lib/lean"
        if lib.is_dir():
            libdirs.append(lib)
    for name, expected in receipt["source_artifacts"].items():
        if sha(bundle / name) != expected:
            raise SystemExit(f"Evidence input hash differs: {name}")
    for name, expected in receipt["production_source_sha256"].items():
        raw = subprocess.check_output(["git", "-C", str(repo), "show", "HEAD:" + name])
        if hashlib.sha256(raw).hexdigest() != expected or (repo / name).read_bytes().replace(b"\r\n", b"\n") != raw.replace(b"\r\n", b"\n"):
            raise SystemExit(f"Production input hash differs: {name}")
    production = repo / ".lake/build/lib/lean"
    if not (production / "Power10Block00.olean").is_file():
        raise SystemExit("Build the pinned +Power10Block00 module before replay.")
    prefix = Path(subprocess.check_output(["lake", "env", "lean", "--print-prefix"], cwd=repo, text=True).strip()).resolve()
    version = subprocess.check_output([str(prefix / "bin/lean"), "--version"], text=True)
    if "version 4.35.0" not in version or "eb6cafb7290e8bd5f2937522d8d804f58f02bafc" not in version:
        raise SystemExit("Stock Lean 4.35.0 is required.")
    bw = shutil.which("bwrap")
    if not bw:
        raise SystemExit("A Linux installation of bwrap is required.")
    out.mkdir(parents=True, exist_ok=False)
    for role, mod, extra in [("challenge", "TrustedPrefix", []), ("solution", "FinitePrefixSolution", [production])]:
        folder = out / role
        folder.mkdir()
        shutil.copy2(bundle / (mod + ".lean"), folder / (mod + ".lean"))
        env = {**os.environ, "LEAN_PATH": os.pathsep.join(map(str, [folder, *extra, *libdirs])), "LEAN_ABORT_ON_PANIC": "1", "LEAN_NUM_THREADS": "1"}
        subprocess.run([str(prefix / "bin/lean"), "-j1", "-o", mod + ".olean", mod + ".lean"], env=env, cwd=folder, check=True)
        with (out / (role + ".export")).open("wb") as fp:
            subprocess.run([str(prefix / "bin/leanexport"), mod, "--", *receipt["export_roots"]], env=env, cwd=folder, stdout=fp, check=True)
    cmd = [bw, "--unshare-all", "--die-with-parent", "--new-session", "--clearenv", "--proc", "/proc", "--dev", "/dev", "--tmpfs", "/tmp"]
    for path in ["/home", "/root", "/run/user", "/var", "/tmp/home", "/tmp/judge", "/project", "/helpers"]:
        cmd.extend(["--dir", path])
    for path in ["/usr", "/bin", "/lib", "/lib64", "/etc"]:
        if os.path.islink(path):
            cmd.extend(["--symlink", os.readlink(path), path])
        elif os.path.exists(path):
            cmd.extend(["--ro-bind", path, path])
    for source, target in [(prefix, "/tool"), (Path(bw), "/helpers/bwrap"), (bundle / "comparator.json", "/project/comparator.json"), (out / "challenge.export", "/tmp/challenge.export"), (out / "solution.export", "/tmp/solution.export")]:
        cmd.extend(["--ro-bind", str(source), target])
    for key, value in {"HOME": "/tmp/home", "PATH": "/tool/bin:/helpers:/usr/bin:/bin", "COMPARATOR_BWRAP": "/helpers/bwrap", "LANG": "C.UTF-8", "LEAN_ABORT_ON_PANIC": "1", "LEAN_NUM_THREADS": "1", "LAKE_ARTIFACT_CACHE": "false"}.items():
        cmd.extend(["--setenv", key, value])
    cmd.extend(["--chdir", "/tmp/judge", "lake", "comparator", "--config", "/project/comparator.json", "--challenge-from-export", "/tmp/challenge.export", "--solution-from-export", "/tmp/solution.export"])
    with (out / "comparator.log").open("wb") as log:
        subprocess.run(cmd, stdout=log, stderr=subprocess.STDOUT, check=True)
    lines = (out / "comparator.log").read_text().splitlines()
    markers = ["nanoda kernel accepts the solution", "Lean default kernel accepts the solution", "Your solution is okay!"]
    if not all(s in lines for s in markers):
        raise SystemExit("Comparator success markers missing.")
    print("\n".join(lines))

if __name__ == "__main__":
    main()
