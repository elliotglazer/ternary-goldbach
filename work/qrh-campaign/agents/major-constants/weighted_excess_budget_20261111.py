"""Exact sufficient-budget arithmetic; no zero data or spectral evaluation."""
from fractions import Fraction as F
from pathlib import Path
import json

R=F(21,4); C=100000; K=6
X2=F(1,2125**2); Y2=F(1,1333**2)
Yb=F(5625,10**26); Xb=Yb/31
Mp=F(79,20); Ms=F(13,8); U=F(6267,5000); P=F(917,1000)
alpha=F(20000,87)
assert 31**100<49**89
assert F(30030,5760)<R
assert alpha*1201+801<277000
assert alpha*F(704,7)*1200000<28*10**9
assert alpha*1001+801<231000
assert alpha*F(704,343)*1200000<567*10**6
Jp=23000*Xb*(277000*300000+28*10**9)
Js=4998000*Yb*(231000*300000+567*10**6)
assert Jp<F(5,10**9) and Js<F(2,10**5)
h=F(4411,10**9); ds=F(2,10**12)
assert F(4406144734183,10**18)+F(2,10**15)<h
assert F(1,10**9)<F(31998,10**9)**2
assert F(31998,10**9)+F(160001,10**9)<F(192,10**6)

# Each coefficient multiplies K in norm, except excess/excess, which multiplies K^2.
coeff_sq={
 'plus_excess_low_star':2*R*Mp**2*X2*Js,
 'star_excess_low_plus':2*R*Ms**2*Y2*Jp,
 'star_excess_high_plus':2*R*Ms**2*Y2*h*h*2400000,
 'plus_excess_star_remainder':2*R*4*X2*300000*ds*ds,
 'excess_excess':8*R*R*Ms**2*X2*Y2,
 'Aplus':2*R**3/C**2*4*U**2*X2,
 'Astar':2*R**3/C**2*882*P**2*Y2,
 'N':8*R*X2,
}
caps={
 'plus_excess_low_star':F(267,10**7),
 'star_excess_low_plus':F(27,10**8),
 'star_excess_high_plus':F(27,10**6),
 'plus_excess_star_remainder':F(4,10**12),
 'excess_excess':F(852,10**8),
 'Aplus':F(3,10**7),
 'Astar':F(348,10**8),
 'N':F(31,10**4),
}
for name,sq in coeff_sq.items():assert sq<caps[name]**2,name
crossnorm=F(192,10**6)+K*sum(caps[n] for n in ['plus_excess_low_star','star_excess_low_plus','star_excess_high_plus','plus_excess_star_remainder'])+K*K*caps['excess_excess']
astar=(F(4912,10**7)+K*caps['Astar'])**2
aplus=(F(7,10**5)+F(21,10**10)+K*caps['Aplus'])**2
n=(F(192,1000)+F(2,10**9)+K*caps['N'])**2
joint=astar+crossnorm**2
assert aplus<F(5,10**7)
assert joint<F(95,10**8)
assert crossnorm**2<F(7,10**7)
assert n<F(123,100)
base_extra=K*Ms*R/F(1333*316)
assert 316**2<C
assert F(44797,10**6)+base_extra<F(4712,10**5)

# A bounded integer conductor census. No individual character or zero enumeration.
limit=300000
spf=list(range(limit+1))
for p in range(2,int(limit**.5)+1):
 if spf[p]==p:
  for j in range(p*p,limit+1,p):
   if spf[j]==j:spf[j]=p
def primitive(c):
 if c==1:return 1
 result=1
 while c>1:
  p=spf[c];e=0
  while c%p==0:c//=p;e+=1
  result*=p-2 if e==1 else p**(e-2)*(p-1)**2
 return result
groups={'retained_uniform':{'conductors':0,'primitive_characters':0},'weighted_excess':{'conductors':0,'primitive_characters':0}}
for c in range(1,limit+1):
 if not ((c%2 and c<=150000) or c%4==0):continue
 group=groups['retained_uniform' if c<=C else 'weighted_excess']
 group['conductors']+=1;group['primitive_characters']+=primitive(c)
assert sum(g['primitive_characters'] for g in groups.values())==5543640188
def encode(q):return {'exact':str(q),'decimal_diagnostic':float(q)}
out={'status':'Exact conditional scalar bounds only; no spectral assertion',
 'effective_excess_budget':K,'conductor_threshold_strictly_above':C,
 'linear_norm_coefficient_squares':{k:encode(v) for k,v in coeff_sq.items()},
 'norm_coefficient_upper_bounds':{k:str(v) for k,v in caps.items()},
 'uniform_Jplus_per_modulus':encode(Jp),'uniform_Jstar_per_modulus':encode(Js),
 'Aplus':encode(aplus),'Astar':encode(astar),'Cross':encode(crossnorm**2),
 'Astar_plus_Cross':encode(joint),'N':encode(n),
 'basegap_total':encode(F(44797,10**6)+base_extra),'conductor_census':groups}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
