from pathlib import Path
import json,re
base=Path('work/openai-math/lean'); seen=set(); order=[]; missing=set(); ext=set()
def visit(mod):
 if mod in seen: return
 seen.add(mod)
 p=base.joinpath(*mod.split('.')).with_suffix('.lean')
 if not p.exists(): missing.add(mod); return
 for line in p.read_text(encoding='utf-8-sig').splitlines():
  m=re.match(r'^(?:public )?import\s+(.+)',line)
  if m:
   for dep in m.group(1).split():
    if dep.startswith('OAI.'): visit(dep)
    else: ext.add(dep)
 order.append(mod)
visit('OAI.NumberTheory.DirichletL.Nonvanishing')
print('OAI closure modules',len(order),'lines',sum(len(base.joinpath(*m.split('.')).with_suffix('.lean').read_text(encoding='utf-8-sig').splitlines()) for m in order))
print('Missing OAI', sorted(missing)); print('External roots', sorted(set(x.split('.')[0] for x in ext)))
print('Placeholder hits')
for mod in order:
 p=base.joinpath(*mod.split('.')).with_suffix('.lean')
 for n,line in enumerate(p.read_text(encoding='utf-8-sig').splitlines(),1):
  if re.search(r'\b(sorry|axiom|admit)\b',line): print(str(p),n,line[:180])
Path('work/qrh-campaign/agents/integration/qrh-modules.json').write_text(json.dumps(order,indent=2))
