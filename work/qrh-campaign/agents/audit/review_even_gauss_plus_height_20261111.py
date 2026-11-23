"""Exact independent band/profile checks, no analytic or spectral evaluation."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
AUTHOR=ROOT/'work/qrh-campaign/agents/moebius'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
tests={}
def ck(k,v):
    assert v,k
    tests[k]=True
expected={'EVEN_GAUSS_PLUS_HEIGHT_PROFILE_2026-11-11.md':'D3408AA27763D7E3C475E7B27DB124FDE9C16EDC916CEE061563B31D9A2DD88B','even_gauss_plus_height_20261111.py':'0A2F8DE733652B502BE6F630273364FA07136A663FB8372DF6D9472AB8342079','even_gauss_plus_height_20261111.json':'EEFA6D42ACF703E65C456BA8DC2A6F678F20E288983E5CCD4CB0B85CDDD392AB'}
for path,h in expected.items():ck(path,sha(AUTHOR/path)==h)
data=json.loads((AUTHOR/'even_gauss_plus_height_20261111.json').read_text())
for path,h in data['pins'].items():ck(path,sha(ROOT/path)==h)

# Horner recurrence computes sum_{k=0}^{16} t^k/k! independently.
def positive_polynomial(z):
    t=z/64
    acc=Q(1)
    for k in range(16,0,-1): acc=1+t*acc/k
    return acc**64
Z=Q(17726,100); C=Q(9,100); a=Q(1371,1000); K=Q(393400); IB=Q(21768,10000)
EB=Q(46,10**17)
ck('EB endpoint',Q(892,1000)*255<EB*positive_polynomial(Q(1598,10000)*255))
ck('IA constant and slope',1+Q(31416,10000)/Q(8492,1000)<a and Q(31416,10000)*1063200/Q(8492,1000)<K)
ck('growth at floor',11*Q(44,10)<C*455*Q(12039,10000))
ck('E1 full-scale conversion',Q(766,100)*10**6/(Q(221,100)*10**13)<Q(347,10**9) and (Q(221,100)*10**13)**2<49*10**25)
rows=[]
for i,row in enumerate(data['bands']):
    L,U=row['L'],row['U']
    u,lo,hi,EA=[Q(row[k]) for k in ['u','sl','su','EA']]
    cap=Q(149,10**9) if row['kind']=='odd_unchanged' else Q(646,10**9)
    ck(f'roots and regime {i}',lo>0 and lo**2<=L and hi**2>=U and u>=10)
    ck(f'EA endpoint {i}',Q(588,1000)*u*u<EA*positive_polynomial(Q(1065,10000)*u*u))
    # Expand sqrt(c)*(2Z*(a+K/c)+2C*(a+K/c)^2).
    G=2*Z*a*hi+2*C*a*a*hi+2*Z*K/lo+4*C*a*K/lo+2*C*K*K/(L*lo)
    E2=Q(12924,100)*(516*EB*(2*Z*IB+2*C*IB**2)+EA*G)
    ck(f'full E2 and saved quantities {i}',E2<cap and G==Q(row['G']) and E2==Q(row['E2']))
    rows.append({'kind':row['kind'],'L':L,'U':U,'E2':str(E2)})
ck('eight bands',len(rows)==8)
ck('odd ambient',Q(347,10**9)+Q(149,10**9)+Q(2,10**17)+Q(516,10**15)<Q(5,10**7))
ck('even ambient',Q(347,10**9)+Q(646,10**9)+Q(2,10**17)+Q(516,10**15)<Q(994,10**9))
energy=Q(994,10**9)**2/2
rho=Q(758,10**9)
ck('energy exact and dominant',energy==Q(data['even_energy']) and Q(5,10**7)**2<energy)
ck('orthogonal rho with removal',rho>Q(516,10**15) and energy+Q(283,10**9)**2<(rho-Q(516,10**15))**2)
oldrho=Q(885,10**9)
ck('old rho and integrated Z',rho<oldrho and 16*150000*19*oldrho**2<Q(6,1000)**2)
ck('base union dominance',Q(191,10)*3*1063200>54000000)
ck('star union dominance',455>300 and Q(191,10)*3>Q(704,343))
ck('line A',7000000*Q(2321,10**22)<(Q(1284,10**9)-Q(8,10**9))**2)
ck('line B',7000000*Q(1753,10**15)<(Q(4,1000)-Q(48,100000))**2)
ck('old mixed allocation',Q(7875,1000)**2>62 and Q(2964,1000)**2<Q(879,100) and Q(1902,10**9)+Q(2,10**6)+oldrho*Q(7875,1000)<Q(2964,1000)*Q(367,10**8))

def ceil(v):return (v.numerator+v.denominator-1)//v.denominator
def u0(c):return Q(23) if c<100 else Q(43,2) if c<1000 else Q(41,2) if c<10000 else Q(39,2)
for row in data['examples']:
    c=row['c'];dc=Q(1063200,c)
    old=ceil(200+max(Q(255),Q(3927,1250)*u0(c)*dc))
    new=ceil(200+max(Q(255),Q(3927,1250)*(u0(c)-Q(2,5))*dc))
    base=ceil(Q(54000000,c))
    ck('example '+str(c),(old,new,base)==(row['coupled'],row['new'],row['base']) and base<=new<=old)
ck('all branch parameters below fallback',all(u<=Q(233,10) for u in [Q(23),Q(43,2),Q(41,2)]) and Q(39,2)<Q(1989,100) and Q(191,10)<Q(1989,100))
out={'scope':'exact band/profile scalar checks only; not a finite-RH certificate','checks':tests,'check_count':len(tests),'bands':rows,'even_energy':str(energy),'input_pins':data['pins'],'author_pins':expected}
dest=HERE/'review_even_gauss_plus_height_20261111.json'
with dest.open('x',encoding='utf-8',newline='\n') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(f'{len(tests)} checks PASS; receipt {sha(dest)}')
