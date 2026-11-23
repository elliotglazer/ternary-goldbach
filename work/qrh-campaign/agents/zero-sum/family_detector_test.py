"""Finite family means; floating point diagnostics plus explicit tail formulas."""
import math, cmath, json
from pathlib import Path
from fractions import Fraction as Q
P=149993; L=10**6
prime=bytearray(b'\x01')*(L+1); prime[:2]=b'\x00\x00'; lam=[0.0]*(L+1)
for p in range(2,L+1):
    if prime[p]:
        if p*p<=L: prime[p*p:L+1:p]=b'\x00'*((L-p*p)//p+1)
        n=p
        while n<=L:
            lam[n]=math.log(p)
            if n>L//p: break
            n*=p
terms=[(n,math.log(n),v) for n,v in enumerate(lam) if v and n%P]
def psi(z):
    total=0j
    while z.real<30:
        total-=1/z; z+=1
    inv=1/z
    # asymptotic evaluation; diagnostic, not a certified enclosure
    return total+cmath.log(z)-inv/2-inv**2/12+inv**4/120-inv**6/252+inv**8/240-inv**10/132

def integ(x,s):
    a=s-1
    return x**(-a)*(math.log(x)/a+1/a**2)
def residue_tail(r,s):
    n=L+1+(r-L-1)%P
    return math.log(n)/n**s+integ(n,s)/P

def row(s,t):
    basic=plus=minus=0.0
    for n,ln,v in terms:
        val=v*math.exp(-s*ln)*math.cos(t*ln)
        basic+=val
        if n%P==1: plus+=val
        if n%P==P-1: minus+=val
    evenN=(P-3)//2; oddN=(P-1)//2; allN=P-2
    eall=(basic-(P-1)*plus)/allN
    eeven=(basic-(P-1)/2*(plus+minus))/evenN
    eodd=-(plus-minus)
    tailall=(integ(L,s)+(P-1)*residue_tail(1,s))/allN
    taileven=(integ(L,s)+(P-1)/2*(residue_tail(1,s)+residue_tail(P-1,s)))/evenN
    tailodd=residue_tail(1,s)+residue_tail(P-1,s)
    even=.5*math.log(P/math.pi)+.5*psi(complex(s,t)/2).real+eeven
    odd=.5*math.log(P/math.pi)+.5*psi((complex(s,t)+1)/2).real+eodd
    mean=(evenN*even+oddN*odd)/allN
    det=sum((s-b)/((s-b)**2+t*t) for b in [.875,.125])
    return {'sigma':s,'t':t,'mean':mean,'euler_mean':eall,'euler_tail':tailall,'even_mean':even,'even_tail':taileven,'odd_mean':odd,'odd_tail':tailodd,'pair_detector':det,'mean_over_pair':mean/det,'mean_lower_diagnostic':(mean-tailall)/det}
rows=[row(s,t) for s in [1.02,1.05,1.1,1.125,1.25,1.5,2] for t in [0,.5,1,2,4,8,16,32]]
def H(s): return 4*((1-2**(-s))/s)**2 * 2**(s/2)*math.gamma(1+s/2)
f=sum((2j*math.pi*.082)**k/math.factorial(k)*H(.875+k) for k in range(30))
rem=(2*math.pi*.082)**30/math.factorial(30)*H(.875+30)
low=Q(4,5)-2*Q(22,7)**2*Q(41,500)**2*Q(135,64)
assert low>Q(51,100)
factor=10**(-25/8)*(P-2)*math.sqrt(P)/(P-1)
result={'status':'diagnostic floats, analytic Euler tail formulas; no interval special-function certificate', 'p':P,'cutoff':L,'rows':rows,'best':min(rows,key=lambda r:r['mean_over_pair']), 'original_grid_best':min((r for r in rows if r['sigma']>=1.125),key=lambda r:r['mean_over_pair']), 'transform_series_30':[f.real,f.imag], 'transform_abs':abs(f),'transform_remainder':rem,'rational_transform_lower':str(low),'family_factor':factor,'positive_detector_cost_diagnostic':factor*abs(f)*min(r['mean_over_pair'] for r in rows),'rigorous_paper_coarse_cost_using_F51_M4_W5':factor*.51*4/5}
Path('work/qrh-campaign/agents/zero-sum/family_detector_results.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
print(json.dumps({k:v for k,v in result.items() if k!='rows'},indent=2))
print('real centers:',[(r['sigma'],r['mean'],r['euler_tail'],r['mean_over_pair']) for r in rows if r['t']==0])

# Exact rational certificates used in the research proof, independent of float table.
assert Q(11,4)**10*Q(4,3)<Q(P,4)
assert Q(27,10)**12>P+1
for a in [Q(1,8),Q(1,50)]:
    res=Q(12,100000)+(12/a+1/a**2)/P
    total=Q(66,(P-3)//2) if a==Q(1,8) else Q(2+1/a**2,(P-3)//2)
    error=total+Q(P-1,P-3)*2*res
    assert error<Q(1,8)
assert 10**25*Q(7,10000)**8<1
assert 387**2<P
factor_lower=Q(7,10000)*387*Q(P-2,P-1)
assert factor_lower*Q(51,100)*Q(4,5)>Q(11,100)
assert 1/(Q(51,50)-Q(7,8))+1/(Q(51,50)-Q(1,8))<Q(81,10)
assert factor_lower*Q(51,100)*Q(40,81)>Q(68,1000)
print('Exact rational certificates: PASS; original grid cost > .11; sigma>=1.02 cost > .068')
