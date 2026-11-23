"""Read-only evidence verification for the completed positive-height pilot."""
from pathlib import Path
import hashlib
import json
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
PILOTS = HERE.parent
def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()

probe = json.loads((HERE / 'positive_height_export_probe_receipt.json').read_text())
assert probe['exit_code'] == 0 and probe['temporary_probe_deleted']
assert not (HERE / 'PositiveHeightSemanticProbe.lean').exists()
for rel, h in probe['pins'].items():
    assert sha(ROOT / rel) == h
assert sha(HERE / 'positive_height_export_probe.log') == probe['log_sha256']
reviews = {
    'audit/spectral-inputs/REVIEW_2026-11-11.md': 'B5FE164DFC0758F3B8B867AA99E1F1AFBDD86D6C80670DCAC4FFBE1A6E9851D3',
    'audit/abel/REVIEW_2026-11-11.md': '8AA5BB633EF1EA429887C2E58DCE96A8687F9DCC24719D49D6BAA9E794B05ED0',
    'audit/spectral-completion/GAMMA_COMPLETION_SOURCE_AUDIT.md': 'D905B0120422E5B3BA2212CE06DDE97CB8108E9BF7CCC3DE2AB55C68778549A4',
    'spectral-reality/REPORT.md': '75AC92BB0DD8326D754B6F99758355109C2AB0BA5AC7674C322B7F29BFA20FEE',
}
for rel, h in reviews.items():
    assert sha(PILOTS / rel) == h

folder = PILOTS / 'spectral'
manifest_path = folder / 'full_closure_manifest_v2.json'
manifest = json.loads(manifest_path.read_text())
full = (folder / 'FullSpectralPilotV2.lean').read_text(encoding='utf8')
chunks = full.split('-- BEGIN OWN SOURCE ')
assert len(chunks) == 12
assert chunks[0].strip().splitlines() == ['import ' + m for m in manifest['external_imports']]
for chunk, pin in zip(chunks[1:], manifest['sources'], strict=True):
    path = Path(pin['path'])
    assert sha(path) == pin['sha256'].upper()
    lines = path.read_text(encoding='utf-8-sig').splitlines()
    body = [line for line in lines if not re.fullmatch(r'import (\S+)', line)]
    implicit = sum(line.strip() == 'noncomputable section' for line in lines)
    expected = str(path) + '\nsection\n' + '\n'.join(body) + '\n' + 'end\n' * (implicit + 1)
    assert chunk.rstrip() == expected.rstrip()
assert sha(folder / 'FullSpectralPilotV2.lean') == manifest['full_sha256'].upper()
build_path = folder / 'FullSpectralPilotV2_strict_20261111_235315.json'
build = json.loads(build_path.read_text())
assert build['exit_code'] == 0 and build['trust_level'] == 0
assert build['source_sha256'].upper() == sha(folder / 'FullSpectralPilotV2.lean')
assert build['olean_sha256'].upper() == sha(folder / 'FullSpectralPilotV2.olean')
assert build['log_sha256'].upper() == sha(build_path.with_suffix('.log'))
out = HERE / 'positive_height_evidence_receipt.json'
assert not out.exists()
evidence_paths = [HERE / 'positive_height_export_probe_receipt.json',
    HERE / 'positive_height_export_probe.log', HERE / 'audit_positive_height_export.py',
    folder / 'POSITIVE_HEIGHT_TARGET.md', manifest_path, build_path,
    folder / 'FullSpectralPilotV2.lean', folder / 'FullSpectralPilotV2.olean']
result = {
    'scope': 'Static source/object/evidence binding only; no analytic evaluation or new Lean run',
    'probe_pins_verified': len(probe['pins']), 'review_pins': reviews,
    'full_closure_owned_bodies_exact': len(manifest['sources']),
    'evidence_pins': {str(p.relative_to(ROOT)).replace('\\', '/'): sha(p) for p in evidence_paths},
    'script_sha256': sha(Path(__file__)),
}
out.write_text(json.dumps(result, indent=2) + '\n', encoding='utf8')
print(json.dumps({'receipt_sha256': sha(out), 'verified_owned_bodies': 11}))
