"""Repeat the local q131071 interpolations after outward amplitude compaction."""
from fractions import Fraction as F
from hashlib import sha256
import json, math
from flint import arb,ctx
from precision_contiguous import HERE,arn,strip_error
from precision_stencil import compact,quantum

def main():
    ctx.prec=192
    src=HERE/'precision-contiguous.json';data=json.loads(src.read_bytes())
    rows={(j,k,p):arb(arb((int(v),-3*p)),arb((int(d),-3*p))) for j,k,p,v,d in data['rows']}
    targets=[F(5695)]+[F(2*j+1,2) for j in range(5689,5700)]
    terms={}
    for target in targets:
        available=sorted((j for j in range(5689,5701) if j!=target),key=lambda j:(abs(j-target),j))
        for m in range(2,len(available)+1):
            ns=sorted(available[:m]);ws=[arn(math.prod((target-j)/(i-j) for j in ns if j!=i)) for i in ns]
            for parity in (0,1):
                error=min((strip_error(ns,target,b,parity) for b in range(2,9)),key=lambda z:z.upper())
                terms[target,m,parity]=(ns,ws,arb(0,error.upper()))
    report=[];primary={}
    for p in (24,28):
        for policy,b in [('full',0)]+[(s,v) for s in ['per_value','shared_block'] for v in [8,12,16]]:
            for category,modes in [('selected_hidden',data['selected_hidden']),('systematic',data['systematic'])]:
                failures=[]
                for k in modes:
                    for target in targets:
                        archive={j:rows[j,k,p] for j in range(5689,5701) if j!=target}
                        if b:
                            common=quantum(max(map(abs,archive.values()),key=lambda z:z.upper()),b)
                            archive={j:compact(v,b,common if policy=='shared_block' else quantum(abs(v),b)) for j,v in archive.items()}
                        certified=0
                        for m in range(2,len(archive)+1):
                            ns,ws,error=terms[target,m,k%2]
                            out=sum((archive[j]*w for j,w in zip(ns,ws,strict=True)),error)
                            certified=int(out>0)-int(out<0)
                            if certified:break
                        if not certified:failures.append([k,str(target)])
                        if policy=='full':primary[f'{p}/{k}/{target}']=certified
                        if target==5695 and certified:
                            assert certified==data['midpoint'][f'{k}/{p}']['sign']
                report.append(dict(p=p,policy=policy,b=b,cohort=category,total_offgrid=11*len(modes),
                                   grey_offgrid=sum(x[1]!='5695' for x in failures),total_heldout=len(modes),
                                   grey_heldout=sum(x[1]=='5695' for x in failures),failures=failures))
    (HERE/'precision-contiguous-storage.json').write_text(json.dumps(dict(rows=report,primary=primary,sha256={f.name:sha256(f.read_bytes()).hexdigest() for f in (src,HERE/'precision_stencil.py',HERE/'precision_contiguous.py',Path(__file__))}),indent=2)+'\n')

if __name__=='__main__':
    from pathlib import Path
    main()
