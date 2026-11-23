from fractions import Fraction as Q
from math import comb
from pathlib import Path
import json
p=Path(__file__).resolve().parent
bands=json.loads((p/'integer-groups.json').read_bytes())['bands']
result=[]
for b in bands:
    D=b['degree']; m=D+1; H=1+(5*b['j']+63)//64; r=64; f=b['grid']; prec=b['p']
    first=Q(2)
    for i in range(m): first*=Q(r*(H+i),f*(i+1))
    errs=[]
    for k in range(20):
        scale=Q(2,r)**k; ratio=Q(r*(H+m),f*(m+1-k))
        assert ratio<1
        tail=first*comb(m,k)*scale/(1-ratio)
        seed=Q(comb(m,k+1),2**prec)*scale
        eps=(seed+tail)*2**94
        assert eps<Q(1,2**16)
        assert eps+Q(1,2)<Q(51,100)
        # sqrt(1/2)+eps < 0.707115: clear denominators and square.
        gap=Q(707115,1000000)-eps
        assert gap>0 and gap**2>Q(1,2)
        errs.append(dict(k=k,seed_num=seed.numerator,seed_den=seed.denominator,
            tail_num=tail.numerator,tail_den=tail.denominator,ratio=str(ratio),error94=float(eps)))
    result.append(dict(band=b['band'],max_combined94=max(e['error94'] for e in errs),by_order=errs))
(p/'exact-errors.json').write_text(json.dumps(result,indent=2))
print([r['max_combined94'] for r in result])
