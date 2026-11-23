"""Read-only integrity check. No theorem, numerical certificate or Lean validation."""
import hashlib
import json
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
OUT = ROOT / 'outputs/qrh-blueprint-next'
OLD = ROOT / 'outputs/qrh-blueprint'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def read_json(p): return json.loads(p.read_text(encoding='utf8'))
def check_file(root, rec):
    p = root / rec['path']
    assert p.is_file(), str(p)
    assert p.stat().st_size == rec['bytes'] and sha(p) == rec['sha256'], str(p)

manifest = read_json(OUT / 'manifest.json')
assert manifest['kind'] == 'frozen research deliverable, not proof validation' and manifest['frozen'] is True
assert manifest['source_pin'] == '23b2d68ca344203d4384e0aff7affa4ec034bef9'
names = [rec['path'] for rec in manifest['files']]
assert len(names) == len(set(names))
actual = {p.relative_to(OUT).as_posix() for p in OUT.rglob('*') if p.is_file()}
assert actual == set(names) | {'manifest.json'}, 'Staging file inventory differs'
for rec in manifest['files']:
    assert not Path(rec['path']).is_absolute() and '..' not in Path(rec['path']).parts
    check_file(OUT, rec)

catalog = read_json(OUT / 'provenance/catalog.json')
assert (HERE / 'catalog.json').read_bytes() == (OUT / 'provenance/catalog.json').read_bytes()
expected_old = 'eaa2fdf61fbb79477242314c3269146ffd45646da030df1d111a0360ed447035'
assert catalog['frozen131_manifest_sha256'] == expected_old
assert sha(OLD / 'manifest.json') == expected_old
archive = OUT / 'archive/frozen131'
assert sha(archive / 'manifest.json') == expected_old
old_manifest = read_json(archive / 'manifest.json')
assert len(old_manifest['files']) == 575
for rec in old_manifest['files']:
    check_file(archive, rec)
    check_file(OLD, rec)
archive_names = {p.relative_to(archive).as_posix() for p in archive.rglob('*') if p.is_file()}
assert archive_names == {r['path'] for r in old_manifest['files']} | {'manifest.json'}

copies = read_json(OUT / 'source-copies.json')['files']
assert len(copies) == len({r['path'] for r in copies})
copy_index = {r['path']: r for r in copies}
for rec in copies:
    assert not Path(rec['source']).is_absolute() and '..' not in Path(rec['source']).parts
    check_file(OUT, rec)
    source = ROOT / rec['source']
    assert source.stat().st_size == rec['bytes'] and sha(source) == rec['sha256'], rec['source']
packet_ids = [p['id'] for p in catalog['accepted_packets']]
assert len(packet_ids) == len(set(packet_ids))
assert not set(packet_ids) & {p['id'] for p in catalog['pending_slots']}
for packet in catalog['accepted_packets']:
    assert packet['status'] == 'accepted research evidence; no new Lean proof'
    assert sum(r['role'] == 'report' for r in packet['files']) == 1
    assert sum(r['role'] == 'review' for r in packet['files']) == 1
    for rec in packet['files']:
        assert {k: copy_index[rec['path']][k] for k in ('source','path','bytes','sha256')} == {k: rec[k] for k in ('source','path','bytes','sha256')}

links = 0
for name in ['README.md', 'OVERVIEW.md', 'SELECTED_STRATEGY.md']:
    body = (OUT / name).read_text(encoding='utf8')
    for target in re.findall(r'\[[^\]]*\]\(([^)]+)\)', body):
        if target.startswith(('https://','http://','#')):
            continue
        assert (OUT / target.split('#')[0]).exists(), target
        links += 1
graph = read_json(OUT / 'dependencies.json')
assert graph['kind'] == 'proposed research map, not an approved proof graph'
seen = set()
for node in graph['nodes']:
    assert node['id'] not in seen
    assert set(node['depends_on']) <= seen, node
    assert node['status'] not in ('proved', 'leanok', 'complete')
    seen.add(node['id'])
status = read_json(OUT / 'staging-status.json')
assert status['frozen'] is True and status['lean_run'] is False
assert catalog['package_stage'] == 'frozen research snapshot; independent synthesis audit pending; not an approved Lean graph'
assert status['accepted_packets'] == len(packet_ids)
assert status['pending_slots'] == catalog['pending_slots']
assert status['archived_files'] == 576
print(json.dumps(dict(result='PASS: package integrity only', files=len(names), source_copies=len(copies),
                      archive_files=576, accepted_packets=len(packet_ids), pending_slots=catalog['pending_slots'],
                      landing_links=links, research_nodes=len(seen), frozen=True, lean_validation=False,
                      manifest_sha256=sha(OUT / 'manifest.json'))))
