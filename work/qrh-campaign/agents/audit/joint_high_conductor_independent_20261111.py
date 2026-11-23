"""Independent exact scalar audit; no producer imports or spectral evaluation."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

checks = {}
def check(label, condition):
    if not condition:
        raise AssertionError(label)
    checks[label] = True

fx, fy = Q(11, 8), Q(27, 20)
check('x_endpoint_power', fx**200 > 49*10**25)
check('y_endpoint_power', fy**200 > 10**25)
check('mixed_tail_sqrt', Q(45,100000)**2 > Q(2,10**7))
check('scalar_low_star_sqrt', 74000**2 > 300000*18225)
check('scalar_low_plus_sqrt', 34**2 > 300000*Q(2,1000)*fx**2)
check('scalar_high_plus_sqrt', 274**2 > 300000*Q(1,4))

dplus, dstar = Q(2,10**15), Q(2,10**12)
extra = dplus*74000+dstar*34+dstar*274+dplus*dstar*180000000000
check('extra_exact', extra == Q(9550009,12500000000000000))
check('extra_cap', extra < Q(2,10**9))
ap = (Q(7,100000)*fx+Q(1,10000)+Q(2,10**9))**2
ast = (Q(49,100000)*fy+Q(12,10**7))**2
cross = (Q(32,10**6)*fx*fy+Q(45,100000)*fy+Q(2,10**9))**2
n = (Q(32,1000)*fx+Q(1,2)+Q(2,10**9))**2
check('Aplus_exact_and_cap', ap == Q('3.8514847504e-8') and ap < Q(5,10**7))
check('Astar_exact', ast == Q('4.3917129e-7'))
check('Cross_exact', cross == Q('4.44758277604e-7'))
check('combined_exact_and_cap', ast+cross == Q('8.83929567604e-7') and ast+cross < Q(95,10**8))
check('N_exact_and_cap', n == Q('0.295936002176000004') and n < Q(123,100))
check('N_display_requires_upward_rounding', n > Q('0.295936002176'))
check('Estar', (135+Q(2,10**6))**2 < 18226)

a, bp, bs = Q(101,100), Q(303,10**25), Q(303,10**19)
afull = a*Q(5,10**7)+Q(38122,100)*Q(285,100)*bp
qfull = a*a*Q(95,10**8)+Q(640208,10**6)*Q(285,100)*bs
qfull += a*bp*18226+a*bs*Q(12301,10000)+bp*bs*360000000000
acap, qcap = Q('5.050000000000330e-7'), Q('9.817952468e-7')
check('full_A', afull < acap)
check('full_Q', qfull < qcap)
check('first_cubic_sqrt', Q('37.41053338496')*acap < Q('.0043466')**2)
check('second_cubic_sqrt', 20*qcap < Q('.0044313')**2)
check('dynamic_loss', Q('.0043466')+Q('.0044313') < Q('.008778'))
check('major_lower', Q('1.052105346')-Q('.002834895')-Q('.008778') > Q('1.0404'))
check('nonprime_reserve', Q('1.0404')-Q('1.0376')-Q('.00271') == Q('.00009'))
check('unchanged_lower_J', (Q('2.94')-Q('.00020001')-Q('1e-9'))**2 > Q('8.6296'))

check('odd_ceiling_margin', 50000000-Q(290400000,7) > 150000)
check('even_ceiling_margin', 99000000-Q(580800000,7) > 300000)
check('odd_250_floor', Q(50000000,150000) > 250)
check('even_250_floor', Q(99000000,300000) > 250)
check('base_H831', Q(290400000,7*50000)+1 < 831)
check('base_count200000', 400*(Q(50*831,87)+2)+1 < 200000)
check('Gauss_weight548', 548**2 > 300000)
m = lambda b: Q(1922,1000)-Q(6686,10000)*b
check('M_global_positive', m(Q(7,8)) > 1)
check('product_beta_derivative', 8-Q(6686,10000) > 0)
check('M_beta_cap', m(Q(14,25)) < Q(13,8))
check('y_base_power', 25*Q(-11,25) == -11)
base = Q(12534,10000)*Q(21,4)/100000
base += 548*Q(13,8)*200000*Q(1,10**11)+548*Q(3,10**14)+549*Q(2,10**9)
check('base_exact_and_cap', base == Q('.00184790151644') and base < Q('.0026') < Q('.04712'))

out = {'scope':'Exact rational and integer comparisons only; high-tail bounds remain analytic inputs.',
       'checks':checks,
       'values':{k:str(v) for k,v in {'extra':extra,'Aplus':ap,'Astar':ast,'Cross':cross,
           'combined':ast+cross,'N':n,'Afull':afull,'Qfull':qfull,'basegap':base}.items()},
       'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
with Path(__file__).with_suffix('.json').open('x', encoding='utf-8') as f:
    json.dump(out,f,indent=2)
    f.write('\n')
print(json.dumps({'status':'PASS','checks':len(checks),'N':str(n)}))
