"""Exact scalar consequences of the proposed joint spectral profile.

No spectral data are evaluated here. The three high-tail caps are premises
that require the separately reviewed conductor calculation.
"""
from fractions import Fraction as F
from pathlib import Path
import json

checks = {}
values = {}

def verify(name, proposition):
    assert proposition, name
    checks[name] = True

def retain(name, value):
    values[name] = str(value)
    return value

fx, fy = F(11, 8), F(27, 20)
verify('endpoint_x_factor', fx**200 > 49*10**25)
verify('endpoint_y_factor', fy**200 > 10**25)
verify('mixed_tail_root', F('2e-7') < F('.00045')**2)
verify('low_star_error_root', 300000*10000*fy**2 < 74000**2)
verify('low_plus_error_root', 300000*F('.002')*fx**2 < 34**2)
verify('high_plus_error_root', 300000*F(1, 4) < 274**2)

d0, ds = F('2e-15'), F('2e-12')
extra = retain('mixed_extra', d0*74000+ds*34+ds*274+d0*ds*180000000000)
verify('mixed_extra_cap', extra < F('2e-9'))
ap = retain('Aplus_c', (F('.00007')*fx+F('.0001')+F('2e-9'))**2)
ast = retain('Astar_c', (F('.00049')*fy+F('1.2e-6'))**2)
cross = retain('Cross_c', (F('.000032')*fx*fy+F('.00045')*fy+F('2e-9'))**2)
combined = retain('Astar_plus_Cross', ast+cross)
n = retain('N', (F('.032')*fx+F('.5')+F('2e-9'))**2)
verify('Aplus_cap', ap < F('5e-7'))
verify('combined_cap', combined < F('9.5e-7'))
verify('N_cap', n < F('1.23'))
estar = retain('unweighted_Estar', (100*fy+F('2e-6'))**2)
verify('unweighted_Estar_cap', estar < 18226)

a, bp, bs = F('1.01'), F('3.03e-23'), F('3.03e-17')
afull = retain('Afull_from_selected_cap', a*F('5e-7')+F('381.22')*F('2.85')*bp)
qfull = retain('Qfull_from_selected_caps', a*a*F('9.5e-7')+F('.640208')*F('2.85')*bs
    +a*bp*18226+a*bs*F('1.2301')+bp*bs*F('3.6e11'))
verify('Afull_cap', afull < F('5.050000000000330e-7'))
verify('Qfull_cap', qfull < F('9.817952468e-7'))
verify('cubic_first_root', F('37.41053338496')*F('5.050000000000330e-7') < F('.0043466')**2)
verify('cubic_second_root', 20*F('9.817952468e-7') < F('.0044313')**2)
verify('cubic_dynamic_cap', F('.0043466')+F('.0044313') < F('.008778'))
verify('major_cap', F('1.052105346')-F('.002834895')-F('.008778') > F('1.0404'))
verify('final_reserve', F('1.0404')-F('1.0376')-F('.00271') == F('.00009'))

# The two parity profiles dominate the original full-twist base-gap cutoff.
verify('odd_ceil_slack', F(50000000)-F(290400000, 7) > 150000)
verify('even_ceil_slack', F(99000000)-F(580800000, 7) > 300000)
verify('odd_height_floor', F(50000000, 150000) > 250)
verify('even_height_floor', F(99000000, 300000) > 250)
verify('base_count_cap', 400*(F(50*831, 87)+2)+1 < 200000)
verify('gauss_weight_root', 300000 < 548**2)
verify('mellin_product_cap', F('1.922')-F('.6686')*F(14, 25) < F(13, 8))
base = retain('affected_base_gap', F('1.2534')*F(21, 4)/100000
    +548*F(13, 8)*200000*F('1e-11')+548*F('3e-14')+549*F('2e-9'))
verify('affected_base_gap_cap', base < F('.0026') < F('.04712'))

receipt = {'status': 'PASS_CONDITIONAL_SCALAR_BUDGET',
    'premises': {'integrated_high_tail': '1/4',
                 'high_times_old_low_star': '1/5000000',
                 'weighted_Aplus_high_tail': '1/100000000'},
    'checks': checks, 'values': values}
with Path(__file__).with_suffix('.json').open('x', encoding='utf-8') as stream:
    json.dump(receipt, stream, indent=2)
    stream.write('\n')
print(json.dumps({'status': receipt['status'], 'checks': len(checks), 'values': values}))
