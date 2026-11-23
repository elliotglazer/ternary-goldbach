"""Exact arithmetic for a conductor-aggregate spectral certificate implication.
No zero counts, zero-free rectangles, or analytic kernels are certified here.
"""
from fractions import Fraction as F
from pathlib import Path
import json

P=Path(__file__).resolve().parent
Q=300000
phi=list(range(Q+1)); spf=list(range(Q+1)); n=[1]*(Q+1)
for p in range(2,Q+1):
    if phi[p]==p:
        for j in range(p,Q+1,p):
            phi[j]-=phi[j]//p
            if spf[j]==j: spf[j]=p
for c in range(2,Q+1):
    p=spf[c]; a=0; m=c
    while m%p==0: m//=p; a+=1
    n[c]=n[m]*(p-2 if a==1 else p**(a-2)*(p-1)**2)
def ceildiv(a,b): return (a+b-1)//b
def heights(c):
    qt=c if c%2==0 else 2*c
    return 200+max(1000,ceildiv(844800000,7*qt)),max(1000,ceildiv(844800000,343*qt))
def count(h): return ceildiv(20000*h+69600,87)

x=49*10**25; y=10**25
# z^(-.03)<1/5 and 10^-8 z^(.29)<3/5 for y<=z<=x.
assert y**3>5**100
assert x**29<(6*10**7)**100
# Hence baseline beta<=.54 plus K<=nN/1e8 at beta<=.7
# gives E<.8*nN*z^(-.89), separately for plus and star.
records=[]; totals=[0,0,0,0,0]; min_single=None
for c in range(1,Q+1):
    if not n[c] or (c%2 and c>150000): continue
    hp,hs=heights(c); np,ns=count(hp),count(hs)
    kp=n[c]*np//10**8; ks=n[c]*ns//10**8
    totals[0]+=n[c]; totals[1]+=n[c]*np; totals[2]+=n[c]*ns
    totals[3]+=kp; totals[4]+=ks
    # One beta=7/8 zero in both carriers contributes at least this
    # value to the scalar I majorant sqrt(Dplus Dstar).
    # Its squared coefficient, before (xy)^(-1/2), is exact.
    coeff2=F(c,phi[c])**4*F(6241,400)*16*23000*4998000*np*ns
    if min_single is None or coeff2<min_single[0]: min_single=(coeff2,c)
    if c in (1,3,4,1000,10000,99991,149993,150000,300000):
        records.append(dict(c=c,characters=n[c],Hp=hp,Hs=hs,Np=np,Ns=ns,
                            allowed_above_054_plus=kp,allowed_above_054_star=ks))

assert totals[0]==5543640188
assert totals[1]==1740063512485802 and totals[2]==1278926120257689
# This tests the majorant's sensitivity, not a lower bound on true Cross.
coeff2,cmin=min_single
# sqrt(coeff2)*(xy)^(-1/4)>1/100 throughout the active conductor family.
assert coeff2**2>F(1,100)**4*x*y
out=dict(status='Exact sufficient-condition arithmetic only; no actual zero certificate.',
    original_profile=True,active_conductors=sum(1 for c in range(1,Q+1) if n[c] and (c%2==0 or c<=150000)),
    characters=totals[0],total_plus_multiplicity_upper=totals[1],total_star_multiplicity_upper=totals[2],
    sum_allowed_exception_counts_plus=totals[3],sum_allowed_exception_counts_star=totals[4],
    blueprint_variant_retains_conductor_one_0555=True,
    blueprint_exception_counts_plus=totals[3]-count(heights(1)[0])//10**8,
    blueprint_exception_counts_star=totals[4]-count(heights(1)[1])//10**8,
    baseline_beta='27/50',exception_beta='7/10',exception_fraction_of_count_upper_bound='1/100000000',
    alternative_E_relative_to_uniform_0555_endpoint_bound='strictly less than 4/5',
    all_conductors_alternative_I_relative_to_uniform_0555_endpoint_bound='strictly less than 16/25; major-only variant',
    blueprint_I_bound='less than 1e-8; retains original c1 condition, so no global .64 claim',
    samples=records,min_single_right_edge_majorant_conductor=cmin,
    min_single_right_edge_majorant_diagnostic=float(coeff2)**.5*(x*y)**(-.25),
    min_single_right_edge_majorant_exact_lower='1/100',
    caveat='Majorant sensitivity is not an actual lower bound on the mixed moment. Both carriers must contain the test zero.')
(P/'resume_weighted_certificate_20261111.json').write_text(json.dumps(out,indent=2))
print(json.dumps(out,indent=2))
