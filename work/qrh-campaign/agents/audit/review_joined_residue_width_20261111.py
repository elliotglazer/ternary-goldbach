"""Independent exact composition/width metadata, without coefficient values."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib
import json
ROOT=Path(__file__).resolve().parents[4]
OWN=Path(__file__).resolve().parent
BASE=OWN.parent
EXPECTED={
 'integration/JOINED_RESIDUE_ARITHMETIC_WIDTH_COMPARISON_2026-11-11.md':'73609552DF8A9847C2C0E65447F6CBE609C352643A8CBA3B5B50354E78311546',
 'integration/joined_residue_width_comparison_20261111.py':'EDE4919DEE7A2D200E1C8803E90A695CA8857ADC51ED40AC42BF89AE81261A06',
 'integration/joined_residue_width_comparison_20261111.json':'581485B43E48F22C3DFAA2C7DFAE11CBC35CC758D2C5037366A1F3876404B5F2',
}
checks=0
def ck(p):
 global checks
 assert p
 checks+=1
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
for p,h in EXPECTED.items():ck(sha(BASE/p)==h)
saved=json.loads((BASE/'integration/joined_residue_width_comparison_20261111.json').read_text())
for row in saved['source_pins']:ck(sha(BASE/row['path'])==row['sha256'])
v=531600; C=2**16; b=100; unit=Q(1,2**100)
for row in saved['degree_rows']:
 i=row['degree']; ell=(v**i).bit_length(); prev=(v**(i-1)).bit_length()
 ck(2**(ell-1)<=v**i<2**ell)
 ck(row['power_bits']==ell)
 ck(row['prescale_signed_bits']==b+ell+17)
 ck(row['general_operand_20F_bits']==b+prev+i+18)
 ck(row['general_operand_10F_bits']==b+prev+i+24)
 ck(row['init_result_20F_bits']==b+ell+i+19)
 ck(row['init_result_10F_bits']==b+ell+i+25)
 for j in range(i):
  ck(4*C*2**(b+j)*v**(i-1)<2**(b+prev+j+18))
  ck(256*C*2**(b+j)*v**(i-1)<2**(b+prev+j+24))
  # Ten-guard unadded-product sum: factor<2, but j<=i-1.
  ck(Q(1,4)+Q(3*j,40)<2)
  ck(512*C*2**(b+j)*v**i<=256*C*2**(b+i)*v**i)
 ck(row['general_products']==i and row['direct_additions']==i)
 ck(row['binary_additions']==sum(j.bit_count()-1 for j in range(1,i+1)))
 ck(row['shifted_operands']==sum(j.bit_count() for j in range(1,i+1)))
ck(sum((20-j)*(j.bit_count()-1) for j in range(1,20))==167)
ck(sum((20-j)*j.bit_count() for j in range(1,20))==357)
ck(19*20//2==190)
ck(sum(Q(6,5)**j for j in range(20))<256)
ck(Q(1,4)+Q(19,40)<Q(3,4))
ck(Q(1,4)+Q(19,20)==Q(6,5))
ck(132900+18*16384<2**19 and 19*16384<2**19)
power=v**19
ck(power.bit_length()==362)
ck(2**37*2**100*power<2**499)
ck(2**38*2**100*power<2**500)
ck(2**43*2**100*power<2**505)
ck(2**44*2**100*power<2**506)
ck(Q(4,3)*C*2**100*power<2**479)
ck((Q(4,3)*C+unit/2)*2**100<2**117)
for bin_ in [100,110,122,141]:
 ck(C*2**bin_*132900<2**(bin_+36))
 ck((Q(4,3)*C+Q(8,3)*unit)*2**bin_<2**(bin_+17))
 ck((v*2**(bin_-100)).bit_length()<=20+bin_-100)
for length in range(1,261):
 ck(190+167+19*(length-1)==19*length+338)
 ck(380+190+19*(length-1)-(357+19*(length-1))==213)
direct=5*46*15+2*15+1
table=15+14*(2*60+1)+14
setup=255*((2*47+1)+2)+4
ck(saved['table_subtotal']=={'product_direct_macro':direct,'product_table_macro':table,'setup_macro':setup})
ck(direct==3481 and table==1723 and setup==24739)
ck(14*(direct-table)<=setup<15*(direct-table))
# Exact algebraic break-even identity on abstract nonnegative cost fixtures.
for U,L,H,R,I,A,G in [(0,1,4,3,5,2,0),(17,25,4,7,20,2,1),(130,260,30,50,900,3,100)]:
 old=19*U*H; new=I+19*(L-1)*A+U*R+G
 ck((old>new)==(U*(19*H-R)>I+19*(L-1)*A+G))
out={'scope':'Conditional width/count composition only; pending comparator/table proofs not accepted here',
     'checks':checks,'author_pins':EXPECTED,'source_pins':saved['source_pins'],
     'degree_rows':saved['degree_rows'],'table_subtotal':saved['table_subtotal']}
dest=OWN/'review_joined_residue_width_20261111.json'
with dest.open('x',encoding='utf-8') as f:
 json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'receipt_sha256':sha(dest)}))
