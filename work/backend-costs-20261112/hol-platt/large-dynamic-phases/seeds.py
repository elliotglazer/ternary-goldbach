import hashlib,json,time
from pathlib import Path
from flint import arb,acb,ctx
ctx.prec=210
ctx.threads=1
p=Path(__file__).resolve().parent
m=p.parents[2]/'qrh-campaign/agents/integration/transform_structural_manifest_20261111.json'
raw=m.read_bytes()
assert hashlib.sha256(raw).hexdigest()=='a41d70db2bb439d73cc817f80b24cb598d3efa89cce1d19a5fa618abbe239637'
qs=[r[0] for r in json.loads(raw)['conductors']]
def fold(z,d):
    for coord in (z.real,z.imag):
        x=coord*2**126
        m=(x+arb(1)/2).floor().unique_fmpz()
        assert m is not None and abs(x-int(m))<arb(1)/2
        d.update(int(m).to_bytes(16,'little',signed=True))
d=hashlib.sha256()
t0=time.process_time()
for q in qs:fold(acb(0,-5*arb(q).log()/128).exp(),d)
out=dict(q_seeds=len(qs),q_seed_sha256=d.hexdigest(),q_seed_cpu=time.process_time()-t0)
d=hashlib.sha256()
t0=time.process_time()
logpi=arb.pi().log()
for j in range(84881):
    t=arb(5*j)/64
    for a in (0,1):
        z=acb(arb(1)/4+arb(a)/2,t/2)
        fold(acb(0,z.lgamma().imag-t*logpi/2).exp(),d)
out.update(gamma_factors=169762,gamma_sha256=d.hexdigest(),gamma_cpu=time.process_time()-t0)
(p/'seeds.json').write_text(json.dumps(out,indent=2))
print(out)
