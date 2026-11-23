"""Directly evaluate the genuine half-grid targets of the fixed q131071 panel."""
from fractions import Fraction as F
from hashlib import sha256
import json
from pathlib import Path
from time import process_time
from flint import acb,arb,ctx
from precision_contiguous import HERE,HOL,Q,N,residues
from prime_panel import phase_table,positive_dft

def source_half(rs,j):
    cells=64;t=arb(5*(2*j+1))/128;s=acb(arb(1)/2,t)
    height=(5*(2*j+1)+127)//128+1;term=F(1)
    for k in range(1,256):
        term*=F(height+k-1,2*cells*k);ratio=F(height+k,2*cells*(k+1))
        if k>=2 and ratio<1 and 2*term/(1-ratio)<F(1,1<<100):break
    else:raise ArithmeticError('tail')
    centers=[arb(2*i+1)/(2*cells) for i in range(cells)];fac=[acb(1)]
    for i in range(k-1):fac.append(-fac[-1]*(s+i)/(i+1))
    coeffs=[[f*(s+i).zeta(1+c) for i,f in enumerate(fac)] for c in centers]
    radius=arb(0,arb(2)**-100);widen=acb(radius,radius);out=[]
    for a in rs:
        c=cells*a//Q;al=arb(a)/Q;delta=al-centers[c];poly=coeffs[c][-1]
        for f in reversed(coeffs[c][:-1]):poly=poly*delta+f
        out.append(acb(al)**(-s)+poly+widen)
    for i in (0,N//5,N//2,N-1):assert out[i].overlaps(s.zeta(arb(rs[i])/Q))
    return s,out

def main():
    ctx.prec=192;ctx.threads=1;begin=process_time()
    src=HERE/'precision-contiguous.json';data=json.loads(src.read_bytes());grades=HERE/'precision-contiguous-storage.json'
    pre=json.loads(grades.read_bytes())['primary'];modes=data['selected_hidden']+data['systematic']
    _,rs=residues(Q);ph=phase_table(rs,Q)
    arch=HOL/'large-coarse-sign/prime-131071.json';old=json.loads(arch.read_bytes())
    masks={r['j']:bin(int(r['reference_signs_hex'],16))[2:] for r in old['nodes']}
    native={};extra=[];times=[]
    for j in range(5689,5700):
        start=process_time();s,raw=source_half(rs,j);spec=positive_dft(raw);del raw
        fac=[(arb.pi()*s.imag/4).exp()*(acb(Q)/arb.pi())**((s+a)/2)*((s+a)/2).gamma()*acb(Q)**(-s) for a in (0,1)]
        def reference(k):
            z=ph[k]*fac[k%2]*spec[k];assert z.imag.contains(0)
            sg=int(z.real>0)-int(z.real<0);assert sg
            return z.real,sg
        for k in modes:
            z,sg=reference(k);native[f'{j}/{k}']=dict(sign=sg,value=str(z))
            for p in (24,28):assert pre[f'{p}/{k}/{2*j+1}/2'] in (0,sg)
        if j==5694:
            for k in range(1,N):
                if masks[j][k]!=masks[j+1][k]:continue
                z,sg=reference(k)
                if (sg>0)!=(masks[j][k]=='1'):
                    extra.append(dict(k=k,j=j,sign=sg,reference=str(z)))
                    if len(extra)==4:break
        times.append(process_time()-start);print('direct midpoint',j,flush=True)
    report=dict(modes=modes,reference=native,retrospective_single_step_examples=extra,cpu=process_time()-begin,
                cpu_by_height=times,inputs={f.name:sha256(f.read_bytes()).hexdigest() for f in [Path(__file__),src,grades,arch]})
    (HERE/'precision-midpoints.json').write_text(json.dumps(report,indent=2)+'\n')

if __name__=='__main__':main()
