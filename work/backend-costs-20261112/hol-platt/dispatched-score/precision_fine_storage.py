"""Test compact storage at the four retrospectively chosen single-step hidden pairs."""
from fractions import Fraction as F
from hashlib import sha256
import json,math
from flint import arb,ctx
from precision_contiguous import HERE,arn,strip_error
from precision_stencil import compact,quantum

def main():
    ctx.prec=192
    src=HERE/'precision-fine-hidden.json';data=json.loads(src.read_bytes());x=F(11389,2)
    observed={(j,k,p):arb(arb((int(v),-3*p)),arb((int(d),-3*p))) for j,k,p,v,d in data['rows']}
    cases=[]
    for k in data['selected_hidden']:
        for p in (24,28):
            raw={j:observed[j,k,p] for j in range(5689,5701)}
            for policy,bits in [('full',0)]+[(a,b) for a in ['per_value','shared_block'] for b in [8,12,16]]:
                values=raw
                if bits:
                    q=quantum(max(map(abs,raw.values()),key=lambda z:z.upper()),bits)
                    values={j:compact(v,bits,q if policy=='shared_block' else quantum(abs(v),bits)) for j,v in raw.items()}
                def sg(v):return int(v>0)-int(v<0)
                for m in range(2,13):
                    ns=sorted(sorted(values,key=lambda j:(abs(j-x),j))[:m]);ws=[arn(math.prod((x-j)/(i-j) for j in ns if i!=j)) for i in ns]
                    rem=min((strip_error(ns,x,b,k%2) for b in range(2,9)),key=lambda z:z.upper())
                    out=sum((values[j]*w for j,w in zip(ns,ws,strict=True)),arb(0,rem.upper()))
                    if sg(out):break
                ref=arb(data['midpoint'][f'{k}/{p}']['direct']);assert out.overlaps(ref)
                if sg(out):assert sg(out)==sg(ref)
                signs=[sg(values[5694]),sg(out),sg(values[5695])]
                cases.append(dict(k=k,p=p,policy=policy,bits=bits,m=m,signs=signs,hidden_proved=bool(signs[0] and signs[0]==signs[2]==-signs[1])))
    (HERE/'precision-fine-storage.json').write_text(json.dumps(dict(cases=cases,source_sha256=sha256(src.read_bytes()).hexdigest()),indent=2)+'\n')

if __name__=='__main__':main()
