"""Independent fixed rational/source checks; no producer import or values."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import re, hashlib, json

HERE=Path(__file__).resolve().parent
AG=HERE.parent
ROOT=AG.parent.parent.parent
AUTHOR=AG/'integration/RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md'
checks=[]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def ck(n,v):
    assert v,n
    checks.append(n)
ck('author hash',sha(AUTHOR)=='FBBB538E0FC72865A9B4815A048992644AA0563AFC2DEA970FB9C3B4F7596EEE')
pins=re.findall(r'^- `([^`]+)`: `([A-F0-9]{64})`\.',AUTHOR.read_text(),re.M)
ck('seventeen inputs',len(pins)==17)
for path,h in pins:
    p=(ROOT if path.startswith('work') else AG)/Path(path.replace('\\','/'))
    ck('pin '+path,sha(p)==h)
for name,h in [
('raw_head_grid100_producer_20261111_v2.py','19883CD951723E35D0CAF28DBEFDFBE3D727C4C186862038BAD58FFAE3E8E129'),
('raw_head_grid100_producer_20261111.json','503719183AA0A5A580C11E54ED6E394EF9093A11379B1CE462C65E1A907B3911')]:
    ck(name,sha(AG/'integration'/name)==h)
def u(b):return F(1,2**b)
tail_log=2*F(1,3)**91/(91*(1-F(1,9)))
ck('actual finite atanh tail',tail_log<u(135))
log_error=19*(tail_log+F(7,4)*u(137))+u(130)
ck('log error independently tighter',log_error<F(949,2048)*u(128)<u(128))
ck('range k bound',265800<2**19)
ck('no period reduction needed',F(5,64)*(19+u(128))<2)
exp_tail=2*F(4**73,factorial(73))
ck('exact factorial tail',exp_tail<u(124))
ck('exp4 bound without evaluation',sum((F(4**j,factorial(j)) for j in range(17)),F(0))+F(4**17,factorial(17))/(1-F(4,18))<81)
step=F(5,64)*u(128)+exp_tail+81*u(131)+u(122)
ck('full step',step<u(120))
J=90000
ck('time grid',F(7000)*64/5==89600<J)
ck('geometric condition',J*u(120)<F(1,2))
E=(u(98)+2*J*u(120))/(1-J*u(120))
ck('direct geometric recurrence',E<u(96))
ck('author coarse recurrence',2*u(98)+4*J*u(120)<u(96))
d=u(96);c=265800
head=c*(2*d+d*d)+u(100)
ck('head complete radius',head<u(75))
ck('scaled head radius',633*head<u(63))
ck('sqrt conductor coarse',c<516**2)
ck('C accepted norm',516+c*d<517)
ck('head before final round norm',(516+c*d)*(1+d)<517)
ck('head after final round norm',516+head<517)
ck('assembled bound',173+517==690)
ck('optional conductor enclosure',d<u(84))
ck('state magnitude bits',(1+d)*2**120<2**121)
ck('step magnitude bits',(1+u(120))*2**122<2**123)
ck('raw C multiply',c*2**121<2**140)
ck('accepted C magnitude bits',(516+c*d)*2**120<2**130)
ck('recurrence combined raw',2*(2**121-1)*(2**123-1)<2**245)
ck('recurrence witness lhs',2**245-1+2**121<2**246)
ck('recurrence output candidate',2*2**120+1<2**122)
ck('head combined raw',2*(2**130-1)*(2**121-1)<2**252)
ck('head witness lhs',2**252-1+2**139<2**253)
ck('head candidate norm',517*2**100+1<2**110)
ck('head witness rhs',(2**110-1)*2**140+2**140-1<2**251)
ck('head shift',120+120-100==140)
ck('recurrence shift',120+122-120==122)
ck('assembly inherited signed capacity',690*2**100<2**114)
def mul(a,b):
    m,n=sorted(((a+7)//8,(b+7)//8))
    return 5*m*n+2*m+1
def add(a):return 2*((a+7)//8)+1
cores=[4*mul(121,123),2*add(245)+4*add(246),2*mul(121,19),4*mul(130,121),2*add(252)+4*add(253),2*add(111)]
ck('all typed core entries',cores==[5252,378,494,5572,390,58])
ck('four packed coordinates',4*16*265800==17011200)
receipt={'scope':'Independent source pins and fixed rational bounds only; no values, inventories or producer import.',
         'author':sha(AUTHOR),'checks':len(checks),'assertions':checks,'pins':dict(pins),'typed_cores':cores,
         'limitations':['Conditional paper producer only','No actual enclosures or signs','Source library, arithmetic, cache and population pricing remain open']}
out=HERE/'review_raw_head_grid100_20261111.json'
with out.open('x',encoding='utf-8') as f:json.dump(receipt,f,indent=2);f.write('\n')
print(json.dumps({'checks':len(checks),'receipt_sha256':sha(out),'bytes':out.stat().st_size}))
