"""Independent saved-row fold. No conductor, unit, query or function generation."""
from pathlib import Path
from fractions import Fraction
from math import prod
import hashlib
import json

HERE=Path(__file__).resolve().parent
BASE=HERE.parent
checks=0
def ck(x):
    global checks
    assert x
    checks+=1
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def read(rel): return json.loads((BASE/rel).read_text())
pins={
'integration/LARGE_INTERPOLATION_SAMPLE_GUARD_LEDGER_2026-11-11.md':'8D358690454A22DECB1E7BEFB8999FE024D68CABBB6432EBE388537475B24FE1',
'integration/sample_guard_ledger_20261111.py':'336F1F606E7DAFA330EDC1372B3FE02668A173DD9EB61F580D5372A944F64A7E',
'integration/sample_guard_ledger_20261111.json':'F27D196EB8C8DFCC13694AE8E5CA9B03783BBA3034AEBA740E3FEFFB13B2F1E0',
'integration/sample_guard_conductor_rows_20261111.json':'1D619640BF0917DAE96F521945D6EB54705967776B8A139A6C60F61AD21AC55F',
}
for p,h in pins.items(): ck(sha(BASE/p)==h)
author=read('integration/sample_guard_ledger_20261111.json')
for p,h in author['pins'].items():
    ck(sha(BASE/p)==h);pins[p]=h
