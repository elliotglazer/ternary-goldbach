"""Exact finite polynomial/metadata checks; no analytic values."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial, comb
import json,hashlib
A=Path(__file__).resolve().parents[1]
pins={
'integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md':'861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895',
'zero-sum/R138000_HURWITZ_SEED_CONTRACTION_EFFICIENCY_2026-11-11.md':'3151FEBCBE953FA458CBFE437222B810468B2E4F173C723F159F67285601D853',
'zero-sum/r138000_p20_alpha_tradeoff_20261111.json':'F7D5E9CC9AE271B5DA2FC60A33CE8DFC23C9EED5F05999B442C20182573A8323',
'zero-sum/REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md':'B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC',
'zero-sum/CONDITIONAL_R138000_SPECTRAL_INVENTORY_2026-11-11.md':'C14E47FBD3EFBC67C541076B99CCF2949FA2BEDFA9217EFD3C87B9AA8617E78B'}
for path,sha in pins.items():assert hashlib.sha256((A/path).read_bytes()).hexdigest().upper()==sha
old=json.loads((A/'zero-sum/r138000_p20_alpha_tradeoff_20261111.json').read_text())
H=sum(r['time_nodes'] for r in old['rows']);intervals=sum(r['old_D']*r['time_nodes'] for r in old['rows'])
assert (H,intervals)==(127989,717521408)
fine=20*(2*intervals+H);target=1266*F(5,16)**20/factorial(20)
checks=6;rows=[]
for P,bits in ((27,85),(28,90),(32,110)):
    # Formal coefficient maps track (original coefficient index, delta power).
    a=[{(j,0):1} for j in range(P)];count=0
    for i in range(P-2,-1,-1):
        for j in range(i,min(P-2,i+19)+1):
            for (index,power),v in list(a[j+1].items()):
                key=(index,power+1);a[j][key]=a[j].get(key,0)+v
            count+=1
    for k in range(20):
        expected={(j,j-k):comb(j,k) for j in range(k,P)}
        assert a[k]==expected;checks+=1
    # Independent truncated polynomial Horner schedule, using delta=1 only
    # after exact delta exponents have been checked above.
    b=[{} for _ in range(20)]
    for j in range(P-1,-1,-1):
        prev=[v.copy() for v in b]
        for k in range(20):
            b[k]=prev[k].copy()
            if k:
                for index,v in prev[k-1].items():b[k][index]=b[k].get(index,0)+v
        b[0][j]=b[0].get(j,0)+1
    for k in range(20):
        assert b[k]=={j:comb(j,k) for j in range(k,P)};checks+=1
    assert count==sum(min(d,20) for d in range(1,P))==20*P-210;checks+=1
    ratios=[]
    for r in old['rows']:
        ratio=F(3*(r['V']+P),4*r['old_D'])
        assert ratio<F(15,16);checks+=1;ratios.append(str(ratio))
    shift=1266*F(15,16)**P/factorial(P)
    assert shift<F(1,2**bits);checks+=1
    budget=target+shift+F(1266,2**100)+F(2532*count,2**110)+F(2532,2**100)
    assert budget<F(1,2**82);checks+=1
    assert (1+F(1,1024))**count<=1/(1-F(count,1024))<2;checks+=1
    slots=P*intervals+20*H
    rows.append(dict(P=P,stages=count,ratios=ratios,shift_bound=str(shift),shift_bits=bits,
                     total_alpha_bound=str(budget),independent_slots=slots,
                     avoided_slots=fine-slots,total_stages=count*intervals,
                     complete_P_slots=P*(intervals+H),uniform_slot_crossover=str(F(count,40-P))))
P=24;V=5000;D=4096;delta=F(1,2*D);d=F(1,4*D)
envelope=1266*(V+P)**P*sum(delta**(P-k)*d**k/F(factorial(k)*factorial(P-k)) for k in range(20))
assert envelope>F(1,2**82);checks+=1
expected=[(19375637796,9327778304,236782064640),(20093159204,8610256896,251132492800),(22963244836,5740171264,308534205440)]
for row,e in zip(rows,expected):
    assert (row['independent_slots'],row['avoided_slots'],row['total_stages'])==e;checks+=1
out=dict(status='PASS_EXACT_SHIFTED_JET_REVIEW',pins=pins,checks=checks,H=H,old_intervals=intervals,
         fine_slots=fine,target_tail=str(target),rows=rows,P24_insufficient_envelope=str(envelope),
         scope='Paper/finite polynomial and metadata only; no seed values or full spectral precision.')
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(status=out['status'],checks=checks,rows=rows),indent=2))
