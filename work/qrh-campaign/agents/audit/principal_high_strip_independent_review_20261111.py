"""Independent exact scalar enclosure. No author imports; frozen data read-only."""
from fractions import Fraction as Q
from decimal import Decimal,localcontext
from pathlib import Path
import hashlib,json
BASE=Path(__file__).resolve().parent;P=BASE.parent/'major-constants'
pins={'PRINCIPAL_HIGH_STRIP_REFINEMENT_2026-11-11.md':'b5ba5316102ab6aa303b30929b3e10020526f6a17c2d8d560c24b4ac65c6c47d','principal_high_strip_refinement_20261111.py':'542867e6669fd724bb1ac34fe778a94c9f0b608b934aa20e2cab41bb2557f3e9','principal_high_strip_refinement_20261111.json':'cea7698dbfe4d70a74e6ee7c65cdca2a460608a03590c6e076c2cd7852fa561b'}
for n,h in pins.items():assert hashlib.sha256((P/n).read_bytes()).hexdigest()==h

def atan(x,n=80):
    s=sum(((-1)**k*x**(2*k+1)/Q(2*k+1) for k in range(n)),Q(0))
    v=(-1)**n*x**(2*n+1)/Q(2*n+1)
    return min(s,s+v),max(s,s+v)

def expbox(x,n=170):
    assert 0<=x<n+2
    term=total=Q(1)
    for k in range(1,n+1):term=term*x/k;total+=term
    return total,total+term*x/(n+1)/(1-x/(n+2))

def logbox(xlo,xhi):
    assert 1<xlo<=xhi
    # Decimal computes a proposed box only; the following rational exp
    # inequalities are the sole acceptance checks for the logarithm.
    with localcontext() as c:
        c.prec=60
        d=(Decimal(xlo.numerator)/Decimal(xlo.denominator)).ln()
        seed=Q(int(d*10**34),10**34)
    lo,hi=seed-Q(1,10**33),seed+Q(1,10**33)
    assert expbox(lo)[1]<xlo and xhi<expbox(hi)[0]
    return lo,hi
al,au=atan(Q(1,5));bl,bu=atan(Q(1,239))
pl,pu=16*al-4*bu,16*au-4*bl
assert Q('3.141592653589793238462643383279')<pl<pu<Q('3.141592653589793238462643383280')
la,ua=logbox(Q(1500),Q(1500));lt,ut=logbox(Q(10**6),Q(10**6));lc,uc=logbox(2*pl,2*pu)
A,T,NA=1500,10**6,1069
assert 0<la-uc-1 and 0<lt-uc-(ua-lc)
# Enclose each positive piece before combining exact signed endpoint terms.
hlo=((lt-uc)**2-(ua-lc)**2)/(4*pu)+(la-uc-1)/(2*pu)+Q(7,8*A)+(5*la+25)/A-Q(5,T)-Q(NA,A)
hhi=((ut-lc)**2-(la-uc)**2)/(4*pl)+(ua-lc-1)/(2*pl)+Q(7,8*A)+(5*ua+25)/A-Q(5,T)-Q(NA,A)
assert Q('9.072023958327')<hlo<hhi<Q('9.072023958328')
low=2*(Q(417,250)+Q(1069,1500));assert low==Q(3571,750)

def model(d):
    el,eu=expbox(35*d)
    return low+(1+el)*hlo,low+(1+eu)*hhi

def ceil12(x):return Q(-((-x.numerator*10**12)//x.denominator),10**12)
rows=[]
for d,cap in [(Q(1,400),Q('23.735')),(Q(3,1000),Q('23.910')),(Q(2,625),Q('23.980532761132')),(Q(13,4000),Q('23.998305865133'))]:
    lo,hi=model(d)
    assert lo<hi<cap<24
    assert Q(49,100)<Q(1,2)-d<Q(1,2)+d<Q(51,100)
    rows.append({'delta':str(d),'conservative_model_upper_ceil12':str(ceil12(hi)),'checked_strict_cap':str(cap),'margin_lower_floor12':str(-ceil12(hi-24))})
assert model(Q('0.00325476'))[1]<24<model(Q('0.00325477'))[0]
# Algebraic endpoint identities tested symbolically by their antiderivatives
# in the review; script only handles the exact constants.
result={'status':'PASS independent exact scalar bounds; high strip unproved; no Lean','method':'Machin 80 terms; log hints accepted only by rational degree170 exp bounds','low_head_cap':str(low),'high_model_enclosure':['9.072023958327','9.072023958328'],'rows':rows,'model_crossing_interval':['.00325476','.00325477'],'exact_N_T_used':False,'producer_pins':pins,'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(BASE/'principal_high_strip_independent_review_20261111.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
