"""Independent exact coefficient-grid allowance audit, without coefficient data."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
OWN = Path(__file__).resolve().parent
AUTHOR = ROOT/'work/qrh-campaign/agents/integration'
EXPECTED = {
    'CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md':'B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815',
    'RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md':'9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4',
    'residue_coefficient_grid_closure_20261111.py':'75E355AC1E89ADB76D1B9F2254C74E35C818852E9BE67B8504EFF4CBE0B84B93',
    'residue_coefficient_grid_closure_20261111.json':'28206373F718F044394C5E2E34C193B300BECA3416FFC523E10AAA333565E0DE',
}
checks = 0
def check(x):
    global checks
    assert x
    checks += 1
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest().upper()

for p,h in EXPECTED.items(): check(sha(AUTHOR/p) == h)
data = json.loads((AUTHOR/'residue_coefficient_grid_closure_20261111.json').read_text())
for p,h in data['pins'].items(): check(sha(ROOT/p) == h)
unit = Q(1,2**100)
alpha = Q(1,2**82)
geometric = sum(Q(1,4)**j for j in range(20))
check(geometric == Q(4,3)*(1-Q(1,4)**20))
check(633*geometric < 844)
old_round = 633*Q(8,3)*unit
check(old_round == 1688*unit)
early_tail = 1266*(Q(5,16)**20/factorial(20)+Q(15,16)**27/factorial(27))
early_other = 2532*unit+633*(20*27-210)*Q(1,2**110)
last_tail = 1266*(Q(7000+20,4*8192)**20/factorial(20)
                   +Q(5*(7000+28),8*4096)**28/factorial(28))
last_other = 844*unit
check((early_tail+early_other+old_round)/alpha == Q(data['old_first_alpha_fraction']))
check((last_tail+last_other+old_round)/alpha == Q(data['old_final_alpha_fraction']))
check(early_tail+early_other+old_round < alpha/3)
check(last_tail+last_other+old_round < Q(4,25)*alpha)
check(Q(1,4)+Q(1,4) < 1)  # two coordinate half-step squared errors
rows = []
for row in data['rows']:
    b = row['b']
    check(b in [100,122] and row['final_g'] == 100)
    quantum = Q(1,2**b)
    bound = 844*quantum+633*unit
    check(bound < old_round)
    check(Q(row['character_evaluation_error']) == bound)
    check(Q(row['allowance_reserve']) == old_round-bound)
    check(Q(row['first_alpha_fraction']) == (early_tail+early_other+bound)/alpha)
    check(Q(row['final_alpha_fraction']) == (last_tail+last_other+bound)/alpha)
    check(4*(3*3387+5)+1 == 40665)
    check(6*(3*1500+7)+1 == 27043)
    check(40665+quantum < 2**16 and 27043+quantum < 2**16)
    den = 2**b*(2*265800)**19
    check(den.bit_length() == b+362)
    for factor,field in [(36,'long_live_signed_bits'),(37,'long_add_signed_bits'),
                         (37,'screened_live_signed_bits'),(38,'screened_add_signed_bits')]:
        check((2**factor*den).bit_length()+1 == row[field])
    check((2**(b-100)*(2*265800)**19).bit_length() == row['final_round_denominator_bits'])
    check(b+17 == row['coefficient_signed_bits'])
    # Algebraic dyadic/rational rounding fixtures. These are not source values.
    for exponent in [0,94,100,110,122,137]:
        for odd in [1,3,17]:
            for n in range(-19,20):
                value = Q(n,odd*2**exponent)
                scaled = value*2**b
                q,r = divmod(scaled.numerator,scaled.denominator)
                rounded = q+int(2*r >= scaled.denominator)
                err = Q(rounded,2**b)-value
                check(abs(err) <= quantum/2)
                check((2*rounded-1)*scaled.denominator <= 2*scaled.numerator
                      < (2*rounded+1)*scaled.denominator)
    rows.append({'b':b,'allowance':str(bound),'reserve':str(old_round-bound),
                 'long_live_signed_bits':row['long_live_signed_bits'],
                 'screened_live_signed_bits':row['screened_live_signed_bits']})
check(844+633 == 1477 and 1688-1477 == 211)
check(data['rounds_per_unique_coefficient_array'] == 20)
for key,tail,other in [('optional_b122_added_to_old_first_fraction',early_tail,early_other),
                      ('optional_b122_added_to_old_final_fraction',last_tail,last_other)]:
    check(Q(data[key]) == (tail+other+old_round+844*Q(1,2**122))/alpha)
check(Q(data['optional_b122_added_to_old_final_fraction']) < Q(151867,10**6))
check(Q(data['optional_b122_added_to_old_first_fraction']) < Q(1,3))
# Mixed fallback must retain the old cap, not claim the all-adapter cap.
for selected in range(21):
    mixture = Q(selected,20)*1477+Q(20-selected,20)*1688
    check(mixture <= 1688)
    check((mixture <= 1477) == (selected == 20))

result = {'scope':'Exact scalar and representation checks only; no source coefficients evaluated',
          'checks':checks,'source_pins':data['pins'],'rows':rows,'author_pins':EXPECTED,
          'author_script_sha256':sha(AUTHOR/'residue_coefficient_grid_closure_20261111.py'),
          'author_receipt_sha256':sha(AUTHOR/'residue_coefficient_grid_closure_20261111.json')}
dest = OWN/'review_residue_coefficient_grid_20261111.json'
with dest.open('x',encoding='utf-8') as f:
    json.dump(result,f,indent=2)
    f.write('\n')
print(json.dumps({'checks':checks,'receipt_sha256':sha(dest)}))
