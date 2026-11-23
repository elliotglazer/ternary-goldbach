import hashlib,json
from pathlib import Path
from flint import arb,acb,ctx
ctx.prec=208
ctx.threads=1
base=Path(__file__).resolve().parent
S=2**81
rows=[list(map(int,l.split())) for l in (base.parent/'c10004-hol-shared-phase'/'phases.tsv').read_text().splitlines()]
assert len(rows)==2301
def pack(vals):return sum((v+S)<<(83*i) for i,v in enumerate(vals))
def cls(v):return 1 if v < -4 else 2 if v>4 else 0
def rnd(v):return int((v*S+arb(1)/2).floor().unique_fmpz())
tiles=[]
digest=hashlib.sha256()
ambiguous=0
for j in range(0,len(rows),64):
    data=[]
    for k,(x,y) in enumerate(rows[j:j+64],j):
        n=k%59+1
        c=acb(arb(n*n)/60).exp_pi_i()
        u,v=rnd(c.real),rnd(c.imag)
        a=(x*u-y*v+S//2)//S;b=(x*v+y*u+S//2)//S
        code=cls(a)+4*cls(b)
        ambiguous+=(cls(a)==0)+(cls(b)==0)
        digest.update(bytes([code]))
        data.append((x,y,u,v,code))
    tiles.append([len(data),*[pack(list(z)) for z in list(zip(*data))[:4]],sum(z[-1]<<(4*i) for i,z in enumerate(data))])
(base/'static.txt').write_text(''.join(' '.join(map(str,zz))+'\n' for zz in tiles))
(base/'static-native.json').write_text(json.dumps(dict(n=len(rows),unknown=ambiguous,hash=digest.hexdigest()),indent=2))
