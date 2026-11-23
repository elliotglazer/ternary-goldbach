"""Measure inherited relative error for each terminal Hardy amplitude enclosure."""
import csv
import hashlib
import json
import math
import sys
from fractions import Fraction
from pathlib import Path
from flint import acb,arb,ctx,fmpz

HERE=Path(__file__).resolve().parent
HOL=HERE.parent
sys.path.insert(0,str(HOL/'c10000-kronecker'))
from kronecker import Cyclic,quantize,pairmul
PINS={}

def data(p):
    raw=p.read_bytes()
    PINS[str(p.relative_to(HOL))]=hashlib.sha256(raw).hexdigest()
    return raw.decode()

def nums(p):
    return [tuple(map(int,l.split())) for l in data(p).splitlines()]

def tsv(p):
    return [tuple(map(int,r)) for r in list(csv.reader(data(p).splitlines(),delimiter='\t'))[1:]]

def ball(p,q,f,g,e,r,i):
    a,b=p*f-q*g,p*g+q*f
    return a*r-b*i,(abs(a)+abs(b))*e+(abs(p)+abs(q)+abs(f)+abs(g)+2)*(abs(r)+abs(i)+2*e)

def bit_floor(num,den):
    s=num.bit_length()-den.bit_length()
    return s-int((num<<max(0,-s))<(den<<max(0,s)))

def summarize(rows,p):
    # |true| >= |v|-d, hence a strict certified relative upper bound d/(|v|-d).
    items=sorted(((bit_floor(abs(v)-d,d) if abs(v)>d else -10000,k,v,d) for k,v,d in rows),
                 key=lambda row:Fraction(abs(row[2]),row[3]))
    def show(i):
        b,k,v,d=items[i]
        return dict(mode=k,hard_bits=None if b==-10000 else b,v=str(v),d=str(d))
    return dict(count=len(rows),common_binary_scale=-3*p,overlap_zero=sum(b==-10000 for b,*_ in items),
        worst=show(0),worst_strict=next(show(i) for i,a in enumerate(items) if a[0]!=-10000),
        lower_percentile_bits={str(percent):show((len(items)-1)*percent//100)['hard_bits'] for percent in [0,1,5,10,25,50,75,90,95,99,100]},
        below_requested_bits={str(n):sum(b<n for b,*_ in items) for n in [4,8,12,16,20,24,32,40,48,56,64]},
        max_physical_source_radius=dict(numerator=str(max(d for _,v,d in rows)),denominator=str(1<<(3*p))))

def small():
    s=HOL/'c10004-full-integer'
    z=nums(s/'spectrum.tsv');phase=nums(HOL/'c10004-hol-shared-phase/phases.tsv');(v,)=nums(s/'params.tsv')
    out=[]
    for j,((r,i),(a,b)) in enumerate(zip(z,phase,strict=True)):
        parity=1-j%2
        f,g=v[2*parity:2*parity+2]
        value,rad=ball(a,b,f,g,v[-2],r,i)
        assert abs(value)>rad and (value>0)==bool((v[-1]>>j)&1)
        out.append(([1+j//59,1+j%59],value,rad))
    return summarize(out,81)

def large():
    d=HOL/'large-sector-second';terms=HOL/'large-terminal-signs'
    raw,root=tsv(d/'input28.tsv'),tsv(d/'roots28.tsv');n=131070
    parts=json.loads(data(d/'cohort.json'))['phase_parts_grid28']
    arc=json.loads(data(HOL/'large-coarse-sign/prime-131071.json'))
    ref=bin(int(next(r['reference_signs_hex'] for r in arc['nodes'] if r['j']==5695),16))[2:]
    summary={};ctx.prec=128
    for p in (24,28):
        s=1<<p;D=1<<(28-p)
        def rd(x): return (x+D//2)//D
        xs=[(rd(r),rd(i)) for _,a,r,i in raw];ws=[]
        for k in range(n):
            t=k*k%(2*n);a=math.pi*t/n
            u,v=round(s*math.cos(a)),round(s*math.sin(a));w=acb(0,arb.pi()*t/n).exp()
            assert abs(w.real*s-u)<1 and abs(w.imag*s-v)<1
            ws.append((u,v))
        aa=[quantize(pairmul(x,w),s) for x,w in zip(xs,ws,strict=True)]
        ring=Cyclic(n,max(abs(z) for x in aa for z in x),s)
        rr,ii=ring.product(ring.complex_pack(aa),ring.complex_pack([(x,-y) for x,y in ws]),fmpz)
        rr,ii=ring.unpack(rr),ring.unpack(ii)
        er=sum((2*s+2)*(3+(abs(x)+abs(y)+2+s-1)//s)+abs(t)+abs(b) for (x,y),(t,b) in zip(xs,aa,strict=True))
        rows=[]
        for k in range(1,n):
            ix,a,b=root[k-1];assert ix==k
            r,i=quantize(pairmul((rr[k],ii[k]),ws[k]),s*s)
            e=(2*s*er+abs(rr[k])+abs(ii[k])+2*er+s*s-1)//(s*s)+1
            value,rad=ball(rd(a),rd(b),*(rd(x) for x in parts[k%2]),e,r,i)
            assert abs(value)<=rad or (value>0)==(ref[k]=='1')
            rows.append((k,value,rad))
        # Compare the actual recomputed coordinates to all archived prechirp tiles.
        for size,start in [(64,1),(256,n//2-128),(1024,n-1024)]:
            tag=terms/f'even{p}n{size}'
            z,rot,params=(nums(Path(str(tag)+suf+'.txt')) for suf in ['zs','ws','abs'])
            for h,(pt,w,c) in enumerate(zip(z,rot,params,strict=True),start):
                assert pt==(rr[h],ii[h]) and w==ws[h]
                assert rows[h-1][1:]==ball(*c[:5],*quantize(pairmul(pt,w),s*s))
        summary[str(p)]=summarize(rows,p)
    return summary

if __name__=='__main__':
    out=dict(q10004_j1_p81=small(),q131071_j5695=large(),sha256=PINS)
    (HERE/'precision-audit.json').write_text(json.dumps(out,indent=2)+'\n')
