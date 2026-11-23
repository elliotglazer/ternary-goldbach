from pathlib import Path
import re, json
root=Path('work/ternary-goldbach')
seen=set(); order=[]; missing=set()
def visit(mod):
 if mod in seen: return
 seen.add(mod)
 path=root.joinpath(*mod.split('.')).with_suffix('.lean')
 if not path.exists():
  missing.add(mod); return
 for line in path.read_text(encoding='utf-8-sig').splitlines():
  m=re.match(r'^(?:public )?import\s+(.+)',line)
  if m:
   for dep in m.group(1).split():
    if dep.startswith('TernaryGoldbach.') or dep=='LadderHints': visit(dep)
 order.append(mod)
for mod in ['TernaryGoldbach.Explicit.PsiAsymp','TernaryGoldbach.Explicit.ZeroSumGen','TernaryGoldbach.Prelim.SchoenfeldGen']: visit(mod)
Path('work/qrh-campaign/agents/integration/project-modules.json').write_text(json.dumps(order,indent=2))
print('Project modules',len(order)); print('\n'.join(order)); print('Missing',missing)
