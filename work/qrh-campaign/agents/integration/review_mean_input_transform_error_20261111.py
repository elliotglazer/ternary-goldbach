"""Independent fixed paper checks. No author imports, values or inventories."""
from pathlib import Path
from fractions import Fraction as F
from math import prod
import json,hashlib
ROOT=Path(__file__).resolve().parent.parent
HERE=Path(__file__).resolve().parent
checks=[]
def ck(name,test):
    if not test: raise AssertionError(name)
    checks.append(name)
def digest(p): return hashlib.sha256(p.read_bytes()).hexdigest().upper()
artifacts={
'independent-feasibility/MEAN_INPUT_TRANSFORM_ERROR_RESEARCH_2026-11-11.md':'160E25353C24850DCA6D167AA5D85D54579FED642BAB3A1E55CC6AD0358C2AF6',
'independent-feasibility/mean_input_transform_error_20261111.py':'23C2DDD5E4264FE87BDA21C9892C0F688561C5FB924035004C1284EE19ACCE93',
'independent-feasibility/mean_input_transform_error_20261111.json':'13444563FC4A24DD4508BB17285665A0FE6F26A12AD8CEABD7499ED2A533E764'}
for p,h in artifacts.items(): ck('artifact '+p,digest(ROOT/p)==h)
a=json.loads((ROOT/'independent-feasibility/mean_input_transform_error_20261111.json').read_text())
for p,h in a['pins'].items(): ck('source '+p,digest(ROOT/p)==h)
# Sparse exact formal polynomials in C_m,C_r,u. No transform/input values.
z=(0,0,0)
def const(x): return {z:F(x)} if x else {}
def var(i):
    p=[0,0,0];p[i]=1;return {tuple(p):F(1)}
def add(*xs):
    out={}
    for x in xs:
        for k,v in x.items():out[k]=out.get(k,F(0))+v
    return {k:v for k,v in out.items() if v}
def scale(x,a):return {k:v*a for k,v in x.items() if v*a}
def mul(x,y):
    out={}
    for k,v in x.items():
        for l,w in y.items():
            m=tuple(i+j for i,j in zip(k,l));out[m]=out.get(m,F(0))+v*w
    return {k:v for k,v in out.items() if v}
cm,cr,u=map(var,range(3));one=const(1)
d=add(mul(cm,add(one,u)),one)
expr=add(d,mul(cr,add(one,mul(u,d))))
expanded=add(cm,cr,one,mul(u,add(cm,mul(cr,d))))
ck('CT exact full cross term',expr==expanded)
ck('CT d cap gap cm*(1-u)',add(add(scale(cm,2),one),scale(d,-1))==mul(cm,add(one,scale(u,-1))))
E=cm;c=cr
ck('tensor normalized factor identity',add(E,mul(c,mul(u,add(one,E)))))==add(mul(add(one,E),add(one,mul(c,u))),const(-1))))
# Synthetic scalar coefficients only. General proof is in review, not fixtures.
rad=[]
for k in (1,4,7):
    u0=F(1,2*k)
    weighted=sum(((1+u0)**(k-j))*(1+F(2,2**j)) for j in range(1,k+1))
    ck(f'radix binomial envelope k{k}',(1+u0)**k<=2)
    ck(f'radix inhomogeneous sum k{k}',sum(1+F(2,2**j) for j in range(1,k+1))<k+2)
    ck(f'radix error envelope k{k}',weighted<=2*k+4)
    rad.append([k,str(weighted)])
# CT scalar boundary handles both zero children too.
for cm0,cr0 in ((0,0),(0,7),(9,0),(3,11)):
    D=max(1,cm0+cr0*(2*cm0+1));u0=F(1,D)
    d0=cm0*(1+u0)+1
    ck(f'CT guard fixture {cm0},{cr0}',d0+cr0*(1+u0*d0)<=cm0+cr0+2)
blue=[]
for n in (2,5,31):
    P=1<<((2*n-2).bit_length());k=P.bit_length()-1;R=2*k+4;A=1+3*R
    Q=3*n*P*A+1;q=3*n*A+n+2;m=2*n-1
    old=6*P*A+2*R*(2*n+1)+8
    new=F(9*P*A+3*P,2)+3*R*n+12*R+14
    exact=F(3,2)*F(P*q+R*(n*m+2*P),n)+F(n+1,n)
    ck(f'Blue geometry {n}',2*n<=P<4*n and R>=8)
    ck(f'Blue cache guard {n}',P*(A+1)<Q and q<Q)
    ck(f'Blue q identity {n}',n*(A+1)+m*A+(A+1)+1==q)
    ck(f'Blue postchirp gap identity {n}',n*(new-exact)==13*n+F(27,2)*n*R-3*P-3*P*R-1)
    ck(f'Blue new cap {n}',exact<=new)
    ck(f'Blue old minus new {n}',old-new==R*(F(9,2)*P+n-10)-6>=74)
    ck(f'Blue original inverse-divide cap {n}',F(2*(Q+R*(n*m+2)+1),n)+1+F(1,n)<=old)
    blue.append([n,P,old,int(new)])
# Exact arithmetic for source reserve. No prime discovery/test or residue scan.
ck('seven fixed factors product',prod((2,3,5,7,11,13,17))==510510>265800)
ratio=prod(F(p,p-1) for p in (2,3,5,7,11,13))
ck('six fixed totient factors',ratio==F(1001,192))
ck('root upper bracket',265800<516**2)
reserve=F(1032,2**63)+F(1,2**50)
ck('source p50 reserve',reserve<F(1,2**52)+F(1,2**50)<1)
ck('uniform augmented mean',175+2*ratio==F(17801,96)<186)
ck('final augmented mean',165+2*ratio==F(16841,96)<176)
ck('source reserve uniform slack',173+1+2*ratio+reserve<186)
ck('source reserve final slack',163+1+2*ratio+reserve<176)
# Fiber-weight symbolic arithmetic in M_L,M_R,E, encoded at fixed rational
# means only as independent coefficient identities, not source sample values.
ck('empty tensor exact',prod([])-1==0)
ck('zero C tensor exact',(1+F(0))-1==0)
out={'scope':'Fixed symbolic/rational/hash checks only. No values, precision selection, metadata fold or author imports.',
'checks':len(checks),'assertions':checks,'artifact_pins':artifacts,'source_pins':a['pins'],
'radix_scalar_checks':rad,'blue_scalar_checks':blue,'p50_source_reserve':[reserve.numerator,reserve.denominator],
'uniform_mean':[17801,96],'final_mean':[16841,96],
'limitations':['Legacy C/D only','Separate sup-norm widths','Full P20 source and actual summed head/representation radii','No p50 adapter or selector adoption']}
p=HERE/'review_mean_input_transform_error_20261111.json'
with p.open('x',encoding='utf-8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':len(checks),'receipt':str(p),'bytes':p.stat().st_size,'sha256':digest(p)}))
