"""Compose frozen count receipts only; no generators, spectra or analytic values."""
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
from copy import deepcopy
import json
HERE=Path(__file__).resolve().parent; ROOT=HERE.parents[3]
checks={}
def ck(name,test):
    assert test,name
    checks[name]=True
pins={
'work/qrh-blueprint/combined_retuned_seed_20261111.json':'5924631261D494F377D647DBB3FA4BDB39796BDF5B2F979499A1D56144A86CAC',
'work/qrh-campaign/agents/audit/REVIEW_COMBINED_PROFILE_RETUNED_SEED_LEDGER_2026-11-11.md':'E2F06FEEA3E132A80BBD5245F37998815713070674A389B6665C985418015190',
'work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md':'E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9',
'work/qrh-blueprint/joint_seed_m159_20261111.json':'EF16593CF667377CD68CA9D3C37343E3364ECA06CABACCC9B8465931E2D83D45',
'work/qrh-campaign/agents/audit/REVIEW_JOINT_SEED_159_CORRECTIONS_2026-11-11.md':'09DEF5ABB358A807936270B07E61FFEE624EF0F04C3E17AC47A1179D944E2E82',
'work/qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F',
'work/qrh-campaign/agents/major-constants/joint_quarter_mesh_head_tradeoff_20261111.json':'F1686B1C1A3183082D9126F4FE680BE6DB42A88D31F82071B752759EE3DE9BD4',
'work/qrh-campaign/agents/audit/REVIEW_JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A',
'work/qrh-campaign/agents/major-constants/combined_odd_even_height_inventory_20261111.json':'BCBAA29AE9A963A46170C5B7B355C0399EE6A622EDBE355ECD24BFE92042C2EE',
'work/qrh-campaign/agents/prime-estimates/WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md':'74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE',
'work/qrh-campaign/agents/prime-estimates/small_family_theta_inventory_final_20261111.json':'26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69',
'work/qrh-campaign/agents/audit/REVIEW_WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md':'34FB45C1CEBFF34A49C7C450BF1C78223593AB188EFEFC7C3EE7FE7658CB0AFE'}
for p,h in pins.items():ck('pin_'+Path(p).name,sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
def read(p):return json.loads((ROOT/p).read_text())
old=read('work/qrh-blueprint/combined_retuned_seed_20261111.json')
joint=read('work/qrh-campaign/agents/major-constants/joint_quarter_mesh_head_tradeoff_20261111.json')
m159=read('work/qrh-blueprint/joint_seed_m159_20261111.json')
large=read('work/qrh-campaign/agents/major-constants/combined_odd_even_height_inventory_20261111.json')
small=read('work/qrh-campaign/agents/prime-estimates/small_family_theta_inventory_final_20261111.json')
ck('parameters',m159['parameters']=={'m':159,'N':1500,'D':4096,'P':28,'V':7000,'W':7009})
rename={'independent_P27_source_coefficients':'source_coefficients','P27_to_P20_midpoint_shift_updates':'source_translation_updates'}
def canon(counts):return {rename.get(k,k):v for k,v in counts.items()}
scenarios=[]
for i,e in enumerate([0,167,320,640]):
    baseline=old['scenarios'][i]; source=large['scenarios'][i]; prior_joint=joint['scenarios'][i]
    ck('scenario_'+str(e),baseline['extra_nodes']==source['extra_nodes']==prior_joint['extra_nodes']==e)
    prev=baseline['selected_P27']['bands']; H=prev[-1]['heights']
    ck('H_'+str(e),H==20199+e==prior_joint['final_heights'])
    bands=[]; first=0
    for band in prev[:4]:
        b=deepcopy(band);b['D_source']=b.pop('D');b.update(P=27,endpoint_P=20,m=64,D_output=b['D_source'])
        b['counts']=canon(b['counts']);b['first_index']=first;b['last_index']=first+b['heights']-1
        first=b['last_index']+1;bands.append(b)
    ck('first_index_'+str(e),first==64001)
    D,N,P,m=4096,1500,28,159
    K=P*(D+1);X=(N+1)*D+1
    per={'source_coefficients':K,'head_reciprocal_scales':N*(P-1)*(D+1),'head_accumulator_additions':N*K,
      'E_contracting_complex_stages':(P+2*m-2)*(D+1),'Bernoulli_weighted_terms':m*K,'Bernoulli_accumulator_additions':m*K,
      'source_translation_updates':3*D*(20*P-210),'P20_fine_anchor_coefficient_deliveries':20*(4*D+1),
      'shared_height_R_recurrence_steps':P-1,'coarse_anchor_instances':D+1,'base_height_argument_pairs':X,
      'initial_B_certificates':0,'step_cis_certificates':0,'step_grid_conversions':0,
      'fine_state_complex_updates':X,'state_to_EM_grid_conversions':X,
      'final_coefficient_power2_scales':20*(4*D+1),'final_coefficient_rounds':20*(4*D+1)}
    ck('m159_counts_'+str(e),per['Bernoulli_weighted_terms']==m159['gamma_terms']==18239844 and per['E_contracting_complex_stages']==m159['E_stages']==1409368)
    for b in bands:b['counts'].update(final_coefficient_power2_scales=0,final_coefficient_rounds=0)
    final={'V':7000,'D_source':D,'D_output':8192,'N':N,'m':m,'P':P,'endpoint_P':P,'heights':H,
      'first_index':64001,'last_index':64000+H,'counts':{k:H*v for k,v in per.items()}}
    bands.append(final)
    totals={k:sum(b['counts'][k] for b in bands) for k in per}
    old_totals=canon(baseline['selected_P27']['totals']);old_final=canon(prev[-1]['counts'])
    for k in old_totals:ck('replacement_'+str(e)+'_'+k,totals[k]==old_totals[k]-old_final[k]+final['counts'][k])
    ck('init_union_'+str(e),totals['initial_B_certificates']==totals['step_cis_certificates']==totals['step_grid_conversions']==7049217)
    ck('update_partition_'+str(e),totals['fine_state_complex_updates']+totals['initial_B_certificates']==totals['base_height_argument_pairs'])
    ck('fine_output_unchanged_'+str(e),totals['P20_fine_anchor_coefficient_deliveries']==old_totals['P20_fine_anchor_coefficient_deliveries'])
    ck('transforms_unchanged_'+str(e),baseline['transform_operations']==source['operations'])
    ck('horner_unchanged_'+str(e),baseline['P20_Horner_stages']==source['P20_Horner_stages']==19*source['residue_inputs'])
    ck('height_endpoint_'+str(e),baseline['global_nodes']==64001+H and F(baseline['last_height'])==F(5*(64000+H),64)<7000)
    alternatives={}
    for theta in [64,128]:
        row=next(x for x in small['scenarios'] if x['extra_nodes']==e and x['theta']==theta)
        d=deepcopy(row); d['not_selected_point_EM_comparator']={k:v for k,v in d['totals'].items() if k.startswith('point_EM_')}
        d['totals']={k:v for k,v in d['totals'].items() if not k.startswith('point_EM_')}
        for par in d['by_conductor_parity'].values():
            for k in list(par):
                if k.startswith('point_EM_'):del par[k]
        ck('small_partition_'+str(e)+'_'+str(theta),all(sum(v[k] for v in d['by_conductor_parity'].values())==val for k,val in d['totals'].items()))
        alternatives[str(theta)]=d
    ck('small_outputs_same_'+str(e),alternatives['64']['totals']['primitive_grid_outputs']==alternatives['128']['totals']['primitive_grid_outputs'])
    scenarios.append({'extra_nodes':e,'large':{'family':{'conductors':125400,'primitive_labels':4333246843,'unit_coefficients':7133015232},
      'global_nodes':baseline['global_nodes'],'last_height':baseline['last_height'],
      'conductor_height_nodes':source['conductor_height_nodes'],'residue_inputs':source['residue_inputs'],
      'primitive_outputs':source['primitive_outputs'],'transform_operations':deepcopy(baseline['transform_operations']),
      'P20_Horner_stages':baseline['P20_Horner_stages'],'seed_bands':bands,'seed_totals':totals,
      'seed_delta_from_retuned_baseline':{k:totals[k]-old_totals.get(k,0) for k in totals}},
      'small_alternatives':alternatives,
      'safe_cardinality_sum':{'conductors':125400+7499,'primitive_labels':4333246843+18477108,
        'requested_primitive_outputs':source['primitive_outputs']+alternatives['64']['totals']['primitive_grid_outputs']}})

setup={'large_transform_unchanged':deepcopy(large['transform_setup_unchanged']),
 'large_seed':{'distinct_arguments_union':7049217,'final_active_arguments':6148097,'retired_at_final_transition':901120,
  'introduced_at_final_transition':0,'log_grid_points':7049217,'log_anchors':960,'log_degree21_stages':148013397,
  'initial_B_certificates':7049217,'step_cis_certificates':7049217,'step_grid_conversions':7049217,
  'gamma_constants':159,'highest_Bernoulli_index':318,'new_gamma_constants_above_m64':95,
  'D4096_lambda_table_entries':28,'additional_lambda_entries_above_P27':1,
  'raw_union_state_step_bytes_at_72_each':72*7049217,'raw_final_state_step_bytes_at_72_each':72*6148097,
  'scope':'Raw two-array layout only, not peak memory. Elementary accuracy remains inherited; setup proof costs are not expanded.'}}
required=[
 {'item':'principal c=1 numerical certification','status':'unpriced_required','note':'Separate full principal demand; not included in either nonprincipal branch.'},
 {'item':'large Hardy/character normalization and postprocessing','status':'unpriced_required','note':'Conductor/phase data, normalization and interval transport beyond retained counters.'},
 {'item':'large EM endpoint assemblies and rational factors','status':'partly_counted_unpriced','note':'Source slots count instances; complex divisions, factor setup and proof/rounding expansion remain to price.'},
 {'item':'elementary certificates and exact Bernoulli construction','status':'partly_counted_unpriced','note':'Calls/grids are counted; big-integer operations, reduction, proof terms and sharing are not fully priced.'},
 {'item':'interpolation and strict signs','status':'unpriced_required','note':'Actual margins, precision repair and continuous coverage are not supplied by output counts.'},
 {'item':'Turing/completeness including central and closed endpoints','status':'unpriced_required','note':'Extra-node scenarios are not closure guarantees; gamma/count integrals and validation remain.'},
 {'item':'failed/adaptive work','status':'unpriced_required','note':'Additional precision, grids, retries and independent replay may exceed these fixed schedules.'},
 {'item':'proof representation and data handling','status':'unpriced_required','note':'Ordinary Lean/MM0 proof generation/verification, metadata, storage, transpose, transport and cache authentication.'},
 {'item':'finite binary Goldbach certificate','status':'unpriced_required','note':'Varying B needs its complete source, anchor, coverage and endpoint proof.'},
 {'item':'ternary prime ladder','status':'unpriced_required','note':'Actual certified chain, primality, gaps and terminal link remain separate.'},
 {'item':'analytic libraries and final theorem assembly','status':'unpriced_required','note':'Reusable analytic proof development and final source-faithful standard-axiom assembly.'}]
out={'scope':'Four fixed conditional nonprincipal schedules. No operation grand total, runtime or completed spectrum.',
 'input_sha256':pins,'checks':len(checks),'legacy_category_renaming':rename,
 'family_partition':{'large':'primitive nonprincipal c>10000, odd c<=132900 or 4|c<=265800',
   'small':'primitive nonprincipal c<=10000 under same profile','principal':'excluded, separately required'},
 'small_parameters':deepcopy(small['parameters']),'small_family':deepcopy(small['family']),
 'setup':setup,'scenarios':scenarios,'required_unpriced':required,
 'units_warning':'Large G/add/rotation/scales, head rational scales, E stages, translations, small contracted Gaussian gates and theta butterflies are distinct. Theta64 and128 are alternatives, not summands. Optional global caches replace their corresponding baseline setup rows, never add to them.'}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':len(checks),'setup':setup['large_seed'],'rows':[
 {'extra':s['extra_nodes'],'H':s['large']['seed_bands'][-1]['heights'],'seed':s['large']['seed_totals'],
 'large_G':s['large']['transform_operations']['general_complex_products'],'outputs_all':s['safe_cardinality_sum']['requested_primitive_outputs'],
 'theta64_time':s['small_alternatives']['64']['totals']['time_butterflies'],'theta128_time':s['small_alternatives']['128']['totals']['time_butterflies']}
 for s in scenarios]},indent=2))
