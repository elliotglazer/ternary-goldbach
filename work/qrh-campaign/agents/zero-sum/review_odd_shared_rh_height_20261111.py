"""Independent rational-only odd-profile check; no evaluator imports."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
AD=HERE.parent/'major-constants'
checks={}
def ck(n,b):
    assert b,n
    checks[n]=True
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
pins={
 'ODD_PLUS_SHARED_RH_HEIGHT_2026-11-11.md':'C4EE2B2F674F6376D987C778FC7886A03A93BC81E61C0BC56D0B1C25E2E4A14D',
 'odd_plus_shared_rh_height_20261111.py':'51125999FDFB867FCC8D142AB51358F76EF1B0A59457C05444BE6340477E2014',
 'odd_plus_shared_rh_height_20261111.json':'A8BC18047E60F92264A705892D757F5F0AFF7B299372C66CB038695CD27463CE'}
for p,h in pins.items():ck('pin_'+p,sha(AD/p)==h)
d=json.loads((AD/'odd_plus_shared_rh_height_20261111.json').read_text())
for p,h in d['input_sha256'].items():ck('dependency_'+p,sha(ROOT/p)==h)
def exp_lower(x):
    term=total=F(1)
    for k in range(1,21):
        term*=x/(128*k);total+=term
    return total**128
z,c,a,k,ib=map(F,['177.26','.1','1.371','196700','2.1768'])
eb=F('4.727e-15')
ck('growth',F('48.4')<=c*440*F('1.2039'))
ck('IA_constant',1+F('3.1416')/F('8.492')<a)
ck('IA_slope',F('3.1416')*531600/F('8.492')<k)
ck('EB_new_witness',F('.892')*240<eb*exp_lower(F('.1598')*240))
ck('sqrt_global',132900<365**2)
ck('floor_inactive',F('3.1416')*F('19.2')*4>240)
spec=[(3,100,'21','1.732','10','1.039e-18'),(100,1000,'20','10','32','7.422e-17'),(1000,10000,'19.5','31.62','100','5.781e-16'),(10000,132900,'19.2','100','365','1.93e-15')]
for i,(lo,hi,us,ls,rs,es) in enumerate(spec):
    u,l,r,e=map(F,[us,ls,rs,es])
    ck(f'roots_{i}',0<l and l*l<=lo and hi<=r*r)
    ck(f'EA_new_witness_{i}',F('.588')*u*u<e*exp_lower(F('.1065')*u*u))
    g=(2*z*a+2*c*a*a)*r+2*k*(z+2*c*a)/l+2*c*k*k/(lo*l)
    e2=F('129.24')*(365*eb*(2*z*ib+2*c*ib*ib)+e*g)
    row=d['bands'][i]
    ck(f'saved_row_{i}',(lo,hi,str(u),str(l),str(r),str(e),str(g),str(e2))==tuple(row[key] for key in ['lower','upper_for_bound','u','sl','su','EA','G','scaled_E2']))
    ck(f'E2_{i}',e2<F('3.93e-7'))
ck('E1',F('7.66e6')/F('2.21e13')<F('3.47e-7'))
coef=F('3.47e-7')+F('3.93e-7')+F('2e-17')+F('516e-15')
ck('complete_coefficient',coef<F('7.41e-7')<F('8.385e-7'))
ck('uniform_cap',F('8.385e-7')**2<F('7.03135e-13'))
ck('orthogonal_cap',F('7.03135e-13')+F('2.83e-7')**2<(F('8.85e-7')-F('516e-15'))**2)
ck('base_slope',F('19.2')*3*531600>27000000)
ck('star_slope',F('19.2')*3>F(704,343))
def ceildiv(n,d):return (n+d-1)//d
def heights(c):
    u10=210 if c<100 else 200 if c<1000 else 195 if c<10000 else 192
    v10=230 if c<100 else 215 if c<1000 else 205 if c<10000 else 195
    h=200+max(240,ceildiv(31416*u10*531600,100000*c))
    v=200+max(255,ceildiv(31416*v10*531600,100000*c))
    b=ceildiv(27000000,c)
    s=max(300,ceildiv(704*531600,343*c))
    return h,v,b,s
for row in d['examples']:
    ck('example_'+str(row['c']),heights(row['c'])==tuple(row[t] for t in ['candidate','coupled_fallback','base','star']))
ok=True;minimum=10**9
for c0 in range(3,132901,2):
    h,v,b,s=heights(c0);minimum=min(minimum,h)
    ok &= h>=max(440,b,s) and h<=v
ck('all_66449_odd_heights',ok)
ck('actual_minimum_442',minimum==442)
out={'scope':'independent odd-only exact checks; no analytic values','checks':checks,'count':len(checks),'author_pins':pins,'dependency_pins':d['input_sha256'],'complete_scaled_coefficient_upper':str(coef),'minimum_height':minimum}
with (HERE/'review_odd_shared_rh_height_20261111.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(str(len(checks))+' checks passed; 66449 odd conductor heights checked')
