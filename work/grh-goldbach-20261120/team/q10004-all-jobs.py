"""Prepare deduplicated raw sample spans, kernels, and exact prior-packet references."""
from fractions import Fraction as F
from hashlib import sha256
import json
from pathlib import Path
import sys
from time import process_time

team=Path(__file__).resolve().parent
local=team/'q10004-gaussian'
hol=local/'hol'
base=team.parents[1]/'backend-costs-20261112/hol-platt'
sys.path[:0]=[str(local),str(base/'small-character-kernel'),str(base/'one-character-completeness')]
from spectrum import LABELS
from grid import HALO,GRID_BITS
from repair import rationals,kernel,SUB,ORDER,WBITS
def digest(p): return sha256(p.read_bytes()).hexdigest()
def dump(name,lines):
    p=hol/name
    p.write_bytes(('\n'.join(lines)+'\n').encode())
    return digest(p)
t0=process_time()
grid=json.loads((local/'grid.json').read_bytes())
spec=json.loads((local/'spectrum.json').read_bytes())
counts=json.loads((local/'counts.json').read_bytes())
analytic,rem,sample=rationals(spec)
coarse=int((analytic+sample)*2**GRID_BITS)+1
packet=(hol/'packets.txt').read_text().splitlines()
manifest=json.loads((hol/'manifest.json').read_bytes())
assert digest(hol/'packets.txt')==manifest['packet_sha256']
target=6578*64*(SUB//5)
edges={1,target-1,target+1,target+320*SUB-1,target+640*SUB-1}
summary={}
offsets=set()
for ix,label in enumerate(LABELS):
    rawpath=local/f'grid-{label}.txt'
    signpath=local/f'signs-{label}.tsv'
    assert digest(rawpath)==grid['rows'][ix]['grid_sha256'] and digest(signpath)==counts['sha256'][signpath.name]
    raw=list(map(int,rawpath.read_text().splitlines()))
    signs=dict(tuple(map(int,x.split())) for x in signpath.read_text().splitlines())
    data=[(t,v) for t,v in signs.items() if t%SUB and t not in edges]
    assert len(data)==counts['channels'][ix]['discovery_requests']
    number=2*(ix//2)+1
    refs={}
    for region in (0,1):
        header=9*number+4*(ix%2)+2*region
        assert list(map(int,packet[header].split()[:3]))==[number,ix%2,region]
        vals=list(map(int,packet[header+1].split()))
        for b,(p,n,w) in enumerate(zip(vals[::3],vals[1::3],vals[2::3],strict=True)):
            for i in range(n): refs[p+i*SUB]=(region,b,i,(w>>i)&1)
    intervals=[]
    jobs=[]
    threshold=int((analytic+rem+5*sample+F(ORDER*max(map(abs,raw)),2**(WBITS+GRID_BITS)))*2**(WBITS+GRID_BITS))+1
    for tick,sign in data:
        j,off=divmod(tick,SUB)
        first=j+1-ORDER//2
        if intervals and first<=intervals[-1][1]:
            intervals[-1][1]=max(intervals[-1][1],first+ORDER)
        else: intervals.append([first,first+ORDER])
        offsets.add(off)
        selected=[refs[t] for t in (j*SUB,tick,(j+1)*SUB)]
        region=selected[1][0]
        assert all(entry[0]==region for entry in selected)
        bits=sum((x>0)<<k for k,x in enumerate(raw[first+HALO:first+HALO+ORDER]))
        jobs.append([region,first,tick,off,bits,*(v for _,b,i,_ in selected for v in (b,i))])
    lines=[f'{label} {coarse} {threshold} {len(intervals)} {len(jobs)}']
    for a,b in intervals:
        lines.append(str(a)+' '+' '.join(map(str,raw[a+HALO:b+HALO])))
    lines.extend(' '.join(map(str,job)) for job in jobs)
    summary[label]=dict(jobs=len(jobs),spans=len(intervals),samples=sum(b-a for a,b in intervals),
        aux_jobs=sum(job[0] for job in jobs),raw_sha256=digest(rawpath),packed_sha256=dump(f'all-{label}.txt',lines))
assert sum(e['jobs'] for e in summary.values())==93
rows=[str(len(offsets))]+[str(off)+' '+' '.join(map(str,kernel(off))) for off in sorted(offsets)]
khash=dump('all-kernels.txt',rows)
(hol/'all-input.json').write_text(json.dumps(dict(channels=summary,kernels=len(offsets),
    kernel_sha256=khash,packet_sha256=manifest['packet_sha256'],prep_cpu=process_time()-t0),indent=2))
print(summary,len(offsets))
