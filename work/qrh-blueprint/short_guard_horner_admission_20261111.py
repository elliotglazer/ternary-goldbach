"""Six exact rational alpha-budget tests, without any function evaluation."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib
import json

HERE = Path(__file__).resolve().parent
A = HERE.parent / 'qrh-campaign' / 'agents'
PINS = {
    'moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md': 'AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63',
    'independent-feasibility/REVIEW_JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md': '84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7',
    'integration/SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md': '3E447AE8E8EEEC847E95CFB7473879EB2B56CFC5E467863404D3ECDBB0180606',
    'zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md': '15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA',
}
checks = 0
def ck(x):
    global checks
    assert x
    checks += 1
def fs(x):
    return f'{x.numerator}/{x.denominator}'
def up(x):
    return (x.numerator*10**9+x.denominator-1)//x.denominator

for rel, expected in PINS.items():
    ck(hashlib.sha256((A/rel).read_bytes()).hexdigest().upper() == expected)

shape = [100,100,100,100,97,95,95,95,89,87,87,87,81,79,79,79,71,71,71,71]
old_v = F(424195,64)
guard_v = F(26525,4)
declared_v = F(7000)
ck(old_v + 41*F(5,64) == guard_v)
ck(old_v < guard_v < declared_v)
shift = 1266*F(5*7028,8*4096)**28/factorial(28)
source = F(844,2**100)
rows=[]
expected = {(18,94):[858600152,861409838,1395647229],
            (19,93):[939289215,939320968,945552042]}
for K,b0 in [(18,94),(19,93)]:
    grids=[x+b0-100 for x in shape[:K]]
    e=sum((2 if j<K-1 else 1)*F(3,4)*F(2)**(-grids[j])*F(1,4)**j for j in range(K))
    ck(min(grids)>=64 and grids[0]==b0)
    ck(100-b0 in (6,7))
    ratios=[]
    for i,V in enumerate([old_v,guard_v,declared_v]):
        target=1266*((V+K)/(4*8192))**K/factorial(K)
        total=target+shift+source+633*e
        ratio=total*2**82
        ck(up(ratio)==expected[(K,b0)][i])
        ck(total>target and e>0)
        rows.append({'K':K,'b0':b0,'V':fs(V),'grids':grids,
                     'target':fs(target),'shift':fs(shift),'source':fs(source),
                     'evaluation':fs(e),'alpha_ratio':fs(ratio),
                     'alpha_ratio_billionth_upper':up(ratio),'admitted':ratio<1})
        ratios.append(ratio)
    ck(ratios[0]<ratios[1]<ratios[2])
    ck(ratios[1]<1)
    ck((ratios[2]<1)==(K==19))
ck(len(rows)==6)
out={'scope':'fixed two candidates at old, +41 guard and declared height caps; rational bounds only',
     'pins':PINS,'checks':checks,'rows':rows,'source_recipe_unchanged':True,
     'production_selected':False,'values_or_new_cost_inventory_produced':False}
dest=HERE/'short_guard_horner_admission_20261111.json'
with dest.open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'checks':checks,'bytes':dest.stat().st_size,
                  'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
