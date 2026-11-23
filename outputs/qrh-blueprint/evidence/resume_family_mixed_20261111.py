"""Exact finite conductor arithmetic for a genuine L2-times-Linfinity mixed bound.
No finite zero exclusion or analytic Gram estimate is proved by this script.
"""
import math,json,time
from fractions import Fraction as F
from pathlib import Path
P=Path(__file__).resolve().parent; R=150000;Q=2*R; SCALE=1<<80
start=time.perf_counter()
phi=list(range(Q+1));mu=[1]*(Q+1);spf=list(range(Q+1));nprim=[1]*(Q+1)
for p in range(2,Q+1):
    if phi[p]==p:
        for n in range(p,Q+1,p):phi[n]-=phi[n]//p;mu[n]*=-1
        for n in range(p*p,Q+1,p*p):mu[n]=0
        for n in range(p*p,Q+1,p):
            if spf[n]==n:spf[n]=p
for n in range(2,Q+1):
    p=spf[n];m=n;a=0
    while m%p==0:m//=p;a+=1
    nprim[n]=nprim[m]*(p-2 if a==1 else (p-1)**2*p**(a-2))

def ceildiv(a,b):return (a+b-1)//b
def active(q):return q%2==0 or q<=R
def heights(c):
    qt=c if c%2==0 else 2*c
    return 200+max(1000,ceildiv(844800000,7*qt)),max(1000,ceildiv(844800000,343*qt))
