"""Independent bounded c5 inverse review; explicit EM, no special-function oracle.

Exact candidate/projector and full partition checks, then alternate EM parameters
on a bounded deterministic selection of accepted panels. No production claim.
"""
from fractions import Fraction as F
from pathlib import Path
from math import comb, factorial
import hashlib, json, time
from flint import arb, acb, ctx

HERE=Path(__file__).resolve().parent
SRC=HERE.parent/'zero-sum'
ctx.prec=192
N=80; M=24; LEFT=F(111,200)
def ar(x):
    x=F(x); return arb(str(x.numerator))/x.denominator
def bx(a,b):
    return acb(arb(ar((a[0]+b[0])/2),ar(abs(a[0]-b[0])/2)),
               arb(ar((a[1]+b[1])/2),ar(abs(a[1]-b[1])/2)))
def error(x): return acb(arb(0,x.upper()),arb(0,x.upper()))
def plus(a,b): return (a[0]+b[0],a[1]+b[1])
def times(a,b): return (a[0]*b[0]-a[1]*b[1],a[0]*b[1]+a[1]*b[0])
roots=[(F(1),F(0)),(F(0),F(1)),(F(-1),F(0)),(F(0),F(-1))]
def total(xs):
    r=(F(0),F(0))
    for x in xs:r=plus(r,x)
    return r
bern=[F(1)]
for n in range(1,2*M+1):
    bern.append(-sum(F(comb(n+1,j))*bern[j] for j in range(n))/F(n+1))
co=[ar(bern[2*k]/factorial(2*k)) for k in range(1,M+1)]
pre=[]
for a in [1,2,4,3]:
    B=ar(N+F(a,5))
    pre.append(([ar(j+F(a,5)).log() for j in range(N)],B.log(),
                [B**(1-2*k) for k in range(1,M+1)]))
def exprel(z):
    # Independently lengthened series: degrees0..24, tail starts25.
    term=out=acb(1)
    for j in range(1,25):
        term=term*z/(j+1);out+=term
    r=abs(z).upper()
    return out+error(r.exp()*r**25/factorial(26))
def values(s):
    rising=[acb(1)]
    for j in range(2*M):rising.append(rising[-1]*(s+j))
    ref=pre[0][1];base=((1-s)*ref).exp();v=[]
    for logs,lb,powers in pre:
        bp=(-s*lb).exp()
        out=sum(((-s*l).exp() for l in logs),acb(0))+bp/2
        out+=bp*sum((co[k-1]*rising[2*k-1]*powers[k-1] for k in range(1,M+1)),acb(0))
        tail=4*abs(rising[2*M]).upper()*(lb*(1-ar(LEFT)-2*M)).exp()
        tail/=6**(2*M)*(ar(LEFT)+2*M-1)
        step=lb-ref
        v.append(out-base*step*exprel((1-s)*step)+error(tail))
    i=acb(0,1);scale=(-s*ar(5).log()).exp()
    return [scale*sum((v[j]*i**(k*j) for j in range(4)),acb(0)) for k in (1,2,3)]
def partition(rows,complete=True):
    previous=(LEFT,F(-12));length=F(0)
    for row in rows:
        a,b=[tuple(map(F,row[key])) for key in ('a','b')]
        assert a==previous
        assert (a[1]==b[1]==-12 and LEFT<=a[0]<b[0]<=2 or
                a[0]==b[0]==2 and -12<=a[1]<b[1]<=12 or
                a[1]==b[1]==12 and LEFT<=b[0]<a[0]<=2 or
                a[0]==b[0]==LEFT and -12<=b[1]<a[1]<=12)
        length+=abs(a[0]-b[0])+abs(a[1]-b[1]);previous=b
    if complete:assert previous==(LEFT,F(-12)) and length==2*(2-LEFT+24)
    return {'last_point':list(map(str,previous)),'covered_length':str(length)}
