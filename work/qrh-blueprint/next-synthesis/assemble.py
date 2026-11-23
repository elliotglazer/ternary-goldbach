"""Freeze a separate research snapshot. Never modify either frozen package."""
import hashlib
import json
import shutil
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
OLD = ROOT / 'outputs/qrh-blueprint'
OUT = ROOT / 'outputs/qrh-blueprint-next'
KIND = 'proposed research map, not an approved proof graph'

def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def read_json(p): return json.loads(p.read_text(encoding='utf8'))
def encoded(data): return (json.dumps(data, indent=2) + '\n').encode('utf8')
def checked_source(root, rec):
    p = root / rec['path']
    assert p.is_file() and p.stat().st_size == rec['bytes'] and sha(p) == rec['sha256'], str(p)
    return p

catalog = read_json(HERE / 'catalog.json')
old_hash = sha(OLD / 'manifest.json')
assert old_hash == catalog['frozen131_manifest_sha256']
old_manifest = read_json(OLD / 'manifest.json')
old_files = {rec['path']: checked_source(OLD, rec) for rec in old_manifest['files']}
actual_old = {p.relative_to(OLD).as_posix() for p in OLD.rglob('*') if p.is_file()}
assert actual_old == set(old_files) | {'manifest.json'}, 'Unexpected old package file'
sources = []
planned = {}
def source_copy(source, dest, purpose):
    assert dest not in planned, dest
    p = ROOT / source
    planned[dest] = p.read_bytes()
    sources.append(dict(source=source, path=dest, role=purpose, bytes=p.stat().st_size, sha256=sha(p)))

for name, p in old_files.items():
    source_copy(p.relative_to(ROOT).as_posix(), 'archive/frozen131/' + name, 'unchanged historical archive')
source_copy((OLD / 'manifest.json').relative_to(ROOT).as_posix(), 'archive/frozen131/manifest.json', 'unchanged historical archive manifest')
for packet in catalog['accepted_packets']:
    for rec in packet['files']:
        p = ROOT / rec['source']
        assert p.stat().st_size == rec['bytes'] and sha(p) == rec['sha256'], rec['source']
        # Some evidence is intentionally shared between accepted packets.
        if rec['path'] in planned:
            assert planned[rec['path']] == p.read_bytes()
            continue
        source_copy(rec['source'], rec['path'], rec['role'])
for name in ['OVERVIEW.md', 'SELECTED_STRATEGY.md']:
    source_copy((HERE / name).relative_to(ROOT).as_posix(), name, 'frozen research synthesis')
for name in ['assemble.py', 'verify_package.py', 'prepare_catalog.py', 'add_finalized_packets.py', 'catalog.json']:
    source_copy((HERE / name).relative_to(ROOT).as_posix(), 'provenance/' + name, 'assembly provenance')

rows = []
for p in catalog['accepted_packets']:
    report = next(f['path'] for f in p['files'] if f['role'] == 'report')
    review = next(f['path'] for f in p['files'] if f['role'] == 'review')
    rows.append(f"| {p['title']} | [Report]({report}) | [Review]({review}) |")
pending = '\n'.join(f"- {p['title']}: {p['status']}." for p in catalog['pending_slots'])
if not pending:
    pending = 'All three requested local review slots have final pins. The full spectral family, the principal strip above height 1500 and the Lean proofs remain open.'
