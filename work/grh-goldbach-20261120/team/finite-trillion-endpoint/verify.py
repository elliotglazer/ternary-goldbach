"""Run the existing one-thread verifier after the shared prime proofs are exported."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
from time import perf_counter, process_time

HERE = Path(__file__).resolve().parent
TEAM = HERE.parent
SMALL = TEAM/"small-prefix"
SHARED = TEAM/"finite-midband-batch"
SAMPLE = TEAM/"finite-interval-sample"


def run():
    archive = json.loads((SHARED/"BandMillionFactorial.json").read_bytes())
    assert archive["exit"] == 0
    seen = {}
    io_wall, io_cpu = perf_counter(), process_time()
    def link(module, parent):
        if module in seen:
            return
        obj = parent/(module+".olean")
        data = obj.read_bytes()
        digest = hashlib.sha256(data).hexdigest()
        receipt = json.loads((parent/(module+".json")).read_bytes())
        assert receipt["exit"] == 0 and digest == receipt["olean_sha256"]
        dest = HERE/obj.name
        if not dest.exists():
            os.link(obj, dest)
        assert os.path.samefile(obj,dest)
        seen[module] = dict(bytes=len(data),sha256=digest)
        source = parent/(module+".lean")
        if source.exists():
            for line in source.read_text(encoding="utf8").splitlines():
                if line.startswith("import "):
                    for child in line.split()[1:]:
                        for directory in (SHARED,SAMPLE):
                            if (directory/(child+".olean")).exists() and (directory/(child+".json")).exists():
                                link(child,directory)
                                break
    link("BandMillionFactorial",SHARED)
    link("SampleBits",SAMPLE)
    io = dict(cached_read_hash_link_wall_s=perf_counter()-io_wall,
              cached_read_hash_link_cpu_s=process_time()-io_cpu,dependencies=seen)
    (HERE/"dependency-io.json").write_text(json.dumps(io,indent=2))
    (HERE/"TrillionImport.lean").write_text("import SampleBits\nimport BandMillionFactorial\n")
    command = [sys.executable,str(SMALL/"check.py"),"--scope",str(HERE),"--memory","1750"]
    for module in ("TrillionImport","TrillionEndpoint"):
        subprocess.run([*command,module],check=True)
    log = (HERE/"TrillionEndpoint.log").read_text(encoding="utf8")
    assert "'TrillionEndpoint.interval' depends on axioms: [propext, Classical.choice, Quot.sound]" in log


if __name__ == "__main__":
    run()
