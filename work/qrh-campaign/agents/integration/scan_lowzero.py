from pathlib import Path
import re
root=Path('work/ternary-goldbach'); graph={}
def closure(roots):
 seen=set()
 def visit(m):
  if m in seen:return
  seen.add(m)
  if m not in graph:
   p=root.joinpath(*m.split('.')).with_suffix('.lean')
   graph[m]=[d for l in p.read_text(encoding='utf-8-sig').splitlines() if (x:=re.match(r'^import\s+(.+)',l)) for d in x[1].split() if d.startswith('TernaryGoldbach.')]
  for d in graph[m]:visit(d)
 for m in roots:visit(m)
 return seen
base=closure(['TernaryGoldbach.Explicit.ZeroSumGen','TernaryGoldbach.Explicit.XiPartial'])
low=closure(['TernaryGoldbach.Explicit.ZetaLowZeroFree','TernaryGoldbach.Explicit.Xi'])
print('Base',len(base),'Low',len(low),'Union',len(base|low),'Additional',len(low-base))
print('\n'.join(sorted(low-base)))
