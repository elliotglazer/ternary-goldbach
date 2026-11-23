import csv,statistics
from pathlib import Path
d=Path(__file__).resolve().parent
rows={}
for line in (d/'tile04_bench.log').read_text().splitlines():
    if line.startswith('TILE,'):
        _,m,k,w,r,t,_=line.split(',')
        if int(r):rows[int(w),int(k),int(r),int(m)]=float(t)
out=[]
for w,k in sorted({(w,k) for w,k,r,m in rows}):
    for name,m,c,count in [('split-minus-control',2,3,1_836_492_654),('add-minus-control',5,0,1_836_492_654),('pack-total',1,None,None),('three-tile-consume-total',4,None,1_775_431_871_117)]:
        if (w,k,1,m) not in rows:continue
        times=[(rows[w,k,r,m]-(rows[w,k,r,c] if c is not None else 0)) for r in (1,2,3)]
        per=2**k if m in (1,4) else 1
        a,b,e=[x/per for x in (min(times),statistics.median(times),max(times))]
        out.append([w,2**k,name,a,b,e,'' if count is None else b*count/3600])
with (d/'paired-times.csv').open('w',newline='') as f:
    wr=csv.writer(f);wr.writerow(['width','lanes','case','min_cpu_s_per_unit','median_cpu_s_per_unit','max_cpu_s_per_unit','unadjusted_campaign_core_h']);wr.writerows(out)
for row in out:
    if row[1]==65536 or row[1]==4096 and row[2] in ('three-tile-consume-total','pack-total'):
        print(row)
