import csv,json,sys,gzip
from pathlib import Path
from time import process_time
from math import gcd
from flint import acb,arb,ctx,dirichlet_char
from collections import Counter
here=Path(__file__).resolve().parent
sys.path.insert(0,str(here.parent/'c10004-real-transform'))
import completed as comp, reference as ct
ctx.prec=224
ctx.threads=1
Q=10004
S=1<<81
def phases():
    units=[int(row['a']) for row in comp.read(here.parent/'c10004-reference/h1.tsv')]
    labels=[(k,l) for k in range(1,40) for l in range(1,60)]
    tau=ct.tensor([acb.exp_pi_i(acb(2*a)/Q) for a in units],comp.dft)
    w={p:z/(acb(0,1)**comp.parity(*p)*arb(Q).sqrt()) for p,z in zip(labels,tau)}
    phase={}
    for p,z in w.items():
        if p in phase:continue
        partner=(40-p[0],60-p[1])
        assert abs(z).contains(1) and w[partner].overlaps(z.conjugate())
        if z.real>-arb(1)/2:
            r=((1+z.real)/2).sqrt()
            e=acb(r,-z.imag/(2*r))
        else:
            assert z.real<arb(1)/2
            r=((1-z.real)/2).sqrt()
            e=acb(-z.imag/(2*r),r)
        phase[p]=e
        if partner!=p:phase[partner]=e.conjugate()
    return labels,phase

def factors(t):
    s=acb(arb(1)/2,t)
    return [(arb.pi()*t/4).exp()*(acb(Q)/arb.pi())**((s+a)/2)*((s+a)/2).gamma() for a in (0,1)]

def run(high):
    labels,phase=phases()
    indices=list(range(84184,84200) if high else range(1,33))
    slab=here.parent/'c10004-time-slab'
    prev={}
    nodes=[]
    candidates=[]
    start=process_time()
    tag='high' if high else 'low'
    with gzip.open(here/(tag+'-signs.tsv.gz'),'wt',newline='') as f:
        wr=csv.writer(f,delimiter='\t',lineterminator='\n')
        wr.writerow(('j','k41','k61','spectrum_radius_grid_units','sign','scaled_value'))
        for h in indices:
            tt=process_time()
            path=here/f'j{h}-source.tsv' if high else slab/f'h{h}.tsv'
            xs=[(int(r['re']),int(r['im'])) for r in comp.read(path)]
            if high: ys=ct.tensor(xs,lambda row:ct.ct(row,True,Counter()))
            else:
                data=comp.read(slab/f'h{h}-spectrum.tsv')
                assert [(int(r['k41']),int(r['k61'])) for r in data]==labels
                ys=[(int(r['re']),int(r['im'])) for r in data]
            refs=ct.tensor([(a,b,1) for a,b in xs],ct.direct_balls)
            t=arb(5*h)/64
            s=acb(arb(1)/2,t)
            fac=[z*acb(Q)**(-s) for z in factors(t)]
            counts=Counter()
            changes=0
            minima=[]
            for p,(a,b),(x,y,e) in zip(labels,ys,refs,strict=True):
                rad=e+ct.upnorm(x-a,y-b)
                value=phase[p]*fac[comp.parity(*p)]*acb(arb(a,rad),arb(b,rad))/S
                assert value.imag.contains(0)
                real=value.real
                sig=1 if real>0 else -1 if real<0 else 0
                counts[sig]+=1
                margin=int((abs(real).lower()*10**12).floor().unique_fmpz())
                minima.append((margin,p))
                if p in prev:
                    last,old=prev[p]
                    changes+=last*sig<0
                    if sig==last and sig:
                        candidates.append((min(old,margin),p,h-1,sig))
                prev[p]=(sig,margin)
                wr.writerow((h,*p,rad,sig,real.str(42)))
            nodes.append(dict(j=h,counts=counts,changes=changes,minimum=min(minima),cpu=process_time()-tt))
    # Check twelve different deepest same-sign intervals with exact Conrey labels.
    candidates.sort()
    selected=[]
    seen=set()
    for row in candidates:
        if row[1] not in seen:
            selected.append(row);seen.add(row[1])
        if len(selected)==12:break
    def residue(a,b,c):
        return (2501*(1+2*a)+4880*pow(6,b,41)+2624*pow(2,c,61))%Q
    targets={}
    test=[residue(1,0,0),residue(0,1,0),residue(0,0,1)]
    for label in range(1,Q):
        if gcd(label,Q)!=1:continue
        chi=dirichlet_char(Q,label)
        if not chi.is_primitive():continue
        m=int(chi.group().exponent()) if callable(getattr(chi.group(),'exponent',None)) else 120
        freq=[int(chi.chi_exponent(a))*d//m for a,d in zip(test,[2,40,60])]
        if freq[0]==1 and tuple(freq[1:]) in seen:
            p=tuple(freq[1:])
            assert all(acb.exp_pi_i(acb(2*k)/d).overlaps(chi(a)) for k,d,a in zip(freq,[2,40,60],test))
            targets[p]=label
    checks=[]
    with ctx.workprec(288):
        for _,p,h,sig in selected:
            if high and checks and (len(checks)>=4 or process_time()-start>48):break
            label=targets[p]
            chi=dirichlet_char(Q,label)
            zs=[]
            for off in (0,1,2):
                t=arb(5*(2*h+off))/128
                z=phase[p]*factors(t)[comp.parity(*p)]*chi.l(acb(arb(1)/2,t))
                assert z.imag.contains(0) and (z.real>0 or z.real<0)
                zs.append((1 if z.real>0 else -1,z.real.str(34)))
            assert zs[0][0]==zs[2][0]==sig
            checks.append(dict(grid_left=h,k=p,conrey=label,values=zs,hidden_pair=zs[1][0]!=sig))
    res=dict(indices=[indices[0],indices[-1]],nodes=nodes,checks=checks,
        cpu=process_time()-start,total_changes=sum(z['changes'] for z in nodes))
    (here/(tag+'-receipt.json')).write_text(json.dumps(res,indent=2))
if __name__=='__main__':
    run(sys.argv[-1]=='high')