def count(h):return ceildiv(20000*h+69600,87)
A=[0]*(Q+1);B=[0]*(Q+1);Bc2=0;Asum=0;P4=0;S4=0;chars=0;zeros_p=0;zeros_s=0;doubled_check=[0]*(Q+1)
conductor_samples=[]
for c in range(1,Q+1):
    if not active(c) or not nprim[c]:continue
    hp,hs=heights(c);np,ns=count(hp),count(hs)
    anum=c*nprim[c]*23000*np;bnum=c*nprim[c]*16*ns*ns
    Asum+=ceildiv(anum*SCALE,phi[c]);Bc2+=ceildiv(bnum*bnum*SCALE,phi[c]*phi[c])
    P4+=ceildiv(c*c*nprim[c]**2*np**3*23000*6241*SCALE,phi[c]**2*400)
    S4+=ceildiv(c*c*nprim[c]**2*ns**3*4998000*16*SCALE,phi[c]**2)
    chars+=nprim[c];zeros_p+=nprim[c]*np;zeros_s+=nprim[c]*ns
    for r in range(1,Q//c+1):
        q=c*r
        if active(q) and mu[r] and math.gcd(c,r)==1:
            A[q]+=anum;B[q]+=bnum;doubled_check[q]+=c*nprim[c]
    if c in (1,3,4,9,16,36,1000,10000,149999,300000):
        conductor_samples.append(dict(c=c,primitive_characters=nprim[c],Hplus=hp,Hstar=hs,Nplus=np,Nstar=ns))
lo=0;up=0;bins={}
for q in range(1,Q+1):
    if not active(q):continue
    assert doubled_check[q]==phi[q]*phi[q],q
    num=A[q]*B[q]*SCALE;den=phi[q]*phi[q]
    lo+=num//den;up+=ceildiv(num,den)
    k=q.bit_length()-1;bins[k]=bins.get(k,0)+ceildiv(num,den)
C=F(up,SCALE)
# From factor25 and ||W+||2<=||W+||1, a separate sufficient I bound.
# Asum/SCALE bounds sum A_c, Bc2/SCALE bounds sum B_c^2.
CI2=F(Asum*Asum*Bc2,SCALE**3)
ci=math.isqrt(CI2.numerator//CI2.denominator)
if ci*ci*CI2.denominator<CI2.numerator:ci+=1
ci4=math.isqrt((P4*S4)//(SCALE*SCALE))
if ci4*ci4*SCALE*SCALE<P4*S4:ci4+=1
XY=49*10**50;CROSSCAP=F(6975,10**10);ICAP=F(279,10**10)
tests=[]
for b in (F(1,2),F(13,25),F(53,100),F(27,50),F(11,20),F(111,200),F(14,25),F(113,200),F(57,100),F(29,50),F(59,100),F(3,5)):
    exponent=2-2*b;den=exponent.denominator;num=exponent.numerator
    cross_ok=C**den<CROSSCAP**den*XY**num
    i_ok=F(ci)**den<ICAP**den*XY**num
    i4_ok=F(ci4)**den<ICAP**den*XY**num
    tests.append(dict(beta=str(b),Cross_upper_diagnostic=float(C)*XY**(-float(exponent)),
        direct_Cross_exact_pass=cross_ok,I_upper_diagnostic=ci*XY**(-float(exponent)),
        factor25_I_exact_pass=i_ok,product_L4_I_upper_diagnostic=ci4*XY**(-float(exponent)),
        product_L4_I_exact_pass=i4_ok))
assert tests[0]['direct_Cross_exact_pass'] and tests[0]['factor25_I_exact_pass']
out=dict(source_pin='23b2d68ca344203d4384e0aff7affa4ec034bef9',
    count_per_window=400,plus_Gram_row=23000,star_pointwise_transform=4,
    coefficient_lower_num=str(lo),coefficient_upper_num=str(up),coefficient_den=str(SCALE),
    direct_coefficient_diagnostic=float(C),factor25_I_coefficient_upper=str(ci),
    product_L4_I_coefficient_upper=str(ci4),P4_coefficient_upper_diagnostic=P4/SCALE,
    S4_coefficient_upper_diagnostic=S4/SCALE,
    direct_beta_threshold_diagnostic=1+math.log(float(CROSSCAP/C))/(2*math.log(XY)),
    factor25_beta_threshold_diagnostic=1+math.log(float(ICAP/ci))/(2*math.log(XY)),
    product_L4_beta_threshold_diagnostic=1+math.log(float(ICAP/ci4))/(2*math.log(XY)),
    direct_Cross_low_cap=str(CROSSCAP),I_cap=str(ICAP),tests=tests,
    primitive_characters=chars,total_plus_count_upper=zeros_p,total_star_count_upper=zeros_s,
    conductor_samples=conductor_samples,
    coefficient_bins={str(k):v/SCALE for k,v in bins.items()},seconds=time.perf_counter()-start,
    status='Exact arithmetic certificate for sufficient implications. Uniform finite beta exclusion, analytic Gram bridges, and remaining explicit-formula errors are not proved here.')
assert C<6794*10**33
assert F(800)*(16+F(428)/(3*F(348,100)**2))<23000
assert F(800)*(72+F(1985)/(3*F(348,100)**2))<102000
assert P4<1296424*10**31*SCALE
assert S4<7010475*10**32*SCALE
assert (6794*10**33)**100 < F(1,10**9)**100*XY**89
assert ci4 < 9533388*10**31
assert ci4**100 < F(1,10**8)**100*XY**89
assert C**25 < F(26,10**8)**25*XY**21
assert count(heights(1)[1])<300000000
raw_star_L2=4998000*300000000*90000000000
assert raw_star_L2**100 < 10000**100*(10**25)**89
assert F(1,1000)+F(4,10**8)<F(2,1000)
assert 54773**2>300000*10000 and 25**2>300000*F(2,1000)
mixed_R=F(2,10**15)*54773+F(2,10**12)*25+F(4,10**27)*180000000000
assert mixed_R<F(2,10**10)
full_cross=(F(5,10000)+F(2,10**10))**2
assert full_cross<F(2501,10**10)
assert F(25,10**8)+full_cross<F(95,10**8)
out['mixed_remainder_certificate']=dict(low_plus_integral_upper='.002',low_star_integral_upper='10000',
    per_character_plus_error='2e-15',per_character_star_error='2e-12',
    rational_mixed_norm_upper=str(mixed_R),safe_norm_upper='2e-10',
    full_coprime_Cross_upper=str(full_cross),safe_Cross_upper='2.501e-7',
    scope='Uses the major-family source-based per-character high/vertical/zero0/coprime bounds and its low second moments; no J premise. Analytic bridges remain to formalize.')
(P/'resume_family_mixed_20261111.json').write_text(json.dumps(out,indent=2))
print(json.dumps(out,indent=2))
