"""Select one actual hidden-pair repair per frozen channel and bind raw windows to packed bits."""
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
import json
import sys

team=Path(__file__).resolve().parent
local=team/'q10004-gaussian'
hol=local/'hol'
base=team.parents[1]/'backend-costs-20261112/hol-platt'
sys.path[:0]=[str(local),str(base/'small-character-kernel'),str(base/'one-character-completeness')]
from spectrum import LABELS
from grid import HALO,GRID_BITS
from repair import rationals,kernel,SUB,ORDER,WBITS
def digest(p): return sha256(p.read_bytes()).hexdigest()
grid=json.loads((local/'grid.json').read_bytes())
samplemeta=json.loads((local/'spectrum.json').read_bytes())
counts=json.loads((local/'counts.json').read_bytes())
analytic,rem,sample=rationals(samplemeta)
coarse=int((analytic+sample)*2**GRID_BITS)+1
pkt=(hol/'packets.txt').read_text().splitlines()
assert digest(hol/'packets.txt')==json.loads((hol/'manifest.json').read_bytes())['packet_sha256']
cases=[]
lines=[]
for ix,label in enumerate(LABELS):
    rawpath=local/f'grid-{label}.txt'
    signpath=local/f'signs-{label}.tsv'
    assert digest(rawpath)==grid['rows'][ix]['grid_sha256']
    assert digest(signpath)==counts['sha256'][signpath.name]
    raw=list(map(int,rawpath.read_text().splitlines()))
    signs=dict(tuple(map(int,x.split())) for x in signpath.read_text().splitlines())
    # Width-50 main region for this pair and label.
    packet=2*(ix//2)+1
    line=9*packet+4*(ix%2)
    assert list(map(int,pkt[line].split()[:3]))==[packet,ix%2,0]
    vals=list(map(int,pkt[line+1].split()))
    blocks=list(zip(vals[::3],vals[1::3],vals[2::3],strict=True))
    def lookup(t):
        for block,(p,n,w) in enumerate(blocks):
            d=t-p
            if d>=0 and d%SUB==0 and d//SUB<n:
                return block,d//SUB,(w>>(d//SUB))&1
        raise ValueError(t)
    tick=next(t for t,s in signs.items() if t%SUB and t//SUB>=100 and
        signs[(t//SUB)*SUB]==signs[(1+t//SUB)*SUB]==-s)
    j,offset=divmod(tick,SUB)
    first=j+1-ORDER//2
    xs=raw[first+HALO:first+HALO+ORDER]
    ws=kernel(offset)
    bits=sum((x>0)<<k for k,x in enumerate(xs))
    assert all((x>0)==(signs[(first+k)*SUB]>0) for k,x in enumerate(xs))
    error=analytic+rem+5*sample+F(ORDER*max(map(abs,raw)),2**(WBITS+GRID_BITS))
    threshold=int(error*2**(WBITS+GRID_BITS))+1
    point_ticks=[j*SUB,tick,(j+1)*SUB]
    refs=[lookup(t) for t in point_ticks]
    assert [2*b-1 for _,_,b in refs]==[signs[t] for t in point_ticks]
    assert abs(sum(x*w for x,w in zip(xs,ws,strict=True)))>threshold
    # Entire window lies on the exact grid in Gaussian phase orientation.
    lines.extend([' '.join(map(str,[label,first,tick,offset,coarse,threshold,bits,refs[1][2]])),
                  ' '.join(map(str,xs)),' '.join(map(str,ws)),
                  ' '.join(str(v) for ref in refs for v in ref[:2])])
    cases.append(dict(label=label,tick=tick,grid_first=first,kernel_offset=offset,
        sign_triple=[signs[t] for t in point_ticks],packet_name=f'runs_{packet}{ix%2}0',
        packet_references=refs,raw_sha256=digest(rawpath),sign_sha256=digest(signpath)))
(hol/'windows.txt').write_text('\n'.join(lines)+'\n')
(hol/'windows.json').write_text(json.dumps(dict(cases=cases,window_sha256=digest(hol/'windows.txt'),
    prior_packet_sha256=digest(hol/'packets.txt'),phase_crosscheck_sha256=digest(local/'crosscheck.json'),
    prior_receipt_sha256=digest(hol/'.hol/objs/Q10004ReceiptTheory.dat')),indent=2))
