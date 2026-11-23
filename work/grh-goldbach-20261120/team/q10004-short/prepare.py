"""Convert the published outward decimal sample balls to exact integer source operands."""
from fractions import Fraction as F
from hashlib import sha256
from math import prod,lcm,ceil
from pathlib import Path
from time import process_time
import csv,gzip,json,re,sys
from flint import arb,ctx

here=Path(__file__).resolve().parent
root=here.parents[2]/'backend-costs-20261112/hol-platt'
sys.path.insert(0,str(root/'guard-repricing'))
import strip_interpolation as strip
ctx.prec=256
start=process_time()
def digest(p): return sha256(p.read_bytes()).hexdigest()
refpath=root/'guard-repricing/strip-interpolation.json'
ref=json.loads(refpath.read_bytes())
coarse=root/'c10004-grid-repair/high-signs.tsv.gz'
assert digest(coarse)==ref['input_sha256'][coarse.name]
cases=ref['hidden_rows']
pairs={(c['k41'],c['k61']) for c in cases}
def interval(s):
    match=re.fullmatch(r'\[([^ ]+) \+/- ([^ ]+)\]',s)
    if not match:return F(s),F(s)
    m,r=map(F,match.groups())
    return m-r,m+r
samples={}
with gzip.open(coarse,'rt') as f:
    for row in csv.DictReader(f,delimiter='\t'):
        p=int(row['k41']),int(row['k61'])
        if p in pairs:
            samples[p,int(row['j'])]=interval(row['scaled_value'])
den=lcm(*(x.denominator for value in samples.values() for x in value))
offsets=sorted({c['j']-strip.LO for c in cases})
def weights(h):
    x=F(2*h+1,2)
    return [prod((x-m)/(v-m) for m in range(16) if m!=v) for v in range(16)]
wden=lcm(*(w.denominator for h in offsets for w in weights(h)))
wt={h:[int(w*wden) for w in weights(h)] for h in offsets}
def line(xs):return ' '.join(map(str,xs))
lines=[line([den,wden,len(wt),len(cases)])]
for off,ws in wt.items():lines.append(line([off,*ws]))
summary=[]
for c in cases:
    j,k,l=c['j'],c['k41'],c['k61']
    p=k,l
    h=j-strip.LO
    midsign=1 if interval(c['reference'])[0]>0 else -1
    vals=[samples[p,jj] for jj in range(strip.LO,strip.HI+1)]
    nodes,_,ep=strip.stencil(16,j)
    R=strip.remainder(16,2,(1+k+l)%2,nodes,ep)
    radius=int((R*2**40).upper().ceil().unique_fmpz())
    for precision in range(0,57):
        scale=1<<precision
        qs=[round((a+b)/2*scale) for a,b in vals]
        if not all(F(q-1,scale)<=a<=b<=F(q+1,scale) for q,(a,b) in zip(qs,vals)):continue
        z=sum(q*w for q,w in zip(qs,wt[h]))
        budget=sum(map(abs,wt[h]))*2**40+radius*wden*scale
        if all(-midsign*q>1 for q in qs[h:h+2]) and midsign*z*2**40>budget:break
    else:raise ValueError(p)
    # Midpoint references only validate the sign after the outward-bound test.
    lines.append(line([h,k,l,scale,radius,int(midsign>0)]))
    lines.append(line(x for (a,b),q in zip(vals,qs) for x in [int(a*den),int(b*den),q]))
    summary.append(dict(j=j,k=k,l=l,parity=(1+k+l)%2,scale=scale,strip_radius=str(F(radius,2**40)),
        raw_rounding_radius=str(F(1,scale)),weight_norm=str(F(sum(map(abs,wt[h])),wden)),sign=midsign))
packet=here/'short.txt'
packet.write_bytes(('\n'.join(lines)+'\n').encode())
(here/'inputs.json').write_text(json.dumps(dict(q=10004,first=strip.LO,order=16,b=2,strip_rho='3/2',
    remainder_denominator=2**40,source_decimal_denominator=den,weight_denominator=wden,distinct_kernels=len(wt),
    rows=summary,archive_sha256=digest(coarse),strip_report_sha256=digest(refpath),packet_sha256=digest(packet),
    prep_cpu_seconds=process_time()-start),indent=2))
