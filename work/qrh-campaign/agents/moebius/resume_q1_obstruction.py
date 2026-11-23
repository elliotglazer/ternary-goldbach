"""Exact lower bound on a q=1 source-envelope floor, not on the true sum."""
from fractions import Fraction as F
from pathlib import Path
from math import factorial
from contextlib import redirect_stdout
import sys,io,json
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/'major-constants'))
with redirect_stdout(io.StringIO()):
 import base_gap_90090_certificate as core
I=core.I;b=core.b
A=F('4.9');B=F('1.55');Y=10**25
# Lower bounds for coefficients in the original positive source RHS.
assert F('1.0064')*2*F('5.65')/F(22,7)*(1+1/F('2.719'))>A
assert F('5.65')**2<32 and B**2<4*F('.60428')

def exp_upper(x,n=200):
 assert 0<=x<n+2
 s=sum((x**j/F(factorial(j)) for j in range(n+1)),F(0))
 return s+x**(n+1)/F(factorial(n+1))/(1-x/F(n+2))

def lower_floor(u):
 total=F(0)
 # Positive omitted tails may be discarded in this lower bound.
 for i in range(5,800):
  lo=F(i,100);hi=F(i+1,100);D=hi*u
  logpart=(I(A/B).log()+I(D).log()/2).l
  assert logpart>0
  f_lo=B/I(D).root().u*(1+logpart)
  # w² exp(-w²/2)>=lo² exp(-hi²/2) throughout the bin.
  mass_lo=(hi-lo)*lo*lo/exp_upper(hi*hi/2)
  total+=mass_lo*f_lo
 return b.down(total)

r=I(150000);t=2*r;z=I(Y)
fr=F('1.7882')*r.log().log()+F('2.50637')/r.log().log()
Lg=fr*(F('3.25')*t.log()+F('7.82'))+F('13.66')*t.log()+F('37.55')
R=F('.41415')+F('.27125')*(1+(4*t).log()/(2*(9*z.root(3)/(F('2.004')*t)).log())).log()
gx=((R*t.log()+F('.8764'))*fr.root()+F('2.526'))/t.root()+Lg/r+F('3.8')/z.root(6)
h=F('.276')/z.root(6)*z.log()*z.log().root()+1234/z.root(3)*z.log()
ghat_hi=b.up(F('1.398')*max(gx.u,h.u)+17*F(670,150000)**3/3)
assert ghat_hi<F('.061')
rows=[]
for u in [F(1200000,49),F(33000),F(40000)]:
 lower=lower_floor(u)
 assert lower>ghat_hi
 rows.append({'u':str(u),'envelope_lower':str(lower),'gap_above_consumer_upper':str(b.down(lower-ghat_hi))})
result={'status':'Exact obstruction to integrating the stated positive Type I2_large + TypeII_640 RHS. Not a lower bound on S, and not an impossibility theorem for other decompositions.','A_lower':str(A),'B_lower':str(B),'ghat_at_Y_upper':str(ghat_hi),'rows':rows,'q1_original_twist_factor':2,'major_local_twist_max':4,'basegap_original_twist_min':'600000/49'}
Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2))
print(json.dumps(result,indent=2))

