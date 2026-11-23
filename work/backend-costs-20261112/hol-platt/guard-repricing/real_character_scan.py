"""Run one primitive quadratic channel, then count its two symmetric ordinates."""
import argparse
from fractions import Fraction as F
from hashlib import sha256
import json
from pathlib import Path
import sys
from flint import acb,arb,ctx,dirichlet_char

here=Path(__file__).resolve().parent
hol=here.parent
parser=argparse.ArgumentParser()
parser.add_argument("q",choices=[65537,132899],type=int)
q=parser.parse_args().q
source=hol.parents[1]/"grh-goldbach-20261120/team"/f"gaussian-panel-q{q}"
out=here/f"real-q{q}"
out.mkdir(exist_ok=True)
sys.path[:0]=[str(source),str(hol/"small-character-kernel"),str(hol/"one-character-completeness")]
import spectrum
import grid
import repair
from phase_ends import enclosure,SCALE

label=q-1
chi=dirichlet_char(q,label)
assert chi.order()==2 and chi.is_primitive() and pow(label,-1,q)==label
def phase_and_weights():
    tab=[chi(j) for j in range(q)]
    tau=sum((z*acb.exp_pi_i(acb(2*j)/q) for j,z in enumerate(tab)),acb(0))
    w=tau/(arb(q).sqrt()*acb(0,1)**chi.parity())
    assert w.contains(1) and w.real>0
    return [1/w.sqrt()],[tab]
for module in [spectrum,grid,repair]:
    module.HERE=out
    module.LABELS=(label,)
spectrum.phase_and_weights=grid.phase_and_weights=phase_and_weights
spectrum.run()
grid.run()
ctx.prec=224
main,last,_,_,_=spectrum.parameters()
assert last-main==640
meta=json.loads((out/"spectrum.json").read_bytes())
analytic,rem,sample=repair.rationals(meta)
raw=list(map(int,(out/f"grid-{label}.txt").read_text().splitlines()))
assert len(raw)==last+2*grid.HALO+1
error=analytic+rem+5*sample+F(repair.ORDER*max(map(abs,raw)),(1<<repair.WBITS)*(1<<grid.GRID_BITS))
limit=(analytic+sample)*(1<<grid.GRID_BITS)
all_coarse=raw[grid.HALO:grid.HALO+last+1]
assert all(abs(v)>limit for v in all_coarse)
coarse=[(i*repair.SUB,1 if v>0 else -1) for i,v in enumerate(all_coarse)]
extra=[]
for tick in sorted(repair.discover(raw,last)):
    j,offset=divmod(tick,repair.SUB)
    assert offset
    start=j+grid.HALO+1-repair.ORDER//2
    center=sum(w*v for w,v in zip(repair.kernel(offset),raw[start:start+repair.ORDER],strict=True))
    assert abs(center)>error*(1<<(repair.WBITS+grid.GRID_BITS))
    extra.append((tick,1 if center>0 else -1))
T,H=F(main*5,64),F(last*5,64)
phase_lo,phase_hi=[F(n,SCALE) for n in enclosure(q,chi.parity(),T,H)]
assert T>50 and (arb(q)*H.numerator/H.denominator/(2*arb.pi())).log()<18
results=[]
for tag,rows in (("coarse",coarse),("repaired",sorted(coarse+extra))):
    main_flips=0
    aux_right=[]
    for lo,hi,aux in [(0,main*repair.SUB,False),(main*repair.SUB,last*repair.SUB,True)]:
        signs=[(i,s) for i,s in rows if lo<=i<=hi]
        assert (signs[0][0],signs[-1][0])==(lo,hi)
        right=[v for (u,x),(v,y) in zip(signs,signs[1:]) if x!=y]
        if aux: aux_right=right
        else: main_flips=len(right)
    K=2*main_flips
    W=2*sum(F(5*(last*repair.SUB-i),64*repair.SUB) for i in aux_right)
    excess=(phase_hi+36-W)/(H-T)-K
    assert excess>=0
    results.append(dict(tag=tag,positive_main_brackets=main_flips,positive_aux_brackets=len(aux_right),
        K=K,W=str(W),upper_minus_K=str(excess),strict_ordinary=excess<1,strict_even_count=excess<2))
s0=acb(arb(1)/2)
central=chi.l(s0)
assert central.imag.contains(0) and (central.real>0 or central.real<0)
assert (central.real>0)==(coarse[0][1]>0)
receipt=dict(q=q,label=label,order=int(chi.order()),parity=int(chi.parity()),main=str(T),H=str(H),
    native_central_L=str(central),main_signs=[coarse[0][1],coarse[main][1]],endpoint_sign=coarse[-1][1],
    coarse_samples=len(coarse),repair_probes=len(extra),phase_upper=str(phase_hi),rows=results,
    input_hashes={f.name:sha256(f.read_bytes()).hexdigest() for f in
    (source/"spectrum.py",source/"grid.py",source/"repair.py",Path(__file__),out/"coefficients.tsv",out/f"grid-{label}.txt")})
(out/"real-count.json").write_text(json.dumps(receipt,indent=2)+"\n")
print("REAL_COUNT",q,results,flush=True)