readme = '''# Next research-blueprint synthesis

Frozen research snapshot, 2026-11-11, awaiting its independent synthesis audit. This is reviewed research evidence and a proposed research map, not a completed proof, approved Lean anchors or an approved Lean dependency graph.

Start with [Current overview](OVERVIEW.md) and [Selected strategy](SELECTED_STRATEGY.md). The [complete 131-chapter historical package](archive/frozen131/README.md) is preserved byte-for-byte. Its superseded routes and chronology remain historical evidence; the two current documents identify the selected route.

The final large theorem must have no new mathematical premise. The full theorem retains only the original `BinaryGoldbachInput`. All finite spectral assertions and computational certificates still require proofs. No Lean build was performed by this assembler.

## Accepted post-131 evidence

Acceptance in this table is limited to each review's stated paper or external-computation claim. It does not mark a Lean theorem proved.

| Packet | Source | Independent review |
|---|---|---|
''' + '\n'.join(rows) + '''

## Review slots

''' + pending + '''

## Preservation and reproduction

`manifest.json` hashes every staged file except itself. `source-copies.json` binds copied material to workspace sources. `provenance/catalog.json` pins the accepted packets and their reviews. `dependencies.json` is an explicitly unapproved research map.

From the repository root, run `python work/qrh-blueprint/next-synthesis/verify_package.py`. It checks the staged bytes, source copies, the full historical archive, current landing-page links and the research map. Run `python work/qrh-blueprint/verify_package.py` separately to check the unchanged old package. These commands do not run Lean, numerical evaluators or a TeX build. Evidence scripts retain their source-relative imports; use the pinned workspace sources for computational replay.

The new synthesis is frozen as research evidence and awaits its own independent synthesis review. No post-freeze edits are permitted; corrections require a successor snapshot or a separately pinned erratum. The archive's original manifest is preserved as an ordinary hashed file in this package. No file in the old package or its assembler/verifier is changed. The interval-primitives and general-family production plans still under review are outside this snapshot.
'''
planned['README.md'] = readme.encode('utf8')

# Coarse proof obligations only. External acceptance is not a formal status.
nodes = []
def node(pid, title, deps=(), status='formal proof obligation'):
    nodes.append(dict(id=pid, title=title, depends_on=list(deps), status=status))
node('checker_math', 'Formalize reviewed EM, polygon, enclosure and Cauchy mathematics', status='reviewed paper arguments; Lean missing')
node('provider', 'Compile and audit genuine global seven-eighths provider', status='reviewed compatibility cut; closure and axiom gates open')
node('zero_transport', 'Actual carriers, principal pole, inverse-character and multiplicity transport', ['provider'])
node('prime_data', 'Complete finite-prime counts and independent recount', status='complete external data; no Lean certificate')
node('finite_nonprime', 'Finite nonprime_mid repair below 10^12 for theta-to-psi transport', status='reviewed finite argument; does not require full global P6')
node('prime_replay', 'Kernel sieve, certified logs and theta recurrence', ['prime_data'], 'reviewed architecture; implementation and kernel replay missing')
node('head', 'Complete head, height-14 exclusion and reciprocal sum', ['checker_math'], 'accepted external data; formal replay missing')
node('sign1500', 'All principal signs and simplicity through closed height 1500', ['head'], 'accepted external certificate; formal replay missing')
top_accepted = any(p['id'] == 'topcount1e6' for p in catalog['accepted_packets'])
assert top_accepted and any(p['id'] == 'em-topcount' for p in catalog['accepted_packets'])
node('topcount', 'Independent total count at height one million via explicit EM/Taylor', ['checker_math'], 'accepted external EM-only count; no RS dependency; not a strip proof')
node('low_strip', 'Principal closed strip [.4968,.5032] above 1500 through one million', ['sign1500'], 'finite spectral certification and Lean proof missing; topcount is an optional alternative ingredient')
node('analytic_count', 'Data-free analytic zero-count bound above 1500', status='reviewed paper argument; Lean missing')
node('moment', 'Principal weighted moment W35 below 24', ['head', 'low_strip', 'analytic_count'])
node('family_pilots', 'Conductor-five rectangle and conductor-101 segment', ['checker_math'], 'accepted bounded external pilots; not full family')
node('family_certificate', 'Complete active primitive family at Hcert and beta<=.555', ['family_pilots'], 'production certificates and Lean proofs missing')
node('psi_envelope', 'Integer psi envelope .01*n/log n over every required range', ['prime_replay', 'finite_nonprime', 'moment', 'family_certificate', 'zero_transport'])
node('p236', 'Exact P2, P3 and P6 producer repairs', status='reviewed paper replacements; Lean missing')
node('other_primes', 'P1, P4, P5 and P7 consumers', ['psi_envelope', 'p236'])
node('mobius', 'Relaxed .03/.10 profile and M1/M2 adapters', ['psi_envelope', 'p236'])
node('totient', 'Finite and remote totient consumer repairs', status='reviewed paper replacements; Lean missing')
node('regionS', 'Separate elementary quotient regionS repair', ['totient'])
node('typeI_II', 'All ten Type I/II producer boundaries and numerical adapters', ['p236', 'other_primes', 'mobius', 'totient'])
node('energy', 'Actual etaPlus energy and consumer side conditions', ['psi_envelope'], 'reviewed paper route; Lean missing')
node('major', 'Major coprime caps, mixed error and complete-sum transfer', ['family_certificate', 'zero_transport'])
node('basegap', 'Finite-family pointwise bound and q=1,2,3 high joins', ['family_certificate', 'zero_transport', 'typeI_II'])
node('minor', 'Minor total with the selected constants', ['typeI_II', 'regionS', 'energy', 'basegap'])
node('large_root', 'TernaryGoldbachFrom (10^27) without analytic premises', ['major', 'minor', 'p236'])
node('full_root', 'Full Statement with only original BinaryGoldbachInput', ['large_root'])
planned['dependencies.json'] = encoded(dict(kind=KIND, semantics='coarse selected obligations, not declaration-level edges or proof validation', nodes=nodes))
planned['source-copies.json'] = encoded(dict(kind='byte provenance only; not mathematical validation', files=sources))
planned['staging-status.json'] = encoded(dict(stage=catalog['package_stage'], frozen=True, lean_run=False,
    old_manifest_sha256=old_hash, archived_files=len(old_files)+1, accepted_packets=len(catalog['accepted_packets']),
    pending_slots=catalog['pending_slots'], limitations=['No approved declaration graph', 'No new Lean proof', 'No full family spectral certificate', 'No principal strip certificate above height 1500']))

