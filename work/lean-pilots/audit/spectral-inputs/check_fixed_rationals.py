"""Independently check the eight source-fixed rational polynomials; no transcendental evaluation."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json,math
H=Path(__file__).resolve().parent;R=H.parents[3];S=R/'work/lean-pilots/spectral'
expected={'Elementary.lean':'B5CD458EC4A06171D8BBAA5B7203E0C9C85E9A9E93DB7B36E5BE6F7C5534E085','FiniteInputs.lean':'7A5CED128210471C8C5A21D6D690762744278FFDDA5428CA4266FA4D418CB01D','RoundedInputs.lean':'D40438867200C6BCF1B3B0356D65B034C00EC71306FE2EECE1C379601ED957B3','Tail.lean':'29A424F0A38B27D22B7336CBA079E9DD4B843FC48F7C6C26F81D708B5B4D55A2'}
pins=[]
for fn,sha in expected.items():
 b=(S/fn).read_bytes();assert hashlib.sha256(b).hexdigest().upper()==sha
 pins.append(dict(file=fn,sha256=sha,bytes=len(b)))
def mul(z,w):return(z[0]*w[0]-z[1]*w[1],z[0]*w[1]+z[1]*w[0])
def logs(x):return 2*sum((x**(2*i+1)/F(2*i+1) for i in range(8)),F(0))
def exps(z):
 term=(F(1),F(0));out=term
 for j in range(1,16):
  term=mul(term,z);term=(term[0]/j,term[1]/j);out=(out[0]+term[0],out[1]+term[1])
 return out
assert 2*F(1,3)**17/F(8,9)<=F(1,50000000)
assert F(2**17,math.factorial(16))<=F(1,10000000)
assert F(4,50000000)<=F(1,10000000)
assert 2*F(3,5)*F(1,10000000)+F(1,10000000)<=F(3,10000000)
assert F(3,10000000)+F(1,2**20)<=F(1,500000)
fixed=[(1,0,1048576,0),(3,1,603167,-51897),(5,2,465235,-58808),(7,2,391753,-60019),(9,3,344388,-59705),(11,3,310626,-58882),(13,3,285003,-57888),(15,3,264704,-56853)]
rows=[];re=im=0
for j,(n,k,a,b) in enumerate(fixed):
 assert 0<n<=16 and k<=3 and 2**k<=n<=2*2**k
 x=F(n-2**k,n+2**k);assert 0<=x<=F(1,3)
 l=k*logs(F(1,3))+logs(x);z=(-l/2,-F(5,64)*l);w=exps(z)
 err=abs(w[0]-F(a,2**20))+abs(w[1]-F(b,2**20));assert err<=F(1,2**20)
 chi=1 if n%4==1 else -1;assert chi==(-1)**j
 re+=chi*a;im+=chi*b
 rows.append(dict(n=n,k=k,real_numerator=a,imag_numerator=b,chi=chi,polynomial_l1_error_le_grid=True,error_numerator_bits=err.numerator.bit_length(),error_denominator_bits=err.denominator.bit_length()))
assert (re,im)==(572952,51250)
assert sum(0 if n%2==0 else 1 if n%4==1 else -1 for n in range(1,17))==0
assert F(1,4)+F(25,4096)==F(1049,4096)<F(33,64)**2
assert F(33,64)*F(1,2)==F(33,128)
assert F(8,500000)==F(1,62500)
radius=F(33,128)+F(1,62500)
assert F(re,2**20)-radius>F(1,4)
assert abs(F(im,2**20))+radius<F(1,2)
out=dict(scope='Source-fixed exact rational diagnostics; Lean proofs are the certificate, no actual log/exp/L evaluation',source_pins=pins,rows=rows,center=[re,im,2**20],all_checks='PASS')
with (H/'fixed_rational_receipt.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(hashlib.sha256((H/'fixed_rational_receipt.json').read_bytes()).hexdigest().upper())
