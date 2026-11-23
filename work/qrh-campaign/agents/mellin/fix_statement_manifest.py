from pathlib import Path
import json
p=Path('work/qrh-campaign/agents/mellin/statement-import-manifest.json')
m=json.loads(p.read_text()); m['circle_method_review_providers_reachable'].pop('Mathlib.Tactic.NormCast',None)
m['circle_method_core_tactic_provider']='Lean.Elab.Tactic.NormCast; this scanner does not recursively inspect core Lean modules'
p.write_text(json.dumps(m,indent=2)+'\n')
