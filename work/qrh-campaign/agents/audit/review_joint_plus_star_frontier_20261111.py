"""Independent exact reconstruction of the joint frontier, no producer imports."""
from fractions import Fraction as Q
from pathlib import Path
import json
import hashlib

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
BLUE=ROOT/'work/qrh-blueprint'
def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()

pins={
    'JOINT_PLUS_STAR_FRONTIER_2026-11-11.md':'BA12BDC77B0FFAA154B99F64ECBDCDBED9FA9C4D39D3265CD79A16B5B5D75C4F',
    'check_joint_plus_star_frontier_20261111.py':'18CFCB19014B7602F3984105F9A1BE5AB0D8AC13C1359D140364EC726891F573',
    'joint_plus_star_frontier_20261111.json':'AA2D645CADEE8E0EFEFB0252A954470C24F4B90DC65E3A2F7DC4F4D23E28D030'}
checks={}
def ck(label,test):
    assert test,label
    checks[label]=True
for path,h in pins.items():
    ck('frozen '+path,digest(BLUE/path)==h)
saved=json.loads((BLUE/'joint_plus_star_frontier_20261111.json').read_text())
for path,h in saved['pins'].items():
    ck('dependency '+path,digest(ROOT/path)==h)
j=Q(879,100)
a0=Q(640208,10**6)*Q(1359756,10**5)
v=Q(778,100)*Q(285,100)
C=49*(j+a0)/9+9*v/2
E=j*Q(367,10**8)+Q(885,10**9)*C
p=Q(1902,10**9)
h=Q(2965,1000); b=Q(43762,1000)
ck('positive roots',h>0 and b>0 and h*h>j and b*b>1915)
ck('source coefficients',C==Q(914205504131,4687500000) and E==Q(64019155993729,312500000000000000))
rows=[]
for rootA,rhonum,printed in [(0,613,'2.95679e-13'),(1,604,'2.84726e-13'),(2,595,'2.73935e-13'),(3,586,'2.63306e-13'),(10,522,'1.92394e-13')]:
    rootA=Q(rootA,10**6);rho=Q(rhonum,10**9)
    constant=h*(p+rootA); slope=C+h*b
    reserve=E-constant-slope*rho
    limit=(E-constant)/slope
    ck('positive and maximal rho '+str(rhonum),rho>0 and reserve>0 and E-constant-slope*(rho+Q(1,10**9))<0)
    ck('integrated Z '+str(rhonum),16*150000*19*rho*rho<Q(6,1000)**2)
    difference=rho-Q(516,10**15)
    cap=difference*difference-Q(283,10**9)**2
    ck('positive orthogonal cap '+str(rhonum),difference>0 and cap>0)
    ck('downward decimal '+str(rhonum),Q(printed)<=cap<Q(printed)+Q(1,10**18))
    rows.append({'A':str(rootA*rootA),'rho':str(rho),'Eplus_cap':str(cap),'cubic_reserve':str(reserve),'envelope_rho_limit':str(limit)})
ck('all saved rows exactly',rows==saved['rows'])
ck('saved roots and B',Q(saved['sqrt_j_upper'])==h and Q(saved['sqrt_B_upper'])==b and saved['B_upper']==1915)
out={'scope':'independent rational envelope and serialization check only','checks':checks,'check_count':len(checks),'rows':rows,'pins':pins,'dependency_pins':saved['pins']}
dest=HERE/'review_joint_plus_star_frontier_20261111.json'
with dest.open('x',encoding='utf-8',newline='\n') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(f'{len(checks)} checks PASS; receipt SHA256 {digest(dest)}')
