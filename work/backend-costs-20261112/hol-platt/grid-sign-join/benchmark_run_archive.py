"""Time the original sign packer on its checked conductor-10000 archive."""

import ast
import json
import tempfile
import time
from pathlib import Path

source = Path(__file__).resolve().parent.parent / 'full-height-count'
module = ast.parse((source / 'pack.py').read_text())
# These two imports load FLINT for earlier analytic stages. The packer uses
# only these modules' geometry and path. Check the entire output against the
# historical archive to verify that the supplied geometry reproduces the run.
module.body = [node for node in module.body if not (
    isinstance(node, ast.ImportFrom) and node.module in ('spectrum', 'repair'))]

with tempfile.TemporaryDirectory() as directory:
    target = Path(directory)
    signs = sorted(source.glob('signs-*.tsv'))
    for path in [*signs, source / 'counts.json']:
        (target / path.name).write_bytes(path.read_bytes())
    scope = dict(HERE=target, LABELS=(3, 6667, 11, 9091), SUB=4096,
                 GUARDS=(167, 320, 640), parameters=lambda: (84224,),
                 __name__='archive_probe')
    exec(compile(module, str(source / 'pack.py'), 'exec'), scope)
    times = []
    for _ in range(5):
        start = time.process_time()
        scope['run']()
        times.append(time.process_time() - start)
        assert (target / 'packets.txt').read_bytes() == (source / 'packets.txt').read_bytes()
    rows = json.loads((target / 'pack.json').read_text())
    print(json.dumps(dict(process_cpu_seconds=times,
                          entries=sum(r['entries'] for r in rows),
                          runs=sum(r['blocks'] for r in rows),
                          input_sign_bytes=sum(p.stat().st_size for p in signs),
                          archive_bytes=(target / 'packets.txt').stat().st_size)))
