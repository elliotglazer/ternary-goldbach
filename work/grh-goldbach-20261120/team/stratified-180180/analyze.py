"""Replay individual repair requests and compare aligned coarse/repaired margins."""
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
from time import perf_counter_ns,process_time
import json
import sys

root=Path(__file__).resolve().parent
team=root.parent
engine=team/'gaussian-panel-q180180'
parent=team.parents[1]/'backend-costs-20261112/hol-platt'
sys.path.extend([str(engine),str(parent/'one-character-completeness'),str(parent/'small-character-kernel')])
from repair import discover,kernel,ORDER,SUB,WBITS,GRID_BITS,HALO

def flips(signs,l,h):
    seq=[(j,s) for j,s in signs if l<=j<=h]
    return [j for (i,s),(j,t) in zip(seq,seq[1:]) if s!=t]

freeze=json.loads((root/'freeze.json').read_bytes())
summary=[]
cpu=0
for i in range(4):
    p=root/f'group{i}'
    if not (p/'inclusive-rounded.json').exists(): continue
    spec,grid,c,inc=[json.loads((p/f).read_bytes()) for f in ('spectrum.json','grid.json','counts.json','inclusive-rounded.json')]
    T=spec['main']*SUB
    H=spec['final']*SUB
    cpu+=spec['cpu_seconds']+grid['total_cpu']+c['total_cpu']
    for parity in (0,1):
        _,a,b=freeze['selected'][parity][i]
        assert spec['labels'][2*parity:2*parity+2]==[a,b]
        r=next(x for x in inc['rows'] if x['labels']==[a,b] and x['guard']==640)
        channels=[]
        sums=[0,0]
        for idx,label in enumerate([a,b],2*parity):
            f=p/f'grid-{label}.txt'
            assert sha256(f.read_bytes()).hexdigest()==grid['rows'][idx]['grid_sha256']
            raw=list(map(int,f.read_text().splitlines()))
            coarse=[(j*SUB,1 if x>0 else -1) for j,x in enumerate(raw[HALO:HALO+spec['final']+1])]
            sums[0]+=len(flips(coarse,0,T))
            sums[1]+=sum(H-j for j in flips(coarse,T,H))
            t=perf_counter_ns()
            jobs=sorted(discover(raw,spec['final']))
            discovery_ns=perf_counter_ns()-t
            assert len(jobs)==c['channels'][idx]['discovery_requests']
            signed=p/f'signs-{label}.tsv'
            assert sha256(signed.read_bytes()).hexdigest()==c['sha256'][signed.name]
            certified=dict(tuple(map(int,l.split())) for l in signed.read_text().splitlines())
            timings=[]
            for tick in jobs:
                j,off=divmod(tick,SUB)
                start=j+HALO+1-ORDER//2
                before=kernel.cache_info().misses
                t=perf_counter_ns()
                dot=sum(w*x for w,x in zip(kernel(off),raw[start:start+ORDER],strict=True))
                ns=perf_counter_ns()-t
                assert (1 if dot>0 else -1)==certified[tick]
                timings.append(dict(tick=tick,offset=off,wall_ns=ns,new_kernel=before<kernel.cache_info().misses))
            channels.append(dict(label=label,jobs=len(jobs),guard_jobs=sum(t>T for t in jobs),discovery_ns=discovery_ns,repair=timings))
        coarse_excess=(F(r['phase_upper'])-F(5*sums[1],64*SUB)+36)/50-sums[0]
        summary.append(dict(pair=[a,b],parity=parity,coarse_K=sums[0],repaired_K=r['K'],
            coarse_excess=str(coarse_excess),coarse_pass=coarse_excess<1,repaired_excess=r['U_minus_K']['moderate'],
            repaired_pass=F(r['U_minus_K']['moderate'])<1,channels=channels,cells=2*spec['final']))
data=dict(rows=summary,source_cpu_seconds=cpu,cells=sum(r['cells'] for r in summary),
          jobs=sum(c['jobs'] for r in summary for c in r['channels']),
          native_first_pass=sum(r['repaired_pass'] for r in summary),
          timing_scope='Repair wall times include exact kernel on first use and dot, and exclude source loading. Source receipts retain full strict error verification.')
(root/'summary.json').write_text(json.dumps(data,indent=2))
print([(r['pair'],sum(c['jobs'] for c in r['channels']),float(F(r['coarse_excess'])),float(F(r['repaired_excess']))) for r in summary])
print(data['source_cpu_seconds'],data['cells'],data['jobs'])
