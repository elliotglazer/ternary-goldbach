"""Formal positive coefficient envelopes and integer widths; no polynomial values."""
from pathlib import Path
from fractions import Fraction as Q
from math import comb,factorial
import json,hashlib
B=Path(__file__).resolve().parents[1]
pins={
'prime-estimates/stored_hurwitz_degree_bounds_20261111.json':'E947C32ED8EA30BA14ED64A7DFF83AA1C8E3F3F222AAD1AD8DAA8484013781BE',
'prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
'major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6',
'prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md':'55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC',
'prime-estimates/FINITE_STIRLING_DIFFERENCE_STATE_BOUND_2026-11-11.md':'4980828A7CDD8A17A9C13427B683CB84B015CFD5ACFF6C9916728A7F00937CF4',
'moebius/REVIEW_FINITE_STIRLING_DIFFERENCE_STATE_BOUND_2026-11-11.md':'212CADE1EDDD73993F5DB59DE6DA00801C7895BB21AB2F0389652B20AB5F237B',
'integration/TRUNCATED_NEWTON_ALL_CELL_TRAVERSAL_2026-11-11.md':'5213690312A3A4C8BC262439844AF2BE227AF5D13635EEDADD3D720EEDAAAE3F',
'zero-sum/REVIEW_TRUNCATED_NEWTON_ALL_CELL_TRAVERSAL_2026-11-11.md':'365EA347A51CB0BE346A5C9447DABD0AC406379FB3871DBE224D6D3E7EDC4FF8',
'independent-feasibility/RESIDUE_POWER_TWO_STATE_NORMALIZATION_2026-11-11.md':'EFB31BE5B3A556CE88A29B1E566ACB86E026F7C9E3E778F67F5B81453914F004',
'zero-sum/REVIEW_RESIDUE_POWER_TWO_STATE_NORMALIZATION_2026-11-11.md':'9F1C14DFD493FE96E4F234EB3526A55D2AF0A25A9BCFE98E56D1DF709DF0A3A5'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for path,h in pins.items():ck(hashlib.sha256((B/path).read_bytes()).hexdigest().upper()==h)
src=json.loads((B/'prime-estimates/stored_hurwitz_degree_bounds_20261111.json').read_text())
S=[[0]*20 for _ in range(20)];S[0][0]=1
for m in range(1,20):
 for j in range(1,m+1):S[m][j]=j*S[m-1][j]+S[m-1][j-1]
def kernel(k,j,step):return sum(Q(comb(k,m)*factorial(j)*S[m][j])*Q(1,4)**(k-m)*step**m for m in range(j,k+1))
def power(x):
 assert x>0
 q=x.numerator.bit_length()-x.denominator.bit_length()
 while x>Q(2)**q:q+=1
 while x<=Q(2)**(q-1):q-=1
 ck(Q(2)**(q-1)<x<=Q(2)**q)
 return q
def describe(x,i):
 q=power(x);r=((531600**i)-1).bit_length()
 return {'norm_bound':str(x),'binary_exponent':q,'max_v_power_exponent':r,'signed_integer_bits_at_vmax':max(1,101+r+q)}
out_rows={}
for name in ('first_four','final'):
 c=[Q(row['stored_center_norm_bound'])+Q(3,4)*Q(1,2**100) for row in src['cohorts'][name]]
 for x in c:ck(x<2**16)
 domains={}
 for domain,step in [('guard20',Q(1,40)),('guard10',Q(1,20)),('all_cell',None)]:
  E=[];stages=[]
  for i in range(20):
   tail=c[19-i:];Ci=max(tail)
   if step is None:
    vals=[2**j*sum(tail[k]*Q(1,4)**k for k in range(j,i+1)) for j in range(i+1)]
   else:vals=[sum(tail[k]*kernel(k,j,step) for k in range(j,i+1)) for j in range(i+1)]
   E.append(vals);state=[];raw=[]
   for j,x in enumerate(vals):
    ref=(Q(4,3)*2**j if step is None else Q(4,3))*Ci
    ck(x<ref)
    row={'order':j,**describe(x,i)}
    row['max_C_i_reference_signed_bits']=describe(ref,i)['signed_integer_bits_at_vmax']
    state.append(row)
   if i:
    for j in range(i+1):
     if j==0:
      g=E[i-1][0]/4;second=c[19-i];kind='coefficient_insertion'
     else:
      factor=(j*step if step is not None else Q(1,2))
      second=factor*E[i-1][j-1]
      g=Q(0) if j==i else (Q(1,4)+j*step if step is not None else Q(1,4))*E[i-1][j]
      kind='new_top' if j==i else 'interior'
     total=g+second
     ck(total<(Q(4,3)*2**j if step is None else Q(4,3))*Ci)
     raw.append({'order':j,'kind':kind,
       'general':describe(g,i) if g else None,
       'secondary_or_insert':describe(second,i),'raw_absolute_sum':describe(total,i)})
   stage={'degree':i,'coefficient_indices':list(range(19-i,20)),
    'C_i':str(Ci),'new_coefficient':describe(c[19-i],i),
    'states':state,'raw_updates':raw,
    'peak_state_signed_bits':max(x['signed_integer_bits_at_vmax'] for x in state),
    'peak_raw_signed_bits':max([x['raw_absolute_sum']['signed_integer_bits_at_vmax'] for x in raw] or [state[0]['signed_integer_bits_at_vmax']])}
   stages.append(stage)
  domains[domain]=stages
 # Guard10 kernel bounds dominate guard20, without comparing inadmissible domains.
 for i in range(20):
  for j in range(i+1):ck(Q(domains['guard20'][i]['states'][j]['norm_bound'])<=Q(domains['guard10'][i]['states'][j]['norm_bound']))
 out_rows[name]={'converted_coefficient_bounds':list(map(str,c)),'domains':domains}
out={'checks':checks,'pins':pins,'scope':'Finite positive envelopes; all_cell rows apply only at retained orders j<L; no occupancy or coefficient values',
'b':100,'max_c':265800,'rows':out_rows}
dst=Path(__file__).with_suffix('.json')
with dst.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dst.read_bytes()).hexdigest().upper(),
'summary':{name:{domain:[[i,st[i]['peak_state_signed_bits'],st[i]['peak_raw_signed_bits']] for i in (0,4,8,12,16,18,19)] for domain,st in row['domains'].items()} for name,row in out_rows.items()}}))
