"""Bounded rational tail-certificate search. No analytic or spectral values."""
from fractions import Fraction as Q
from pathlib import Path
from math import factorial
import hashlib,json

HERE=Path(__file__).resolve().parent
checks=0
def ck(v):
    global checks
    assert v
    checks+=1
def exp_negative_upper(x):
    assert x>=0
    # exp(x/16) exceeds this positive Taylor polynomial.
    term=Q(1); total=term
    for j in range(1,25):
        term=term*(x/16)/j
        total+=term
    return 1/total**16
def upper_scaled(v,scale=10**9):
    v*=scale
    return (v.numerator+v.denominator-1)//v.denominator
def atan_bounds(q,n):
    s=sum((-1)**j*Q(1,q)**(2*j+1)/(2*j+1) for j in range(n))
    t=s+(-1)**n*Q(1,q)**(2*n+1)/(2*n+1)
    return min(s,t),max(s,t)

pL=Q(157,50);pU=Q(22,7);C=265800;delta=Q(5,64);B=Q(32,5);V=7000
a,b=atan_bounds(5,10);c,d=atan_bounds(239,3)
ck(16*a-4*d>pL);ck(16*b-4*c<pU)
ck(sum(Q(1,j*j) for j in range(1,9))+Q(1,8)<Q(5,3))
ck(sum(Q(1,j**3) for j in range(1,5))+Q(1,32)<Q(5,4))
ck(Q(5000)**4>(C/pL)**3)
ck(Q(1500000)**4>(C/pL)**5)
ck(Q(28)**16>(C/(2*pL))**5)
ck(Q(6,5)**4>2);ck(Q(9,5)**2>pU);ck(Q(5,4)**6>3)
ck(Q(6,5)*Q(9,5)*Q(5,4)<6)
ck(2*pU<Q(18,7)**2);ck(pU/8+Q(1,4)<Q(3,4))
ck(Q(7,3)**4>27);ck(Q(18,7)*Q(7,3)==6)
ck(6*9*28==1512)
ck(2*pL>Q(5,2)**2);ck(Q(7,5)**2<2)

budget=Q(1,2**46)
def tails(h,m):
    P=h*pU*(V+Q(2,5)*h+1+Q(5,14))
    fs=[]
    for M,power,zeta in [(Q(3,2),5000,Q(5,3)),(Q(5,2),1500000,Q(5,4))]:
        x=2*pL*B*M-M*M/(2*h*h)
        ck(x>0)
        fs.append(2*power*zeta*P/(pL*M)*exp_negative_upper(x))
    z=m*delta
    # The polynomial ratio is largest at t0=0; the numerator at t0=V.
    ratio=(1+delta/(2+z))*exp_negative_upper((2*z*delta+delta*delta)/(2*h*h))
    ck(z*(2+z)>=h*h);ck(ratio<1)
    sample=3024*(2+V+z)*exp_negative_upper(z*z/(2*h*h))/(1-ratio)
    return max(fs),sample,ratio

rows=[]
for hnum in range(300,401):
    h=Q(hnum,1000)
    passing=[]
    # Recompute only scalar tail inequalities, never function samples.
    for m in range(36,65):
        f,s,r=tails(h,m)
        if f+s<budget:
            passing.append(m)
    if passing:
        m=min(passing);f,s,r=tails(h,m)
        rows.append({'h':str(h),'m':m,'TF_fraction_of_budget_upper_billionths':upper_scaled(f/budget),
                     'TS_fraction_of_budget_upper_billionths':upper_scaled(s/budget),
                     'total_fraction_of_budget_upper_billionths':upper_scaled((f+s)/budget)})
ck(bool(rows))
best_m=min(row['m'] for row in rows)
best=[row for row in rows if row['m']==best_m]
# Keep a simple rational candidate alongside the smallest passing grid length.
named=[]
for h,m in [(Q(1,3),48),(Q(13,40),42),(Q(8,25),42)]:
    f,s,r=tails(h,m)
    named.append({'h':str(h),'m':m,'passes':f+s<budget,
                  'TF_fraction_of_budget_upper_billionths':upper_scaled(f/budget),
                  'TS_fraction_of_budget_upper_billionths':upper_scaled(s/budget),
                  'total_fraction_of_budget_upper_billionths':upper_scaled((f+s)/budget)})
pins={
'LARGE_BRANCH_WINDOW_INTERPOLATION_ROUTE_2026-11-11.md':'DA67CB3B463FED71B6545CD13DF374B7713924DFA92C44B37E83862FBA4CCE69',
'../major-constants/REVIEW_LARGE_BRANCH_WINDOW_INTERPOLATION_ROUTE_2026-11-11.md':'873F9A0A15D77D5F90032139F42B29329F812C370FD122716504A207E6828AEF'}
for p,h in pins.items():ck(hashlib.sha256((HERE/p).read_bytes()).hexdigest().upper()==h)
out={'scope':'conditional analytic tail certificates only','checks':checks,
     'search':{'h_numerator': [300,400],'h_denominator':1000,'m':[36,64]},
     'threshold':'2^-46','sample_envelope':'1512*(2+abs(t))','exp_upper':'1/(sum_j=0..24 (x/16)^j/j!)^16',
     'smallest_passing_m_in_grid':best_m,'best_rows':best,'minimum_rows_by_h':rows,'named_candidates':named,'pins':pins}
with HERE.joinpath('shorter_large_branch_windows_20261111.json').open('x',encoding='utf8',newline='\n') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'smallest_passing_m':best_m,'best':best,'named':named}))
