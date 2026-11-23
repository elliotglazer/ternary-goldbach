"""Supply Arb-certified values at the radix-2 boundary preceding projected samples."""
from pathlib import Path
from flint import acb,arb,ctx
from time import perf_counter,process_time
import hashlib,json
here=Path(__file__).resolve().parent
full=here.parent/'full-height-count'
join=here.parent/'grid-sign-join'
src=full/'coefficients.tsv'
receipt=json.loads((full/'spectrum.json').read_text())
assert hashlib.sha256(src.read_bytes()).hexdigest()==receipt['sha256']['coefficients.tsv']
N,J=receipt['N'],receipt['J']
ctx.prec=384
ctx.threads=1
S=1<<256
rad=json.loads((join/'inputs.json').read_text())['coarse_radius']
label=3
tiles=(join/'tiles-3.txt').read_text().splitlines()
selected=[2,512,1026,1318]
positions=[i*64+k for i in selected for k in range(64)]
ticks=[j-128 for j in positions]
assert all(0<=j<=84864 for j in ticks)
grid=[int(s) for s in (full/'grid-3.txt').read_text().splitlines()]
signs={int(a):int(b) for a,b in (l.split() for l in (full/'signs-3.tsv').read_text().splitlines())}
def center(x):
    return int((x.mid()*S+arb(1)/2).floor().unique_fmpz())
def phase(x):
    v=center(x)
    assert abs(x*S-v)<1
    return v
t0=perf_counter();c0=process_time()
parts=[]
for parity in [0,1]:
    a=[acb(0)]*(N//2)
    count=0
    with src.open() as f:
        for j,line in enumerate(f):
            fields=line.split()
            assert j==int(fields[0])
            count+=1
            if j%2!=parity:continue
            v=acb(arb((int(fields[1]),-256)),arb((int(fields[2]),-256)))
            a[((-j)%N)//2]=v
            if j:a[j//2]=v.conjugate()
    assert count==J+1
    out=acb.dft(a)
    parts.append([out[k] for k in ticks])
    del out,a
elapsed=perf_counter()-t0
payload=[]; tally={}
for index,k,E,O in zip(positions,ticks,*parts,strict=True):
    W=acb.exp_pi_i(acb(-2*k)/N)
    er,orr,oi,wr,wi=map(phase,(E.real,O.real,O.imag,W.real,W.imag))
    z=er*S+wr*orr-wi*oi
    err=S+abs(wr)+abs(wi)+abs(orr)+abs(oi)+2
    w,e,n,*words=map(int,tiles[index//64].split())
    off=index%64
    q=((words[off//4]>>(w*(off%4)))% (1<<w))-(1<<(w-1))
    den=1<<(512-220+e)
    assert q*den<=z-err and z+err<(q+1)*den
    # Original 220-bit floor center is only used for an independent comparison.
    assert grid[index]//(1<<e)==q
    code=2 if q*(1<<e)>rad+(1<<e) else 1 if q*(1<<e)<-rad-(1<<e) else 0
    assert code and (1 if code==2 else -1)==signs[k*4096]
    tally[code]=tally.get(code,0)+1
    payload.append(' '.join(map(str,(er,orr,oi,wr,wi,e,q,code))))
(here/'butterflies.txt').write_text('\n'.join(payload)+'\n')
print(json.dumps(dict(label=label,N=N,spectrum_bins=J+1,tile_ids=selected,ticks=[[t*64-128,t*64-65] for t in selected],count=len(payload),codes=tally,
    two_half_transforms_and_ingress_wall=elapsed,native_total_wall=perf_counter()-t0,native_total_cpu=process_time()-c0,
    coefficient_sha256=hashlib.sha256(src.read_bytes()).hexdigest()),indent=2))
