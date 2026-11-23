"""Matched saved-row folds only; no conductor/unit/query/value generation."""
from pathlib import Path
from fractions import Fraction as F
from math import prod
import hashlib,json
HERE=Path(__file__).resolve().parent
BASE=HERE.parent
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def read(r):return json.loads((BASE/r).read_text())
pins={
'integration/SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md':'3E447AE8E8EEEC847E95CFB7473879EB2B56CFC5E467863404D3ECDBB0180606',
'integration/short_window_guard_ledger_20261111.py':'61B98033E06FD6B982FB762EBB1DFF44CC08151AD9E70FB9B86B51EC123CFE2D',
'integration/short_window_guard_ledger_20261111.json':'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4',
'integration/short_window_guard_conductor_rows_20261111.json':'A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA',
'integration/sample_guard_conductor_rows_20261111.json':'1D619640BF0917DAE96F521945D6EB54705967776B8A139A6C60F61AD21AC55F',
'zero-sum/REVIEW_LARGE_INTERPOLATION_SAMPLE_GUARD_LEDGER_2026-11-11.md':'412F441652C40B0C3B8F031EF8260947AFB4614FA1C7F51CEACC5B5780B735C7',
}
for p,h in pins.items():ck(sha(BASE/p)==h)
a=read('integration/short_window_guard_ledger_20261111.json')
for p,h in a['pins'].items():ck(sha(BASE/p)==h);pins[p]=h
m=read('integration/transform_structural_manifest_20261111.json')
rows=m['conductors']; req={(x[0],x[1]):x[5] for x in m['requests']}
srows=read('integration/short_window_guard_conductor_rows_20261111.json')['rows_data']
lrows=read('integration/sample_guard_conductor_rows_20261111.json')['rows_data']
old=read('integration/sample_guard_ledger_20261111.json')
seed=read('major-constants/reconciled_nonprincipal_schedule_20261111.json')
summary=read('integration/transform_structural_inventory_20261111.json')
tail=read('audit/shorter_large_branch_windows_20261111.json')
selected=[r for r in tail['best_rows'] if F(r['h'])==F(159,500) and r['m']==41]
ck(len(selected)==1 and selected[0]['total_fraction_of_budget_upper_billionths']==927193523)
ck(a['window']=={'h':'159/500','m':41,'terms':83,'analytic_tail_ratio_upper':'927193523/1000000000','analytic_tail_reference':'2^-46','no_numerical_sign_claim':True})
extras=[0,167,320,640]
cats=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
limits=[(0,6400),(6401,12800),(12801,25600),(25601,64000),(64001,128000)]
ck(len(rows)==len(srows)==len(lrows)==125400)
# The third guard family is computed directly on the deleted interval, not by subtraction.
fold={key:[[[0]*8 for _ in limits] for _ in extras] for key in ('original','short','long','deleted')}
sumphi=sumprim=0;maxJ=0;minJ=10**12
for row,sr,lr in zip(rows,srows,lrows):
 c,phi,primitive,H,J,axes,weights=row
 full=[n for n,q in axes];ret=[n if q==0 else n-n//q for n,q in axes]
 ck(prod(full)==phi and prod(ret)==primitive)
 ops=[sum(prod(ret[:i])*prod(full[i+1:])*req[n,q][k] for i,(n,q) in enumerate(axes)) for k in range(5)]
 ck(sr[:5]==lr[:5]==[c,J,phi,primitive,ops])
 sw=[];lw=[]
 for si,e in enumerate(extras):
  start=J+e
  intervals={'original':(0,start-1),'short':(start,start+40),'long':(start,start+255),'deleted':(start+41,start+255)}
  counts={}
  for key,(lo,hi) in intervals.items():
   counts[key]=[max(0,min(hi,top)-max(lo,bottom)+1) for bottom,top in limits]
   ck(sum(counts[key])==hi-lo+1)
   for bi,w in enumerate(counts[key]):
    for k,v in enumerate([1,phi,primitive,*ops]):fold[key][si][bi][k]+=w*v
  ck(counts['original']==weights[5*si:5*si+5])
  ck(all(x+y==z for x,y,z in zip(counts['short'],counts['deleted'],counts['long'])))
  sw+=counts['short'];lw+=counts['long']
 ck(sw==sr[5] and lw==lr[5]);ck(J>256)
 sumphi+=phi;sumprim+=primitive;maxJ=max(maxJ,J);minJ=min(minJ,J)
ck(a['family']==old['family']==dict(conductors=len(rows),primitive_labels=sumprim,unit_inputs_per_height=sumphi,min_main_count=minJ,max_main_count=maxJ))
ck([r[1] for scenario in fold['original'] for r in scenario]==summary['unit_band'])
def vector(v,derived=True):
 d=dict(conductor_height_nodes=v[0],residue_inputs=v[1],primitive_outputs=v[2],operations=dict(zip(cats,v[3:])))
 if derived:d.update(P20_Horner_stages=19*v[1],kernel_products=v[7],root_products=v[3]-v[7])
 return d
def total(v):return [sum(r[k] for r in v) for k in range(8)]
D=4096;N=1500;P=28;M=159
anchor=D+1;arg=(N+1)*D+1;fine=4*D+1
per={'source_coefficients':anchor*P,'head_reciprocal_scales':anchor*N*(P-1),
'head_accumulator_additions':anchor*N*P,'E_contracting_complex_stages':anchor*(P+2*M-2),
'Bernoulli_weighted_terms':anchor*P*M,'Bernoulli_accumulator_additions':anchor*P*M,
'source_translation_updates':D*3*350,'P20_fine_anchor_coefficient_deliveries':fine*20,
'shared_height_R_recurrence_steps':P-1,'coarse_anchor_instances':anchor,'base_height_argument_pairs':arg,
'initial_B_certificates':0,'step_cis_certificates':0,'step_grid_conversions':0,
'fine_state_complex_updates':arg,'state_to_EM_grid_conversions':arg,
'final_coefficient_power2_scales':fine*20,'final_coefficient_rounds':fine*20}
results=[]
for i,e in enumerate(extras):
 s=a['scenarios'][i];o=old['scenarios'][i];ss=seed['scenarios'][i]['large']
 original=vector(total(fold['original'][i]),False)
 new=vector(total(fold['short'][i]));long=vector(total(fold['long'][i]));removed=vector(total(fold['deleted'][i]))
 ck(s['extra_nodes']==o['extra_nodes']==e)
 ck(s['old_runtime']==o['old_runtime']==original)
 ck(original['operations']==ss['transform_operations'])
 ck(s['added_runtime']==new and o['added_runtime']==long)
 ck(s['matched_m256_reduction_runtime']==removed)
 ck(s['added_by_band']==[vector(v) for v in fold['short'][i]])
 ck(o['added_by_band']==[vector(v) for v in fold['long'][i]])
 ck(s['matched_m256_band_reduction']==[vector(v) for v in fold['deleted'][i]])
 for h,obj in ((41,s['shared_source_added_operations']),(256,o['shared_source_added_operations']),(215,s['matched_m256_reduction_shared_source'])):
  ck(obj=={k:h*v for k,v in per.items()})
 count=maxJ+e+41;last=count-1;height=F(5*last,64)
 ck(s['global_old_count']==maxJ+e and s['global_new_count']==count)
 ck(s['max_guard_index']==last and F(s['max_guard_height'])==height<7000)
 ck(o['global_new_count']-count==o['max_guard_index']-last==215)
 ck(s['shared_source_added_heights_by_band']==[0,0,0,0,41])
 ck(s['full_positive_Y_guard_normalizations']==41*sumprim)
 ck(count<128000 and last>64000)
 results.append(dict(extra=e,last_index=last,last_height=str(height),extension=new,reduction=removed))
neg=a['negative_full_superset'];nr=a['matched_negative_reduction']
ck(neg['positive_indices_needed']==[1,41] and F(neg['max_absolute_height'])==F(205,64))
ck(neg['attenuation_scalar_enclosures']==41 and neg['scalar_transports']==41*sumprim and neg['inverse_label_bindings']==sumprim)
ck(nr=={'attenuation_scalar_enclosures':215,'scalar_transports':215*sumprim})
ck(a['per_query_direct_stencil']=={'products':83,'additions':82,'m256_products':513,'m256_additions':512,'reduction_each':430,'kernel_values_shared_with_old_h':False})
ck(a['setup']==old['setup'])
ck(any('83-term' in x for x in a['unpriced']) and not any('513-term' in x for x in a['unpriced']))
ck(a['conductor_rows']['bytes']==(BASE/'integration/short_window_guard_conductor_rows_20261111.json').stat().st_size)
ck(a['conductor_rows']['sha256']==pins['integration/short_window_guard_conductor_rows_20261111.json'])
out={'status':'PASS_MATCHED_SHORT_WINDOW_SAVED_METADATA','checks':checks,'pins':pins,
'rows_checked':len(rows),'scenarios':results,'source_per_height':per,
'scope':'Saved row and exact count comparison only. No regenerated conductor/circuit, unit/query/function values, author execution, analytic parameter search or build.'}
dest=HERE/'review_short_window_guard_ledger_20261111.json'
with dest.open('x',encoding='utf8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'receipt_sha256':sha(dest)}))