def main():
    start=time.perf_counter()
    candidate=json.loads((SRC/'c5_global_inverse_candidate_20261111.json').read_text())
    receipt=json.loads((SRC/'c5_global_inverse_certificate_20261111.json').read_text())
    assert candidate['characters']==[1,2,3] and candidate['residues']==[1,2,4,3]
    poles=[tuple(map(F,p)) for p in candidate['poles']]
    assert len(set(poles))==385 and all(p[0]==F(1,2) for p in poles)
    assert LEFT-F(1,2)==F(11,200)
    raw=[[tuple(map(F,z)) for z in row] for row in candidate['coefficients']]
    assert len(raw)==386
    for row in raw:
        group=[tuple(x/4 for x in total(times(row[k-1],roots[(-k*j)%4]) for k in (1,2,3))) for j in range(4)]
        assert total(group)==(0,0)
        for k in (1,2,3):
            assert total(times(group[j],roots[(k*j)%4]) for j in range(4))==row[k-1]
    coeff=[[acb(ar(re),ar(im)) for re,im in row] for row in raw]
    poleballs=[acb(ar(re),ar(im)) for re,im in poles]
    checked=[];geometry={}
    assert len(receipt['attempts'])==receipt['combined_vector_panel_evaluations']
    for j,method in enumerate(('l1','T16')):
        successes=[row for row in receipt['attempts'] if j in row['active'] and row['passed'][j]]
        failures=[row for row in receipt['attempts'] if j in row['active'] and not row['passed'][j]]
        assert len(failures)==receipt[method+'_failed_active_panels']
        assert [(r['a'],r['b'],r['depth']) for r in successes]==[(r['a'],r['b'],r['depth']) for r in receipt[method+'_panels']]
    for method in ('l1','T16'):
        rows=receipt[method+'_panels']
        geometry[method]=partition(rows,receipt['status']=='PASS_EXTERNAL_GLOBAL_INVERSE_C5')
        assert len(rows)==receipt[method+'_panel_count']
        assert all(F(row['bound'])<1 for row in rows)
        # Evenly spaced, largest certified bound, and widest panels.
        chosen={int(j*(len(rows)-1)/15) for j in range(16)} if rows else set()
        chosen.update(sorted(range(len(rows)),key=lambda j:F(rows[j]['bound']),reverse=True)[:4])
        chosen.update(sorted(range(len(rows)),key=lambda j:sum(abs(F(rows[j]['a'][k])-F(rows[j]['b'][k])) for k in (0,1)),reverse=True)[:4])
        def alternate(a,b):
            s=bx(a,b);lv=values(s);bv=list(coeff[0])
            for pole,cc in zip(poleballs,coeff[1:]):
                inv=1/(s-pole)
                for k in range(3):bv[k]+=cc[k]*inv
            residual=[1-lv[k]*bv[k] for k in range(3)]
            moment=sum((abs(z).upper()**32 for z in residual),arb(0)).upper()
            group=[sum((residual[k-1]*acb(ar(roots[(-k*j)%4][0]),ar(roots[(-k*j)%4][1])) for k in (1,2,3)),acb(0))/4 for j in range(4)]
            norm=sum((abs(z).upper() for z in group),arb(0)).upper()
            return norm,moment
        for index in sorted(chosen):
            row=rows[index];a,b=[tuple(map(F,row[key])) for key in ('a','b')]
            pieces=[];refinements=[]
            def check(a,b,depth=0):
                norm,moment=alternate(a,b)
                q=norm if method=='l1' else moment
                if q<1:
                    pieces.append({'a':list(map(str,a)),'b':list(map(str,b)),
                                   'alternate_bound':str(q),'depth':depth})
                    return
                refinements.append({'depth':depth,'bound':str(q)})
                assert depth<8,'Alternate enclosure did not pass bounded refinement'
                mid=tuple((a[j]+b[j])/2 for j in range(2))
                check(a,mid,depth+1);check(mid,b,depth+1)
            check(a,b)
            checked.append({'method':method,'index':index,'refinements':refinements,'pieces':pieces})
    names=['c5_global_inverse_candidate_20261111.py','c5_global_inverse_candidate_20261111.json','c5_global_inverse_certificate_20261111.py','c5_global_inverse_certificate_20261111.json']
    out={'status':'PASS_BOUNDED_INDEPENDENT_CHECKS','author_status':receipt['status'],
         'source_hashes':{name:hashlib.sha256((SRC/name).read_bytes()).hexdigest() for name in names},
         'bits':192,'EM_N':N,'EM_M':M,'exprel_degree':24,'exact_coefficient_rows':len(raw),
         'complete_partitions_checked':2 if receipt['status']=='PASS_EXTERNAL_GLOBAL_INVERSE_C5' else 0,
         'exact_attempt_count':len(receipt['attempts']),'geometry':geometry,
         'alternate_panel_checks':checked,'elapsed_seconds':time.perf_counter()-start}
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps({k:v for k,v in out.items() if k!='alternate_panel_checks'},indent=2))
if __name__=='__main__':main()
