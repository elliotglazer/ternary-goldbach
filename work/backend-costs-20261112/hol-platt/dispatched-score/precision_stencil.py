"""Check 8/12/16-bit amplitude storage on the archived adjacent q10004 panel."""
from fractions import Fraction as F
from collections import Counter
from hashlib import sha256
import json
from pathlib import Path
import sys
from flint import arb,ctx

HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/'guard-repricing'))
from strip_interpolation import read,stencil,remainder,LO,HI,SRC

def quantum(x,b):
    m,e=x.upper().man_exp()
    step=int(e)+int(m).bit_length()-b
    while arb((2**b-1,step))<x.upper(): step+=1
    return step

def compact(x,b,e):
    step=arb((1,e))
    k=int((x.mid()/step+arb(1)/2).floor().unique_fmpz())
    assert abs(k)<(1<<b)
    center=arb((k,e));error=x.rad()+step/2
    z=center+arb(0,error.upper())
    assert z.contains(x)
    return z

def main():
    ctx.prec=192
    coarse=read('high-signs.tsv.gz','j')
    pairs=sorted({(a,b) for j,a,b in coarse})
    kernels={}
    for j in range(LO,HI):
        for m in range(2,17):
            nodes,w,p=stencil(m,j)
            for parity in (0,1):
                err=min((remainder(m,b,parity,nodes,p) for b in range(2,6)),key=lambda z:z.upper())
                kernels[j,m,parity]=(nodes[0]-LO,w,arb(0,err.upper()))
    allresults={}
    for policy,bits in [('uncompressed',0)]+[(p,b) for p in ['per_value','shared_16'] for b in [8,12,16]]:
        signs={}
        for a,b in pairs:
            values=[coarse[j,a,b][0] for j in range(LO,HI+1)]
            if bits:
                common=quantum(max([abs(v) for v in values],key=lambda z:z.upper()),bits)
                values=[compact(v,bits,common if policy=='shared_16' else quantum(abs(v),bits)) for v in values]
            for j in range(LO,HI):
                # Choose any strict stencil (shortest first) using only coarse data.
                for m in range(2,17):
                    start,w,err=kernels[j,m,(1+a+b)%2]
                    z=sum((v*c for v,c in zip(values[start:start+m],w,strict=True)),err)
                    sg=int(z>0)-int(z<0)
                    if sg:
                        signs[j,a,b]=sg
                        break
        allresults[f'{policy}_{bits}']=signs
    direct=read('high-midpoints.tsv.gz','left_j')
    hidden={k for k,(_,s) in direct.items() if coarse[k][1]==coarse[k[0]+1,*k[1:]][1]==-s}
    report={}
    for tag,ss in allresults.items():
        assert all(s==direct[k][1] for k,s in ss.items())
        missing=set(direct)-set(ss)
        report[tag]=dict(total=len(direct),strict=len(ss),ambiguous=len(missing),
            hidden_total=len(hidden),hidden_strict=len(hidden & ss.keys()),
            ambiguous_with_equal_endpoints=sum(coarse[k][1]==coarse[k[0]+1,*k[1:]][1] for k in missing))
    output=dict(results=report,conductor=10004,indices=[LO,HI],
        mantissa='b unsigned magnitude bits plus sign, dyadic exponent per value or per character block of 16',
        quantization_radius='original source radius plus half the quantum',
        sha256={p.name:sha256(p.read_bytes()).hexdigest() for p in [Path(__file__),SRC/'high-signs.tsv.gz',SRC/'high-midpoints.tsv.gz',HERE.parent/'guard-repricing/strip_interpolation.py']})
    (HERE/'precision-stencil.json').write_text(json.dumps(output,indent=2)+'\n')
    print(report)

if __name__=='__main__':main()
