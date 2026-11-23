"""Hash existing final pilot evidence. No Lean run or mathematical evaluation."""
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]

def record(path):
    data = path.read_bytes()
    return dict(path=str(path), bytes=len(data), sha256=hashlib.sha256(data).hexdigest().upper())

manifest = json.loads((HERE / 'full_closure_manifest_v2.json').read_text())
paths = []
for item in manifest['sources']:
    path = Path(item['path'])
    assert record(path)['sha256'].lower() == item['sha256']
    paths += [path, path.with_suffix('.olean')]
local_names = [
    'REPORT.md', 'freeze_pilot_receipt.py', 'full_closure_manifest_v2.json',
    'FullSpectralPilotV2.lean', 'FullSpectralPilotV2.olean',
    'FullSpectralPilotV2_strict_20261111_235315.json',
    'FullSpectralPilotV2_strict_20261111_235315.log',
    'ImportBaseline.lean', 'ImportBaseline.olean',
    'ImportBaseline_strict_20261111_235422.json',
    'ImportBaseline_strict_20261111_235422.log',
    'FullPilotAudit.lean', 'FullPilotAudit.olean',
    'FullPilotAudit_20261111_235534.json', 'FullPilotAudit_20261111_235534.log',
    'CorruptInputControl.lean', 'CorruptInputControl_20261111_235546.json',
    'CorruptInputControl_20261111_235546.log',
    'FullSpectralPilot.lean', 'FullSpectralPilot_strict_20261111_235122.json',
    'FullSpectralPilot_strict_20261111_235122.log',
    'assemble_full_pilot_v2.py', 'measure_lean.py', 'run_lean.py',
    'input_centers.json', 'make_input_centers.py', 'write_rounding_proofs.py',
]
paths += [HERE / name for name in local_names]
relative_names = [
    'work/qrh-campaign/agents/audit/REVIEW_POSITIVE_HEIGHT_SPECTRAL_PILOT_SEMANTICS_2026-11-11.md',
    'work/lean-pilots/audit/spectral-inputs/REVIEW_2026-11-11.md',
    'work/lean-pilots/audit/abel/REVIEW_2026-11-11.md',
    'work/lean-pilots/audit/spectral-completion/GAMMA_COMPLETION_SOURCE_AUDIT.md',
    'work/lean-pilots/audit/positive_height_export_probe_receipt.json',
    'work/lean-pilots/audit/positive_height_evidence_receipt.json',
    'work/lean-pilots/spectral-reality/REPORT.md',
    'work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean',
    'work/qrh-campaign/agents/integration/artifacts/TernaryGoldbach/Explicit/LGrowth.olean',
    'work/qrh-campaign/agents/integration/logs/TernaryGoldbach.Explicit.LGrowth.success.json',
    'work/ternary-goldbach/lake-manifest.json',
]
paths += [ROOT / name for name in relative_names]
paths += [Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')]
records = [record(p) for p in dict.fromkeys(paths)]
build = json.loads((HERE / 'FullSpectralPilotV2_strict_20261111_235315.json').read_text())
baseline = json.loads((HERE / 'ImportBaseline_strict_20261111_235422.json').read_text())
audit = json.loads((HERE / 'FullPilotAudit_20261111_235534.json').read_text())
corrupt = json.loads((HERE / 'CorruptInputControl_20261111_235546.json').read_text())
assert build['exit_code'] == baseline['exit_code'] == audit['exit_code'] == 0
assert corrupt['exit_code'] == 1 and not (HERE / 'CorruptInputControl.olean').exists()
assert all('-t0' in x['command'] for x in (build, baseline, audit, corrupt))
receipt = dict(
    status='complete internal actual positive-height sample; independently reviewed PASS',
    theorem='SpectralPilot.positive_height_chi4_certificate',
    hypotheses=[], axioms=['propext', 'Classical.choice', 'Quot.sound'],
    source_closure_files=11, complete_build=build, import_baseline=baseline,
    strict_audit=audit, strict_corrupt_control=corrupt,
    first_bundle_failed=True, successful_bundle='FullSpectralPilotV2',
    default_trust_development_distinct=True, dependency_rebuild=False,
    production_throughput_claim=False, full_family_RH_claim=False,
    nearest_rounding_policy_claim=False, artifacts=records,
)
destination = HERE / 'pilot_receipt.json'
with destination.open('x', encoding='utf8', newline='\n') as stream:
    json.dump(receipt, stream, indent=2)
    stream.write('\n')
print(json.dumps({'report': record(HERE / 'REPORT.md'), 'receipt': record(destination)}, indent=2))
