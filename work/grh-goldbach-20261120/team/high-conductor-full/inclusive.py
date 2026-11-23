"""Price the inclusive mesh using only retained coarse signs and interior repairs."""
from fractions import Fraction as F
from hashlib import sha256
import json
from pathlib import Path
import sys
from flint import arb,ctx,dirichlet_char

here=Path(__file__).resolve().parent
team=here.parent
work=team.parents[1]
sys.path.append(str(work/'backend-costs-20261112/hol-platt/one-character-completeness'))
from phase_ends import enclosure,SCALE
ctx.prec=160
rounded='--round-main' in sys.argv
for folder in (s for s in sys.argv[1:] if s!='--round-main'):
    p=team/folder
    data=json.loads((p/'counts.json').read_bytes())
    spec=json.loads((p/'spectrum.json').read_bytes())
    q=spec['q']
    original=F(data['T'])
    T=F(5*spec['main'],64) if rounded else original
    sub=data['sub']
    target=T*64*sub/5
    assert target.denominator==1
    initial=original*64*sub/5
    edges={1,initial-1,initial+1,*(initial+e*sub-1 for e in [320,640])}
    signs={}
    for label in spec['labels']:
        f=p/f'signs-{label}.tsv'
        assert sha256(f.read_bytes()).hexdigest()==data['sha256'][f.name]
        raw=[tuple(map(int,l.split())) for l in f.read_text().splitlines()]
        signs[label]=[(j,s) for j,s in raw if j not in edges]
        assert sum(j%sub==0 for j,s in signs[label])==spec['final']+1
    result=[]
    for a,b in zip(spec['labels'][::2],spec['labels'][1::2],strict=True):
        parity=dirichlet_char(q,a).parity()
        for guard in (320,640):
            end=(spec['main']+guard)*sub
            H=F(5*end,64*sub)
            phase=F(enclosure(q,parity,T,H)[1],SCALE)
            logq=(arb(q*H.numerator)/(H.denominator*2*arb.pi())).log()
            allowance=F(int((((18397+1242*logq)/10000)*2**32).upper().ceil().unique_fmpz()),2**32)
            def flips(label,lo,hi):
                r=[(j,s) for j,s in signs[label] if lo<=j<=hi]
                return [j for (i,s),(j,t) in zip(r,r[1:]) if s!=t]
            ks=[len(flips(l,0,target)) for l in [a,b]]
            weight=sum(end-j for l in [a,b] for j in flips(l,target,end))
            W=F(weight*5,64*sub)
            excess={k:(phase-W+2*x)/(H-T)-sum(ks) for k,x in [('Rumely',allowance),('moderate',18)]}
            result.append(dict(labels=[a,b],guard=guard,T=str(T),H=str(H),main_counts=ks,K=sum(ks),W_ticks=weight,
                W=str(W),phase_upper=str(phase),allowances={'Rumely':str(allowance),'moderate':'18'},U_minus_K={k:str(x) for k,x in excess.items()},
                approximate={k:float(x) for k,x in excess.items()}))
    (p/('inclusive-rounded.json' if rounded else 'inclusive.json')).write_text(json.dumps(dict(endpoint_policy='inclusive; omit all purpose-built endpoint probes',rows=result,
        signed_inputs=data['sha256']),indent=2))
    print(q,[(r['K'],r['guard'],r['approximate']) for r in result])
