from pathlib import Path
from math import comb
from time import process_time
from fractions import Fraction
import json,sys
p=Path(__file__).resolve().parent
sys.path.insert(0,str(p.parent/'coefficient-panels'))
from normalize import parameters, supplied, translated
from panel import seed, ORDER, OUTPUT_BITS
from flint import ctx
ctx.prec,ctx.threads=440,1
sys.set_int_max_str_digits(0)
gfile=p.parent/'hurwitz-seed-integer/integer.json'
sfile=p.parent/'hurwitz-seed-integer/normalized-seeds.json'
actual=json.loads(sfile.read_bytes()) if sfile.exists() else None
bands=json.loads(gfile.read_bytes())['bands']
rows=[]; lines=[]
for g in bands:
    i,f,lo,hi=(g[k] for k in ('band','grid','lo','hi')); j=hi-1; r=64
    D,prec,err=parameters(f,j,128); center=f-64
    if actual is None: co=supplied(f,center,j,r,D,prec)
    else:
        s=next(s for s in actual if s['band']==i)
        assert [s[k] for k in ('grid','j','center','radius','degree','seed_bits')]==[f,j,center,r,D,prec]
        co=s['seeds']
    # Use a constant seed admission cap by precision. All subsequent intermediate
    # Horner coefficients are bounded by this cap and the radius-weighted binomial sum.
    C=1<<(prec+64); cap=max(abs(v) for xy in co for v in xy)
    assert cap<C
    A=max(Fraction(comb(D+1,k+1),32**k) for k in range(20))
    den=1<<(prec-94+6*D)
    w=(int(C*64**D*A)+den).bit_length()+1
    B=1<<w; M=B**20; O=1<<128
    assert C*64**D < M and C*64**D*A+den < B//2
    adj=sum((B//2+den//2)*B**k for k in range(20))
    xs=[[xy[a]+C for xy in reversed(co)] for a in (0,1)]
    exp=[[],[]]; worst=0; t0=process_time()
    for pos in range(129):
        d=pos-r; zz=translated(co,r,d,prec)
        if pos in (0,64,128):
            truth=seed(f,center+d,j,19,94)
            worst=max(worst,max(abs(a-b) for xy,zy in zip(zz,truth) for a,b in zip(xy,zy)))
        for a in (0,1):
            acc=0; scale=1
            for x in xs[a]:
                acc=(acc*(2*B+d)+(x-C)*scale)%M
                scale*=64
            shifted=(acc+adj)%M
            vals=[(shifted>>(w*k))%B//den-B//(2*den) for k in range(20)]
            assert vals==[z[a] for z in zz] and max(map(abs,vals))<O//2
            exp[a].append(sum((v+O//2)<<(128*k) for k,v in enumerate(vals)))
    assert worst<=1
    rows.append(dict(band=i,lo=lo,hi=hi,grid=f,j=j,center=center,degree=D,p=prec,field=w,
        seed_max_bits=cap.bit_length(),groups=(hi-lo)*(f//128),last_groups=hi-lo,cells=(hi-lo)*(f+1),
        pre_round_complex_error_output_units=err,max_direct_rounded_delta=worst,
        compared_direct_offsets=[-64,0,64],native_reference_cpu=process_time()-t0))
    line=lambda v:' '.join(map(str,v))
    lines.extend(map(line,[[i,D,w,prec],xs[0],xs[1],exp[0],exp[1]]))
    print(rows[-1],flush=True)
(p/('integer-samples.txt' if actual is not None else 'samples.txt')).write_text('\n'.join(lines)+'\n',newline='\n')
(p/('integer-groups.json' if actual is not None else 'groups.json')).write_text(json.dumps(dict(source='parent_integer' if actual is not None else 'direct_arb',bands=rows),indent=2))
