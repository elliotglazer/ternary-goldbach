"""Finite symbolic phase identities and exact metadata; no FFT or function values."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib,json
BASE=Path(__file__).resolve().parents[1]
PINS={
 'audit/SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md':'076030481DEB4A922356A5BC0B8CCB243DF3FBB15A0DD427A29DEB044E82D430',
 'zero-sum/REVIEW_SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md':'5683768E8F7B8B93FD4CD2E45CDBED40BFA9CC1BAE238CF920A22B40FEBB820A',
 'major-constants/SMALL_THETA_OFFGRID_ARITHMETIC_SCHEDULE_2026-11-11.md':'8B299BFBDB936C6B85E0AEE6A3D61B0104A2D40D9E604DA98E1E8A76AAD8A0B9',
 'prime-estimates/small_family_theta_inventory_final_20261111.json':'26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69'}
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
for p,h in PINS.items(): ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
B=2*1250000**2+1; Delta=Q(5,64)
# Polynomial phase reduction using only zeta^(N/2)=-1.
def phases(N,terms):
 out={}
 for e,c in terms:
  e%=N
  if e>=N//2: e-=N//2; c=-c
  out[e]=out.get(e,0)+c
 return {e:c for e,c in out.items() if c}
for N in (8,16,32,64):
 m=N//2
 for r in range(m):
  for f in range(N):
   j=f%m; sign=1 if f<m else -1
   expected=phases(N,[(2*r*f,1),(N//4+(2*r+1)*f,1)])
   packed=phases(N,[(2*r*j,1),(2*r*j+N//4+j,sign)])
   ck(expected==packed)
 # zeta^(m-j)=-conjugate(zeta^j), used in sparse pair packing.
 for j in range(1,m): ck(phases(N,[(m-j,1)])==phases(N,[(-j,-1)]))
 for J in range(1,N//4):
  roots=set(range(0,m,2))|set(range(1,J+1))
  ck(len(roots)==N//4+(J+1)//2)
precision=[]; examples=[]
for tilt,ub in ((64,244),(128,345)):
 eps=Q(1,2**82*3**tilt)
 for k0 in range(18,32):
  N=2**k0; m=N//2; J=(25*N+191)//192; Ctime=2*k0+4
  u=eps*Delta/(448*Ctime*(B+1))
  H=Q(44,7*N)*1/Delta
  e0=(3*B+5)*u
  E=2*e0+(k0-1)*(2*B+4)*u
  ck(4*J<N); ck(u<=Q(1,2*k0)); ck((B+1)*u<1); ck(E<1)
  ck(2*(3*B+5)+(k0-1)*(2*B+4)==Ctime*B+4*k0+6)
  ck(E<=Ctime*(B+2)*u); ck(m*E<eps*N*Delta/448); ck(m*E<eps/(64*H))
  uf=Q(1,2**ub); Ef=(2*(3*B+5)+(k0-1)*(2*B+4))*uf
  ck(uf<=Q(1,2*k0)); ck((B+1)*uf<1); ck(Ef<1); ck(m*Ef<eps/(64*H))
 precision.append({'theta':tilt,'optional_uniform_gate_bits':ub})
for k0 in (18,24,31):
 N=2**k0; m=N//2; J=(25*N+191)//192
 fn=N*k0//2; fm=m*(k0-1)//2
 ck(fn-fm==N*(k0+1)//4)
 root_count=N//4+(J+1)//2
 ck(root_count<N//2)
 examples.append({'N':N,'J':J,'full_butterflies':fn,'half_butterflies':fm,
                  'packed_complex_products':fm+J,'packed_complex_additions':2*fm+2*J,
                  'packed_complex_rounds':3*fm+3*J+1,'root_table_upper':root_count,
                  'workspace_complex_slots':m})
source=json.loads((BASE/'prime-estimates/small_family_theta_inventory_final_20261111.json').read_text())
rows=[]
for row in source['scenarios']:
 t=row['totals']; n=t['time_dft_complex_outputs']; f=t['time_butterflies']; j=t['frequency_conjugate_copies']; labels=t['primitive_labels']
 ck(n%4==0); ck(f%2==0)
 half=f//2-n//4; products=half+j
 ck(products<f)
 rows.append({'extra_nodes':row['extra_nodes'],'theta':row['theta'],
 'full_time_butterflies':f,'full_time_complex_slots_sum':n,'positive_coefficients_sum':j,
 'half_time_butterflies':half,'packed_complex_products':products,
 'packed_complex_additions':2*products,'packed_complex_rounds':3*products+labels,
 'packing_complex_products':j,'packing_complex_additions':2*j,'packing_complex_rounds':3*j+labels,
 'half_time_complex_slots_sum':n//2,'raw_real_outputs_sum':n,
 'complex_product_reduction':f-products,'labels_preserved':labels})
out={'scope':'symbolic identity, rational error and saved metadata only','checks':checks,
 'pins':PINS,'B':B,'precision':precision,'examples':examples,'whole_family_rows':rows}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f: json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper(),'main_rows':[r for r in rows if r['extra_nodes']==0]}))
