from pathlib import Path
import json,re
base=Path('work/openai-math/lean')
roots=['OAI.NumberTheory.DirichletL.RowCompletion.ZeroFreeRegion','OAI.NumberTheory.DirichletL.Nonvanishing']
results={}
for root in roots:
    seen=set(); external=set(); missing=set(); lines=0; hits=[]
    def visit(mod):
        global lines
        if mod in seen:return
        seen.add(mod)
        p=base.joinpath(*mod.split('.')).with_suffix('.lean')
        if not p.exists():missing.add(mod);return
        text=p.read_text(encoding='utf-8-sig')
        lines+=len(text.splitlines())
        for i,line in enumerate(text.splitlines(),1):
            if re.search(r'\b(sorry|axiom|admit)\b',line):hits.append([mod,i,line[:180]])
            m=re.match(r'^(?:public )?import\s+(.+)',line)
            if m:
                for dep in m[1].split():
                    if dep.startswith('OAI.'):visit(dep)
                    else:external.add(dep)
    visit(root)
    results[root]={'modules':len(seen),'lines':lines,'missing':sorted(missing),'external_roots':sorted(set(d.split('.')[0] for d in external)),'lexical_hits':hits,'closure':sorted(seen)}
Path('work/qrh-campaign/agents/zero-sum/row-completion-closure.json').write_text(json.dumps(results,indent=2))
for root,r in results.items():print(root, {k:v for k,v in r.items() if k not in ['closure','lexical_hits']},'lexical_hits',len(r['lexical_hits']))
print('extra main modules',len(set(results[roots[1]]['closure'])-set(results[roots[0]]['closure'])))
