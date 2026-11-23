import json,runpy,math
from pathlib import Path
p=Path('work/qrh-campaign/agents/moebius')
m=runpy.run_path(str(p/'base_gap_90090_middle.py'))
evaluate=m['evaluate']
rows=[evaluate(u,vf,y=10.**e,n=600) for e in range(25,81) for u in [30000,35000,40000,500000] for vf in [16,64,128]]
worst=[]
for u in [30000,35000,40000,500000]:
 for vf in [16,64,128]:
  row=min((r for r in rows if r['u']==u and r['V_multiplier']==vf),key=lambda r:r['slack'])
  refined=evaluate(u,vf,y=row['y'],n=4000)
  worst.append(refined)
  print(u,vf,'log10y',math.log10(row['y']),'slack',refined['slack'],'total',refined['total'])
# Diagnose where the unchanged raw-above part already exceeds the allowance.
def dead(u):
 r=evaluate(u,128,n=1500)
 return r['raw_above']+r['tails']-r['ghat']
def root(a,b):
 fa=dead(a)
 for _ in range(32):
  c=(a+b)/2
  if dead(c)*fa>0:a=c
  else:b=c
 return (a+b)/2
roots=[root(50000,150000),root(300000,500000)]
print('raw-above+tail-only dead zone roots',roots)
(p/'base_gap_90090_middle_yscan.json').write_text(json.dumps({'status':'Floating grid diagnostics only. No continuum coverage is asserted.','log10_y_grid':'integers25..80','worst_samples_refined':worst,'raw_above_plus_tail_crossings_at_Y':roots},indent=2))
