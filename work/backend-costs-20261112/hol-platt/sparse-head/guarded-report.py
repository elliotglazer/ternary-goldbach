from pathlib import Path
from collections import defaultdict
import json,re,hashlib
p=Path(__file__).resolve().parent
assert (p/'checksweep01.status').read_text().strip()=='0'
f=p.parent/'small-time-selected-consumer'
jobs=defaultdict(list)
for line in (p/'checksweep01.log').read_text().splitlines():
    m=re.fullmatch(r'(\d+),(\d+),(\d+),([.\d]+),([.\d]+)',line)
    if m:
        lab,i,mode,sec,_=m.groups()
        jobs[int(lab),int(i),int(mode)].append(float(sec))
count=0
for l in [3,6667,11,9091]:
    for i in [0,128,512,1024]:
        words=(f/f'g-{l}-{i}.hex').read_text().split()
        n=int(words[-1],16)
        assert int(words[2],16).bit_count()==n
        count+=n
        assert len(jobs[l,i,2])==len(jobs[l,i,3])==2
sums={i:sum(sum(v) for (l,r,m),v in jobs.items() if m==i) for i in (2,3)}
out=dict(rows=16,nonempty_rows=12,distinct_sites=count,repetitions_per_row=2,baseline_cpu=sums[2],guarded_cpu=sums[3],difference_cpu=sums[3]-sums[2],scope="direct literal cv_eval, GC and quotation conversions dominate; no full-campaign transport",log_sha256=hashlib.sha256((p/'checksweep01.log').read_bytes()).hexdigest())
(p/'guarded-sites.json').write_text(json.dumps(out,indent=2)+'\n')
print(out)
