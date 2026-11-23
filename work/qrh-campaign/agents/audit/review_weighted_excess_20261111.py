"""Independent rational budget and arithmetic support checks; no zero data."""
from pathlib import Path
from fractions import Fraction as F
import json
import hashlib

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
raw=AGENTS/'major-constants/weighted_excess_budget_20261111.json'
d=json.loads(raw.read_text())
X=49*10**25; Y=10**25; R=F(21,4); K=6
xp=F(1,2125**2); ys=F(1,1333**2)
yb=F(5625,10**26); xb=yb/31
assert 2125**8<X and 1333**8<Y
assert yb**100*Y**89>1 and 31**100<49**89
assert (6794*10**33)**100<(X*Y)**89/F(10**9)**100
# Full-strip affine Mellin envelope: product increases below b and affine part
# decreases above b. log(Y)>57 is more than needed for its positive derivative.
A=F(961,500); B=F(3343,5000); beta=F(111,200)
assert A-B*beta<F(13,8) and 57*(A-B*beta)>B
Jp=23000*xb*(277000*300000+28*10**9)
Js=4998000*yb*(231000*300000+567*10**6)
assert Jp==F(d['uniform_Jplus_per_modulus']['exact'])<F(5,10**9)
assert Js==F(d['uniform_Jstar_per_modulus']['exact'])<F(2,10**5)
Mp=F(79,20); Ms=F(13,8); h=F(4411,10**9); ds=F(2,10**12)
sq={
 'plus_excess_low_star':2*R*Mp**2*xp*Js,
 'star_excess_low_plus':2*R*Ms**2*ys*Jp,
 'star_excess_high_plus':2*R*Ms**2*ys*h**2*2400000,
 'plus_excess_star_remainder':8*R*xp*300000*ds**2,
 'excess_excess':8*R**2*Ms**2*xp*ys,
 'Aplus':8*R**3/F(100000**2)*F(6267,5000)**2*xp,
 'Astar':2*R**3/F(100000**2)*882*F(917,1000)**2*ys,
 'N':8*R*xp,
}
cap={k:F(v) for k,v in d['norm_coefficient_upper_bounds'].items()}
for k,v in sq.items():
 assert v==F(d['linear_norm_coefficient_squares'][k]['exact'])<cap[k]**2
crossnorm=F(192,10**6)+K*(cap['plus_excess_low_star']+cap['star_excess_low_plus']+cap['star_excess_high_plus']+cap['plus_excess_star_remainder'])+K*K*cap['excess_excess']
values={
 'Aplus':(F(7,10**5)+F(21,10**10)+K*cap['Aplus'])**2,
 'Astar':(F(4912,10**7)+K*cap['Astar'])**2,
 'Cross':crossnorm**2,
 'N':(F(192,1000)+F(2,10**9)+K*cap['N'])**2,
 'basegap_total':F(44797,10**6)+K*Ms*R/F(1333*316),
}
values['Astar_plus_Cross']=values['Astar']+values['Cross']
for k,v in values.items(): assert v==F(d[k]['exact'])
assert values['Aplus']<F(5,10**7)
assert values['Astar_plus_Cross']<F(95,10**8)
assert values['N']<F(123,100)
assert values['basegap_total']<F(4712,10**5)
assert values['Astar']>F(25,10**8) # Old optional split is NOT retained.

# Independent primitive census by divisor inversion of the totient, rather than
# the author's prime-power primitive formula.
n=300000
phi=list(range(n+1))
for p in range(2,n+1):
 if phi[p]==p:
  for j in range(p,n+1,p):phi[j]-=phi[j]//p
phi[1]=1
prim=phi.copy()
for c in range(1,n+1):
 for j in range(2*c,n+1,c):prim[j]-=prim[c]
active=lambda c:(c%2==1 and c<=150000) or c%4==0
census={True:[0,0],False:[0,0]}
for c in range(1,n+1):
 if active(c):
  census[c<=100000][0]+=1
  census[c<=100000][1]+=prim[c]
  assert F(c,phi[c])<R
  if c>100000:
   # Only ratios 1 and 2 can lie below max modulus 300000; ratio2 cannot
   # contribute when c is even because the Gauss support requires coprimality.
   eligible=[c]
   if c%2 and 2*c<=n:eligible.append(2*c)
   assert 3*c>n and len(eligible)<=2
assert census[True]==[75000,1847865075]
assert census[False]==[75000,3695775113]
out={'status':'PASS independent rational/support review; no spectral data',
 'author_receipt_sha256':hashlib.sha256(raw.read_bytes()).hexdigest().upper(),
 'budgets':{k:str(v) for k,v in values.items()},
 'joint_slack':str(F(95,10**8)-values['Astar_plus_Cross']),
 'retained_uniform':census[True], 'weighted_excess':census[False],
 'diagonal_coefficient_squares':{k:str(v) for k,v in sq.items()}}
dest=HERE/'review_weighted_excess_20261111.json'
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
