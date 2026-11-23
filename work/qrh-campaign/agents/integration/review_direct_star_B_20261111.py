"""Independent exact allocation/normalization checks; no function values or author import."""
from pathlib import Path
from fractions import Fraction as F
from math import isqrt, factorial
import hashlib, json, re
HERE=Path(__file__).resolve().parent
A=HERE.parent
report=A/'audit/DIRECT_STAR_B_SOURCE_OBSTRUCTION_V2_2026-11-11.md'
sha='65B892756EA24A086C673082D3CA551AF99EECA5DDA63CB3523EE3F5514A88A9'
checks={}
def ck(name,test):
    assert test,name
    checks[name]=True
ck('author pin',hashlib.sha256(report.read_bytes()).hexdigest().upper()==sha)
pins={}
for path,expected in re.findall(r'\]\((C:/[^)]+)\)\s*\|\s*([A-F0-9]{64})',report.read_text(encoding='utf8')):
    ck('pin:'+Path(path).name,hashlib.sha256(Path(path).read_bytes()).hexdigest().upper()==expected)
    pins[path]=expected
ck('all17 author input pins',len(pins)==17)

# Square-root intervals certified by integer inequalities, used only for this scalar allocation.
def sqrt_box(q):
    scale=10**30
    n=isqrt(q.numerator*scale*scale//q.denominator)
    ck('sqrt witness '+str(q),n*n*q.denominator<=q.numerator*scale*scale<(n+1)**2*q.denominator)
    return F(n,scale),F(n+1,scale)
j=F(879,100); u=F(367,10**8); p=F(1504,10**9); rho=F(885,10**9)
C=j*(u-p)**2
lo,hi=sqrt_box(C)
rows=[]
for a,maxb in [(F(3,10**6),14),(F(2,10**6),24),(F(1,10**6),37),(F(0),52)]:
    blo,bhi=sqrt_box(F(maxb)); nlo,nhi=sqrt_box(F(maxb+1))
    ck('permitted integer '+str(maxb),a+rho*bhi<lo)
    ck('next integer rejected '+str(maxb+1),a+rho*nlo>hi)
    rows.append({'A':str(a*a),'last_B':maxb,'accepted_by_rational_upper':True,'next_rejected_by_rational_lower':True})
ck('absolute B ceiling',52<C/rho**2<53)
R=132900; y=10**25; x=49*y
ck('arc Jacobian',F(x,y*y)==F(49,y))
ck('arc disjoint domain',16*R*R<=x and 8*R<=x)
ck('sieve lower cutoff domain',R>=100000 and 16*(20000*R)**2<=x)
ck('sieve rho domain sufficient',(2*R)**10<y**3)
ck('denominator scale identity',F(2)**2*F(49,16)==F(7,2)**2)
ck('Qset parity counts',R%2==0 and R//2+R==199350)
ck('volume bound coefficient',16*F(3,4)==12)
ck('removal bound',F(2,10**9)*4*R==F(1329,1250000))
ck('removal volume strict',12*R*R<(4*R)**2)
ck('exp1 elementary upper',2+F(1,2)/(1-F(1,3))<3)
ck('log2R lower witness',3**11<2*R)
ck('exp2 elementary lower',sum((F(2**k,factorial(k)) for k in range(6)),F(0))>7)
ck('mixture tail mass',1-F(5,14)==F(9,14))
ck('energy strict lower comparison',F(9,14)**2/2-F(1,5)==F(13,1960)>0)
ck('source mass sufficient upper',F(1359756,100000)<14)
ck('seven prime minimum product',2*3*5*7*11*13*17==510510>300000)
ck('six prime ratio',F(2*3*5*7*11*13,1*2*4*6*10*12)==F(1001,192)<F(21,4))
ck('principal projection weight sum',16*F(21,4)*2==168)
ck('limiting upper comparison lower bound',49*(2*(11+2)-14)*F(1,5)==F(588,5)>53)
result={'status':'PASS_EXACT_COMPARISON_METADATA','checks':checks,'number_of_checks':len(checks),
        'author_sha256':sha,'input_pins':pins,'allocation_rows':rows,'B_ceiling':str(C/rho**2),
        'scope':'Scalar and source-pin checks only; no actual B or asymptotic coefficient claim.'}
dest=Path(__file__).with_suffix('.json')
if dest.exists():
    assert json.loads(dest.read_text(encoding='utf8'))==result, 'saved receipt mismatch'
else:
    with dest.open('x',encoding='utf8',newline='\n') as f:
        f.write(json.dumps(result,indent=2)+'\n')
print(json.dumps({'status':result['status'],'checks':len(checks)}))
