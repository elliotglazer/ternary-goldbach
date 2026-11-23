from fractions import Fraction as F
from math import prod,isqrt
from pathlib import Path
import hashlib
p=149993
assert all(p%d for d in range(2,isqrt(p)+1))
assert prod([2,3,5,7,11,13,17])==510510>300000
assert prod([F(q,q-1) for q in [2,3,5,7,11,13]])==F(30030,5760)
assert F('1.2534')*F('1.016')<F('1.129')**2
main=F(30030,5760)*F('1.129')*49/600000
assert main<F('.000481')
low=F('.6')*F(8,23)+F('.13')*F(3,2)-2*F(22,7)**2*F('.082')**2*F(135,64)
assert low==F(55673979,450800000)>F('.12')
# Standard source exp(1)<2.7182818286 proves both exponential lower bounds.
e=F('2.7182818286')
assert e<F(5,3)**2 and e**2<F(100,13)
# pi<22/7 proves the fourth Gaussian moment bound.
assert 9*F(22,7)/2<16
ibp=9*F('1.2534')*F('9.5')/(2*F('3.14'))**2
assert ibp<F('2.72')
assert 387**2<p and F(10000,7)**8>10**25
bad=F('.12')*F(7,10000)*387*F(p-2,p-1)
assert bad>F('.01398')
assert F(600000,49*p)<=F('.082')<F(600000,p)
assert F('2.72')/F(600000,49)**2<F('1.82e-8')
for n,v in [('main bound',main),('cosine lower',low),('IBP coefficient',ibp),('artificial-inventory lower',bad)]:print(n, v, float(v))
print('PASS_ALL_EXACT_CHECKS')
q=Path('work/qrh-campaign/agents/zero-sum/BASE_GAP_QRH.md')
print('SOURCE_SHA256',hashlib.sha256(q.read_bytes()).hexdigest())
