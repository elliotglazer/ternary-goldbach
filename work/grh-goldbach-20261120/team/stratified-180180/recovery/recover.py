"""Recover intentionally withheld integer-grid signs from the 192 other neighboring nodes."""
from fractions import Fraction as F
from functools import lru_cache
from hashlib import sha256
from math import comb
from pathlib import Path
import json
import sys
from time import perf_counter_ns

out=Path(__file__).resolve().parent
root=out.parent
team=root.parent
work=team.parents[1]
engine=team/'gaussian-panel-q180180'
sys.path.extend([str(engine),str(work/'backend-costs-20261112/hol-platt/one-character-completeness'),
                 str(work/'backend-costs-20261112/hol-platt/small-character-kernel')])
from repair import HALO,GRID_BITS,WBITS,SUB,ORDER
assert ORDER==192
h=ORDER//2
offsets=[k for k in range(-h,h+1) if k]
D=comb(2*h,h)
start=perf_counter_ns()
exact=[F((-1)**(abs(k)+1)*comb(2*h,h-abs(k)),D) for k in offsets]
weights=[round(w*2**WBITS) for w in exact]
weight_ns=perf_counter_ns()-start
assert sum(exact)==1 and all(sum(w*k**j for w,k in zip(exact,offsets))==0 for j in range(1,ORDER))
L1=sum(map(abs,exact))
panel=json.loads((root/'summary.json').read_bytes())

def flips(seq,low,high):
    part=[(t,s) for t,s in seq if low<=t<=high]
    return [t for (_,a),(t,b) in zip(part,part[1:]) if a!=b]

near='--near' in sys.argv
rows=[]
setup_ns=[]
for i in range(4):
    p=root/f'group{i}'
    spec,grid,counts,aligned=[json.loads((p/f).read_bytes()) for f in ('spectrum.json','grid.json','counts.json','inclusive-rounded.json')]
    main=spec['main']*SUB
    end=spec['final']*SUB
    edge={1,main-1,main+1,main+320*SUB-1,main+640*SUB-1}
    J,N=spec['J'],spec['N']
    # Check a tight magnitude majorant for the dyadic trigonometric polynomial.
    timer=perf_counter_ns()
    coeff=p/'coefficients.tsv'
    assert sha256(coeff.read_bytes()).hexdigest()==spec['sha256'][coeff.name]
    cm=[0]*4
    for line in coeff.read_text().splitlines():
        v=list(map(int,line.split()))
        for j in range(4): cm[j]+=(1 if v[0]==0 else 2)*(abs(v[1+2*j])+abs(v[2+2*j]))
    setup_ns.append(perf_counter_ns()-timer)
    # |p^(192)| <= C*(2*pi*J/N)^192.  Product of nodal distances at zero is (96!)^2.
    analytic=F(3,24)*F(5*N,64)*F(1,2**82*3**spec['theta'])
    for pair in [s for s in panel['rows'] if s['pair'][0] in spec['labels']]:
        candidates=[]
        records={}
        for ch in pair['channels']:
            l=ch['label']
            ix=spec['labels'].index(l)
            f=p/f'grid-{l}.txt'
            assert sha256(f.read_bytes()).hexdigest()==grid['rows'][ix]['grid_sha256']
            raw=list(map(int,f.read_text().splitlines()))
            f=p/f'signs-{l}.tsv'
            assert sha256(f.read_bytes()).hexdigest()==counts['sha256'][f.name]
            seq=[tuple(map(int,line.split())) for line in f.read_text().splitlines()]
            seq=[(t,s) for t,s in seq if t not in edge]
            records[l]=dict(raw=raw,seq=seq,ix=ix)
            hidden={t['tick']//SUB for t in ch['repair']}
            for (prev,sp),(t,s),(nxt,sn) in zip(seq,seq[1:],seq[2:]):
                if not (t%SUB==0 and 0<prev<t<nxt<main): continue
                if not near and not sp==sn==-s: continue
                j=t//SUB
                candidates.append((min((min(abs(j-k),abs(j-k-1)) for k in hidden),default=10**8),abs(raw[HALO+j]),l,j))
        distance,_,label,j=min(candidates)
        ref=next(r for r in aligned['rows'] if r['labels']==pair['pair'] and r['guard']==640)
        rec=records[label]
        t=j*SUB
        original=dict(rec['seq'])[t]
        rec['seq']=[(x,s) for x,s in rec['seq'] if x!=t]
        rec['raw'][HALO+j]=None
        def tally():
            K=sum(len(flips(rec['seq'],0,main)) for rec in records.values())
            ticks=sum(end-x for rec in records.values() for x in flips(rec['seq'],main,end))
            return K,(F(ref['phase_upper'])-F(5*ticks,64*SUB)+36)/50-K
        dropped_K,dropped=tally()
        start=perf_counter_ns()
        neighbors=[rec['raw'][HALO+j+k] for k in offsets]
        C=F(cm[rec['ix']],2**spec['bits'])
        remainder=C*F(44*J,7*N)**ORDER/D
        # DFT output samples have dyadic error <2 ulps.  Rounded weights <= 0.5 ulp each.
        radius=analytic+remainder+L1*F(2,2**GRID_BITS)+F(ORDER*max(map(abs,neighbors)),2**(WBITS+GRID_BITS+1))
        center=F(sum(w*x for w,x in zip(weights,neighbors)),2**(WBITS+GRID_BITS))
        strict=1 if center>radius else -1 if center < -radius else 0
        check_ns=perf_counter_ns()-start
        assert strict and strict==original
        accepts=lambda claimed: claimed*center>radius
        assert accepts(strict) and not accepts(-original)
        rec['seq']=sorted(rec['seq']+[(t,strict)])
        K,restored=tally()
        assert K==ref['K'] and restored==F(ref['U_minus_K']['moderate']) and restored<1
        if not near: assert K==dropped_K+2 and dropped>=1
        rows.append(dict(labels=pair['pair'],coarse_index=j,label=label,nearest_repair_cell=distance if distance<10**8 else None,
            withheld_K=dropped_K,withheld_excess=str(dropped),restored_K=K,restored_excess=str(restored),
            strict_sign=strict,opposite_claim_accepted=accepts(-original),interval=[str(center-radius),str(center+radius)],
            radius=float(radius),distance_from_zero=float(abs(center)-radius),recovery_ns=check_ns))
report=dict(selection=('Any main-range sign' if near else 'Main-range singleton sign run')+' first by distance to a previous interior repair cell endpoint, then smallest unsigned coarse magnitude, label and index. One coarse sign and its raw center are erased per pair.',
            units='Cold weight preparation and warm online recovery in wall nanoseconds; source validation, test fixture selection, counting, and one-time polynomial magnitude scan excluded from these timers.',
            seed_source=sha256((root/'summary.json').read_bytes()).hexdigest(),weight_ns=weight_ns,coefficient_setup_ns=setup_ns,weight_l1=float(L1),rows=rows)
(out/('near-recovery.json' if near else 'recovery.json')).write_text(json.dumps(report,indent=2))
print(weight_ns,[(r['label'],r['coarse_index'],r['nearest_repair_cell'],r['recovery_ns']) for r in rows])
