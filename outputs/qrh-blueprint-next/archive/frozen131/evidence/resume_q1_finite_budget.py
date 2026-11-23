"""Exact q1 finite-strip sufficiency budget. The finite strip is UNPROVED.
Uses the already selected shared b=.555 family contract, without greater height.
"""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json
Y=10**25;b=F(111,200);dmax=95000
ceil=lambda x:(x.numerator+x.denominator-1)//x.denominator
H=ceil(F(484,7)*dmax);Hshared=ceil(200+max(F(300),F(484,7)*600000))
N=ceil(400*(2*F(H)/F('3.48')+2))
assert H<=Hshared
# Fresh radius-3 Jensen windows, not count_line_windowG (which assumes RH).
height=F(H)+F('3.48')
BPz2=9200*(height+22)*(F('1.25')*(height+11))**9+20*(height+22)**3*(F('1.25')*(height+11))**2
assert BPz2/F('.355')<F(10,3)**400
assert 2**2+F('1.74')**2<3**2
assert F('2.719')<F(10,3) and 10*F('4.4')<53
power=F('7.5e-12');assert power**200*Y**89>1
low=4*N*power
# Reviewed count-window/geometric tail argument with the expanded actual twist.
G=3+F(dmax)/F('2.7');window=803*G
assert G/H<F(1,39)
exp_lower=lambda x,n:sum((x**j/F(factorial(j)) for j in range(n+1)),F(0))
EA=F('.588')*22**2/exp_lower(F('.1065')*22**2,220)
assert EA<F('2e-20')
EAcoeff=2*window*EA
EBcoeff=2*F('.892')*250*(5*250+2500)/exp_lower(F('.1598')*250,200)
assert EBcoeff<F('1e-11')
assert 1333**8<Y
high=(EAcoeff+EBcoeff)/1333
assert high<F('1e-14')
# Actual etaU contour constant from existing all-twist vertical derivation.
vertical=F('5e16')/F(10**37) # sqrt(Y)>=1e12, henceY^(3/2)>=1e37
assert vertical<F('1e-19')
main=F('1.016')/F(600000,49)**2
assert main<F('7e-9')
parity=F('4e-9')
total=low+high+vertical+main+parity
assert total<F('.04712')
assert total<F('.04530054')
out={'status':'Conditional sufficient budget only. Requires the SAME unproved shared finite b=.555 spectral certificate and global QRH, plus etaU explicit-formula bridges. No new final premise is admitted.','q_reduced':1,'original_moduli':[1,2],'u_min':'1200000/49','u_max':190000,'effective_etaU_twist_min':'600000/49','effective_etaU_twist_max':dmax,'H_used':H,'H_shared_plus1':Hshared,'N_low_upper':N,'power_upper':str(power),'low_upper':str(low),'tail_upper':str(high),'vertical_upper':str(vertical),'fourier_upper':str(main),'parity_upper':str(parity),'total_upper_decimal':float(total),'gap_below_uniform_ghat_floor':float(F('.04712')-total),'total_upper':str(total)}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2))
print(json.dumps({k:v for k,v in out.items() if k not in ['tail_upper','total_upper']},indent=2))
