"""Full-family second moment scalar model; no spectral certificate is asserted."""
from fractions import Fraction as F
from math import gcd,log,ceil
import json
from pathlib import Path
R=150000; M=2*R; scale=10**12
phi=list(range(M+1)); mu=[1]*(M+1); spf=list(range(M+1))
for p in range(2,M+1):
    if spf[p]==p:
        for n in range(p,M+1,p):
            phi[n]-=phi[n]//p;mu[n]*=-1
            if spf[n]==n: spf[n]=p
        for n in range(p*p,M+1,p*p): mu[n]=0
prim=[0]*(M+1);prim[1]=1
for n in range(2,M+1):
    p=spf[n];v=n;e=0
    while v%p==0:v//=p;e+=1
    prim[n]=prim[v]*((p-2) if e==1 else p**(e-2)*(p-1)**2)
def ceiling(f):return (f.numerator+f.denominator-1)//f.denominator
def updiv(a,b):return (a*scale+b-1)//b
Hp=[0]*(M+1);Hs=[0]*(M+1);Np=[0]*(M+1);Ns=[0]*(M+1)
active=[]
for c in range(1,M+1):
    if (c%2 and c>R) or not prim[c]:continue
    active.append(c);qt=c*(2 if c%2 else 1)
    Hp[c]=200+max(1000,ceiling(F(704*1200000,7*qt)))
    Hs[c]=max(1000,ceiling(F(704*1200000,343*qt)))
    Np[c]=ceiling(400*(F(50*Hp[c],87)+2))
    Ns[c]=ceiling(400*(F(50*Hs[c],87)+2))
# Integer numerators accumulated at each q, exact induction indicator.
numPA=[0]*(R+1);numSA=[0]*(R+1);numN=[0]*(M+1)
for c in active:
    if c%2 and mu[c]:
        for r in range(c,R+1,2*c):
            if mu[r]:
                numPA[r]+=2*c*prim[c]*Np[c]
                numSA[r]+=2*c*prim[c]*Ns[c]
    if c>1:
        for q in range(c,M+1,c):
            if q%2 and q>R:continue
            r=q//c
            if mu[r] and gcd(c,r)==1:
                numN[q]+=c*prim[c]*Np[c]
SPA=F(sum(updiv(numPA[r],phi[r]**3) for r in range(1,R+1,2) if mu[r]),scale)
SSA=F(sum(updiv(numSA[r],phi[r]**3) for r in range(1,R+1,2) if mu[r]),scale)
SN=F(sum(updiv(numN[q],phi[q]) for q in range(1,M+1) if numN[q]),scale)
Cplus=F('1.2534')**2*23000*SPA
# P<=130 is the directly available uniform Gaussian source envelope.
Cstar130=130**2*49*102000*SSA
Cstar2=4*49*102000*SSA
CN=23000*SN
x0=49*10**25;y0=10**25
out={'status':'conditional scalar family model; finite zero locations NOT certified','active_conductors':len(active),'primitive_characters':sum(prim[c] for c in active),'weighted_count_plus_upper_exact':str(SPA),'weighted_count_star_upper_exact':str(SSA),'N_weighted_count_upper_exact':str(SN),'coefficients':{k:str(v) for k,v in [('Aplus',Cplus),('Astar_P130',Cstar130),('Astar_P2',Cstar2),('N',CN)]}}
for k,C,z,cap in [('Aplus',Cplus,x0,5e-7),('Astar_P130',Cstar130,y0,2.5e-7),('Astar_P2',Cstar2,y0,2.5e-7),('N',CN,x0,1.23)]:
    out[k]={'at_beta_half_diagnostic':float(C)/z,'beta_threshold_diagnostic':1+log(cap/float(C))/(2*log(z))}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
