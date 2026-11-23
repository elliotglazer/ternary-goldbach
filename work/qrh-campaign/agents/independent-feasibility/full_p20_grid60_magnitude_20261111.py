"""Fixed magnitude extension and six already-declared fullP20 b94 cases."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json
HERE=Path(__file__).resolve().parent
A=HERE.parent
PINS={
 'independent-feasibility/FULL_P20_INPUT_MAGNITUDE_5691_2026-11-11.md':'718CFC0DDAA0594A2AB26ADDCEBA09E472E07C1ED21FD8058821957251EAC223',
 'zero-sum/REVIEW_FULL_P20_INPUT_MAGNITUDE_5691_2026-11-11.md':'42985BB1A88F4F70A3C9C37584725C34D04EDFE9DBEFF8BAE19E1F79E7B44E8C',
 'prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
 'moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md':'AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63',
 'independent-feasibility/REVIEW_JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md':'84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7',
 'major-constants/REVIEW_SHORT_GUARD_HORNER_DOMAIN_ADMISSION_2026-11-11.md':'4D313FBFEC13EBC9D80490C5CC995228D67E71F211F865113A67969A60BB82E9',
}
n=0
def ck(x):
 global n
 n+=1
 if not x:raise AssertionError(n)
for p,h in PINS.items():ck(hashlib.sha256((A/p).read_bytes()).hexdigest().upper()==h)
bp=A.parent.parent/'qrh-blueprint'/'SHORT_GUARD_HORNER_DOMAIN_ADMISSION_2026-11-11.md'
ck(hashlib.sha256(bp.read_bytes()).hexdigest().upper()=='6DF38245BECCD8A35B94F98787C4DEF64EEB9EFCF9FB07E54E1D9EC554C48DF2')
eta=F(1,2**100);ut=F(1,2**110);R=F(1,2**116);W=4*eta+330*ut
H=lambda z:1+z+z*z/(2*(1-z/3))
e60=F(3,4*2**60)
uf=5170+R+20*W+6*(H(F(5,16))-1)+F(8,3)*e60
ul=F(9023,2)+R+F(4,3)*eta+F(15,2)*(H(F(7,32))-1)+F(8,3)*e60
ck(uf<F(10345,2));ck(ul<F(9027,2))
ck(F(8,3)*e60==F(1,2**59))
shape=[100,100,100,100,97,95,95,95,89,87,87,87,81,79,79,79,71,71,71,71]
grids=[b-6 for b in shape]
ck(len(grids)==20 and min(grids)==65 and grids[0]==94)
E=sum((1 if j==19 else 2)*F(3,4*2**b)/4**j for j,b in enumerate(grids))
ck(E==F(5253,2048*2**94))
ck(100-grids[0]==6)
Sf=1266*F(15,16)**27/factorial(27)
Sl=1266*F(5*7028,8*4096)**28/factorial(28)
Nf=2532*eta+633*330*ut;Nl=844*eta
rows=[]
for name,V,D,final in [('band1',F(500),512,False),('band2',F(1000),1024,False),('band3',F(2000),2048,False),('band4',F(5000),4096,False),('final_declared',F(7000),8192,True),('final_guard',F(26525,4),8192,True)]:
 T=1266*((V+20)/(4*D))**20/factorial(20)
 alpha=T+(Sl if final else Sf)+(Nl if final else Nf)+633*E
 ck(alpha<F(1,2**82))
 rows.append({'case':name,'K':20,'b0':94,'min_grid':65,'alpha_ratio':[int((alpha*2**82).numerator),int((alpha*2**82).denominator)]})
ck(F(10345,2)+517+1+F(1,2**80)<5691)
ck(F(9027,2)+517+1+F(1,2**80)<5032)
out={'checks':n,'scope':'fixed rational envelopes and six declared cases only','pins':PINS,
 'magnitude_min_grid':60,'arbitrary_grid60_alpha_admitted':False,
 'full_p20_fixed94':rows,'uniform_V':5691,'final_V':5032}
raw=(json.dumps(out,indent=2)+'\n').encode()
with (HERE/'full_p20_grid60_magnitude_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps({'checks':n,'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest().upper()}))
