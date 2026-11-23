from pathlib import Path
import re,json
base=Path('work/openai-math/lean'); allmods=json.loads(Path('work/qrh-campaign/agents/integration/qrh-modules.json').read_text()); graph={}
for mod in allmods:
 text=base.joinpath(*mod.split('.')).with_suffix('.lean').read_text(encoding='utf-8-sig')
 graph[mod]=[dep for line in text.splitlines() if (m:=re.match(r'^(?:public )?import\s+(.+)',line)) for dep in m[1].split() if dep.startswith('OAI.')]
for root in ['OAI.NumberTheory.DirichletL.Foundation','OAI.NumberTheory.DirichletL.Detector.FinalAssemblyUnconditional']:
 seen=set()
 def visit(mod):
  if mod in seen:return
  seen.add(mod)
  for d in graph.get(mod,[]):visit(d)
 visit(root)
 print(root,len(seen),'imports Foundation', 'OAI.NumberTheory.DirichletL.Foundation' in seen)
Path('work/qrh-campaign/agents/integration/qrh-import-graph.json').write_text(json.dumps(graph))