manifest = dict(kind='frozen research deliverable, not proof validation', source_pin=old_manifest['source_pin'],
                frozen=True, files=[dict(path=name, bytes=len(data), sha256=hashlib.sha256(data).hexdigest()) for name, data in sorted(planned.items())])
manifest_bytes = encoded(manifest)
if OUT.exists():
    existing = {p.relative_to(OUT).as_posix() for p in OUT.rglob('*') if p.is_file()}
    assert existing <= set(planned) | {'manifest.json'}, f'Unexpected staging files: {existing - set(planned)}'
    old_stage_manifest = OUT / 'manifest.json'
    if old_stage_manifest.exists() and read_json(old_stage_manifest).get('frozen') is True:
        assert old_stage_manifest.read_bytes() == manifest_bytes, 'Frozen snapshot differs; create a successor, do not edit this package'
        assert existing == set(planned) | {'manifest.json'}
        for dest, data in planned.items():
            assert (OUT / dest).read_bytes() == data, f'Frozen file differs: {dest}'
        print(json.dumps(dict(result='already frozen; identical reproduction; no writes', manifest_sha256=sha(old_stage_manifest))))
        raise SystemExit(0)
for dest, data in planned.items():
    p = OUT / dest
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_bytes(data)
(OUT / 'manifest.json').write_bytes(manifest_bytes)
assert sha(OLD / 'manifest.json') == old_hash
print(json.dumps(dict(output=str(OUT), staged_files=len(planned)+1, bytes=sum(len(v) for v in planned.values()),
                      archived_files=len(old_files)+1, accepted_packets=len(catalog['accepted_packets']), pending_slots=catalog['pending_slots'], frozen=True,
                      manifest_sha256=sha(OUT / 'manifest.json'))))
