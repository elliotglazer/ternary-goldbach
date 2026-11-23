"""Choose each compressed span's scale by testing its regular and repaired signs."""
import hashlib,json
from pathlib import Path
from time import process_time
from fractions import Fraction
from collections import Counter

hol=Path(__file__).resolve().parent/'q10004-gaussian/hol'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
meta=json.loads((hol/'all-input.json').read_bytes())
weights={}
for row in (hol/'all-kernels.txt').read_text().splitlines()[1:]:
    key,*ws=map(int,row.split())
    assert sum(map(abs,ws))<=5*(1<<256)
    weights[key]=ws
start=process_time()
report={}
for label,inventory in meta['channels'].items():
    src=hol/f'all-{label}.txt'
    assert sha(src)==inventory['packed_sha256']
    header,*lines=src.read_text().splitlines()
    _,r,e,ns,nj=map(int,header.split())
    spans=lines[:ns]
    jobs=[list(map(int,l.split())) for l in lines[ns:]]
    out=[header]
    histogram=Counter()
    shifts=[]
    max_ratio=Fraction(0)
    bits=total=0
    for span in spans:
        first,*xs=map(int,span.split())
        relevant=[job for job in jobs if first<=job[1] and job[1]+192<=first+len(xs)]
        assert relevant
        for exponent in range(min(abs(x).bit_length() for x in xs),-1,-1):
            unit=1<<exponent
            qs=[(x+unit//2)//unit for x in xs]
            if any(abs(q*unit)<=r+unit for q in qs):continue
            passed=True
            for _,j,_,off,word,*_ in relevant:
                s=qs[j-first:j-first+192]
                assert sum((q>0)<<k for k,q in enumerate(s))==word
                z=sum(q*w for q,w in zip(s,weights[off],strict=True))*unit
                if abs(z)<=e+(5<<256)*unit:passed=False;break
            if passed:break
        else:raise ValueError(label)
        max_ratio=max(max_ratio,max(Fraction(abs(q*unit-x),unit) for x,q in zip(xs,qs)))
        width=max(abs(q).bit_length() for q in qs)+1
        base=1<<width
        digits=[q+base//2 for q in qs]
        assert all(0<=v<base for v in digits)
        packed=[sum(v<<(width*k) for k,v in enumerate(digits[a:a+8])) for a in range(0,len(qs),8)]
        out.append(' '.join(map(str,[first,exponent,width,len(qs),*packed])))
        histogram[width]+=len(qs);shifts.append(exponent);bits+=len(qs)*width;total+=len(qs)
    out.extend(lines[ns:])
    dest=hol/f'compressed-{label}.txt'
    dest.write_bytes(('\n'.join(out)+'\n').encode())
    report[label]=dict(sha256=sha(dest),raw_input_sha256=sha(src),mean_bits=bits/total,
          width_histogram=dict(histogram),unit_exponents=[min(shifts),max(shifts)],
          maximum_error_in_units=str(max_ratio))
(hol/'compression.json').write_text(json.dumps(dict(channels=report,prep_cpu=process_time()-start),indent=2))
