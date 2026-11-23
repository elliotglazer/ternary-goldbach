"""Exact PA-template recurrences only: no arithmetic/function/transform values."""
from functools import lru_cache
from pathlib import Path
import json
def cd(a,b): return (a+b-1)//b
def A(n): return 2*n+1
def M(a,b): return 5*a*b+2*min(a,b)+1
def H(n): return 12*cd(n,2)+8*n+21
@lru_cache(None)
def G(n):
    if n<=3: return M(n,n)
    h=cd(n,2)
    return min(M(n,n),G(h)+G(n-h)+G(h+1)+H(n))
@lru_cache(None)
def Rect(a,b):
    a,b=max(a,b),min(a,b)
    assert b>=1
    opts={'schoolbook':M(a,b),'pad':G(a),
          'chunks':cd(a,b)*(G(b)+A(2*b))}
    h=cd(a,2)
    if a>=4 and b>h:
        opts['unequal_split']=Rect(h,h)[0]+Rect(a-h,b-h)[0]+Rect(h+1,h+1)[0]+H(a)
    choice=min(opts,key=opts.get)
    return opts[choice],choice,opts
def costs(base,n,ng,n4,nf,nG):
    if base=='schoolbook': R=lambda a,b:M(a,b)
    elif base=='padded': R=lambda a,b:G(max(a,b))
    else: R=lambda a,b:Rect(a,b)[0]
    four_products=4*R(n,n); fixed_products=3*R(n,ng); gauss_products=2*R(n,n)+R(ng,ng)
    four=four_products+2*A(n4)
    fixed=fixed_products+A(ng)+2*A(nf)
    gauss=gauss_products+2*A(ng)+A(n4)+2*A(nG)
    setup=2*A(ng); delta=four-fixed; delta_gauss=gauss-fixed
    return dict(four_products=four_products,fixed_products=fixed_products,gauss_products=gauss_products,
        four=four,fixed_runtime=fixed,gauss=gauss,fixed_setup=setup,fixed_once=fixed+setup,
        fixed_saved_per_use=delta,strict_break_even_uses=(setup//delta+1 if delta>0 else None),
        fixed_saved_vs_gauss_per_use=delta_gauss,
        strict_break_even_vs_gauss=(setup//delta_gauss+1 if delta_gauss>0 else None),
        excluded='signed bridges, split/encoding, cache access, rounding/radius proofs')
rows=[]
for b in [4,8,10,12,16]:
    for p in [128,192,256,512,1024]:
        n=cd(p,b); ng=cd(p+1,b); n4=cd(2*p+1,b); nf=cd(2*p+2,b); nG=cd(2*p+3,b)
        rows.append(dict(radix_bits=b,p=p,n=n,grown_n=ng,output_n_four=n4,output_n_fixed=nf,output_n_gauss=nG,
            equal_product=Rect(n,n),unequal_product=Rect(n,ng),grown_product=Rect(ng,ng),
            schedules={name:costs(name,n,ng,n4,nf,nG) for name in ['schoolbook','padded','rectangular']}))
for n in range(1,260):
    for m in [n,max(1,n-1)]:
        v,_,opts=Rect(n,m)
        assert v<=M(n,m) and v<=G(n)
out=dict(scope='unsigned PA-template skeleton comparison with explicit missing signed/representation costs',rows=rows,
         recurrence_sanity_checks=518)
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    for r in rows:
        if r['radix_bits']==8:
            s=r['schedules']['rectangular']
            print(r['p'],r['n'],r['grown_n'],s['four'],s['fixed_runtime'],s['fixed_once'],s['gauss'],s['strict_break_even_uses'])
