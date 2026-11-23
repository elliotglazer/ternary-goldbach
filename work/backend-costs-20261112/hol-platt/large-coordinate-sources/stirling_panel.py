import json, time, hashlib, sys
from pathlib import Path
from flint import acb, arb, fmpq, ctx
ctx.prec=220
ctx.threads=1
folder=Path(__file__).resolve().parent
rows=(folder/'gamma-rectangles.txt').read_text().splitlines()
full='--full' in sys.argv
digest=hashlib.sha256()
terms=[fmpq.bernoulli(2*k)/(2*k*(2*k-1)) for k in range(1,20)]
b40=abs(fmpq.bernoulli(40))
assert 2**(20+170)*b40 < 40*39*64**39
receipt=[]
for block,start in enumerate((0,) if full else (1,84000)):
    t0=time.process_time()
    maxrad=arb(0)
    for j in range(start,84881 if full else start+512):
        for a in (0,1):
            t=arb(5*j)/64
            g=acb(arb(1)/4+arb(a)/2,t/2)
            shift=64 if g.imag<64 else 0
            z=g+shift
            assert abs(z)>=64 and z.real>0
            inv=1/z
            v=acb(0)
            for beta in reversed(terms):
                v=arb(beta)+inv**2*v
            main=(z-arb(1)/2)*z.log()-z+inv*v
            # The omitted real constant log(2*pi)/2 has zero imaginary part.
            arg=main.imag-t*arb.pi().log()/2
            if shift:
                prod=acb(1)
                for k in range(shift):
                    prod*=g+k
                arg-=prod.arg()
            arg+=arb(0,arb(2)**(-170))
            out=acb(0,arg).exp()
            for comp,x in enumerate((out.real,out.imag)):
                i=2048*block+4*(j-start)+2*a+comp
                if full:
                    m=(x*2**105+arb(1)/2).floor().unique_fmpz()
                    assert m is not None and abs(x*2**105-int(m))<arb(1)/2
                    digest.update(int(m).to_bytes(14,"little",signed=True))
                    maxrad=max(maxrad,x.rad())
                    continue
                lo,hi,m=map(int,rows[i].split())
                v=(x+2)*2**150
                assert v>lo and v<hi
                maxrad=max(maxrad,x.rad())
    receipt.append(dict(first=start,phase_factors=169762 if full else 1024,cpu=time.process_time()-t0,
                        max_radius=str(maxrad)))
print(receipt)
if full:
    expected=json.loads((folder/'full-gamma-native.json').read_text())['p105_digest']
    assert digest.hexdigest()==expected
    receipt[0]['p105_digest']=expected
(folder/('full-stirling-native.json' if full else 'stirling-panel.json')).write_text(json.dumps(receipt,indent=2))

