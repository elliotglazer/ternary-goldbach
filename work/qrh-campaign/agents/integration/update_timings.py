from pathlib import Path
import json
p=Path('work/qrh-campaign/agents/integration/compile-timings.json')
d=json.loads(p.read_text())
seen={m['module'] for m in d['checked_modules']}
for module,seconds in [('TernaryGoldbach.Explicit.LGrowthLeft',39.2),('TernaryGoldbach.Explicit.ZeroCount',35.6),('TernaryGoldbach.Explicit.LogDerivL',455.3),('TernaryGoldbach.Explicit.ExplicitFormula',273.2)]:
 if module not in seen:d['checked_modules'].append({'module':module,'exit_code':0,'seconds':seconds})
d['active_session']=11793
p.write_text(json.dumps(d,indent=2))
