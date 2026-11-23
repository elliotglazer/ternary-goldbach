"""Independent saved-data, integer and Fraction checks. No function evaluation."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial, comb, lcm
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
PINS = {
    'independent-feasibility/FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md': '19DB61735647D0267954692733C2CF045B977D540A4CF55B5DBDB1145EE82CB8',
    'independent-feasibility/finite_em_rational_cost_inventory_20261111.py': 'B638E79245CADF189561F81D37393369A5A7D527628410C2462BA58386B35CB9',
    'independent-feasibility/finite_em_rational_cost_inventory_20261111.json': '58FBCA32FBC3D472649EA4B3E31C6C9EB864408A83082346789F3E1FCD6B0782',
}
checks = []
def check(name, truth):
    assert truth, name
    checks.append(name)
for path, pin in PINS.items():
    check('pin ' + path, hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper() == pin)
inv = json.loads((ROOT/'independent-feasibility/finite_em_rational_cost_inventory_20261111.json').read_bytes())
for path, data in inv['files'].items():
    raw = (ROOT/path).read_bytes()
    check('input hash ' + path, hashlib.sha256(raw).hexdigest().upper() == data['sha256'])
    check('input bytes ' + path, len(raw) == data['bytes'])
candidate = json.loads((ROOT/'integration/small_em_batch_candidate_20261111_01.json').read_bytes())
def compact_bytes(value):
    return len(json.dumps(value, separators=(',', ':'), ensure_ascii=True).encode())
target = {k:candidate[k] for k in ('parameters','analytical_budget','g_jets','panels','endpoints')}
slice7 = {k:candidate[k] for k in ('parameters','analytical_budget')}
slice7.update(g_jets=[candidate['g_jets'][7]], panels=[candidate['panels'][7]], endpoints=candidate['endpoints'][7:9])
check('full target bytes', compact_bytes(target) == 68025 == inv['whole_target_compact_json_bytes'])
check('j7 target bytes', compact_bytes(slice7) == 10799 == inv['j7_slice_compact_json_bytes'])
for key, data in inv['sections'].items():
    check('section bytes ' + key, compact_bytes(candidate[key]) == data['compact_json_bytes'])
zero_count = sum(int(row['radius']['mantissa']) == 0 for row in candidate['moments'])
check('moment partition counts', zero_count == 10368 and len(candidate['moments'])-zero_count == 1920)
expected_ranges = [(1,2,0),(3,10,-1),(11,50,-2),(51,244,-3),(245,1024,-4)]
for lo,hi,q in expected_ranges:
    rows = candidate['bins'][lo-1:hi]
    check('saved q range ' + str(q), len(rows)==hi-lo+1 and all(row['n']==n and row['q']==q and row['k']==q%32 for n,row in zip(range(lo,hi+1),rows)))

# Independently construct the ordinary Bernoulli recurrence, not evaluator code.
bern = [F(1)]
for n in range(1,33):
    bern.append(-sum((F(comb(n+1,k))*bern[k] for k in range(n)),F(0))/F(n+1))
factor_den = 1
for m,row in enumerate(candidate['corrections']['bernoulli'],1):
    factor = bern[2*m]/factorial(2*m)/1025**(2*m-1)
    stored = F(int(row['factor']['numerator']),int(row['factor']['denominator']))
    check('Bernoulli factor ' + str(m), factor == stored)
    factor_den = lcm(factor_den,factor.denominator)
check('factor lcm', str(factor_den)==inv['factor_common_denominator'] and factor_den.bit_length()==443)

b,g,dc = 1025,513,10000
dm = 2**(39*b+23)*factorial(15)*factorial(23)
dd = 2**(g+15*b)*factorial(15)
dr = lcm(2,dc**31*factor_den)
dq = dc*dr
de = 2**(15*b)*factorial(15)
computed = {
 'uniform_moment_denominator_bits':dm.bit_length(),
 'uniform_direct_main_denominator_bits':dd.bit_length(),
 'correction_R_denominator_bits':dr.bit_length(),
 'correction_Q_denominator_bits':dq.bit_length(),
 'log_B_coefficient_common_denominator_bits':de.bit_length(),
 'fresh_phase_full_correction_denominator_bits':(dq*de*2**b).bit_length(),
 'FFT_one_stage_denominator_exponent':g+b+1,
 'FFT_no_interstage_rounding_denominator_exponent':g+5*(b+1),
 'exact_contraction_denominator_exponent_before_scale':g+3*23,
 'phase_step_product_denominator_exponent':g+b,
}
for key,value in computed.items():
    check('denominator ' + key, value==inv['denominator_designs'][0][key])
for h in range(16):
    check('direct common denominator h'+str(h), dd % (2**(g+b*h)*factorial(h)) == 0)
    for m in range(24):
        check('moment common denominator h'+str(h)+'m'+str(m), dm % (2**(b*(1+h+m)+m)*factorial(h)*factorial(m)) == 0)
check('fresh versus reused phase bits', (dq*de*2**b).bit_length()-(dq*de*2**g).bit_length()==512)
check('elementary example exceeds stated bits', (2**(1025*512)*factorial(512)).bit_length()>524800)

eps = F(1,2**512)
phase = 8193*eps
for j in range(8):
    check('direct phase bound j'+str(j), phase < 2**15*eps)
    if j<7:
        phase=(1+2*eps)*phase+3*eps
term=(2**15*2**45+2**46)*eps
main=1024*term+eps
correction=2**48*(2**15*2**13+2**13)*eps+eps
assembly=2002*main+correction+eps
check('direct term error',term<2**61*eps)
check('direct main error',main<2**72*eps)
check('direct correction error',correction<2**78*eps)
check('direct assembly error',assembly<2**84*eps<F(1,2**53))

count = inv['symbolic_counts']
check('batch main count',count['batch']['moment_contributions']==1024*16*24==393216)
check('batch recurrence count',count['batch']['residual_recurrence_steps']==1024*16*23==376832)
check('batch butterflies',count['batch']['butterflies']==16*24*16*5==30720)
check('batch gates exact',count['batch']['total_named_gates_exact_Horner']==12288+61440+3*128==74112)
check('batch gates affine',count['batch']['total_named_gates_24_Horner_updates']==12288+61440+27*128==77184)
check('direct certificate count',count['direct_phase_reuse']['complex_base_and_step_certificates']==2*1025==2050)
check('direct recurrence count',count['direct_phase_reuse']['phase_recurrence_products']==7*1025==7175)
check('direct main count',count['direct_phase_reuse']['main_coefficient_contributions']==8*1024*16==131072)
check('direct named gates',count['direct_phase_reuse']['total_named_gates']==8*1025+3*128==8584)
check('correction schedule',count['shared']['correction_multiplications_upper']==8*((3*16+2)*16+16*17//2)==7488)
check('image schedule',count['shared']['rational_image_Horner_complex_products']==17*15==255)

out={'status':'PASS_EXACT_SCALAR_AND_SAVED_DATA_REVIEW','input_pins':PINS,
     'scope':'Saved-data inventory, exact integer/Fraction scalars and Bernoulli recurrence only. No elementary/model/FFT evaluation or author script execution.',
     'checks':checks,'check_count':len(checks),'denominator_results':computed,
     'direct_phase_reuse_bounds':{'phase':'2^15 eps','main':'2^72 eps','correction':'2^78 eps','assembly':'2^84 eps','eps':'2^-512'}}
HERE.joinpath('review_finite_em_rational_cost_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps({'status':out['status'],'check_count':len(checks),'denominators':computed}))
