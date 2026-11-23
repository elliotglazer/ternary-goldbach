from pathlib import Path
from flint import arb,ctx
from math import isqrt
import json
p=Path(__file__).resolve().parent
ctx.prec=320
D=2**139; G=2**64
def rnd(d,x): return (2*x+d)//(2*d)
def lc(a,b):
    v=0
    for k in reversed(range(45)):
        j=2*k+1;v=rnd(j*b*b,2**137*b*b+j*a*a*v)
    return rnd(b,2*a*v)
def expc(r):
    x,y=G,0
    for k in reversed(range(72)):
        d=D*(k+1);x,y=rnd(d,G*d-r*y),rnd(d,r*x)
    return x
def center(a):return int((a+arb(1)/2).floor().unique_fmpz())
l2=lc(1,3);pi=center(D*arb.pi())
cache=[]
for n in range(1,3990):
    k=n.bit_length()-1;b=1<<k;cache.append((isqrt(G*G//n),rnd(256,k*l2+lc(n-b,n+b))))
rows=[]
for tick in [102396199792,102396199793,102396199794]:
    t=arb(tick)/1024;s=(t/(2*arb.pi())).sqrt();assert int(s.floor().unique_fmpz())==3989
    z=1-2*(s-3989);J=(arb.pi()*(z*z+arb(3)/4)/2).cos()/(arb.pi()*z).cos()/s.sqrt()
    H=t*(t/(2*arb.pi())).log()/2-t/2-arb.pi()/8+1/(48*t)
    h=center(D*H);j=center(G*G*J);v=j
    for w,l in cache:
        f=h-tick*l;q=rnd(pi,f);r=f-q*pi
        v+=2*w*expc(r)*(-1 if q%2 else 1)
    rows.append([tick,h,pi,j,v])
def lit(v):return str(v) if v>=0 else '(~'+str(-v)+')'
qs=[('sample'+str(i),'rscheck '+' '.join(map(lit,row))) for i,row in enumerate(rows)]
qs.append(('wrong','~(rscheck '+' '.join(map(lit,rows[0][:-1]+[rows[0][-1]+1]))+')'))
(p/'inputs.json').write_text(json.dumps(rows,indent=2))
qs.append(('shared3','rscommon '+lit(pi)+' '+' '.join('('+','.join(map(lit,(t,h,j,v)))+')' for t,h,_,j,v in rows)))
qs.append(('setup','LENGTH (cache 3989 11 (logc 1 3)) = 3989'))

src=(p/'bench.template').read_text()
(p/'bench.sml').write_text(src+'\n'+''.join('val _=measure "'+label+'" ``'+q+'``;\n' for label,q in qs)+'val _=print "RS_DONE\\n";\n')


