from delivery import *
from statistics import median,mean
from collections import defaultdict
import re
sched=json.loads((p/'schedule.json').read_bytes())
runs=defaultdict(list)
for n,pc,k,m,t in re.findall(r'^(\d+),(\d+),(\d+),(\d+),([.\d]+)',(p/'long01_bench.log').read_text(),re.M):
 runs[int(n),int(pc),int(k)].append((int(m),float(t)))
prices=[]
for (n,prec,k),a in runs.items():
 if len(a)!=8:continue
 r=[t for m,t in a if m==1];s=[t for m,t in a if m==2]
 diff=[t2-t1 if m1==1 else t1-t2 for (m1,t1),(m2,t2) in zip(a[::2],a[1::2])]
 cnt=sched['per_np' if prec>128 else 'per_n']['dense_manifest']
 prices.append(dict(n=n,precision=prec,sites=k,recurrence=median(r),full=median(s),packing=median(diff),pairs=diff,
   all_full_hours=cnt*median(s)/k/3600,additional_pack_hours=cnt*median(diff)/k/3600,
   c10000_class_hours=sched['c10000_class']['dense_manifest']*median(s)/k/3600))
out=dict(packets=prices);(p/'prices.json').write_text(json.dumps(out,indent=2))
print([(v['n'],v['precision'],v['sites'],round(v['recurrence'],3),round(v['full'],3),round(v['packing'],3),round(v['all_full_hours'],1),round(v['additional_pack_hours'],1)) for v in prices])
