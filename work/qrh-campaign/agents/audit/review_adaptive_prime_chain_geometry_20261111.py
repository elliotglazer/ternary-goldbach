"""Saved integer geometry only, with no prime or modular-power evaluations."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
source = HERE.parent/'major-constants'/'adaptive_prime_chain_geometry_20261111.json'
raw = source.read_bytes()
assert hashlib.sha256(raw).hexdigest().upper() == 'E5388691D293161EF4E8FC863AAF4E1C2C2419632CD555D2CD320F6709FEABF5'
data = json.loads(raw)
N, T, F = 10**27, 10**27-1, 2**45
assert data['N'] == N and data['T'] == T and N < F*F < (F+1)**2

def ceiling(a, b):
    return -((-a)//b)

checks = 0
for row, stride in zip(data['rows'], [157,313,111616], strict=True):
    B = row['B']
    H, R = divmod(B-2,F)
    kt = ceiling(T-B-1,F)
    k0 = B//F
    assert row['H'] == H and row['lattice_remainder'] == R
    assert row['target_k'] == kt and row['first_k_max'] == k0
    assert (kt-1)*F+1+B < T <= kt*F+1+B
    assert row['deficit_width'] == (H-1).bit_length()
    assert row['necessary_new_primes_all_formats'] == max(0,ceiling(T-B-3,B-2))
    bound = 1+max(0,ceiling(kt-k0,H))
    assert row['necessary_same_F_records'] == bound
    assert k0+(bound-1)*H >= kt and k0+(bound-2)*H < kt
    assert row['old_fixed_window_count'] == (T-5)//(stride*F)
    for item in row['conditional_bounds']:
        jump = H-item['deficit_max']
        assert jump > 0 and item['min_k_jump'] == jump
        upper = 1+max(0,ceiling(kt-1,jump))
        assert item['record_count_upper_if_success'] == upper
        assert 1+(upper-1)*jump >= kt
    checks += 1

for row in data['encoding_boundary_examples']:
    p,B,f = row['previous'],row['B'],row['F']
    lo,hi = (p-1)//f+1,(p+B-3)//f
    assert row['lower_k'] == lo and row['upper_k'] == hi
    assert row['count'] == max(0,hi-lo+1)
    for k in range(max(0,lo-1),hi+2):
        assert (p<k*f+1<=p+B-2) == (lo<=k<=hi)
    checks += 1

for row in data['batches']:
    n = row['factors']
    assert row['product_bit_bound'] == row['root_payload_bit_upper'] == 90*n
    assert row['product_multiplications'] == n-1
    assert row['common_root_squares'] == 44 and row['direct_root_squares'] == 44*n
    assert row['schoolbook_square_work_ratio_common_to_direct'] == n
    checks += 1

out = {'status':'PASS','scope':'saved integer geometry only; no certificate or prime evaluation',
       'source_sha256':hashlib.sha256(raw).hexdigest().upper(),
       'row_groups_checked':checks,'geometry_rows':3,'encoding_examples':4,'batch_rows':6,
       'candidate_primes_evaluated':0}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
