"""Entry points for the root Lakefile. See proof/README.md for prerequisites."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import zipfile

from restore_bundle import restore


PROOF = Path(__file__).resolve().parent
BUILD = PROOF.parent / ".lake" / "build"
REPLAY = BUILD / "replay"
EVIDENCE = PROOF / "evidence"
RECEIPT = json.loads((EVIDENCE / "CompletedGoldbach-receipt.json").read_text())


def check_digest(path, expected):
    with path.open("rb") as stream:
        digest = hashlib.sha256()
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    if digest.hexdigest() != expected:
        raise SystemExit(f"Unexpected SHA-256 for {path}")


def restore_sources():
    BUILD.mkdir(parents=True, exist_ok=True)
    archive = BUILD / "lean-sources.zip"
    restore(archive)
    with zipfile.ZipFile(archive) as bundle:
        bundle.extractall(REPLAY)

    # The release linker specializes the pinned proof. Reject visible edits
    # that would otherwise be silently ignored by the bundled replay.
    final = "CompletedGoldbach.lean"
    pairs = [(PROOF / final, REPLAY / "grh-link" / final)]
    pairs.extend((p, REPLAY / p.name) for p in PROOF.glob("*.lean") if (REPLAY / p.name).is_file())
    for visible, archived in pairs:
        if not visible.is_file() or visible.read_text(encoding="utf-8") != archived.read_text(encoding="utf-8"):
            raise SystemExit(f"{visible.name} differs from the pinned proof bundle")
    print(f"Restored sources to {REPLAY}", flush=True)


def input_dir(name, required_file):
    value = os.environ.get(name)
    if not value or not (Path(value) / required_file).is_file():
        raise SystemExit(f"Set {name} to a directory containing {required_file}. See proof/README.md.")
    return Path(value).resolve()


def dependency_paths(mathlib, grh, env):
    paths = subprocess.check_output(
        ["lake", "env", "printenv", "LEAN_PATH"], cwd=mathlib, env=env, text=True
    ).strip().split(os.pathsep)
    return os.pathsep.join([str(REPLAY), str(grh)] +
                           [str((mathlib / path).resolve()) for path in paths if path])


def inspect(directory, env):
    output = subprocess.check_output(
        ["lean", "--run", str(EVIDENCE / "InspectModule.lean"), "CompletedGoldbach.olean"],
        cwd=directory, env=env, text=True
    )
    print(output, end="")
    prefix = RECEIPT["declaration"] + " #["
    entries = [line[len(prefix):-1] for line in output.splitlines()
               if line.startswith(prefix) and line.endswith("]")]
    if len(entries) != 1 or sorted(entries[0].split(", ")) != sorted(RECEIPT["axioms"]):
        raise SystemExit("Exported axioms differ from the release receipt")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("target", choices=["inspect", "sources", "build", "lean-path"])
    target = parser.parse_args().target
    if target == "sources":
        restore_sources()
        return

    env = os.environ.copy()
    env.pop("LEAN_PATH", None)
    if target == "inspect":
        check_digest(EVIDENCE / "CompletedGoldbach.olean", RECEIPT["object_sha256"])
        inspect(EVIDENCE, env)
        return

    grh = input_dir("GRH_LIB", "Main.olean")
    mathlib = input_dir("MATHLIB", ".lake/build/lib/lean/Mathlib.olean")
    if target == "lean-path":
        print(dependency_paths(mathlib, grh, env))
        return

    check_digest(grh / "Main.olean", RECEIPT["release_main_sha256"])
    restore_sources()
    subprocess.run([sys.executable, "reproduce.py", str(mathlib)], cwd=REPLAY, env=env, check=True)
    env["LEAN_PATH"] = dependency_paths(mathlib, grh, env)
    subprocess.run(["lean", "-j1", "--run", "grh-link/LinkWithAxioms.lean", "close"],
                   cwd=REPLAY, env=env, check=True)
    inspect(REPLAY, env)


if __name__ == "__main__":
    main()
