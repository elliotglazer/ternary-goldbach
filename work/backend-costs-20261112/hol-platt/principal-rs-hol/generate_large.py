from generate import D,G,arb,ctx,cache,pi,center,rnd,lit,p
from flint import dirichlet_char
import json
start=102396199792;step=128;m=512
def phase(f):
    q=rnd(pi,f);r=f-q*pi;x,y=G,0
    assert abs(q)<=10**10 and abs(r)<=2*D
    for k in reversed(range(72)):
        d=(k+1)*D;x,y=rnd(d,G*d-r*y),rnd(d,r*x)
    return (-x,-y) if q%2 else (x,y)
def scalars(i):
    t=arb(start+step*i)/1024;P=arb.pi();a=(t/(2*P)).sqrt()
    assert int(a.floor().unique_fmpz())==3989
    z=1-2*(a-3989);J=(P*(z*z+arb(3)/4)/2).cos()/(P*z).cos()/a.sqrt()
    H=t*(t/(2*P)).log()/2-t/2-P/8+1/(48*t)
    return center(D*H),center(G*G*J),H,J
data=[scalars(i) for i in range(m)];h0=data[0][0];A=[[0,0] for _ in range(m)]
for w,l in cache:
    x,y=phase(h0-start*l);u,v=phase(-step*l)
    for a in A:
        a[0]+=2*w*x;a[1]+=2*w*y
        x,y=rnd(G,x*u-y*v),rnd(G,x*v+y*u)
rows=[];sig=[];diff=[];truth=[]
src=[(arb(n).log(),1/arb(n).sqrt()) for n in range(1,3990)]
for i,((h,j,H,J),(a,b)) in enumerate(zip(data,A)):
    u,v=phase(h-h0);val=rnd(G,a*u-b*v)+j;rows.append((h,j,val))
    t=arb(start+i*step)/1024
    K=J+2*sum((w*(H-t*l).cos() for l,w in src),arb(0))
    Z=dirichlet_char(1,1).hardy_z(t).real
    e=arb(451)/1000/t**(arb(3)/4)
    assert abs(arb(val)/G**2-K)<arb(4)/10**12 and abs(K-Z)<e and abs(K)>e
    sig.append(1 if val>0 else -1);assert (Z>0 if sig[-1]>0 else Z<0)
    diff.append(float(abs(arb(val)/G**2-K)));truth.append(float(abs(K)/e))
N=[int((arb(start+step*i)/1024).zeta_nzeros().unique_fmpz()) for i in [0,m-1]]
res=dict(start=start,step=step,n=m,counts=N,changes=sum(x!=y for x,y in zip(sig,sig[1:])),max_abs_diff=max(diff),min_tail_ratio=min(truth),signs=sig,rows=rows)
(p/'mesh-large.json').write_text(json.dumps(res,indent=2))
def args(sub):
    return '['+';'.join('('+','.join(map(lit,r))+')' for r in sub)+']'
def call(sub):
    return 'mesh_run '+' '.join(map(lit,(start,h0,pi,step)))+' '+args(sub)
template=(p/'bench.template').read_text().replace('cv_transLib RSKernelTheory','cv_transLib RSKernelTheory RSBatchTheory')
bench=template+'\n'
for n in [128,256,512]:
    bench+='val _=measure "mesh'+str(n)+'" ``'+call(rows[:n])+'``;\n'
bad=rows[:];h,j,z=bad[-1];bad[-1]=(h,j,z+1)
bench+='val _=measure "wrong512" ``~('+call(bad)+')``;\n'
(p/'meshlarge.sml').write_text(bench+'val _=print "RS_DONE\\n";\n')
print({k:v for k,v in res.items() if k not in ('rows','signs')})

