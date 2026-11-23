"""Bounded rational-only source-scalar experiment; no spectral/prime evaluation."""
from fractions import Fraction as F
from pathlib import Path
from math import isqrt
import re, json, hashlib

ROOT=Path(__file__).resolve().parents[4]
SRC=ROOT/'work/ternary-goldbach/TernaryGoldbach'
def log_unit(x, n=80):
    assert 1<=x<=2
    z=(x-1)/(x+1)
    lo=2*sum((z**(2*k+1)/F(2*k+1) for k in range(n)),F(0))
    return lo,lo+2*z**(2*n+1)/(F(2*n+1)*(1-z*z))
L2=log_unit(F(2))
def log_bounds(x):
    assert x>=1
    k=0
    while x>=2:
        x/=2;k+=1
    a,b=log_unit(x)
    return a+k*L2[0],b+k*L2[1]
def down(x,scale=10**6):return F(x.numerator*scale//x.denominator,scale)
def up(x,scale=10**6):return F(-(-x.numerator*scale//x.denominator),scale)
def sqrt_up(x,scale=10**6):
    n=isqrt(x.numerator*scale*scale//x.denominator)
    return F(n+1,scale)
def sqrt_down(x,scale=10**6):
    return F(isqrt(x.numerator*scale*scale//x.denominator),scale)
def g_bound(Y,R):
    # All roots/logs below are rational interval witnesses, not floating evaluations.
    u=1
    while (u*10)**3<=Y:u*=10
    u=max(w*u for w in range(1,10) if (w*u)**3<=Y)
    t=F(1)
    while (1/(t/10))**6<=Y:t/=10
    # improve integer reciprocal without taking a real sixth root
    v=int(1/t)
    for w in (2*v,3*v,4*v,5*v,6*v,7*v,8*v,9*v):
        if w**6<=Y:t=F(1,w)
    a=up(log_bounds(F(2*R))[1]);b=up(log_bounds(F(8*R))[1])
    b2=down(log_bounds(F(9*u)/(F('4.008')*R))[0])
    rho=up(log_bounds(1+b/(2*b2))[1])
    lr0=log_bounds(F(R));lr=(down(lr0[0]),up(lr0[1]))
    c1=up(log_bounds(lr[1])[1]);c2=down(log_bounds(lr[0])[0])
    fr=F('1.7882')*c1+F('2.50637')/c2
    s1=sqrt_up(fr);s2=sqrt_down(F(2*R))
    ell=up(log_bounds(F(Y))[1]);sq=sqrt_up(ell)
    hf=F('.276')*t*ell*sq+1234*t*t*ell
    ga=F('1.398')*((((F('.27125')*rho+F('.41415'))*a+F('.8764'))*s1+F('2.526'))/s2+(fr*(F(13,4)*a+F('7.82'))+F('13.66')*a+F('37.55'))/R+F('3.8')*t)+F(17,3)*F(670,R)**3
    gb=F('1.398')*hf+F(17,3)*F(670,R)**3
    assert u**3<=Y and R<=F(u,6) and (1/t)**6<=Y
    return up(max(ga,gb)),dict(u=u,t=t,a=a,b=b,b2=b2,rho=rho,c1=c1,c2=c2,s1=s1,s2=s2,hf=hf)

text=(SRC/'MinorArcs/NumericsCells.lean').read_text(encoding='utf-8')
ratio=F(15015,5760)
mass=F('13.597558')-ratio*F('0.406')
assert log_bounds(F(3,2))[1]<F('.406')
assert F('2.831')**2<F('.6392')*mass
J=F('8.01')
assert (F('2.831')-F('.00020001')-F(1,10**9))**2>J+F('.0002')
rows=[]
for i in range(3,9):
    sec=text.split('theorem cell'+str(i)+' ')[1].split('end TernaryGoldbach')[0]
    Y=int(re.search(r'cell_bound \(Y := 1e(\d+)\)',sec)[1]); Y=10**Y
    get=lambda key:F(re.search(r'\('+re.escape(key)+r' := ([0-9.]+)\)',sec)[1])
    gs=[F(s.strip()) for s in re.search(r'\(fun i => \(\[([^]]+)\] : List ℝ\)',sec)[1].split(',')]
    rest=sec[re.search(r'\(fun i => \(\[([^]]+)\] : List ℝ\)',sec).end():]
    es=[F(s.strip()) for s in re.search(r'\(fun i => \(\[([^]]+)\] : List ℝ\)',rest)[1].split(',')]
    assert len(gs)==len(es)
    chain=sum((g*e for g,e in zip(gs,es)),F(0))
    G,params=g_bound(Y,100000)
    total=G*(get('cl0')*get("sD'")-J)+get("sD'")*chain+get('Gt')*get("τ'")
    selected=F('1.016')*total+F('.016')*G*J+F(1,10**20)
    rows.append(dict(cell=i,Y=Y,G=G,params=params,chain=chain,sd=get("sD'"),tail=get('Gt')*get("τ'"),minor_scalar=total,old_sig_passes=total<F('1.037'),selected_scalar=selected,passes=selected<F('1.037001')))

# Selected-energy correction is essential; cell5's old-sig pass does not survive it.
assert F('.640208')-F('.021095')/60>F('.6398')
assert F('1.016')*F('.6398')>F('.65')
G6=rows[3]['G']
assert G6<F('.067')
assert all(r['passes'] for r in rows[3:])
assert not rows[2]['passes']
asym=G6*(F('14.61155')*F('1.2947')-J)+F('1.2947')*(F('.165282706731081808')+F('.00084')+F('1.398')*F(1,10**10))+F('.00022')
asym_selected=F('1.016')*asym+F('.016')*G6*J+F(1,10**20)
assert asym_selected<F('1.037001')
Hremote=12000*350**2/F(2**125)
assert F(1,10**24)+Hremote*F('8.6294')<F(1,10**20)
assert F('1.0005')*F('1.037001')+2001*F('22.75')*F(8,10**11)<F('1.0376')
sing=lambda R:2*(F('.6606')*(1-F(1,199))-F('22.1')/R)
assert sing(100000)>F('1.314')
assert sing(75000)<F('1.314')
# Correlated new base-gap allocation at y>=1e30; m<=2q<=200000.
assert (10**30)**89*5**200>10**2800 # y^(-89/200)<5*10^-14
K=F(800)*F(193600000,7)/F('3.48')
Ecount=F(800)/F('3.48')+801
assert F(3,2)*K+448*Ecount<10**10 # W_m*N(H), using sqrt(2q)/q<=1.5
main=F('1.016')*49**2*F('5.53')/(8*100000)
gap=main+F(13,8)*10**10*F(5,10**14)+448*F(3,10**14)+(1+448)*F(2,10**9)
assert gap<F('.025')
# ghat lower from Fr>3, sqrt Fr>1.7, log(2R)>12, sqrt(2R)<448.
assert log_bounds(F(200000))[0]>12
glow=F('1.398')*((F('.41415')*12+F('.8764'))*F('1.7')+F('2.526'))/448
assert glow>F('.03')
assert 2**118<10**36<2**120
assert 2**60>2*10**16
assert F(36*10**18,83**2*10)>4*10**10 # old Johnston H fails c/epsilon domain at new endpoint
payload=dict(scope='rational scalar certificates only; no final smaller-family theorem',mass_lower=mass,prime_energy_lower=J,rows=rows,asymptotic_old_sig_upper=asym,asymptotic_selected_upper=asym_selected,singular100000=sing(100000),singular75000=sing(75000),base_gap_upper=gap,weighted_zero_count_upper=10**10,ghat_lower=glow,candidate_N=10**36,fixed_B_ladder_multiplier=10**9,new_Proth_power=60)
def encode(x):
    if isinstance(x,F):return {'num':str(x.numerator),'den':str(x.denominator),'upper_1e9':str(-(-x.numerator*10**9//x.denominator))}
    if isinstance(x,dict):return {k:encode(v) for k,v in x.items()}
    if isinstance(x,list):return [encode(v) for v in x]
    return x
out=Path(__file__).with_suffix('.json');out.write_text(json.dumps(encode(payload),indent=2)+'\n',encoding='utf-8')
print(json.dumps({'rows':[(r['cell'],str(up(r['minor_scalar'],10**6)),str(up(r['selected_scalar'],10**6)),r['passes']) for r in rows],'asym_selected':str(up(asym_selected,10**6)),'gap':str(up(gap,10**6)),'receipt_sha256':hashlib.sha256(out.read_bytes()).hexdigest().upper()}))
