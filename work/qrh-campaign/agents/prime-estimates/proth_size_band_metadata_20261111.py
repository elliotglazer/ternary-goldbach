"""Integer geometry and proof-call counts only; no prime or modular evaluations."""
from pathlib import Path
from fractions import Fraction
from hashlib import sha256
import json

N0=989*10**24
T=N0-1
ceil=lambda a,b:(a+b-1)//b
thresholds=[(2**j+1)**2 for j in range(1,45)]
rows=[]
for B in [10**15,2*10**15,10**16,2*10**16,10**17,2*10**17,4*10**18]:
    D=B-2
    K=max(0,ceil(T-B-3,D))
    assert T-B>=thresholds[-1]
    counts=[max(0,ceil(a-3,D)-1) for a in thresholds]
    # Exact counts on the hypothetical maximum-step integer grid, not primes.
    assert counts==[min(K,max(0,(a-4)//D)) for a in thresholds]
    saving=sum(counts)
    bands=[]
    for m in range(45):
        n=(counts[m] if m<44 else K)-(counts[m-1] if m else 0)
        assert n>=0
        bands.append(n)
    assert sum(bands)==K and sum((44-m)*v for m,v in enumerate(bands))==saving
    rows.append(dict(B=B,necessary_new_rungs=K,forced_early_counts=counts,
                     forced_saved_square_calls=saving,ideal_old_calls=44*K,
                     ideal_new_calls=44*K-saving,
                     saving_over_ideal_old= str(Fraction(saving,44*K)),
                     hypothetical_maxstep_band_counts=bands,
                     header_bits_upper=44*K.bit_length()))
# Boundary logic only: minimum accepted exponent, with strict square bound.
boundary=[]
for j in range(1,45):
    a=(2**j+1)**2
    for p in (a-2,a,a+2):
        m=next(m for m in range(46) if p<(2**(m+1)+1)**2)
        assert m==(j-1 if p<a else j)
        boundary.append(dict(j=j,p=p,m=m))
out=Path(__file__).with_suffix('.json')
data=dict(scope='Integer metadata, hypothetical grid labels are not primes',N0=N0,T=T,
          thresholds=thresholds,rows=rows,boundary_checks=len(boundary))
with out.open('x',encoding='utf8',newline='\n') as f:
    json.dump(data,f,indent=2);f.write('\n')
print(json.dumps(dict(rows=len(rows),boundary_checks=len(boundary),receipt_sha256=sha256(out.read_bytes()).hexdigest().upper(),
                     summary=[{k:r[k] for k in ('B','necessary_new_rungs','forced_saved_square_calls','header_bits_upper')} for r in rows])))
