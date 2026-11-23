"""Saved structural metadata fold only. No factoring, unit/query/value enumeration."""
from pathlib import Path
from hashlib import sha256
from fractions import Fraction
import json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'integration/transform_structural_manifest_20261111.json':'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637',
 'integration/transform_structural_inventory_20261111.json':'503FB2C859473372990408464F4F333E1C67FF1FBC83E8585F05AED44B836CC0',
 'moebius/REVIEW_TRANSFORM_STRUCTURAL_MULTIPLICITY_INVENTORY_2026-11-11.md':'2D5CE1CDB699A0026E5B84F51FB2C05F4C09928C0B062B2E95B6DDBE8F8B748D',
 'major-constants/reconciled_nonprincipal_schedule_20261111.json':'0E83C9AB65725FBD34F0D34FC462E9EC805A040717DA92B1AB262CC7A9345397',
 'major-constants/combined_odd_even_height_inventory_20261111.json':'BCBAA29AE9A963A46170C5B7B355C0399EE6A622EDBE355ECD24BFE92042C2EE',
 'audit/LARGE_BRANCH_WINDOW_INTERPOLATION_ROUTE_2026-11-11.md':'DA67CB3B463FED71B6545CD13DF374B7713924DFA92C44B37E83862FBA4CCE69',
 'audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md':'96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D',
 'zero-sum/REVIEW_LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md':'F6F38CBFC4237AB0C4AAC978EF1D0157754DFAA461D01FC3D54D921B1FE45D54',
}
checks=0
def ck(t):
 global checks
 assert t
 checks+=1
for p,h in PINS.items():ck(sha256((AGENTS/p).read_bytes()).hexdigest().upper()==h)
def read(p):return json.loads((AGENTS/p).read_text(encoding='utf-8'))
manifest=read('integration/transform_structural_manifest_20261111.json')
old=read('integration/transform_structural_inventory_20261111.json')
seed=read('major-constants/reconciled_nonprincipal_schedule_20261111.json')
combined=read('major-constants/combined_odd_even_height_inventory_20261111.json')
extras=[0,167,320,640]
ends=[6400,12800,25600,64000,128000]
cats=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
ck(manifest['extras']==extras and manifest['band_last_indices']==ends)
requests={(r[0],r[1]):r[-1] for r in manifest['requests']}
ck(len(requests)==35190)
rows=manifest['conductors'];ck(len(rows)==125400 and len(rows)<=1000000)
def bands(count):
 start=0;out=[]
 for end in ends:
  out.append(max(0,min(count,end+1)-start));start=end+1
 ck(sum(out)==count)
 return out
def bucket():
 return {'conductor_height_nodes':0,'residue_inputs':0,'primitive_outputs':0,
         'operations':{k:0 for k in cats}}
def add(b,w,phi,prim,ops):
 b['conductor_height_nodes']+=w;b['residue_inputs']+=w*phi;b['primitive_outputs']+=w*prim
 for j,k in enumerate(cats):b['operations'][k]+=w*ops[j]
oldband=[bucket() for _ in range(20)]
newband=[bucket() for _ in range(20)]
compact=[];maxJ=0;minJ=10**20;sumphi=sumprim=0
for c,phi,prim,H,J,axes,weights in rows:
 ck(len(weights)==20 and J>=257)
 suffix=phi;before=1;ops=[0]*5
 for n,q in axes:
  ck(suffix%n==0 and (q==0 or n%q==0))
  suffix//=n
  for z in range(5):ops[z]+=before*suffix*requests[n,q][z]
  before*=n if q==0 else n-n//q
 ck(suffix==1 and before==prim)
 inc=[]
 for s,e in enumerate(extras):
  prior=bands(J+e);after=bands(J+e+256)
  ck(prior==weights[s*5:s*5+5])
  delta=[b-a for a,b in zip(prior,after)];ck(sum(delta)==256 and min(delta)>=0)
  for band in range(5):
   add(oldband[5*s+band],prior[band],phi,prim,ops)
   add(newband[5*s+band],delta[band],phi,prim,ops)
  inc.extend(delta)
 compact.append([c,J,phi,prim,ops,inc])
 maxJ=max(maxJ,J);minJ=min(minJ,J);sumphi+=phi;sumprim+=prim
ck(maxJ==84200 and sumphi==7133015232 and sumprim==4333246843)
ck([b['residue_inputs'] for b in oldband]==old['unit_band'])
def total(bs):
 out=bucket()
 for b in bs:
  for key in ('conductor_height_nodes','residue_inputs','primitive_outputs'):out[key]+=b[key]
  for k in cats:out['operations'][k]+=b['operations'][k]
 return out
