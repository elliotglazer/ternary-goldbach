"""Freeze source and independent compile evidence; no compilation or values."""
from pathlib import Path
import hashlib,json
H=Path(__file__).resolve().parent;R=H.parents[3]
P=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib')
def pin(p):
 b=p.read_bytes();return dict(path=str(p),bytes=len(b),sha256=hashlib.sha256(b).hexdigest().upper())
for name in ('FiniteAbel','Audit'):
 j=json.loads((H/(name+'.json')).read_text());assert j['exit_code']==0 and not j['dependency_build']
assert pin(H/'FiniteAbel.lean')['sha256']=='98B68F87E5F4EB842E2B839C368F7066B958A6A266B3C42D995F576A3BD46310'
assert (H/'FiniteAbel.olean').read_bytes()==(R/'work/lean-pilots/spectral-abel/FiniteAbel.olean').read_bytes()
log=(H/'Audit.log').read_text(encoding='utf-8')
ax=[l for l in log.splitlines() if 'depends on axioms:' in l]
assert len(ax)==4 and all(l.endswith('[propext, Classical.choice, Quot.sound]') for l in ax)
paths=[H/x for x in ('FiniteAbel.lean','FiniteAbel.olean','FiniteAbel.json','FiniteAbel.log','Audit.lean','Audit.olean','Audit.json','Audit.log','run_audit.py','make_receipt.py')]
paths += [R/'work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean',R/'work/qrh-campaign/agents/integration/artifacts/TernaryGoldbach/Explicit/LGrowth.olean',R/'work/qrh-campaign/agents/integration/logs/TernaryGoldbach.Explicit.LGrowth.success.json',P/'Mathlib/NumberTheory/AbelSummation.lean',P/'Mathlib/NumberTheory/LSeries/DirichletContinuation.lean']
out=dict(verdict='PASS for exact generic finite Abel decomposition; no concrete tail or full spectral acceptance',pins=[pin(p) for p in paths],axiom_lines=ax)
with (H/'review_receipt.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(pin(H/'review_receipt.json')))
