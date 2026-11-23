"""Rational bound checks only. No analytic values or production data."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

root = Path(__file__).resolve().parent.parent
pins = {
 'qrh-blueprint/JOINT_SEED_224_CORRECTIONS_2026-11-11.md': 'E438F4EF3AEC8352947B046E55C07418D9DA233B5E602B6FEF5CB402600F61F5',
 'qrh-campaign/agents/audit/REVIEW_JOINT_SEED_224_CORRECTIONS_2026-11-11.md': '7A74329B1D51F9E0113ECB76DC68DC1DC7F4182EAF29209DE47CE068EF84D888',
}
for p,h in pins.items():
 assert hashlib.sha256((root/p).read_bytes()).hexdigest().upper()==h
checks=[]
def check(name,test):
 assert test,name
 checks.append(name)
m,N,D,P,V,W=159,1500,4096,28,7000,7009
check('Euclidean factor cap',F(V*V)+(F(P-1)+2*m-F(1,2))**2<W*W)
check('square-root endpoint cap',1502<39**2)
r=F(W,6*1501)
check('E contraction',r<F(17,20))
R=F(156,1)/F(4*m-1,2)*r**(2*m)
check('remainder',R<F(1,2**116))
fact=1
for k in range(P):
 if k:fact*=k
 check(f'factor endpoint {k}',V*V+(F(k)+2*m-F(1,2))**2<W*W)
 check(f'scaled remainder {k}',F(156,1)/F(2*k+4*m-1,2)*F(W,1501*D)**k/fact*r**(2*m)<=R)
seed=F(10507,2**118)+F(278753,2**122)+R
check('seed',seed<F(107,1000*2**100))
check('output',2*seed+F(351,2**110)<F(557,1000*2**100))
check('correction error',31*m<7936)
slots=P*(D+1)
rows={}
for old in (256,224):
 rows[str(old)]={'gamma_saved':(old-m)*slots,'E_saved':2*(old-m)*(D+1)}
out={'parameters':{'m':m,'N':N,'D':D,'P':P,'V':V,'W':W},'checks':checks,
 'remainder':str(R),'seed_over_eta':str(seed*2**100),'savings_per_height':rows,
 'gamma_terms':m*slots,'E_stages':(P+2*m-2)*(D+1),'pins':pins}
path=Path(__file__).with_name('joint_seed_m159_20261111.json')
if path.exists():assert json.loads(path.read_text())==out
else:path.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(f'PASS {len(checks)} checks, {len(pins)} pins')
print(json.dumps(rows))
