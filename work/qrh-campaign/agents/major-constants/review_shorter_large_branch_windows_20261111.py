"""Independent bounded rational certificates; no author imports or analytic values."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import hashlib,json
HERE=Path(__file__).resolve().parent
AG=HERE.parent
checks=0
def ck(p):
    global checks
    assert p
    checks+=1
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
pins={
 'audit/SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md':'32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E',
 'audit/shorter_large_branch_windows_20261111.py':'7C51A4655CE47873A3352BB8BE74EE9FB8A371A4F38365A1CFFA91564C005FA4',
 'audit/shorter_large_branch_windows_20261111.json':'745A2EF89CF23580562D76DDAD5D4C6EB57CC4F1C4FA50329148021745953A41',
 'audit/LARGE_BRANCH_WINDOW_INTERPOLATION_ROUTE_2026-11-11.md':'DA67CB3B463FED71B6545CD13DF374B7713924DFA92C44B37E83862FBA4CCE69',
 'major-constants/REVIEW_LARGE_BRANCH_WINDOW_INTERPOLATION_ROUTE_2026-11-11.md':'873F9A0A15D77D5F90032139F42B29329F812C370FD122716504A207E6828AEF'}
for rel,h in pins.items():ck(digest(AG/rel)==h)
target=json.loads((AG/'audit/shorter_large_branch_windows_20261111.json').read_text())

def atan_even_odd(q):
    # Independent 12-term lower / 13-term upper alternating bounds.
    low=sum((Q((-1)**j,(2*j+1)*q**(2*j+1)) for j in range(12)),Q(0))
    return low,low+Q(1,25*q**25)
l5,u5=atan_even_odd(5);l239,u239=atan_even_odd(239)
piL,piU=Q(157,50),Q(22,7)
ck(16*l5-4*u239>piL and 16*u5-4*l239<piU)
ck(sum(Q(1,n*n) for n in range(1,6))+Q(1,5)<Q(5,3))
ck(sum(Q(1,n**3) for n in range(1,4))+Q(1,18)<Q(5,4))
C=265800;D=Q(5,64);band=Q(32,5)
ck(Q(5000)**4>(C/piL)**3)
ck(Q(1500000)**4>(C/piL)**5)
ck(Q(28)**16>(C/(2*piL))**5)
ck(Q(6,5)**4>2 and Q(9,5)**2>piU and Q(5,4)**6>3)
ck(Q(6,5)*Q(9,5)*Q(5,4)<6)
ck(Q(18,7)**2>2*piU)
ck(piU/8+Q(1,4)<Q(3,4) and Q(7,3)**4>27)
ck(Q(18,7)*Q(7,3)==6 and 6*9*28==1512)
ck(Q(5,2)**2<2*piL and Q(7,5)**2<2)
ck(target['search']=={'h_numerator':[300,400],'h_denominator':1000,'m':[36,64]})

def poly(t,degree):
    # Horner form, independent of the author's term-by-term accumulation.
    value=Q(1,factorial(degree))
    for i in reversed(range(degree)):value=value*t+Q(1,factorial(i))
    return value
def negexp(x):
    ck(x>0)
    return Q(1)/poly(x/16,24)**16
def direct_negexp(x):
    ck(x>0)
    return Q(1)/poly(x,192)
def fourier(h,upper):
    pbar=piU*h*(7001+Q(5,14)+Q(2,5)*h)
    parts=[]
    for M,cap,zeta in [(Q(3,2),5000,Q(5,3)),(Q(5,2),1500000,Q(5,4))]:
        E=2*piL*band*M-M*M/(2*h*h)
        parts.append(2*cap*zeta*pbar/(piL*M)*upper(E))
    return max(parts),parts
def sample(h,m,upper):
    z=m*D
    ck(z*(2+z)>=h*h)
    ratio=(2+z+D)/(2+z)*upper((z*D+D*D/2)/(h*h))
    ck(ratio<1)
    result=3024*(7002+z)*upper(z*z/(2*h*h))/(1-ratio)
    return result,ratio
budget=Q(1,2**46)
def billion(x):
    x=x/budget*10**9
    return -(-x.numerator//x.denominator)
def row(h,m,f,s):
    return {'h':str(h),'m':m,'TF_fraction_of_budget_upper_billionths':billion(f),
            'TS_fraction_of_budget_upper_billionths':billion(s),
            'total_fraction_of_budget_upper_billionths':billion(f+s)}
mins=[];matrix=[]
for hn in range(300,401):
    h=Q(hn,1000);f,_=fourier(h,negexp);accepted=[]
    for m in range(36,65):
        s,r=sample(h,m,negexp)
        passes=f+s<budget
        matrix.append([hn,m,passes])
        if passes:accepted.append(row(h,m,f,s))
    if accepted:mins.append(accepted[0])
ck(mins==target['minimum_rows_by_h'])
best=min(x['m'] for x in mins)
bestrows=[x for x in mins if x['m']==best]
ck(best==target['smallest_passing_m_in_grid']==41)
ck(bestrows==target['best_rows'])
for ref in target['named_candidates']:
    h=Q(ref['h']);m=ref['m']
    f,_=fourier(h,negexp);s,r=sample(h,m,negexp)
    got=row(h,m,f,s);got['passes']=f+s<budget
    ck(got==ref)

# Separate proof of two useful accepted pairs using an unscaled degree-192
# positive Taylor polynomial rather than the author's scaled degree-24 power.
selected=[]
for h,m in [(Q(159,500),41),(Q(8,25),41),(Q(13,40),42),(Q(1,3),48)]:
    f,parities=fourier(h,direct_negexp);s,r=sample(h,m,direct_negexp)
    ck(f+s<budget)
    guard=Q(424195,64)+(m+1)*D
    ck(guard<7000)
    selected.append(dict(h=str(h),m=m,samples=2*m+1,guard=str((m+1)*D),
                         max_target_plus_guard=str(guard),
                         total_upper_billionths=billion(f+s),
                         Fourier_upper_billionths=billion(f),sample_upper_billionths=billion(s),
                         ratio_upper=str(r),reserve_lower_billionths=10**9-billion(f+s)))
out={'scope':'Independent exact scalar search replay and selected-pair certificate; no values/sign success.',
     'pins':pins,'checks':checks,'tests':len(matrix),'passing_tests':sum(r[2] for r in matrix),
     'minimum_rows':mins,'best_m':best,'best_rows':bestrows,'independent_direct_Taylor_selected':selected,
     'search_status_sha256':hashlib.sha256(json.dumps(matrix,separators=(',',':')).encode()).hexdigest().upper(),
     'global_optimum':False,'actual_guard_samples_produced':False}
path=HERE/'review_shorter_large_branch_windows_20261111.json'
with path.open('x',encoding='utf-8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':digest(path),'selected':[{k:v for k,v in x.items() if k!='ratio_upper'} for x in selected]},indent=2))
