"""Independent exact metadata review. No author imports or analytic values."""
from pathlib import Path
from fractions import Fraction as Q
from collections import Counter
import hashlib, json

HERE=Path(__file__).resolve().parent
A=HERE.parent
candidate=A/'prime-estimates/adaptive_small_theta_interpolation_20261111.json'
prior=A/'prime-estimates/small_family_minimal_theta_20261111.json'
data=json.loads(candidate.read_text())
old=json.loads(prior.read_text())
checks=0
def ck(p):
    global checks
    assert p
    checks+=1
def ceil(q):return -(-q.numerator//q.denominator)
q=Q(160919,393216)
ck(q==Q(22,7)*(Q(25,192)+Q(1,2**18)))
ck(0<q<Q(605,1344)<1)
for name,h in data['pins'].items():ck(hashlib.sha256((A/name).read_bytes()).hexdigest().upper()==h)
params={}
oldparams={(p['odd'],p['theta']):p for p in old['selectors']}
ck(len(data['parameters'])==130)
for p in data['parameters']:
    key=p['odd'],p['theta'];theta=p['theta'];w=Q(40_000_000 if p['odd'] else 80_000_000,theta)
    eps=Q(1,2**82*3**theta);mass=44*(2*w*w+1);r=p['order'];s=p['old_bandwidth_order']
    ck(64<=theta<=128 and r%2==s%2==0 and 2<=r<=s<=340)
    ck(Q(p['W'])==w and Q(p['M'])==mass and Q(p['epsilon'])==eps)
    ck(mass*q**r<eps/16<=mass*q**(r-2))
    ck(mass*Q(605,1344)**s<eps/16<=mass*Q(605,1344)**(s-2))
    ck(Q(p['remainder_over_epsilon'])==mass*q**r/eps)
    ck(p['K']==oldparams[key]['K'])
    params[key]=p
ck(len(params)==130)
ck(data['distinct_orders']==list(range(182,261,2)))
ck(data['shared_exact_weights']==7*sum(data['distinct_orders']))
maxnorm=Q(0)
for record in data['kernels']:
    r=record['order'];m=r//2;nodes=list(range(1-m,m+1))
    ck(record['nodes']==[nodes[0],nodes[-1]])
    for ell,row in enumerate(record['offsets'],1):
        x=Q(ell,8)
        w=Q(1)
        for other in nodes[1:]:w*=(x-other)/(nodes[0]-other)
        weights=[w]
        for i,j in enumerate(nodes[:-1]):
            w*= -Q(r-1-i,i+1)*(x-j)/(x-j-1)
            weights.append(w)
        for degree in range(7):ck(sum(w*j**degree for w,j in zip(weights,nodes))==x**degree)
        norm=sum(abs(w) for w in weights)
        ck(norm==Q(row['Lebesgue'])<4)
        ck(ceil(1000*norm)==row['upper_thousandths'])
        ck(hashlib.sha256('\n'.join(str(w) for w in weights).encode()).hexdigest().upper()==row['weight_digest'])
        maxnorm=max(maxnorm,norm)

# Euler phi and primitive-character totals via divisor inversion, independently
# of the author's prime-power primitive-count product.
phi=list(range(10001));phi[1]=1
for p in range(2,10001):
    if phi[p]==p:
        for n in range(p,10001,p):phi[n]=phi[n]//p*(p-1)
primitive=phi[:]
for d in range(1,10001):
    for n in range(2*d,10001,d):primitive[n]-=primitive[d]
family=[c for c in range(3,10001) if primitive[c]>0]
ck(family==[c for c in range(3,10001) if c%2 or c%4==0])
ck(len(family)==7499 and sum(primitive[c] for c in family)==18477108)
out=[];minimumN=None;used=set()
for scen,expected in zip(old['scenarios'],data['scenarios'],strict=True):
    e=scen['extra_nodes'];hist=Counter();qh=Counter();terms=oldterms=queries=oldqterms=0
    choices=scen['choice_in_increasing_active_conductor_order'];ck(len(choices)==len(family))
    for c,theta in zip(family,choices,strict=True):
        band=sum(c>=t for t in (100,1000,10000))
        u=([Q(21),Q(20),Q(39,2),Q(96,5)] if c%2 else [Q(113,5),Q(211,10),Q(201,10),Q(191,10)])[band]
        height=ceil(200+max(Q(240 if c%2 else 255),Q(3927,1250)*u*Q(531600 if c%2 else 1063200,c)))
        top=ceil(Q(64*height,5))+e
        par=params[(bool(c%2),theta)];K=par['K'];r=par['order'];used.add(r)
        N=8
        while Q(5*N,64)<max(Q(2*5*top*K,64*theta),Q(5*top,64)+2*K,Q(6)):N*=2
        minimumN=N if minimumN is None else min(minimumN,N)
        J=ceil(Q(25*N,192))
        ck(N>=2**18 and N>r and top+1<=N and 2*J<N)
        ck(Q(J,N)<Q(25,192)+Q(1,N) and Q(22*J,7*N)<=q)
        mass=Q(par['M']);eps=Q(par['epsilon']);v=eps/(16*r*(mass+3))
        ck(r*(mass+1)*v+(2*r)*v==eps/16)
        count=7*primitive[c]*top
        hist[r]+=1;qh[r]+=count;terms+=r*count;queries+=count;oldterms+=340*count;oldqterms+=par['old_bandwidth_order']*count
    got={'extra_nodes':e,'order_conductor_histogram':{str(k):v for k,v in sorted(hist.items())},'order_query_histogram':{str(k):v for k,v in sorted(qh.items())},'new_endpoints':queries,'real_products':terms,'real_additions':terms-queries,'rounding_gates':2*terms,'sample_accesses':terms,'fixed340_products':oldterms,'old_bandwidth_adaptive_products':oldqterms,'saved_products':oldterms-terms,'remaining_fraction':str(Q(terms,oldterms))}
    ck(got==expected);out.append(got)
ck(minimumN==2**18 and used==set(data['distinct_orders']))
result={'status':'PASS_INDEPENDENT_EXACT_METADATA','checks':checks,'max_Lebesgue':str(maxnorm),'min_N':minimumN,'scenarios':out,'pins':{str(p.relative_to(A)):hashlib.sha256(p.read_bytes()).hexdigest().upper() for p in [candidate,prior]}}
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'status':result['status'],'checks':checks,'min_N':minimumN,'main_products':out[0]['real_products']}))
