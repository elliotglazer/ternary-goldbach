"""Independent symbolic and integer audit. No author import/modular values."""
from pathlib import Path
from hashlib import sha256
import json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
BLUE=ROOT/'work/qrh-blueprint'
AUTHOR=BLUE/'CYCLOTOMIC_SUM_ONLY_CERTIFICATES_2026-11-11.md'
RECEIPT=BLUE/'cyclotomic_sum_only_schedules_20261111.json'
GROUPED=HERE.parent/'major-constants/grouped_order_root_schedules_20261111.json'

def digest(p): return sha256(p.read_bytes()).hexdigest().upper()
assert digest(AUTHOR)=='1289E9B4DFBB20B3FC84BB85CD35A676227DDFBFC4A3266A6FAB4A6CC3C27927'
assert digest(RECEIPT)=='F30C91250F8210F8FB0600757028C5C3CB629F0EC0144E6AE5AD66D6B582EE14'
data=json.loads(RECEIPT.read_text())
group=json.loads(GROUPED.read_text())

def polynomial_and_cost(n):
    # Iterative reconstruction along the leading-bit prefixes, unlike author recursion.
    if n==1: return [1],(0,0,0)
    bits=bin(n)[2:];prefix=int(bits[:2],2)
    poly=[1]*prefix
    sq=int(prefix==3);mul=0;adds=prefix-1
    for digit in bits[2:]:
        odd=int(digit);out=[0]*(2*len(poly)+odd)
        if odd: out[0]=1
        for j,coeff in enumerate(poly):
            out[2*j+odd]+=coeff
            out[2*j+odd+1]+=coeff
        poly=out;sq+=1;mul+=1;adds+=1+odd
    return poly,(sq,mul,adds)

for n in range(1,257):
    poly,cost=polynomial_and_cost(n)
    assert poly==[1]*n
    if n>=2:
        ell=n.bit_length()-1;eps=int(bin(n)[2:4]=='11')
        assert cost[:2]==(ell-1+eps,ell-1)
for row in data['prime_sum_schedules']:
    q=row['q'];_,c=polynomial_and_cost(q)
    assert c==(row['squares'],row['other_products'],row['additions'])
    assert sum(c[:2])==row['sum_only_total']
    ell=q.bit_length()-1
    assert row['previous_generic_sum_total']==2*ell+bin(q).count('1')-2
    assert row['binary_power_plus_unit_total']==ell+bin(q).count('1')

qs=group['qs'];base=1
for q in qs: base*=q
assert base==200560490130
out=[]
for row,old in zip(data['portfolio'],group['rows']):
    tag=row['tag'];assert tag==old['multiplier']
    F=base*tag;assert F==row['F']==old['F'] and F**2>10**27
    quot=F;total=[0,0,0];roots=0
    for component in row['components']:
        q=component['q'];e=0
        while quot%q==0:quot//=q;e+=1
        assert e==component['e']
        if q==2:
            c=(e-1,0,0);roots+=int(e>1)
        else:
            exponent=1
            for _ in range(e-1):exponent*=q
            _,s=polynomial_and_cost(q)
            # Count actual bit transitions of the specified leading-one prepower.
            tail=bin(exponent)[3:]
            c=(len(tail)+s[0],tail.count('1')+s[1],s[2]);roots+=1
        assert c==(component['squares'],component['other_products'],component['sum_additions'])
        total=[x+y for x,y in zip(total,c)]
    assert quot==1 and roots==row['roots'] and row['inverse_fields']==0
    assert total==[row['squares'],row['other_products'],row['sum_additions']]
    assert total[2]==52 and sum(total[:2])==row['total_modular_products']
    prev=next(p for p in old['partitions'] if p['root_count']==10)
    out.append({'tag':tag,'new_products':sum(total[:2]),'new_coordinates':roots,
      'old_products':prev['total_modular_operations'],
      'old_coordinates':prev['root_plus_inverse_coordinates'],
      'square_saving':prev['exponent_squares']-total[0],
      'other_product_saving':prev['exponent_products']+prev['aggregate_unit_products']-total[1]})
assert [r['new_products'] for r in out]==[55,56,57,56,57,56]
assert [r['old_products'] for r in out]==[70,71,72,71,72,71]
assert out[0]['square_saving']==5 and out[0]['other_product_saving']==10
for p in data['source_pins']:assert digest(Path(p['path']))==p['sha256']
receipt={'scope':'Independent symbolic coefficients and integer schedules only; no modular candidate evaluations',
 'author_sha256':digest(AUTHOR),'author_receipt_sha256':digest(RECEIPT),
 'author_script_sha256':digest(BLUE/'cyclotomic_sum_only_schedules_20261111.py'),
 'grouped_receipt_sha256':digest(GROUPED),'symbolic_n_values':256,
 'source_pin_checks':len(data['source_pins']),'comparison':out,'result':'PASS'}
dest=HERE/'review_sum_only_schedules_20261111.json'
dest.write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
print(json.dumps(receipt,indent=2))
