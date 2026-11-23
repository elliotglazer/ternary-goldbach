"""Divisor-recursion metadata audit; no prime/character/transform evaluations."""
from pathlib import Path
from fractions import Fraction
from hashlib import sha256
import json, ast

HERE=Path(__file__).resolve().parent
Z=HERE.parent/'zero-sum'
paths={
 'r138':Z/'conditional_r138000_mixed_inventory_20261111.json',
 'r140':Z/'conditional_r140000_mixed_inventory_20261111.json',
}
expected={
 'r138':'0D48AF7655976B5B0A0BC2750CA92F26E30B33E1F45540015627EEFFC5C60D5F',
 'r140':'DA26BF4BA4744CF5AF096670873FE9CA258735A8EFA4DE09D0F490A56F36F5F7',
}
data={}
for k,p in paths.items():
 assert sha256(p.read_bytes()).hexdigest().upper()==expected[k]
 data[k]=json.loads(p.read_text())
N=300000
# sum_{d|n} phi(d)=n; sum_{d|n} primitive(d)=phi(n).
# No factorization or primality classification is used to construct these arrays.
phi=list(range(N+1));prior=[0]*(N+1);primitive=[0]*(N+1)
for d in range(1,N+1):
 primitive[d]=phi[d]-prior[d]
 assert primitive[d]>=0
 for n in range(2*d,N+1,d):
  phi[n]-=phi[d]
  prior[n]+=primitive[d]
sf=[True]*(N+1)
for d in range(2,548):
 for n in range(d*d,N+1,d*d):sf[n]=False

keys=['conductors','primitive_labels','real_primitive_labels','nonreal_inverse_pairs',
 'unit_coefficients','nominal_conductor_height_nodes','coarse_residue_inputs',
 'coarse_primitive_outputs','max_height_nodes']
checks=0;results={}
def equal(x,y):
 global checks
 assert x==y,(x,y)
 checks+=1
for R in [150000,140000,138000]:
 accum={g:{k:0 for k in keys} for g in ['all_conductors','large_above10000','small_at_most10000']}
 maxcs=[]
 for c in range(3,2*R+1):
  if not ((c%2 and c<=R) or c%4==0):continue
  a=100000000 if c%2 or c<=125000 else 200*c+75000000
  J=(64*a+5*c-1)//(5*c)+1
  if c%2:real=int(sf[c])
  elif c%8==4:real=int(sf[c//4])
  elif c%16==8:real=2*int(sf[c//8])
  else:real=0
  assert (primitive[c]-real)%2==0
  groups=['all_conductors','large_above10000' if c>10000 else 'small_at_most10000']
  for g in groups:
   rec=accum[g]
   vals=[1,primitive[c],real,(primitive[c]-real)//2,phi[c],J,phi[c]*J,primitive[c]*J]
   for k,v in zip(keys[:-1],vals):rec[k]+=v
   rec['max_height_nodes']=max(rec['max_height_nodes'],J)
  if c>10000 and J==127989:maxcs.append(c)
 source=data['r140' if R==140000 else 'r138']['profiles'][str(R)]
 for g in accum:
  for k,v in accum[g].items():equal(v,source[g][k])
 equal(maxcs,[10001])
 results[str(R)]={'counts':accum,'large_maximizers':maxcs}
for R in ['140000','138000']:
 equal(results[R]['counts']['small_at_most10000'],results['150000']['counts']['small_at_most10000'])
base=data['r138']['profiles']['150000']['large_above10000']['operations']
new=data['r138']['profiles']['138000']['large_above10000']['operations']
ratios={}
for k,lo,hi in [('general_complex_products',899767,899768),('complex_add_sub',899585,899586)]:
 r=Fraction(new[k],base[k]);assert Fraction(lo,10**6)<r<Fraction(hi,10**6)
 ratios[k]={'exact':str(r),'scope':'arithmetic of stored totals only; full circuit recipe not replayed'}
BLUE=HERE.parents[2]/'qrh-blueprint'
root_script=BLUE/'reconcile_cutoff_precision_reuse_20261111.py'
root_receipt=BLUE/'reconcile_cutoff_precision_reuse_20261111.json'
tree=ast.parse(root_script.read_text())
pins=next(ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign)
          and any(isinstance(t,ast.Name) and t.id=='PINS' for t in n.targets))
for rel,h in pins.items():equal(sha256((HERE.parent/rel).read_bytes()).hexdigest().upper(),h)
rr=json.loads(root_receipt.read_text())
old=json.loads((Z/'mixed_radix_character_inventory_20261111.json').read_text())
og=old['large_reduced']['baseline']['general_complex_products']
oa=old['large_reduced']['baseline']['complex_add_sub']
ng=new['general_complex_products'];na=new['complex_add_sub']
equal(rr['quoted_circuit_counts'],{'old_G':og,'old_A':oa,'R138_G':ng,'R138_A':na})
composed={
 'labels_138_over_150':Fraction(results['138000']['counts']['all_conductors']['primitive_labels'],results['150000']['counts']['all_conductors']['primitive_labels']),
 'complex_products_138_mixed_over_150_whole_axis':Fraction(ng,og),
 'real_products_138_fixed_three_over_150_four':Fraction(3*ng,4*og),
 'real_additions_138_fixed_three_over_150_four':Fraction(2*na+3*ng,2*oa+2*og),
}
for k,v in composed.items():equal(Fraction(rr['ratios'][k]['numerator'],rr['ratios'][k]['denominator']),v)
for R in results:
 equal(rr['labels'][R],{'conductor_indices':results[R]['counts']['all_conductors']['conductors'],
       'primitive_labels':results[R]['counts']['all_conductors']['primitive_labels']})
out={'scope':'independent divisor metadata and quoted-cost composition; no spectral circuit replay',
 'checks':checks,'result':'PASS','source_hashes':expected,'results':results,'ratios':ratios}
out['root_composition']={k:str(v) for k,v in composed.items()}
out['root_pins_checked']=len(pins)
out['root_source_hashes']={p.name:sha256(p.read_bytes()).hexdigest().upper() for p in
 [root_script,root_receipt,BLUE/'RECONCILED_CUTOFF_PRECISION_AND_REUSE_2026-11-11.md']}
dest=HERE/'review_cutoff_labels_20261111.json'
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'checks':checks,'result':'PASS','labels':{R:v['counts']['all_conductors']['primitive_labels'] for R,v in results.items()},'ratios':ratios},indent=2))
