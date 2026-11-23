"""Original finite-RH envelope: coarse cutoff search and one refinement only."""
from fractions import Fraction as F
from pathlib import Path
from math import isqrt
import re,json,hashlib
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
SRC=ROOT/'work/ternary-goldbach/TernaryGoldbach'
def unitlog(x):
    assert 1<=x<=2
    z=(x-1)/(x+1);n=80
    lo=2*sum((z**(2*k+1)/F(2*k+1) for k in range(n)),F(0))
    return lo,lo+2*z**(2*n+1)/(F(2*n+1)*(1-z*z))
L2=unitlog(F(2))
def logb(x):
    k=0
    while x>=2:x/=2;k+=1
    a,b=unitlog(x);return a+k*L2[0],b+k*L2[1]
def lo(x):return F(x.numerator*10**7//x.denominator,10**7)
def hi(x):return F(-(-x.numerator*10**7//x.denominator),10**7)
def nthroot(n,k):
    l,h=0,1
    while h**k<=n:h*=2
    while h-l>1:
        m=(l+h)//2
        if m**k<=n:l=m
        else:h=m
    assert l**k<=n<(l+1)**k
    return l
def sqbounds(x):
    v=isqrt(x.numerator*10**14//x.denominator)
    return F(v,10**7),F(v+1,10**7)
def ghat(Y,R):
    u=nthroot(Y,3);t=F(1,nthroot(Y,6))
    assert Y>=10**25 and R>=670 and 6*R<=u
    a=hi(logb(F(2*R))[1]);b=hi(logb(F(8*R))[1])
    b2=lo(logb(F(9*u)/(F('4.008')*R))[0]);rho=hi(logb(1+b/(2*b2))[1])
    lr=logb(F(R));c1=hi(logb(hi(lr[1]))[1]);c2=lo(logb(lo(lr[0]))[0])
    assert b2>0 and c2>0
    fr=F('1.7882')*c1+F('2.50637')/c2
    s1=sqbounds(fr)[1];s2=sqbounds(F(2*R))[0]
    ell=hi(logb(F(Y))[1]);sq=sqbounds(ell)[1]
    hf=F('.276')*t*ell*sq+1234*t*t*ell
    main=F('1.398')*((((F('.27125')*rho+F('.41415'))*a+F('.8764'))*s1+F('2.526'))/s2+(fr*(F(13,4)*a+F('7.82'))+F('13.66')*a+F('37.55'))/R+F('3.8')*t)+F(17,3)*F(670,R)**3
    return hi(max(main,F('1.398')*hf+F(17,3)*F(670,R)**3))

text=(SRC/'MinorArcs/NumericsCells.lean').read_text(encoding='utf-8')
cells=[]
for i in range(9):
    start=re.search(r'^theorem cell'+str(i)+r'\s',text,re.M)
    assert start is not None
    nextdecl=re.search(r'^theorem\s',text[start.end():],re.M)
    end=len(text) if nextdecl is None else start.end()+nextdecl.start()
    sec=text[start.start():end]
    matches=re.findall(r'cell_bound \(Y := ([0-9]+(?:\.[0-9]+)?e[0-9]+)\)',sec)
    assert len(matches)==1
    Yq=F(matches[0]);assert Yq.denominator==1
    Y=Yq.numerator
    assert Y==(10**25,3*10**25,10**26,10**27,10**28,10**30,10**34,10**42,10**58)[i]
    get=lambda key:F(re.search(r'\('+re.escape(key)+r' := ([0-9.]+)\)',sec)[1])
    match=re.search(r'\(fun i => \(\[([^]]+)\] : List ℝ\)',sec)
    gs=[F(s.strip()) for s in match[1].split(',')]
    es=[F(s.strip()) for s in re.search(r'\(fun i => \(\[([^]]+)\] : List ℝ\)',sec[match.end():])[1].split(',')]
    assert len(gs)==len(es)
    cells.append(dict(cell=i,Y=Y,Y_literal=matches[0],source_start_line=text.count('\n',0,start.start())+1,source_section_sha256=hashlib.sha256(sec.encode('utf-8')).hexdigest().upper(),chain=sum((g*e for g,e in zip(gs,es)),F(0)),sd=get("sD'"),tail=get('Gt')*get("τ'"),cl=get('cl0')))

# The original per-modulus major error with the original J<=8.79 upper bound.
major_error=(F('3.67e-6')+49*F('8.85e-7')/9)*F('8.79')+(F(9,2)*F('8.85e-7')*F('7.78')+49*F('2.03e-5'))*F('2.85')+49*F('8.85e-7')/9*F('.640208')*F('13.59756')
nonprime=F('.00271')
def evaluate_cutoff(R):
    assert R%2==0 and 100000<=R<=150000
    mass=F('13.597558')-F(15015,5760)*hi(logb(F(150000,R))[1])
    jfull=(F('.63907')-F('.000962'))*mass-F('3.6e-9')*300000
    j=(jfull-(1+10**5)*F(8,10**11))/(1+F(1,10**5))
    sing=2*(F('.6606')*(1-F(1,199))-F('22.1')/R)
    major=sing*F('.800689')-major_error
    estimates=[]
    for c in cells:
        G=ghat(c['Y'],R)
        U=G*(c['cl']*c['sd']-j)+c['sd']*c['chain']+c['tail']
        minor=F('1.0005')*U+2001*F('22.75')*F(8,10**11)
        estimates.append(dict(cell=c['cell'],Y=c['Y'],G=G,Mexpr_upper=U,minor_upper=minor,margin=major-minor-nonprime))
    Ga=ghat(10**58,R)
    Ua=Ga*(F('14.61155')*F('1.2947')-j)+F('1.2947')*(F('.165282706731081808')+F('.00084')+F('1.398e-10'))+F('.00022')
    minora=F('1.0005')*Ua+2001*F('22.75')*F(8,10**11)
    gap=F('1.016')*49**2*F('5.53')/(8*R)+548*(F('1.4874e-6')+F('2e-9'))+F('2e-9')
    checks=dict(major=major>F('1.049'),finite_minor=all(e['minor_upper']<F('1.0376') for e in estimates),asymptotic_minor=minora<F('1.0376'),basegap=gap<F('.014'),positive_mass=mass>0,positive_J=jfull>0,positive_I=j>0,positive_singular=sing>0,base_coefficients=all(c['cl']*c['sd']-j>0 for c in cells),asymptotic_base=F('14.61155')*F('1.2947')-j>0)
    return dict(R=R,mass_lower=mass,J_lower=jfull,I_lower=j,singular_lower=sing,major_lower=major,major_target_reserve=major-F('1.049'),basegap_upper=gap,cells=estimates,asymptotic_minor=minora,asymptotic_margin=major-minora-nonprime,minor_target_reserve=F('1.0376')-max([e['minor_upper'] for e in estimates]+[minora]),checks=checks,passes=all(checks.values()))

coarse=[]
for R in range(140000,99999,-1000):
    result=evaluate_cutoff(R);coarse.append(result)
    if not result['passes']:break
assert len(coarse)>=2 and not coarse[-1]['passes'] and coarse[-2]['passes']
refinement=[]
for R in range(coarse[-2]['R']-100,coarse[-1]['R'],-100):
    result=evaluate_cutoff(R);refinement.append(result)
    if not result['passes']:break
rows=coarse+refinement
best=min(r['R'] for r in rows if r['passes'])
def enc(v):
    if isinstance(v,F):return dict(num=str(v.numerator),den=str(v.denominator),ceil_1e7=str(-(-v.numerator*10**7//v.denominator)))
    if isinstance(v,dict):return {k:enc(x) for k,x in v.items()}
    if isinstance(v,list):return [enc(x) for x in v]
    return v
ghat_lower=F('1.398')*((F('.41415')*12+F('.8764'))*F('1.7')+F('2.526'))/548
assert ghat_lower>F('.03')
N0=989*10**24
assert F(989,490)*F(49,10)*10**26==N0
assert F(69,10)**32<N0 and F(264,100)**64<N0 and 10**26<N0
out=dict(scope='unchanged original finite-RH envelope; 1000 coarse grid then one 100 refinement',source_cells_sha256=hashlib.sha256((SRC/'MinorArcs/NumericsCells.lean').read_bytes()).hexdigest().upper(),parsed_cells=cells,major_error=major_error,nonprime_allowance=nonprime,ghat_lower=ghat_lower,N0=N0,coarse_step=1000,refinement_step=100,best_demonstrated_R=best,rows=rows)
path=Path(__file__).with_suffix('.json');path.write_text(json.dumps(enc(out),indent=2)+'\n')
for r in rows:
    print(r['R'],r['passes'],'I',hi(r['I_lower']),'major',hi(r['major_lower']),'worst margin',hi(min(e['margin'] for e in r['cells'])), 'minor0',hi(r['cells'][0]['minor_upper']))
print('SHA256',hashlib.sha256(path.read_bytes()).hexdigest().upper())
