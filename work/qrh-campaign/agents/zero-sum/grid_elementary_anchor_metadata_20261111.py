"""Integer/Fraction metadata only; no elementary-function evaluations."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

BASE = Path(__file__).parent
PINS = {
    '../integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md': '1e1d5099d398ee978d635729873f4d3941bc186bd91d086198b39962df8e564e',
    '../major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md': '60b4bc4414a75b90bf036e0cba2cab6f12c270cf7de1f45c767341d872d383e9',
}
for name, pin in PINS.items():
    assert hashlib.sha256((BASE/name).read_bytes()).hexdigest() == pin

def grid(D):
    stop = 3389*D
    n = D
    anchors = []
    while n <= stop:
        count = min(n//128, stop-n+1)
        assert count >= 1 and F(count-1, n) <= F(1,128)
        anchors.append((n, count))
        n += count
    total = stop-D+1
    assert sum(k for _, k in anchors) == total and n == stop+1
    return dict(D=D, total_points=total, anchor_count=len(anchors),
                nonanchor_points=total-len(anchors), max_block_points=max(k for _,k in anchors),
                denominator_bound=stop, denominator_bits=stop.bit_length(),
                first_blocks=anchors[:3], last_blocks=anchors[-3:],
                anchor_plan_sha256=hashlib.sha256(json.dumps(anchors,separators=(',',':')).encode()).hexdigest())

rows=[]
for p in (64, 121, 128, 135, 192, 256, 512):
    E=F(1,2**p)
    K=max(1,(p+10)//7-1)
    tail=2*F(1,128)**(K+1)
    assert tail <= E/8
    if K>1: assert 2*F(1,128)**K > E/8
    Q=1
    while 12*2*F(1,3)**(2*Q+1)/((2*Q+1)*(1-F(1,9))) > E/8:
        Q += 1
    # Full errors: anchor, tail, Horner/coefficients, final rounding.
    assert E/4+E/8+2*(E/32)+E/8 < E
    assert E/4+F(5,4)*(E/8)+2*(E/32)+2*(E/32)+E/8 < E
    rows.append(dict(target_bits=p, block_degree=K, independent_atanh_terms=Q,
                     block_tail=str(tail), horner_grid_bits=p+5))
grids=[grid(8192),grid(16384)]
for g in grids:
    g['degree19_horner_stages_per_function']=19*g['nonanchor_points']
    g['degree17_horner_stages_per_function']=17*g['nonanchor_points']
    g['degree19_amplitude_coefficient_slots']=20*g['anchor_count']
    g['degree17_amplitude_coefficient_slots']=18*g['anchor_count']
    g['all_log135_and_amplitude121_stages']=36*g['nonanchor_points']
    g['fixed64_anchor_count']=(g['total_points']+63)//64
    assert g['anchor_count'] <= 3073
assert grids[0]['total_points']==27754497
assert grids[1]['total_points']==55508993
# Conditional proposed scaled-leaf allocation, not an adoption or value test.
delta=F(1,2**118); logerr=F(1,2**135); amperr=F(1,2**121)
assert logerr <= delta/(8*10000) and amperr == delta/8
result=dict(status='PASS_EXACT_GRID_AND_ERROR_METADATA',
            exclusions='No logs, square roots, phases, L-functions, or transforms evaluated.',
            input_pins=PINS, grids=grids, precision_rows=rows,
            proposed_scaled_leaf_bits=dict(log=135,inverse_sqrt=121,Bx=118),
            anchor_error_fraction='1/4', tail_fraction='1/8',
            coefficient_and_horner_gate_fraction='1/32', final_round_fraction='1/8')
Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(result,indent=2))
