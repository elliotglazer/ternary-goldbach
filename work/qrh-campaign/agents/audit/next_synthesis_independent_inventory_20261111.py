"""Independent read-only successor snapshot inventory and byte comparison."""
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path.cwd();OUT=ROOT/'outputs/qrh-blueprint-next';OLD=ROOT/'outputs/qrh-blueprint';A=ROOT/'work/qrh-campaign/agents/audit'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def js(p):return json.loads(p.read_text())
manifest_pin='3f0da3e74f80f563f2f2fd8368afba46ff6cc086f7459c2b32b52a47385b686a'
old_pin='eaa2fdf61fbb79477242314c3269146ffd45646da030df1d111a0360ed447035'
assert sha(OUT/'manifest.json')==manifest_pin and sha(OLD/'manifest.json')==old_pin
m=js(OUT/'manifest.json');names=[x['path'] for x in m['files']]
assert len(names)==676 and len(set(names))==676 and m['frozen'] is True
assert set(names)|{'manifest.json'}=={p.relative_to(OUT).as_posix() for p in OUT.rglob('*') if p.is_file()}
for r in m['files']:
    p=OUT/r['path'];assert p.stat().st_size==r['bytes'] and sha(p)==r['sha256']
old_files={p.relative_to(OLD).as_posix():p for p in OLD.rglob('*') if p.is_file()}
archive=OUT/'archive/frozen131'
assert set(old_files)=={p.relative_to(archive).as_posix() for p in archive.rglob('*') if p.is_file()}
for name,p in old_files.items():assert p.read_bytes()==(archive/name).read_bytes()
copies=js(OUT/'source-copies.json')['files'];assert len(copies)==672
for r in copies:assert (ROOT/r['source']).read_bytes()==(OUT/r['path']).read_bytes()
catalog=js(OUT/'provenance/catalog.json');assert len(catalog['accepted_packets'])==16 and catalog['pending_slots']==[]
for packet in catalog['accepted_packets']:
    for r in packet['files']:assert sha(ROOT/r['source'])==r['sha256']==sha(OUT/r['path'])
g=js(OUT/'dependencies.json');nodes={n['id']:n for n in g['nodes']};assert len(nodes)==27
assert 'not an approved proof graph' in g['kind']
visiting=set();done=set()
def visit(k):
    assert k not in visiting
    if k in done:return
    visiting.add(k)
    for dep in nodes[k]['depends_on']:visit(dep)
    visiting.remove(k);done.add(k)
for k in nodes:visit(k)
assert 'topcount' not in nodes['moment']['depends_on']
assert nodes['large_root']['title']=='TernaryGoldbachFrom (10^27) without analytic premises'
assert nodes['full_root']['title']=='Full Statement with only original BinaryGoldbachInput'
status=js(OUT/'staging-status.json');assert status['lean_run'] is False
source=ROOT/'work/ternary-goldbach'
head=subprocess.check_output(['git','-C',str(source),'rev-parse','HEAD'],text=True).strip()
gitstatus=subprocess.check_output(['git','-C',str(source),'status','--porcelain','--untracked-files=all'],text=True).splitlines()
assert head=='23b2d68ca344203d4384e0aff7affa4ec034bef9'
assert gitstatus==['?? TernaryGoldbach/Explicit/QrhMellin.lean','?? TernaryGoldbach/Explicit/QrhNumeric.lean']
paths=[OUT/'manifest.json',OUT/'README.md',OUT/'OVERVIEW.md',OUT/'SELECTED_STRATEGY.md',OUT/'dependencies.json',OUT/'provenance/assemble.py',OUT/'provenance/verify_package.py',OUT/'provenance/catalog.json',OLD/'manifest.json',source/'TernaryGoldbach/Statement.lean',source/'TernaryGoldbach/MainTheorems.lean']
r={'status':'PASS independent snapshot inventory and byte preservation; no proof validation','manifest_files':676,'source_copy_byte_matches':672,'archived_byte_matches':len(old_files),'accepted_packets':16,'research_nodes':27,'new_verifier_observed':'exit0,36landing links,676files','old_verifier_observed':'exit0,575files,131chapters,149links,35nodes','canonical_head':head,'canonical_status':gitstatus,'pins':{str(p.relative_to(ROOT)):sha(p) for p in paths},'script_sha256':sha(Path(__file__))}
(A/'next_synthesis_independent_inventory_20261111.json').write_text(json.dumps(r,indent=2)+'\n')
print(json.dumps(r,indent=2))
