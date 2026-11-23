"""Independent polynomial and rational audit; no analytic-function evaluations."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import re, hashlib, json
ROOT=Path(__file__).resolve().parents[4]
A=ROOT/'work/qrh-campaign/agents'
author=A/'major-constants/WEIGHTED_STAR_HIGH_ZERO_BAND_BOUND_2026-11-11.md'
assert hashlib.sha256(author.read_bytes()).hexdigest().upper()=='DDF6E8D4F568BA7E31DA1AE5F8857166F23BCD53E39CA3C593880FEAFA833AA1'
checks={}
def ck(k,v):
    assert v,k
    checks[k]=True
pins=[]
for path,digest in re.findall(r'\| ([\w/-]+\.(?:lean|md)) \|[^\n]*?([A-F0-9]{64}) \|',author.read_text()):
    p=(ROOT/'work/ternary-goldbach/TernaryGoldbach'/path) if path.endswith('.lean') else A/path
    ck('pin:'+path,hashlib.sha256(p.read_bytes()).hexdigest().upper()==digest)
    pins.append({'path':str(p.relative_to(ROOT)),'sha256':digest})
# Dense coefficients and explicit derivative/product operations, independent of author D().
def deriv(p):return [F(i)*p[i] for i in range(1,len(p))]
def add(p,q):return [(p[i] if i<len(p) else 0)+(q[i] if i<len(q) else 0) for i in range(max(len(p),len(q)))]
def mul(p,q):
    r=[F(0)]*(len(p)+len(q)-1)
    for i,a in enumerate(p):
        for j,b in enumerate(q):r[i+j]+=a*b
    return r
def euler_exp(p):return [F(0)]+add(deriv(p),p)
p=mul([0,0,1],mul([2,-1],mul([2,-1],[2,-1])))
p1=euler_exp(p);p2=euler_exp(p1)
ck('P2',p2==[0,0,32,-68,20,17,-5,-1])
sq=mul(p2,p2)
integ=sum((a*F(2)**i/i for i,a in enumerate(sq) if i),F(0))
ck('integral',integ==F(16128,715))
ck('boundary_zero',sum(p2[i]*2**i for i in range(len(p2)))==0)
# Positive exp series tail: at n=5, subsequent ratio <=1/6.
ck('exp_one_upper',sum((F(1,factorial(n)) for n in range(5)),F(0))+F(1,factorial(5))*F(6,5)<F(11,4))
ck('exp_three_upper',F(11,4)**3<21)
ck('b_derivative',F(200,3)*F(39,2)<1600)
ck('b_second_derivative',F(200,3)*21*integ<32400)
ck('f_second_integral',220+80+4*2+12==320)
ck('Fourier_constant',2+F(2,3)+F(4,3)+F(320,36)==F(116,9))
ck('Fourier_log',F(220,36)==F(55,9))
ck('B_derivative_sign_at_one',55-2*116<0)
ck('Gaussian_integral_cap',F(22,7)*2<9) # sqrt(2pi)<3
ck('angle_cost',2*4*10==80)
# C=80D²/2401; theta=H/(2C) or1/4, switch C<=2H.
ck('angle_clipped',-F(1,4)+F(2,16)==-F(1,8))
ck('angle_free',-F(1,2)+F(1,4)==-F(1,4))
h=F(87,25)
ck('disk_window',4+(h/2)**2<9)
ck('count',4/h+F(2,1024)<2)
gram=98*(96+F(2904)/(3*h*h))
ck('Schur',gram<17500)
ck('band_constant',35000<188**2 and F(188*1920,9*2401)<17)
ck('H_log_anchor',1024>48*10)
ck('D_upper_anchor',1920*5>2401)
ck('D_lower_using_log_le_H',F(2401,1920)*1024>1)
ck('chosen_E',F(1920,320)==6)
# Geometric moment recurrence S_k=sum_{r<k} binom(k,r) S_r (k>=1).
from math import comb
S=[F(2)]
for k in range(1,4):S.append(sum(F(comb(k,r))*S[r] for r in range(k)))
ck('geometric_moments',S==[2,2,6,26])
ck('tail_coefficients',55*S[2]==330 and 55*S[3]==1430)
lower=(2*171+2*226+330)+11*(2*171+6*226+1430)
ck('closed_lower',lower==35532 and 17*lower==604044)
ck('omega_c3',F(3,2**3)+F(3,2**3)==F(3,4)>F(1,4))
ck('allocation_failure',F(302022,10**9)>F(1,10**6))
result={'scope':'Independent exact metadata/scalars only','status':'PASS','pins':pins,'checks':checks,'P2':[str(x) for x in p2],'integral':str(integ),'Schur_constant':str(gram)}
out=Path(__file__).with_suffix('.json')
if out.exists():assert json.loads(out.read_text())==result
else:
    with out.open('x',encoding='utf-8',newline='\n') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'status':'PASS','checks':len(checks),'pins':len(pins)}))
