from fractions import Fraction as F
import json
f=lambda x:F(str(x))
checks={
 'coarse_psi':f('1.387')+2*F(19,10000)<f('1.4'),
 'C_log2':f('1.4')*f('.7')==f('.98'),
 'factorial_margin_at_cut':F(10**9,100)>f('7.8'),
 'log100_bound':f('2.7')**5>100,
 'middle_range':10**9//2>=10**8,
 'finite_psi_margin':1+f('1.5262')/1000<f('1.03883'),
 'compact_sqrt':700**2<500000,
 'compact_log':f('2.7')**14>500000,
 'compact_log1000':f('2.7')**7>1000,
 'compact_psi':f('1.387')+2*F(14,700)<f('1.43'),
 'compact_C_log2':f('1.43')*f('.694')==f('.99242'),
 'compact_final':f('.00658')*10**6>f('9.86'),
 'RS_P4':1+f('.0047629')<f('1.0064'),
 'RS_P5':1+3*f('.0047629')+F(10**12,(25*10**6)**2)<f('1.022'),
 'RS_overlap':f('2.72')**20<10**9,
}
assert all(checks.values()),checks
print(json.dumps({'checks':checks,'RS_P5_safe_coefficient':str(1+3*f('.0047629')+F(10**12,(25*10**6)**2))},indent=2))