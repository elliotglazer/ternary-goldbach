"""Exact sufficient tail/profile arithmetic; no zeros or runtime are certified."""
from fractions import Fraction as F
from math import factorial,log,pi
from pathlib import Path
import json
M=300000;R=150000
spf=list(range(M+1));prim=[0]*(M+1);prim[1]=1
for p in range(2,M+1):
    if spf[p]==p:
        for n in range(p,M+1,p):
            if spf[n]==n:spf[n]=p
for n in range(2,M+1):
    p=spf[n];v=n;a=0
    while v%p==0:v//=p;a+=1
    prim[n]=prim[v]*((p-2) if a==1 else p**(a-2)*(p-1)**2)
def ceil(f):return (f.numerator+f.denominator-1)//f.denominator
def elo(z,n=350):return sum((z**j/factorial(j) for j in range(n)),F(0))
def count(H):return ceil(400*(F(50*H,87)+2))
# G=max denominator bound can be replaced by3+d/2.7 for BOTH rhoA and rhoB.
# H>=250 and H>=69*d imply G/H<1/39: split d<=4 or d>=4.
assert 39*(3+F(4)/F('2.7'))<250
assert 39*(F(3,4)+1/F('2.7'))<69
assert 800+F(106,39)<803
assert 803*(3+F(600000)/F('2.7'))<180_000_000
assert 803*(3+F(600000,49)/F('2.7'))<4_000_000
assert F(484,7)>69
# Source base-height condition; pi<22/7 and 22*pi factor.
assert F(484,7)==22*F(22,7)
assert 803/(22*F('3.14')*F('2.7'))<5
assert 803*3<2500
assert F(2,250)<F('.1598') # t(5t+2500)e^(-.1598t) decreasing after250
assert elo(F('.1065')*22**2)>F('.588')*22**2/F('2e-20')
EBp=130*F('.892')*300*(5*300+2500)
EBs=2*F('.892')*250*(5*250+2500)
assert elo(F('.1598')*300)>EBp/F('4e-13')
assert elo(F('.1598')*250)>EBs/F('1e-11')
assert 2125**8<49*10**25
assert 1333**8<10**25
assert (130*180_000_000*F('2e-20')+F('4e-13'))/2125<F('3e-13')
assert (2*4_000_000*F('2e-20')+F('1e-11'))/1333<F('1e-14')
assert F('3e-13')+F('1e-15')+F('1e-18')<F('4e-13')
assert F('1e-14')+F('1e-12')+F('1e-18')<F('2e-12')
# Unchanged reviewed low bounds; enlarged norm perturbations still close all caps.
assert 900000**2>720000000000
assert (F('.00007')+F('4e-13')*900000)**2<F('5e-7')
assert (F('.00049')+F('2e-12')*600000)**2<F('2.5e-7')
assert (F('.0002')+F('3e-7'))**2<F('1e-4')
rmix=F('4e-13')*55000+F('2e-12')*25+F('4e-13')*F('2e-12')*180000000000
assert rmix<F('3e-8')
assert (F('.0005')+F('3e-8'))**2<F('7e-7') # low Cross<2.5e-7
stats={k:{'weighted_height':0,'count_proxy':0,'max_height':0,'diagnostic_count_proxy':0.} for k in ['old_plus','new_plus','old_star','new_star','platt_same_active']}
rows=[]; nc=0;chars=0
for c in range(1,M+1):
    if (c%2 and c>R) or not prim[c]:continue
    nc+=1;chars+=prim[c];qt=2*c if c%2 else c;D=F(1200000,qt)
    oldp=200+max(1000,ceil(F(704,7)*D)); olds=max(1000,ceil(F(704,343)*D))
    newp=200+max(300,ceil(F(484,7)*D)); news=max(250,ceil(F(484,343)*D))
    platt=ceil(F(10**8,c)) if c%2 else ceil(max(F(10**8,c),200+F(75000000,c)))
    assert newp<=oldp and news<=olds and news<=newp
    hs={'old_plus':oldp,'new_plus':newp,'old_star':olds,'new_star':news,'platt_same_active':platt}
    for key,H in hs.items():
        st=stats[key];st['weighted_height']+=prim[c]*H;st['count_proxy']+=prim[c]*count(H);st['max_height']=max(st['max_height'],H)
        st['diagnostic_count_proxy']+=prim[c]*H/pi*log(max(1.,c*H/(2*pi*2.718281828459045)))
    if c in [1,3,4,100,1000,10000,50000,100000,149999,300000]:rows.append({'c':c,'primitive_count':prim[c],**hs})
out={'status':'exact sufficient arithmetic only; spectral data and analytic formalization still open','selected_beta':'111/200','active_conductors':nc,'primitive_characters':chars,'profile_plus':'ceil(200+max(300,(484/7)*Dc))','profile_star':'ceil(max(250,(484/343)*Dc))','plus_normalized_tail_cap':'3e-13','star_normalized_tail_cap':'1e-14','mixed_norm_remainder_upper_exact':str(rmix),'mixed_norm_remainder_cap':'3e-8','stats':stats,'sample_heights':rows,'warnings':['count_proxy is a coarse Jensen multiplicity upper proxy, not actual zeros or required certificate records','diagnostic_count_proxy is a floating Riemann-von-Mangoldt leading expression, not a proved count','platt_same_active compares heights on this active family only, not the entire original Platt task','height and count proxies do not establish running time or proof volume']}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
assert stats['new_plus']['weighted_height']*1000<555*stats['old_plus']['weighted_height']
assert stats['new_star']['weighted_height']*1000<251*stats['old_star']['weighted_height']
assert stats['new_plus']['count_proxy']*1000<556*stats['old_plus']['count_proxy']
assert stats['new_star']['count_proxy']*1000<253*stats['old_star']['count_proxy']
assert stats['new_plus']['weighted_height']*1000<667*stats['platt_same_active']['weighted_height']
# Ep's q1 summand is the exact raw principal residual on the broad q1 interval.
assert (F('.0002')+F('3e-7'))**2<F('8e-6')
# Stronger direct weighted-principal lower energy avoids the separate local kernel.
assert F('.6392')*F('13.597558')>F('2.94')**2
assert (F('2.94')-F('.0002003')-F('1e-9'))**2>F('8.6296')
print('PROFILE_PROXY_AND_LOWER_J_SCALAR_CHECKS_PASS')
# Frozen original-profile corollary, independent of reduced-height adoption.
assert F('.00020001')**2<F('8e-6')
assert F('7.2e11')*F('1e-15')**2<F('1e-9')**2
assert (F('2.94')-F('.00020001')-F('1e-9'))**2>F('8.6296')
print('ORIGINAL_PROFILE_Q1_AND_LOWER_J_COROLLARY_PASS')
