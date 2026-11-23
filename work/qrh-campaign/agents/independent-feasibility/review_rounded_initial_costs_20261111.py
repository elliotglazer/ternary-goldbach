"""Independent Pascal/byte-price reconstruction, no actual arithmetic data."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib,json
B=Path(__file__).resolve().parents[1]
pins={
'major-constants/ROUNDED_INITIAL_DIFFERENCE_COST_COMPARISON_2026-11-11.md':'BB570E4A54C551C0CA4137CAD792548EC89D11594BC284D437AF01946C9BB6E0',
'major-constants/rounded_initial_costs_20261111.py':'C53F39BA5DBE3052C27201FF7C3193E3F160ABCECF5907601ED2A8432FAD0BF1',
'major-constants/rounded_initial_costs_20261111.json':'5157CA6B7BEF1826EB0818DF7C1EED239961E0FD642BE622097CECC42902E7DB',
'integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md':'3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227'}
n=0
def ck(x):
 global n
 assert x
 n+=1
data=json.loads((B/'major-constants/rounded_initial_costs_20261111.json').read_text())
pins.update(data['pins'])
for p,h in pins.items():ck(hashlib.sha256((B/p).read_bytes()).hexdigest().upper()==h)
def digits(bits):return (bits+7)//8
def ad(bits):return 2*digits(bits)+1
def mult(a,b):
 x,y=sorted((digits(a),digits(b)))
 return sum(5*y+2 for _ in range(x))+1
def core(q,d,w,dyadic=False):return (0 if dyadic else mult(q,d))+sum(ad(x) for x in (w,d+3,d+2))
pascal=[1]+[0]*19;rows=[]
for L in range(1,261):
 S=sum(pascal);p=102+S.bit_length()
 ck(Q(S,2**p)<Q(1,2**102))
 ck(103<=p<=197)
 initial=40*core(p+43,362,p+407)
 exact=2*core(117,362,481)
 dyadic=2*core(117,p-99,p+19,True)
 threshold=next(U for U in range(1,100) if U*(exact-dyadic)>initial)
 row={'L':L,'p':p,'twenty_complex_init_core':initial,
  'exact_final_complex_core':exact,'dyadic_final_complex_core':dyadic,
  'strict_conversion_core_U_threshold':threshold,
  'rounded_advance_complex_add_core':38*ad(p+45),
  'init_complex_rounds':20,'unit_rounds':'U','all_numerator_advances':L-1}
 ck(row==data['rows'][L-1]);rows.append(row)
 ck((threshold-1)*(exact-dyadic)<=initial)
 ck(exact==7580 and exact>dyadic)
 # Raw size algebra after an exact denominator power cancellation.
 for r in (0,1,19,38,190,361):
  for j in range(20):
   for delta in (0,1,7,14):
    nu=sum(j//(2**i) for i in range(1,5))
    lam=j*delta+nu;shift=p-100+lam;a=min(r,shift)
    ck(shift>=a and r>=a and shift-r==(shift-a)-(r-a))
 for j in range(19,0,-1):pascal[j]+=pascal[j-1]
ck(rows[-1]['p']==197 and rows[-1]['strict_conversion_core_U_threshold']==40)
ck(40*(197+44)==9640 and 197+408==605)
ck(Q(4,3)+Q(1,4)+1<Q(8,3))
ck(633*Q(31,12)==Q(6541,4))
selected=[rows[L-1] for L in (1,10,20,40,80,130,260)]
ck(selected==data['selected'])
out={'status':'PASS_CONDITIONAL_PRICE_INTERFACE','checks':n,'pins':pins,'selected':selected,
 'scope':'Independent finite metadata and algebra only; no author execution, actual coefficients, builds or occupancy scan.'}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':n,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
