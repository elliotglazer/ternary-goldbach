"""Check the Gaussian pilot's selector and its signs against the frozen Hurwitz slab."""
from fractions import Fraction as F
from hashlib import sha256
import json
from pathlib import Path
import sys

team=Path(__file__).resolve().parent
out=team/'q10004-gaussian'
parent=team.parents[1]/'backend-costs-20261112/hol-platt'
for place in (out,parent/'small-character-kernel',parent/'one-character-completeness'):
    sys.path.append(str(place))
from spectrum import Q,LABELS,parameters
from grid import GRID_BITS,HALO
from repair import rationals,ORDER,WBITS,kernel,SUB
main,last,N,J,theta=parameters()
W=F(80000000,theta)
eps=F(1,2**82*3**theta)
assert Q*F(5*last,64)<80000000
K=L=1
while 128*W*W*F(3,8)**K>=eps: K+=1
while 48*W*F(3,8)**L>=eps: L+=1
assert F(8,3)**20>=W*(20+L)
assert N>=max(F(2*last*K,theta), F(5*last+128*K,5),F(384,5))
assert J==(25*N+191)//192
spec=json.loads((out/'spectrum.json').read_bytes())
analytic,rem,sample=rationals(spec)
reference=json.loads((team/'q10004-block.json').read_bytes())
orientation={}
for label in LABELS:
    raw=list(map(int,(out/f'grid-{label}.txt').read_text().splitlines()))
    error=analytic+rem+5*sample+F(ORDER*max(map(abs,raw)),2**(WBITS+GRID_BITS))
    received=reference['conrey_signs'][str(label)]
    gauge=[]
    for i,expected in enumerate(received):
        j=84184+i//2
        if i%2:
            start=j+HALO+1-ORDER//2
            v=F(sum(w*x for w,x in zip(kernel(SUB//2),raw[start:start+ORDER],strict=True)),2**(WBITS+GRID_BITS))
            assert abs(v)>error
        else:
            v=F(raw[j+HALO],2**GRID_BITS)
            assert abs(v)>analytic+sample
        gauge.append(expected*(1 if v>0 else -1))
    assert len(set(gauge))==1
    orientation[label]=gauge[0]
result=dict(q=Q,q_times_final_height=str(Q*F(5*last,64)),K=K,L=L,N=N,J=J,
    per_character_phase_sign_relative_to_frozen=orientation,strict_signs=124,
    counts_sha256=sha256((out/'counts.json').read_bytes()).hexdigest(),
    hurwitz_sha256=sha256((team/'q10004-block.json').read_bytes()).hexdigest())
(out/'crosscheck.json').write_text(json.dumps(result,indent=2)+'\n')
print(result)
