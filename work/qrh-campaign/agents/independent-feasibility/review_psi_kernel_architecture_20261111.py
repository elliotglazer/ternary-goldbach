"""Structural/math replay only: no Lean, no large masks, no full-range sieve."""
from pathlib import Path
from fractions import Fraction as F
from math import isqrt
import json,hashlib,runpy,contextlib,io

HERE=Path(__file__).resolve().parent
P=HERE.parent/'prime-estimates'
D=P/'psi_full_candidate_20261111'
load=lambda p:json.loads(p.read_text())
expected=load(P/'resume_psi_kernel_replay_sizing_20261111.json')
buf=io.StringIO()
with contextlib.redirect_stdout(buf):
    runpy.run_path(str(P/'resume_psi_kernel_replay_sizing_20261111.py'))
assert json.loads(buf.getvalue())==expected

# Independent small prime base. This is NOT a Lean certificate.
primes=[]
for n in range(2,70711):
    if all(n%p for p in primes if p<=isqrt(n)):
        primes.append(n)
assert primes==load(D/'base_primes.json')['primes']
assert len(primes)==7004 and primes[-1]==70709
assert 266**2==70756 and 70711**2==5000045521>5*10**9
first=load(P/'resume_psi_short_gap_20261111.json')
rows=[{'a':10**9,'b':first['pilot_endpoint'],'count':first['pilot_count'],
       'subwindows':first['pilot_subwindows'],'log_box':first['pilot_log_box'],
       'theta_lower':first['pilot_theta_lower'],'theta_upper':first['pilot_theta_upper']}]
for f in ['resume_psi_multi32_20261111.json','resume_psi_stress512_20261111.json']:
    rows.extend(load(P/f)['windows'])
for f in sorted(D.glob('batch_*.json')):
    rows.extend(load(f)['windows'])
assert len(rows)==6439

S=10**9
endpoint=10**9
L,U=999967635190289132,999970323068320645
ell=20723265833
cells=bits=0
lengths=[]
assert endpoint*(S-S//10000)<=L and U<=endpoint*(S+S//10000)
for w in rows:
    a,b=w['a'],w['b']
    assert a==endpoint and b==min(5*10**9,a+a//4000)
    cursor=a
    count=0
    for c in w['subwindows']:
        assert c['n']==cursor and 0<c['width']<=32768
        assert 0<=c['count']<=c['width']
        assert 70710<=cursor and cursor+c['width']<70711**2
        cursor+=c['width']; count+=c['count']; cells+=1
    assert cursor==b and count==w['count']
    bits+=count; lengths.append(len(w['subwindows']))
    lo,hi=w['log_box']
    assert 0<=hi-lo<=100
    L+=count*ell; U+=count*hi
    storedL=w.get('theta_lower_scaled',F(w.get('theta_lower','0'))*S)
    storedU=w.get('theta_upper_scaled',F(w.get('theta_upper','0'))*S)
    assert L==storedL and U==storedU
    assert b*(S-S//10000)<=L and U<=b*(S+S//10000)
    ell=lo; endpoint=b
assert endpoint==5*10**9 and cells==125271 and bits==184106689
assert (L,U)==(4999882220821805278,4999930929840072558)

bitlength=[p*((131072-1)//p)+1 for p in primes]
ours={
 'pattern_payload_bytes_rounded_individually':sum((l+7)//8 for l in bitlength),
 'pattern_payload_bytes_fixed_width_upper':len(primes)*16384,
 'pattern_hex_digits_no_leading_zeros':sum((l+3)//4 for l in bitlength),
 'pattern_hex_digits_fixed_width_upper':len(primes)*32768,
 'pattern_chunks_of_64':110,'last_pattern_chunk_size':28,
 'base_integer_chunks_of_256_for_0_through_70710':277,
 'windows':len(rows),'subcells':cells,'subcells_per_window_min':min(lengths),
 'subcells_per_window_max':max(lengths),'count_modules_at_128_declarations':979,
 'syntactic_one_pass_base_leaf_visits':cells*len(primes),'syntactic_pcL7_leaf_occurrences':cells*128,
 'syntactic_one_pass_outer_chunk_result_visits':cells*110,
 'syntactic_one_pass_outer_binary_ors':cells*109,
 'syntactic_one_pass_all_binary_ors':cells*7003,
 'dynamic_kernel_work_bound_claimed':False,
 'true_prime_bits_over_all_cells':bits,
 'materialized_all_cell_masks_bytes_fixed_width':cells*4096,
 'new_endpoint_log_boxes':len(rows),'new_log_boolean_checks':2*len(rows)}
for k,v in ours.items(): assert expected[k]==v,k
assert 32768+70710==103478<131072
assert 64*109+28==7004 and 6+7==13
actual_or={'inner_binary_OR_operations':cells*(7004-110),
           'outer_binary_OR_operations':cells*109,
           'total_binary_OR_operations':cells*7003,
           'outer_chunk_result_visits':cells*110}
assert actual_or['outer_binary_OR_operations']==13654539
assert actual_or['total_binary_OR_operations']==877272813

# Exact endpoint interpolation coefficients. Real functions require floor.
low=F(1,4000)+F(1,10000)
high=F(1,4000)+(F(1,10000)+F(17,360000))*F(4001,4000)
assert low==F(7,20000) and high==F(572053,1440000000)
assert low<F(1,2300) and high<F(1,2300)
assert 31622**2<10**9
assert F('1.4262')/31622<F(17,360000)
assert F('2.7')**23>5*10**9

files=[P/'RESUME_PSI_KERNEL_REPLAY_ARCHITECTURE_2026-11-11.md',
       P/'resume_psi_kernel_replay_sizing_20261111.py',
       P/'resume_psi_kernel_replay_sizing_20261111.json']
out={'status':'PASS: external structural/math replay; no new Lean or full-range count proof',
     'input_sha256':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in files},
     'all_grid_and_cell_endpoints_checked':True,'all_theta_states_recomputed':True,
     'complete_small_base_recomputed':True,'sizing':ours,
     'balanced_tree_operations_syntactic_only':actual_or,
     'final_theta_scaled':[L,U],
     'lower_interpolation_coefficient':str(low),'upper_interpolation_coefficient':str(high)}
HERE.joinpath('review_psi_kernel_architecture_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
