from pathlib import Path
from collections import Counter
from time import perf_counter,process_time
from flint import arb,acb,ctx
import hashlib,json
here=Path(__file__).resolve().parent
data=here.parent/'full-height-count'
sparse=here.parent/'sparse-count'
labels=(3,6667,11,9091)
N=524288; H=N//2; J=68267; M=85121; P=304
ctx.prec=420
ctx.threads=1
start,cpu=perf_counter(),process_time()
spec=data/'coefficients.tsv'
assert hashlib.sha256(spec.read_bytes()).hexdigest()==json.loads((data/'spectrum.json').read_bytes())['sha256']['coefficients.tsv']
ms=[];raws=[]
for label in labels:
    masks=[]; selected={}
    for tile,line in enumerate((sparse/f'raw-{label}.txt').read_text().splitlines()):
        fields=line.split(); mask=int(fields[0])
        masks.append(mask)
        positions=[tile*64+j for j in range(64) if mask>>j&1]
        nums=[int(v,16)-(1<<255) for v in fields[1:]]
        assert len(positions)==len(nums)
        selected.update(zip(positions,nums))
    assert len(masks)==1331 and max(selected)<M
    ms.append(masks); raws.append(selected)
union=sorted(set.union(*(set(d) for d in raws)))
def scaled(z):
    x=int((z.mid()*(1<<P)+arb(1)/2).floor().unique_fmpz())
    assert abs(z*(1<<P)-x)<1
    return x
def reduce(z,p):return (z+(1<<(P-p-1)))>>(P-p) if p<P else z
def enc(z,w):
    assert -(1<<(w-1))<=z<(1<<(w-1))
    return z+(1<<(w-1))
def phase(tick):
    w=acb.exp_pi_i(acb(-2*(tick-128))/N)
    return scaled(w.real),scaled(w.imag)
roots={k:phase(k) for k in union}
parts=[]
for col,label in enumerate(labels):
    cells={k:[] for k in raws[col]}
    for parity in (0,1):
        z=[acb(0)]*H
        with spec.open() as f:
            for j,line in enumerate(f):
                fields=line.split()
                assert j==int(fields[0])
                if j%2!=parity:continue
                a=acb(arb((int(fields[1+col*2]),-256)),arb((int(fields[2+col*2]),-256)))
                z[((-j)%N)//2]=a
                if j:z[j//2]=a.conjugate()
        assert j==J
        out=acb.dft(z);del z
        for k,vs in cells.items():
            x=out[(k-128)%H]
            vs.extend([scaled(x.real)] if parity==0 else [scaled(x.real),scaled(x.imag)])
        del out
    parts.append(cells)
    print('PREPARED',label,len(cells),flush=True)
ratio=Counter();tot=0;largest=0
with (here/'full-operands.hex').open('w',newline='\n') as fo:
    for tile in range(1331):
        positions=[j for j in range(tile*64,min(M,tile*64+64)) if any(j in d for d in raws)]
        for p in range(224,P+1,4):
            S=1<<p;ok=True;largest_coord=0
            for pos in positions:
                wr,wi=[reduce(u,p) for u in roots[pos]]
                for col in range(4):
                    if pos not in raws[col]:continue
                    a,b,c=[reduce(u,p) for u in parts[col][pos]]
                    largest_coord=max(largest_coord,abs(a),abs(b),abs(c))
                    q=raws[col][pos]
                    z=a*S+wr*b-wi*c
                    err=S+abs(wr)+abs(wi)+abs(b)+abs(c)+2
                    if not q*(S*S) <= (z-err)<<220 or not (z+err)<<220 < (q+1)*(S*S):
                        ok=False;break
                if not ok:break
            if ok:break
        assert ok,(tile,pos,p)
        w=max(2,largest_coord.bit_length()+1)
        ratio[p]+=1
        row=[str(tile),str(p),str(w),str(len(positions))]
        for pos in positions:
            wr,wi=[reduce(u,p) for u in roots[pos]]
            root=enc(wr,p+2)+(enc(wi,p+2)<<(p+2))
            y=0
            for col in reversed(range(4)):
                if pos not in raws[col]:continue
                a,b,c=[reduce(u,p) for u in parts[col][pos]]
                y=(y<<(3*w)) + enc(a,w)+(enc(b,w)<<w)+(enc(c,w)<<(2*w))
                tot+=1
            record=pos+((root+(y<<(2*p+4)))<<17)
            row.append(format(record,'x'))
            largest=max(largest,record.bit_length())
        fo.write(' '.join(row)+'\n')
assert tot==71325
report=dict(outputs=tot,union=len(union),tiles=1331,precision_hist=dict(ratio),max_word_bits=largest,
    bytes=(here/'full-operands.hex').stat().st_size,wall=perf_counter()-start,cpu=process_time()-cpu,
    operand_sha256=hashlib.sha256((here/'full-operands.hex').read_bytes()).hexdigest())
(here/'full-native.json').write_text(json.dumps(report,indent=2))
print(report)
