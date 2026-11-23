from pathlib import Path
from statistics import mean
from collections import defaultdict
import json,re
p=Path(__file__).parent; complete={}
for f in p.glob('stable*_bench.log'):
  rows=defaultdict(lambda:defaultdict(list))
  for l,k,n,m,c,w in re.findall(r'^(p?\d+),(\d+),(\d+),(\d+),([.\d]+),([.\d]+)',f.read_text(),re.M):
    rows[l][int(m)].append(float(c))
  full={}
  for l,v in rows.items():
    if len(v[1])==len(v[2])==2:
      net=(mean(v[2])-mean(v[1]))/128
      pairs=[(b-a)/128 for a,b in zip(v[1],reversed(v[2]))]
      full[l]=dict(mean_net=net,replicated_pair_deltas=pairs)
  complete[f.name]=full
done=[d for d in complete.values() if len(d)==8]
if done:
  rr=done[-1];labs=['3','6667','11','9091']
  a=mean(rr[l]['mean_net'] for l in labs);b=mean(rr['p'+l]['mean_net'] for l in labs)
  summary=dict(genuine_mean=a,periodic_mean=b,delta=a-b,ratio=a/b,paired_channel_premia=[rr[l]['mean_net']-rr['p'+l]['mean_net'] for l in labs],sites=1024,retained=706)
else:summary={}
out=dict(controls=complete,summary=summary)
(p/'genuine-stable.json').write_text(json.dumps(out,indent=2));print(out)
