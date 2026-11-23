"""Generate a real eight-height source block and independent check values in each later band."""
from fractions import Fraction
from math import gcd
from pathlib import Path
import argparse
import hashlib
import json
import sys

from flint import acb,arb,ctx

HERE=Path(__file__).resolve().parent
BASE=HERE.parent/'large-weighted-slab'
sys.path.insert(0,str(BASE))
from adaptive_groups import groups
from schedule import PATH

Q=1<<112
OUT=1<<120
BASE_IN=Q*OUT
M=(1<<61)-1


def pack(rows,base):
    return sum(v*base**i for i,v in enumerate(rows))


def coefficients(f,k,j):
    t=arb(5*j)/64
    s=acb(arb(1)/2,t)
    a=arb(1)+arb(k)/f
    fac=acb(1)
    row=[]
    for degree in range(20):
        val=fac*(s+degree).zeta(a)
        z=[int((v*(1<<94)+arb(1)/2).floor().unique_fmpz()) for v in (val.real,val.imag)]
        assert abs(val*(1<<94)-acb(*z))<1
        row.append(z)
        fac=-fac*(s+degree)*2/(f*(degree+1))
    h=(5*j+63)//64+1
    # |s+r| < h+r. At sigma >=20.5 the defining Hurwitz series is <2.
    first=Fraction(2)
    for r in range(20):
        first*=Fraction(h+r,2*f*(r+1))
    ratio=Fraction(h+20,2*f*21)
    assert ratio<1
    rem=first/(1-ratio)
    # The error of a rounded power on Q is <= 2/3 of a unit on |z|<=1/4.
    coeff_norm=sum(abs(x)+abs(y) for x,y in row[1:])
    bound=rem+(Fraction(4,3)+Fraction(3,4)+Fraction(2*coeff_norm,3*Q))/(1<<94)
    return s,row,bound


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--band1',action='store_true')
    parser.add_argument('--next',action='store_true',help='Prepare the next eight heights with identical conductor geometry.')
    args=parser.parse_args()
    first=args.band1
    suffix=('-next' if args.next else '')+('-first' if first else '')
    inputs=f'resident{suffix}.txt'
    theory='FirstBandSlab' if first else 'BandSlab'
    ctx.prec,ctx.threads=256,1
    sys.set_int_max_str_digits(0)
    rows=sorted((c,phi,j+41) for c,phi,_,_,j,_,_ in json.loads(PATH.read_bytes())['conductors'])
    cap=json.loads((BASE/'adaptive-groups.json').read_bytes())['maximum_bytes']
    all_bands=json.loads((BASE/'later-band-budget.json').read_bytes())['bands']
    bands=all_bands[:1] if first else all_bands[1:]
    result=[]
    with (HERE/inputs).open('w',encoding='ascii',newline='\n') as out:
        for ix,bd in enumerate(bands,1 if first else 2):
            lo,hi=bd['height_indices']
            f=bd['cells']-1
            k=f//2-1
            j=lo+8*((hi-lo)//16)
            active=[r for r in rows if r[2]>lo]
            choices=[([r for r in gp if r[2]>=j+8],size) for gp,size in groups(active,cap,128)]
            weights=[sum(r[1] for r in gp) for gp,size in choices]
            running=0
            for (gp,size),weight in zip(choices,weights,strict=True):
                running+=weight
                if 2*running>=sum(weights):
                    break
            cs=[r[0] for r in gp]
            assert len(cs)>=32 and max(cs)<400001
            if args.next:
                j+=8
            assert all(r[2]>=j+8 for r in gp)
            analytic=[coefficients(f,k,j+i) for i in range(8)]
            lanes=[[r[1][m][i] for r in analytic for i in (0,1)] for m in range(20)]
            while not any(lanes[-1]):
                lanes.pop()
            coeff=[pack(v,BASE_IN) for v in lanes]
            bias=pack([BASE_IN//2+Q//2]*16,BASE_IN)
            seed=(sum(2*abs(v)+int(v<0) for v in coeff)+bias)%M
            tag=f'b{ix}j{j}n8'
            print(tag,4,bias,len(cs),file=out)
            print(*coeff,file=out)
            ns,answers=[0],[seed]
            checked=set()
            for c in cs:
                g=gcd(c,f)
                den=2*c//g
                numerators=[a for a in range((2*k-1)*c//(2*f)+1,(2*k+1)*c//(2*f)+1) if gcd(a,c)==1]
                rs=[(f*a-c*k)//g for a in numerators]
                print(den,*rs,file=out)
                acc=answers[-1]
                for a,r in zip(numerators,rs,strict=True):
                    assert 4*abs(r)<=den
                    w=[Q]
                    for _ in lanes[1:]:
                        w.append((2*w[-1]*r+den)//(2*den))
                    vals=[sum(v*h for v,h in zip(column,w,strict=True)) for column in zip(*lanes,strict=True)]
                    z=[(2*v+Q)//(2*Q) for v in vals]
                    assert all(0<=v+BASE_IN//2+Q//2<BASE_IN for v in vals)
                    assert all(-OUT//2<=v<OUT//2 for v in z)
                    acc=(17*acc+pack([v+OUT//2 for v in z],OUT))%M
                    if len(checked)<4 and a in (numerators[0],numerators[-1]):
                        checked.add((c,a))
                        for t,(s,_,bound) in enumerate(analytic):
                            direct=s.zeta(arb(1)+arb(a)/c)
                            assert abs(direct-acb(z[2*t],z[2*t+1])/(1<<94)) < arb(bound.numerator)/bound.denominator
                ns.append(ns[-1]+8*len(rs))
                answers.append(acc)
            tests=[0,8,32,len(cs)]
            assert len(set(tests))==4
            assert len(checked)==4
            for n in tests:
                print(n,ns[n],answers[n],file=out)
            bound=max(r[2] for r in analytic)*633*(1<<82)
            result.append(dict(tag=tag,band=ix,grid=f,cell=k,start=j,conductors=cs,
                               outputs=ns[-1],degree=len(coeff)-1,amplified_fraction_of_budget=float(bound),
                               direct_checks=[[c,a] for c,a in sorted(checked)]))
            print(tag,len(cs),ns[-1],float(bound),flush=True)
    (HERE/('fixtures'+suffix+'.json')).write_text(json.dumps(dict(cases=result,manifest_sha256=hashlib.sha256(PATH.read_bytes()).hexdigest(),
        input_sha256=hashlib.sha256((HERE/inputs).read_bytes()).hexdigest()),indent=2)+'\n')
    if args.next:
        return
    # Reuse the previously checked kernel circuit and timing controls verbatim.
    harness=(BASE/'SlabScript.sml').read_text()
    for old,new in [('Theory Slab\n',f'Theory {theory}\n'),('TextIO.openIn "terms.txt"','TextIO.openIn "resident.txt"'),
                    ('[name,k,b]=rtokens()','[name,k,b,ng]=rtokens()'),
                    ('List.tabulate(8,fn _=>rtokens())','List.tabulate(valOf(Int.fromString ng),fn _=>rtokens())')]:
        assert harness.count(old)==1
        harness=harness.replace(old,new)
    if first:
        harness=harness.replace('TextIO.openIn "resident.txt"',f'TextIO.openIn "{inputs}"')
        harness=harness.replace('oneResident())[1,2,3,4]','oneResident())[1]')
    (HERE/(theory+'Script.sml')).write_text(harness)
    (HERE/'Holmakefile').write_bytes((BASE/'Holmakefile').read_bytes())
    run=((BASE/'run.sh').read_text().replace('sha256sum SlabScript.sml terms.txt resident.txt',f'sha256sum {theory}Script.sml {inputs}')
         .replace('SlabTheory.uo',theory+'Theory.uo'))
    (HERE/('run-first.sh' if first else 'run.sh')).write_text(run,newline='\n')


if __name__=='__main__':
    main()
