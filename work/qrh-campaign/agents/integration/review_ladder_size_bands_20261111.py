"""Independent integer metadata review. No primality or modular computations."""
from pathlib import Path
from hashlib import sha256
from fractions import Fraction
import json

HERE=Path(__file__).resolve().parent
BASE=HERE.parent
ROOT=BASE.parents[2]
MATH=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib')
pins={
 BASE/'prime-estimates/FINITE_LADDER_SIZE_BAND_CERTIFICATES_2026-11-11.md':'14F7E2E2E16342FC9D30CD6EEBA2E2FE968C1EF7B1AB21EE9625097FE1E50AA3',
 BASE/'prime-estimates/proth_size_band_metadata_20261111.py':'A7B4BCFE1426A651FC37BB5CB010E29E63DA6CA3F7D40AB2A820B51DDBDE02F4',
 BASE/'prime-estimates/proth_size_band_metadata_20261111.json':'E013872F1D68BF17E391F041CD289CB674CBF8A4AB7344AA6C77ED8E68B63781',
 BASE/'prime-estimates/FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md':'F950F36C3361A4BABB253B502168B613893DB5DCD002599A7BC261A950A16FC6',
 BASE/'major-constants/EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md':'77ADA365011EA6069D3D2F8131950AD65ECAD285400BBD5C307C7444F0093785',
 BASE/'prime-estimates/SUPPLIED_ROOT_PRODUCTION_PAYLOAD_2026-11-11.md':'EA13551BB8A8C572F983A26EC57E4F3FCD3E658F86DCE8252BABF70002814044',
 ROOT/'work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean':'0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F',
 MATH/'Mathlib/NumberTheory/Fermat.lean':'6A20F4E26D0345801E5CD7286CCA8A0A05130FFEAD8BDF4F501D09A2B4FD97A5'}
for path,pin in pins.items():
    assert sha256(path.read_bytes()).hexdigest().upper()==pin, str(path)
receipt=json.loads((BASE/'prime-estimates/proth_size_band_metadata_20261111.json').read_text())
N0=989*10**24; T=N0-1
thresholds=[(2**j+1)**2 for j in range(1,46)]
assert N0 < thresholds[-1] and receipt['N0']==N0 and receipt['T']==T
checks=1; rows=[]
for row in receipt['rows']:
    B=row['B']; D=B-2
    K=(T-B-4)//D+1
    # Counts from the strict inequality 3+iD<A, not the author's crossing ceil.
    cumulative=[max(0,min(K,(A-4)//D)) for A in thresholds[:-1]]
    bands=[]; previous=0
    for count in cumulative+[K]:
        bands.append(count-previous);previous=count
    S=sum(cumulative)
    assert T-B>=thresholds[-2]
    assert 3+K*D<=T-4 and 3+K*D+B>=T
    assert K==row['necessary_new_rungs']
    assert cumulative==row['forced_early_counts']
    assert bands==row['hypothetical_maxstep_band_counts'] and min(bands)>=0
    assert S==row['forced_saved_square_calls']==sum((44-m)*b for m,b in enumerate(bands))
    assert 44*K==row['ideal_old_calls'] and 44*K-S==row['ideal_new_calls']
    assert Fraction(S,44*K)==Fraction(row['saving_over_ideal_old'])
    assert row['header_bits_upper']==44*K.bit_length()
    checks+=9
    rows.append({'B':B,'K':K,'saved_calls':S,'header_bits':44*K.bit_length()})
for j,A in enumerate(thresholds[:-1],1):
    for candidate,expected in [(A-2,j-1),(A,j),(A+2,j)]:
        got=sum(candidate>=bound for bound in thresholds)
        assert got==expected
        checks+=1
# No primality assigned to any synthetic labels here.
# Check composition overhead identity in bounded integer segment examples.
for q in range(1,18):
    for a in range(1,23):
        for b in range(1,23):
            separate=(a+q-1)//q+(b+q-1)//q
            joined=(a+b+q-1)//q
            assert joined<=separate<=joined+1
            checks+=1
out=HERE/'review_ladder_size_bands_20261111.json'
assert not out.exists()
out.write_text(json.dumps({'scope':'Integer checks only; mathematical proof in review',
    'checks':checks,'pins':{str(p):h for p,h in pins.items()},'rows':rows},indent=2)+'\n')
print(json.dumps({'checks':checks,'pins':len(pins),'output':str(out)}))
