"""Independent exact cache metadata review; no source values or writer imports."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
AGENTS=HERE.parent
PINS={
 'work/qrh-blueprint/HEIGHT_LAYER_COEFFICIENT_CONVERSION_CACHE_2026-11-11.md':'9471C5D353D459C6C6B22A6DD5C555618C9CFACF9B94950FD5C839FF02771C2B',
 'work/qrh-blueprint/coefficient_layer_cache_metadata_20261111.py':'22461AE6A7568E2930C36E813EAA53EFCF3F17BB0DAC2AD356F7B66EE3238306',
 'work/qrh-blueprint/coefficient_layer_cache_metadata_20261111.json':'CE161550F3F8E0DB9B9448F9347EBC7747415295873FE62157C8956C20FC3993'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
def main():
 for path,h in PINS.items():ck(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()==h)
 data=json.loads((ROOT/'work/qrh-blueprint/coefficient_layer_cache_metadata_20261111.json').read_text(encoding='utf-8'))
 ck(len(data['pins'])==8)
 for path,h in data['pins'].items():ck(hashlib.sha256((AGENTS/path).read_bytes()).hexdigest().upper()==h)
 original=json.loads((AGENTS/'prime-estimates/short_horner_prefix_composition_20261111.json').read_text(encoding='utf-8'))
 scenarios={r['extra_nodes']:r for r in data['scenarios']}
 source={r['extra_nodes']:r for r in original['scenarios']}
 ck(len(data['scenarios'])==4 and set(scenarios)=={0,167,320,640})
 ck(len(source)==4 and set(source)==set(scenarios))
 dout=(512,1024,2048,4096,8192)
 boundaries=(0,6401,12801,25601,64001)
 ck([int(Q(v)*64/5) for v in (500,1000,2000,5000)]==[6400,12800,25600,64000])
 summary=[]
 for extra,row in scenarios.items():
  ends=boundaries[1:]+(84200+extra,)
  height_counts=[b-a for a,b in zip(boundaries,ends)]
  ck(height_counts==[6401,6400,12800,38400,20199+extra])
  ck(sum(height_counts)==84200+extra)
  prior=source[extra]
  ck(len(prior['bands'])==5)
  units=[b['unit_residue_height_inputs'] for b in prior['bands']]
  ck(row['unit_outputs']==sum(units))
  ck(set(row['modes'])=={'full20','constant_prefix'})
  for mode,K in [('full20',[20]*5),('constant_prefix',[19,19,19,20,18])]:
   r=row['modes'][mode];ck(len(r['bands'])==5)
   expect=[]
   for i,(D,h,k,U) in enumerate(zip(dout,height_counts,K,units),1):
    anchors=2*D+1
    objects=h*anchors
    coefficients=objects*k
    coordinates=2*coefficients
    payload=anchors*k*2*16
    expected={'band':i,'F':2*D,'heights':h,'K':k,'full_grid_array_admissions':objects,
       'complex_coefficient_conversions':coefficients,'coordinate_conversions':coordinates,
       'one_layer_converted_payload_bytes':payload,'unit_residue_height_inputs':U}
    ck(r['bands'][i-1]==expected);expect.append(expected)
   objects=sum(s['full_grid_array_admissions'] for s in expect)
   coordinates=sum(s['coordinate_conversions'] for s in expect)
   ck(r['array_admissions']==objects)
   ck(r['coordinate_conversions']==coordinates)
   ck(r['complex_conversions']==coordinates//2)
   ck(r['largest_converted_layer_payload_bytes']==max(s['one_layer_converted_payload_bytes'] for s in expect))
   ck(Q(r['unit_outputs_per_proposed_array_average'])==Q(sum(units),objects))
   ck(Q(r['coordinate_conversions_per_unit_output'])==Q(coordinates,sum(units)))
   summary.append({'extra':extra,'mode':mode,'objects':objects,'coordinates':coordinates,'payload':r['largest_converted_layer_payload_bytes']})
 eta=Q(2)**-100;ut=Q(2)**-110;rem=Q(2)**-116
 W=4*eta+330*ut;flat=2**27*(eta/4+330*ut)
 Zfirst=[5170+rem+W]+[6*Q(5,4)**j/factorial(j)+min(4**j*W,flat) for j in range(1,20)]
 Zfinal=[Q(9023,2)+rem+eta]+[Q(15,2)*Q(7,8)**j/factorial(j)+eta for j in range(1,20)]
 for z in Zfirst+Zfinal:
  ck(z+Q(3,4)<8192)
  for b in range(101):
   # Euclidean conversion envelope implies each coordinate's integer bound.
   ck((z+Q(3,4)*Q(2)**-b)*2**b<2**113)
 ck(114<128)
 ck(data['no_runtime_claim'] is True)
 for path,h in PINS.items():ck(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()==h)
 out={'status':'PASS_BOUNDED_CACHE_METADATA_REVIEW','checks':checks,'author_pins':PINS,
      'source_pins':data['pins'],'summary':summary,
      'scope':'Independently reconstructed counts/encoding only; paper audit separately covers reuse/transport. No writer replay, source values, conductor enumeration or build.'}
 dest=HERE/'review_height_layer_cache_20261111.json'
 with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
 print(json.dumps({'checks':checks,'summary':summary}))
if __name__=='__main__':main()