scenarios=[]
for s,e in enumerate(extras):
 prior=total(oldband[s*5:s*5+5]);delta=total(newband[s*5:s*5+5]);large=seed['scenarios'][s]['large']
 ck(prior['operations']==old['scenarios'][s]['operations']==large['transform_operations'])
 for key in ('conductor_height_nodes','residue_inputs','primitive_outputs'):ck(prior[key]==large[key])
 ck(delta['conductor_height_nodes']==256*len(rows))
 ck(delta['residue_inputs']==256*sumphi and delta['primitive_outputs']==256*sumprim)
 if s:ck(all(delta[k]==scenarios[0]['added_runtime'][k] for k in delta))
 for key in cats:ck(delta['operations'][key]==256*combined['per_extra_node_operations'][key])
 global_old=maxJ+e;global_new=global_old+256
 ck(global_old==large['global_nodes'])
 last=global_new-1;ck(Fraction(5*last,64)<7000)
 final=large['seed_bands'][-1];H=final['heights']
 ck(final['P']==28 and final['D_source']==4096 and final['D_output']==8192 and final['N']==1500 and final['m']==159)
 per={}
 for k,v in final['counts'].items():ck(v%H==0);per[k]=v//H
 source_add={k:256*v for k,v in per.items()}
 ck(source_add['fine_state_complex_updates']==256*6148097)
 ck(source_add['initial_B_certificates']==source_add['step_cis_certificates']==source_add['step_grid_conversions']==0)
 for b in newband[s*5:s*5+5]:
  b['P20_Horner_stages']=19*b['residue_inputs']
  b['kernel_products']=b['operations']['dyadic_scales']
  b['root_products']=b['operations']['general_complex_products']-b['kernel_products']
 delta['P20_Horner_stages']=19*delta['residue_inputs']
 delta['kernel_products']=delta['operations']['dyadic_scales']
 delta['root_products']=delta['operations']['general_complex_products']-delta['kernel_products']
 # Compare only common fields after derived fields are introduced.
 scenarios.append({'extra_nodes':e,'old_runtime':prior,'added_runtime':delta,
   'added_by_band':newband[s*5:s*5+5],
   'global_old_count':global_old,'global_new_count':global_new,'max_guard_index':last,
   'max_guard_height':str(Fraction(5*last,64)),
   'shared_source_added_heights_by_band':[0,0,0,0,256],
   'shared_source_added_operations':source_add,
   'full_positive_Y_guard_normalizations':delta['primitive_outputs']})
schema={'rows':'[c,J_sample_count,phi,primitive,per_height_five_operation_vector,scenario_major_five_band_guard_counts]',
        'extras':extras,'categories':cats,'band_last_indices':ends,
        'manifest_sha256':PINS['integration/transform_structural_manifest_20261111.json'],'rows_data':compact}
data=(json.dumps(schema,separators=(',',':'))+'\n').encode();ck(len(data)<32*1024*1024)
rowpath=HERE/'sample_guard_conductor_rows_20261111.json'
out={'scope':'Conditional +256 positive-prefix sample guards; saved rows only; no query/character/function values.',
 'pins':PINS,'count_conventions':{'J':'sample count','last_index':'J+extra-1','new_positive_indices':'J+extra .. J+extra+255','negative_indices':'-256 .. -1'},
 'family':{'conductors':len(rows),'primitive_labels':sumprim,'unit_inputs_per_height':sumphi,'min_main_count':minJ,'max_main_count':maxJ},
 'scenarios':scenarios,'negative_full_superset':{'positive_indices_needed':[1,256],'max_absolute_height':'20',
 'attenuation_scalar_enclosures':256,'scalar_transports':256*sumprim,'inverse_label_bindings':sumprim,
 'notes':'Optional full materialization. No new character transforms. Root-phase signs and real enclosure products remain required.'},
 'setup':{'new_transform_dimensions':0,'new_seed_rational_arguments':0,'new_initial_B_or_step_certificates':0,
 'unchanged_transform_setup':manifest['unchanged_setup'],'unchanged_seed_setup':seed['setup']['large_seed']},
 'unpriced':['positive actual-Y completion/scaling/phase and sample radii','negative root-phase signs, attenuation proof and rounding/radius transport',
 'actual target-query count and 513-term finite kernel/arithmetic work','guard-only source/transform precision or sign repairs',
 'source endpoints/divisions and finite-head/residue/c^-s corrections','cache lifetime, storage, binding and proof/checking costs'],
 'conductor_rows':{'file':rowpath.name,'bytes':len(data),'sha256':sha256(data).hexdigest().upper()},'checks':checks}
receipt=(json.dumps(out,indent=2)+'\n').encode();ck(len(receipt)+len(data)<64*1024*1024)
out['checks']=checks;receipt=(json.dumps(out,indent=2)+'\n').encode()
with rowpath.open('xb') as f:f.write(data)
with (HERE/'sample_guard_ledger_20261111.json').open('xb') as f:f.write(receipt)
print(json.dumps({'checks':checks,'rows_bytes':len(data),'receipt_bytes':len(receipt),'added':scenarios[0]['added_runtime'],
 'endpoints':[s['max_guard_height'] for s in scenarios],'source_add':scenarios[0]['shared_source_added_operations']},indent=2))
