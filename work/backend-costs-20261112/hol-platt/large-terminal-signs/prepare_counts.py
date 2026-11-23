from pathlib import Path
import gzip,csv
from collections import defaultdict
d=Path(__file__).resolve().parent
for name in ['low','high']:
 ss=defaultdict(list)
 with gzip.open(d.parent/'c10004-grid-repair'/f'{name}-signs.tsv.gz','rt') as f:
  for r in csv.DictReader(f,delimiter='\t'):
   ss[int(r['k41']),int(r['k61'])].append((int(r['j']),int(r['sign'])))
 out=[]
 for _,rs in sorted(ss.items()):
  begin=rs[0][0]; upper=rs[-1][0]+1;to=0;c=0
  for k,(j,sign) in enumerate(rs):
   assert j==begin+k and abs(sign)==1
   if k and sign!=rs[k-1][1]:c+=1;to+=4096*(upper-j)
  out.append([sum((s>0)<<i for i,(_,s) in enumerate(rs)),c,to])
 print(name,len(out),begin,upper,len(rs),sum(u[1] for u in out),sum(u[2] for u in out))
 (d/(name+'count.txt')).write_text(''.join(' '.join(map(str,r))+'\n' for r in out))
