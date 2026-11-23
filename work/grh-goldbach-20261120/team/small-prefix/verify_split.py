"""Regenerate all sources of the eight-module proof and compare their hashes."""
from hashlib import sha256
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import time

from split_power import generate

ROOT = Path(__file__).resolve().parent/"ten-billion"
expected = ROOT/"compact"
source = ROOT/"fast/Power10.lean"
with TemporaryDirectory(dir=ROOT) as scratch:
    out = Path(scratch)
    cpu, wall = time.process_time(),time.perf_counter()
    generate(source,out,300,True)
    cpu, wall = time.process_time()-cpu,time.perf_counter()-wall
    hashes = {p.name:sha256(p.read_bytes()).hexdigest() for p in out.iterdir()}
    assert hashes.keys() == {p.name for p in expected.iterdir() if p.is_file()}
    assert all(sha256((expected/n).read_bytes()).hexdigest()==h for n,h in hashes.items())
receipt = dict(split_cpu_seconds=cpu,split_wall_seconds=wall,input_sha256=sha256(source.read_bytes()).hexdigest(),
               regenerated_files=hashes)
(ROOT/"split-receipt.json").write_text(json.dumps(receipt,indent=2)+"\n",encoding="utf-8")
print(len(hashes),cpu,wall)