# Actual smoothing improvement, proved in the note from the Fourier-tail bridge.
Pcap=F(32,35)+F('.00221')
assert Pcap<F('.917')<1
Cstar=Pcap**2*49*102000*SSA
Rstar=F('1.2e-6');Rp=F('2e-9')
from math import factorial
def elo(z,n=350):return sum((z**j/factorial(j) for j in range(n)),F(0))
eup=F('2.7182818286')
assert eup**61<x0
assert eup**1439<y0**25 # log y0>57.56
b=F(111,200);power=2*(1-b)
# Safe round proof targets including norm perturbation.
assert elo(61*power)>Cplus/F('.00007')**2
assert (F('.00007')+Rp)**2<F('5e-7')
assert elo(F(1439,25)*power)>Cstar/F('.00049')**2
assert (F('.00049')+Rstar)**2<F('2.5e-7')
assert elo(61*power)>CN/F('.001')
# Principal energy: W(delta)<14 and source finite nontrivial-zero count at c=1.
CEp=14*23000*Np[1]
assert elo(61*power)>CEp/F('.0002')**2
assert (F('.0002')+F('1e-8'))**2<F('1e-4')
# Larger safe rational beta for the same inequalities, with full remainder reserve.
b_sharp=F(5573,10000)
assert elo(F(1439,25)*2*(1-b_sharp))>Cstar/(F('.0005')-Rstar)**2
# Actual constants for uniform normalized contour+zero0 remainder<1e-18.
assert elo(F(150))>512*300000**9*300001/F('.355')
assert F('.28')/600001>F('4e-7')
assert F('.28')/(F(600000,49)+1)>F('2e-5')
Vp=106000*8*(187*2/F('4e-7')+F('2.6')*2/F('4e-7')**2)
Vs=900*8*(187*2/F('2e-5')+F('2.6')*2/F('2e-5')**2)
assert Vp/F(10**39)+400*39000/F(x0)<F('1e-18')
# y^-3/2 <4e-38 because y>=1e25 and sqrt(y)>2.5e12.
assert Vs*F('4e-38')+400*600/F(y0)<F('1e-18')
assert 2*400*(16+F(428)/(3*F('3.48')**2))<23000
assert 2*400*(4*18+F(1985)/(3*F('3.48')**2))<102000
assert 18*(1+4*F(19,4)*F(23,4))<1985
assert 130**2*49*102000*SSA/F(y0)>27*F('2.5e-7')
out['actual_P_cap_exact']=str(Pcap)
out['Astar_actual_P']={'coefficient_exact':str(Cstar),'at_beta_half_diagnostic':float(Cstar)/y0,'beta_threshold_with_remainder_diagnostic':1+log(float((F('.0005')-Rstar)**2/Cstar))/(2*log(y0))}
out['safe_common_beta']='111/200'
out['sharper_safe_beta_Astar']='5573/10000'
out['exact_checks']='PASS: all scalar comparisons including norm remainders; analytic lemmas and finite spectra remain unproved'
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print('UPDATED',json.dumps({k:out[k] for k in ['actual_P_cap_exact','Astar_actual_P','safe_common_beta','sharper_safe_beta_Astar','exact_checks']},indent=2))

# Independent finite arithmetic consistency: primitive Gauss norms sum to phi(q)^2.
gauss=[0]*(M+1)
for c in active:
    for q in range(c,M+1,c):
        if q%2 and q>R:continue
        r=q//c
        if mu[r] and gcd(c,r)==1:gauss[q]+=c*prim[c]
assert all(gauss[q]==phi[q]**2 for q in range(1,M+1) if q%2==0 or q<=R)
assert elo(61*2*(1-b_sharp))>Cplus/F('.00008')**2
assert elo(61*2*(1-b_sharp))>CN/F('.001')
assert elo(61*2*(1-b_sharp))>CEp/F('.0002')**2
print('GAUSS_IDENTITY_AND_COMMON_BETA_5573_10000_PASS')

# Full finite-zero to coprime mixed norm perturbation at selected b=111/200.
assert ceiling(400*(F(2*1_300_000)/F('3.48')+2))<300_000_000
star_total_coeff=9*10**10*49*102000*300_000_000
assert elo(F('57.5')*F('.89'))>F(star_total_coeff,10000)
assert F('.001')+F('.0002')**2<F('.002')
assert 55000**2>300000*10000
assert 25**2>300000*F('.002')
assert (18*10**10)**2==324*10**20
Rmix=F('2e-15')*55000+F('2e-12')*25+F('2e-15')*F('2e-12')*(18*10**10)
assert Rmix<F('2e-10')
out['mixed_remainder_norm_upper_exact']=str(Rmix)
out['mixed_remainder_safe_cap']='2e-10'
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print('MIXED_REMAINDER_PASS',str(Rmix),float(Rmix))
