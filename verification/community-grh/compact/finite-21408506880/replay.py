"""Rebuild the finite benchmark from a checkout at receipt.json's pinned commit."""
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

bundle = Path(__file__).resolve().parent
repo = Path(sys.argv[1]).resolve()
receipt = json.loads((bundle / "receipt.json").read_bytes())
pin = subprocess.check_output(["git", "-C", str(repo), "rev-parse", "HEAD"], text=True).strip()
assert pin == receipt["repository_commit"], (pin, receipt["repository_commit"])
for module, source in receipt["project_ancestors"].items():
    assert hashlib.sha256((repo / (module + ".lean")).read_bytes()).hexdigest() == source["source_sha256"], module
for record in receipt["proofs"]:
    assert hashlib.sha256((bundle / record["source"]).read_bytes()).hexdigest() == record["source_sha256"]
env = dict(os.environ)
env.setdefault("LEAN_NUM_THREADS", "1")
subprocess.run(["lake", "build", *["+" + module + ":olean" for module in receipt["imports"]]], cwd=repo, env=env, check=True)
capture = subprocess.check_output(["lake", "env", sys.executable, "-c", "import json,os,shutil;print(json.dumps([shutil.which('lean'),os.environ['LEAN_PATH']]))"], cwd=repo, env=env, text=True)
lean, project_path = json.loads(capture)
project_libs = [str((repo / p).resolve()) for p in project_path.split(os.pathsep)]
with tempfile.TemporaryDirectory() as work:
    env["LEAN_PATH"] = os.pathsep.join([work, *project_libs])
    for proof in receipt["proofs"]:
        source = Path(work) / proof["source"]
        shutil.copyfile(bundle / source.name, source)
        result = subprocess.run([lean, "-j1", "-o", source.with_suffix(".olean").name, source.name], cwd=work, env=env, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, check=True)
        normalized = " ".join(result.stdout.split())
        assert "depends on axioms: [propext, Classical.choice, Quot.sound]" in normalized, normalized
        print(normalized)