manifest=read('integration/transform_structural_manifest_20261111.json')
summary=read('integration/transform_structural_inventory_20261111.json')
seed=read('major-constants/reconciled_nonprincipal_schedule_20261111.json')
export=read('integration/sample_guard_conductor_rows_20261111.json')
cats=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
extras=[0,167,320,640]
starts=[0,6401,12801,25601,64001]
ends=[6400,12800,25600,64000,128000]
ck(manifest['conductor_fields']==['c','phi','primitive','H','J','ordered_axes_n_q','scenario_major_band_minor_height_nodes'])
ck(manifest['request_fields'][-1]=='five_counts')
requests={(r[0],r[1]):r[5] for r in manifest['requests']}
ck(len(requests)==len(manifest['requests'])==35190)
rows=manifest['conductors']; saved=export['rows_data']
ck(len(rows)==len(saved)==125400)
# Eight columns: conductor heights, residues, primitive outputs, five operation categories.
old=[[[0]*8 for _ in range(5)] for _ in extras]
new=[[[0]*8 for _ in range(5)] for _ in extras]
sumphi=sumprim=0;maxJ=0;minJ=10**12
for row, target in zip(rows,saved):
    c,phi,primitive,H,J,axes,weights=row
    lengths=[a[0] for a in axes]
    retained=[n if q==0 else n-n//q for n,q in axes]
    ck(prod(lengths)==phi and prod(retained)==primitive)
    # Explicit products on either side of an axis, rather than the author's running suffix.
    op=[0]*5
    for i,(n,q) in enumerate(axes):
        mult=prod(retained[:i])*prod(lengths[i+1:])
        for k,v in enumerate(requests[n,q]): op[k]+=mult*v
    ck(target[:5]==[c,J,phi,primitive,op])
    increments=[]
    for scenario,extra in enumerate(extras):
        first=J+extra;last=first+255
        prior=[max(0,min(first-1,b)-a+1) for a,b in zip(starts,ends)]
        inc=[max(0,min(last,b)-max(first,a)+1) for a,b in zip(starts,ends)]
        ck(prior==weights[5*scenario:5*scenario+5])
        ck(sum(prior)==first and sum(inc)==256)
        increments+=inc
        unit_vector=[1,phi,primitive,*op]
        for band in range(5):
            for k,v in enumerate(unit_vector):
                old[scenario][band][k]+=prior[band]*v
                new[scenario][band][k]+=inc[band]*v
    ck(increments==target[5])
    ck(J>256)
    maxJ=max(maxJ,J);minJ=min(minJ,J);sumphi+=phi;sumprim+=primitive
ck(author['family']==dict(conductors=len(rows),primitive_labels=sumprim,unit_inputs_per_height=sumphi,min_main_count=minJ,max_main_count=maxJ))
ck([r[1] for scenario in old for r in scenario]==summary['unit_band'])
def unpack(v):
    return {'conductor_height_nodes':v[0],'residue_inputs':v[1],'primitive_outputs':v[2],
            'operations':dict(zip(cats,v[3:]))}
def sumcols(vs): return [sum(v[k] for v in vs) for k in range(8)]
def derived(v):
    d=unpack(v)
    d.update(P20_Horner_stages=19*v[1],kernel_products=v[7],root_products=v[3]-v[7])
    return d
# Independently derive current final-band source multiplicities from its parameters.
D=4096;N=1500;P=28;m=159;h=256;anchors=D+1;args=(N+1)*D+1;fine=4*D+1
source={
'source_coefficients':h*anchors*P,
'head_reciprocal_scales':h*anchors*N*(P-1),
'head_accumulator_additions':h*anchors*N*P,
'E_contracting_complex_stages':h*anchors*(P+2*m-2),
'Bernoulli_weighted_terms':h*anchors*P*m,
'Bernoulli_accumulator_additions':h*anchors*P*m,
'source_translation_updates':h*D*3*350,
'P20_fine_anchor_coefficient_deliveries':h*fine*20,
'shared_height_R_recurrence_steps':h*(P-1),
'coarse_anchor_instances':h*anchors,
'base_height_argument_pairs':h*args,
'initial_B_certificates':0,'step_cis_certificates':0,'step_grid_conversions':0,
'fine_state_complex_updates':h*args,'state_to_EM_grid_conversions':h*args,
'final_coefficient_power2_scales':h*fine*20,'final_coefficient_rounds':h*fine*20}
results=[]
for i,e in enumerate(extras):
    a=author['scenarios'][i];s=seed['scenarios'][i]['large']
    ck(a['extra_nodes']==e)
    prior=unpack(sumcols(old[i]));added=derived(sumcols(new[i]))
    ck(prior==a['old_runtime'])
    ck(prior['operations']==summary['scenarios'][i]['operations']==s['transform_operations'])
    ck(all(prior[k]==s[k] for k in ('conductor_height_nodes','residue_inputs','primitive_outputs')))
    ck(added==a['added_runtime'])
    ck([derived(v) for v in new[i]]==a['added_by_band'])
    count=maxJ+e+256;last=count-1;height=Fraction(5*last,64)
    ck(a['global_old_count']==maxJ+e==s['global_nodes'])
    ck(a['global_new_count']==count and a['max_guard_index']==last and Fraction(a['max_guard_height'])==height)
    ck(height<7000 and count<128000 and last>=64001)
    ck(a['shared_source_added_heights_by_band']==[0,0,0,0,256])
    ck(source==a['shared_source_added_operations'])
    ck(a['full_positive_Y_guard_normalizations']==256*sumprim)
    results.append({'extra':e,'last_index':last,'height':str(height),'added_runtime':added})
neg=author['negative_full_superset']
ck(neg['positive_indices_needed']==[1,256] and Fraction(neg['max_absolute_height'])==20)
ck(neg['attenuation_scalar_enclosures']==256 and neg['scalar_transports']==256*sumprim and neg['inverse_label_bindings']==sumprim)
ck(author['setup']['unchanged_transform_setup']==manifest['unchanged_setup'])
ck(author['setup']['unchanged_seed_setup']==seed['setup']['large_seed'])
ck(all(author['setup'][k]==0 for k in ('new_transform_dimensions','new_seed_rational_arguments','new_initial_B_or_step_certificates')))
ck(args==6148097<seed['setup']['large_seed']['distinct_arguments_union']==7049217)
ck(author['conductor_rows']['bytes']==(BASE/'integration/sample_guard_conductor_rows_20261111.json').stat().st_size)
ck(author['conductor_rows']['sha256']==pins['integration/sample_guard_conductor_rows_20261111.json'])
out={'status':'PASS_SAVED_ROW_GUARD_FOLD','checks':checks,'pins':pins,'rows_checked':len(rows),
     'scenarios':results,'independent_source_increment':source,
     'scope':'Saved manifest/receipt folds only. No conductor, factor, unit, query, character or numerical value generation; no author program execution. Analytic window theorem separate.'}
dest=HERE/'review_large_sample_guard_ledger_20261111.json'
with dest.open('x',encoding='utf8',newline='\n') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':sha(dest)}))
