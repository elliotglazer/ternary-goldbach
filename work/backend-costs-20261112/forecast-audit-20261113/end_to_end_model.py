"""Small conditional Fermi model. Literal semantic counts only; no inventory or values."""
from pathlib import Path
import hashlib, json, math
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
YEAR=31557600
# type, count, hypothetical fraction of measured 343-bit dependent butterfly,
# real products per operation in the separate deliberately coarse PA scenario.
rows=[
 ('large_root_product',920122241148146,[.08,.25,1],3),
 ('large_kernel_product',89017934196032,[.10,.35,1.5],3),
 ('large_complex_add',2090319798067922,[.005,.02,.10],0),
 ('large_quarter_turn',92576511158537,[.001,.005,.02],0),
 ('large_negation',19970124208,[.001,.005,.02],0),
 ('residue_horner_stage',60254515577760*19,[.02,.06,.25],2),
 ('raw_head_product_assembly',60254515577760,[.08,.25,1],4),
 ('input_regrid',54067011555562,[.005,.02,.10],0),
 ('raw_integer_state_update',265800*89600,[.08,.25,1],4),
 ('raw_conductor_cache',1528006797,[.02,.08,.3],2),
 ('em_head_scale',10969166595220,[.03,.10,.5],2),
 ('em_head_add',11386294892080,[.005,.02,.1],0),
 ('em_bernoulli_scale_add',703333562176,[.04,.15,.75],2),
 ('em_E_stage',58114704402,[.15,.5,3],4),
 ('em_fine_state_update',417288057616,[.08,.25,1],4),
 ('em_shift_update',150847656960,[.02,.10,.5],2),
 ('em_endpoint_slot',7543088084,[.5,2,10],8),
 ('em_final_scale_round',6632648000,[.01,.05,.2],0),
 ('em_state_copy_conversion',417295106833,[.005,.02,.1],0),
 ('shared_coefficient_coordinate_conversion',28734393000,[.01,.04,.2],0),
 ('small_character_butterfly',128941391789290,[.5,1,3],3),
 ('small_time_butterfly',89858217607168,[.5,1,3],3),
 ('small_gaussian_unit',8542028172242,[.1,.5,3],3),
 ('small_bucket_add',7969016316193,[.01,.05,.2],0),
 ('small_character_point_product',25399177848072,[.3,.65,2],3),
 ('small_complex_prefactor',1202865170991,[.3,.65,2],3),
 ('small_real_radial_prefactor',2421291652611,[.1,.3,1],1),
 ('small_inverse_scale',15046227780352,[.01,.05,.2],0),
 ('small_odd_scale',4156411711634,[.01,.05,.2],0),
 ('large_completion_sign',36468561640066,[.1,.4,2],4),
 ('small_sign',1775431871117,[.005,.02,.1],0),
 ('negative_guard_adapter_superset',177663120563,[.02,.1,.5],2),
 ('frequency_conjugate_copy',1202846693883,[.001,.005,.02],0),
 ('zero_imag_projection',18477108,[.001,.005,.02],0),
 ('em_shared_R_step',2210506,[.1,.5,3],2),
 # Complete elementary enclosure factors are assumptions, not bare multiplication prices.
 ('small_root_cis_enclosure',10003939328+25330722+41412194+59992+22494,[10,1000,100000],30),
 ('small_outer_complex_exp_enclosure',2605203866,[100,10000,1000000],100),
 ('small_cutoff_rational_division',2605203866,[5,500,50000],2),
 ('small_seed_unit_contraction',2605203866,[.3,.65,2],3),
 ('small_phase_root_division_product',18477108,[20,2000,200000],10),
 ('small_positive_root_setup',14998,[10,1000,100000],10),
 ('small_real_exp_seed',7499,[100,10000,1000000],100),
 ('small_fixed_setup_arithmetic',221845280,[.1,.5,3],2),
 ('small_gauss_butterfly',1005598874,[.8,2,6],3),
 ('small_gauss_point_product',191293204,[.5,1,4],3),
 ('small_gauss_inverse_scale',113309696,[.01,.05,.2],0),
 ('small_kernel_build_butterfly',163605472,[.8,2,6],3),
 ('em_initial_B_step_cis_grid_objects',3*7049217,[100,10000,1000000],100),
 ('em_log_anchor',960,[100,10000,1000000],100),
 ('em_nonanchor_log_stage',148013397,[.03,.1,.5],2),
 ('raw_log_inverse_root_step_enclosures',3*265800,[100,10000,1000000],100),
 ('bernoulli_exact_constant',159,[1000,100000,10000000],1000),
 ('large_kernel_setup_product',2388169382,[.1,.35,1.5],3),
 ('large_kernel_setup_add',5865912000,[.005,.02,.1],0),
 ('large_kernel_setup_quarter',181592717,[.001,.005,.02],0),
 ('large_chirp_enclosure',150746135,[10,1000,100000],30),
 ('large_cache_presum',726404736,[.005,.02,.1],0),
 ('large_scaled_cache_round',363202368,[.01,.05,.2],0),
]
scenarios=['favorable','planning','stress']
rates={'Lean':13.464615/8192,'HOL4':.073960/8192,'Candle':.158679/8192}
native=.003747830/8192
geometry=[1,1.02,1.10] # explicit allowance, NOT an exact e167/e640 projection
query_fraction=[.001,.03,1]
retry_gen=[1,1.25,3]; retry_accept=[1,1.1,2]
reuse=[10000,100,1]
named_blocks=math.ceil((920122241148146+89017934196032+218799609396458)/8192)
small_labels=18477108; large_labels=4333246843
result={'scope':'Conditional proposed implementations, not measured full TG or upper/lower bounds',
 'seconds_per_core_year':YEAR,'semantic_rows':[], 'assumptions':{},'backends':{}}
for name,count,factors,products in rows:
 result['semantic_rows'].append(dict(name=name,count=count,butterfly_factors=factors,
  pa_real_product_multiplicity=products))
result['assumptions']=dict(geometry_factor=geometry,query_fraction=query_fraction,
 generation_retry=retry_gen,accepted_refinement_factor=retry_accept,
 literal_payload_reuse=reuse,notional_8192_operation_blocks=named_blocks,
 serialized_bytes_per_notional_block=[8192,65536,1048576],
 io_bytes_per_second=[10e9,1e9,.1e9],serialization_bytes_per_cpu_second=[500e6,100e6,20e6],
 principal_terms=250000001*4095,principal_butterfly_factor=[.5,5,50],
 labels=small_labels+large_labels,closure_seconds_per_label=[.001,.1,10],
 cache_reload_factor=[1,3,10],
 cache_entries_large_and_small=363202368+24654496,
 large_nonchirp_root_keys=[1000000,100000000,8*49899*265800],
 process_blocks_per_shard=[1000000,10000,100],process_startup_seconds=[5,20,100],
 finite_scope='separate explicit production assumptions below; no HOL batch ratio transferred; B1e16 ladder success conditional',
 finite=dict(B=10**16,L=2**36,tiles=19073486329,anchor_records=37252608,
   rungs=[103845000000,118680000000,197800000000],
   native_mask_seconds_per_word=[1.3e-6,2.6e-6,6.5e-6],
   complete_tile_seconds={'Lean':[.0034,.0068,.0272],'HOL4':[.001,.01,.1],'Candle':[.002,.02,.2]},
   complete_ladder_rung_seconds={'Lean':[.0001,.001,.1],'HOL4':[.0001,.001,.1],'Candle':[.0002,.002,.2]},
   anchor_check_seconds={'Lean':[.03,.055,.25],'HOL4':[.002,.005,.05],'Candle':[.004,.01,.1]},
   anchor_generation_seconds=[.002,.02,.2],source_exception_library_io_cpu_reserve_years=[1,10,100]),
 library_module_counts=[1000,5000,20000],library_cpu_seconds_per_module_build=[60,600,3600],
 library_rebuild_rounds=[2,10,50],
 library_port_module_multiplier={'Lean':[1,1,1],'HOL4':[2,4,8],'Candle':[2,4,8]},
 human_engineer_years={'Lean':[2,10,50],'HOL4':[10,50,200],'Candle':[10,50,200]},
 core_rate_seconds_per_butterfly=rates,native_rate_seconds_per_butterfly=native)
for backend,rate in rates.items():
 out={}
 for i,s in enumerate(scenarios):
  categories={n:c*f[i]*geometry[i]*rate*retry_accept[i]/YEAR for n,c,f,p in rows}
  weighted=sum(c*f[i] for n,c,f,p in rows)*geometry[i]
  lq=math.ceil(36468561640066*query_fraction[i]); sq=math.ceil(1775431871117*query_fraction[i])
  repair=lq*83*[.01,.05,.25][i]+sq*220*[.03,.1,.5][i]
  categories['offgrid_arithmetic']=repair*rate*retry_accept[i]/YEAR
  categories['native_discovery_generation']=(weighted+repair)*native*retry_gen[i]/YEAR
  # Acceptance times already include HOL/Candle execution and theorem derivation.
  categories['lean_additional_frontend']=((weighted+repair)*rate*[.25,1,4][i]/YEAR if backend=='Lean' else 0)
  setup=4.269485 if backend=='HOL4' else 4.186 if backend=='Candle' else 7.734375
  # Lean's setup anchor is a broader data build and is deliberately qualified.
  retained_blocks=math.ceil(named_blocks*geometry[i]*retry_accept[i])
  categories['literal_representation']=retained_blocks*setup/reuse[i]/YEAR
  categories['principal']=(250000001*4095)*[.5,5,50][i]*rate*retry_accept[i]/YEAR
  categories['nonprincipal_closure']=(small_labels+large_labels)*[.001,.1,10][i]/YEAR
  categories['cache_input_translation']=(363202368+24654496)*setup/192*[1,3,10][i]/YEAR
  categories['large_nonchirp_root_producer']=result['assumptions']['large_nonchirp_root_keys'][i]*[10,1000,100000][i]*rate/YEAR
  categories['generic_library_compilation']=[1000,5000,20000][i]*[60,600,3600][i]*[2,10,50][i]*result['assumptions']['library_port_module_multiplier'][backend][i]/YEAR
  categories['process_distribution_setup']=math.ceil(retained_blocks/[1000000,10000,100][i])*[5,20,100][i]/YEAR
  finite=result['assumptions']['finite']
  finiteparts=dict(mask_search=math.ceil((10**16//2-1)/64)*finite['native_mask_seconds_per_word'][i]/YEAR,
   complete_tiles=finite['tiles']*finite['complete_tile_seconds'][backend][i]/YEAR,
   complete_ladder=finite['rungs'][i]*finite['complete_ladder_rung_seconds'][backend][i]/YEAR,
   anchors=finite['anchor_records']*(finite['anchor_check_seconds'][backend][i]+finite['anchor_generation_seconds'][i])/YEAR,
   remaining=finite['source_exception_library_io_cpu_reserve_years'][i])
  categories['finite_coverage_and_ladder']=sum(finiteparts.values())
  proof_volume=retained_blocks*[8192,65536,1048576][i]
  payload_volume=math.ceil((9237783904256*52+363202368*28+8590000128)*geometry[i]*retry_accept[i])
  volume=proof_volume+payload_volume
  categories['serialization_and_root_assembly']=volume/[500e6,100e6,20e6][i]/YEAR
  out[s]=dict(categories_core_years=categories,finite_parts_core_years=finiteparts,total_core_years=sum(categories.values()),
   total_core_hours=sum(categories.values())*8766,retained_notional_blocks=retained_blocks,serialized_bytes=volume,
   proof_bytes_assumed=proof_volume,raw_payload_bytes_assumed=payload_volume,
   one_io_pass_years=volume/[10e9,1e9,.1e9][i]/YEAR,
   engineer_years=result['assumptions']['human_engineer_years'][backend][i],
   hypothetical_wall_lower_bound_years_1000_effective_cores=max(sum(categories.values())/1000,volume/[10e9,1e9,.1e9][i]/YEAR))
 result['backends'][backend]=out
# PA experiment is scalar only. This model deliberately does not pretend to have
# a matched network: proposed signed/range/composition overhead is explicit.
pa={}
for i,s in enumerate(scenarios):
 prod=sum(c*p for n,c,f,p in rows)*geometry[i]
 prod+=(250000001*4095)*[2,8,32][i] # explicitly guessed principal real-product work
 prod+=result['assumptions']['large_nonchirp_root_keys'][i]*30
 prod+=math.ceil(36468561640066*query_fraction[i])*83
 prod+=math.ceil(1775431871117*query_fraction[i])*220
 # Generic 343-bit product implementation used as reference with UNMEASURED width adjustment.
 adjusted=prod*[.1,.3,1][i]*[2,5,20][i]
 gen=adjusted*((79.08+6.86+.85)/64)*retry_gen[i]/YEAR
 check=adjusted*(.220877/64)*retry_accept[i]/YEAR
 volume=adjusted*(52088360/64)*retry_accept[i]
 # Separate 90-bit ladder: unmeasured width adjustment, including proof generation.
 ladder_products=result['assumptions']['finite']['rungs'][i]*88*[.02,.1,.3][i]*[2,5,20][i]
 ladder=ladder_products*((79.08+6.86+.85+.220877)/64)/YEAR
 volume+=ladder_products*(52088360/64)
 extra=ladder+[200,1000,20000][i]+[10,100,10000][i]+[1,30,1000][i]
 pa[s]=dict(raw_real_products=prod,width_factor=[.1,.3,1][i],
  unmeasured_nonproduct_and_composition_factor=[2,5,20][i],
  generation_core_years=gen,first_check_core_years=check,
  finite_ladder_core_years=ladder,finite_library_source_closure_reserve_core_years=extra,total_core_years=gen+check+extra,
  serialized_bytes=volume,one_io_pass_years=volume/[10e9,1e9,.1e9][i]/YEAR,
  engineer_years=[10,100,500][i])
result['ordinary_PA_current_scalar_architecture']=pa
evidence=[
 'work/backend-costs-20261112/lean-dependent/REPORT.md',
 'work/backend-costs-20261112/lean-dependent/RESULTS.json',
 'work/backend-costs-20261112/hol4-setup/DEPENDENT_BLOCK_REPORT.md',
 'work/backend-costs-20261112/hol4-setup/DEPENDENT_RESULTS.json',
 'work/backend-costs-20261112/candle-setup/DEPENDENT_REPORT.md',
 'work/backend-costs-20261112/candle-setup/DEPENDENT_RESULTS.json',
 'work/backend-costs-20261112/mm0-pa/REPORT.md',
 'work/backend-costs-20261112/mm0-pa/RESULTS.json',
 'work/backend-costs-20261112/finite-lean/REPORT.md',
 'work/backend-costs-20261112/finite-lean/RESULTS.json',
 'work/backend-costs-20261112/finite-lean/BATCH_REPORT.md',
 'work/backend-costs-20261112/finite-lean/BATCH_RESULTS.json',
 'work/backend-costs-20261112/finite-hol/BATCH_REPORT.md',
 'work/backend-costs-20261112/finite-hol/BATCH_RESULTS.json',
 'work/qrh-blueprint/estimates-20261111/SPECTRAL_COST_ESTIMATE.md',
 'work/qrh-blueprint/estimates-20261111/FINITE_COST_ESTIMATE.md',
 'work/lean-pilots/spectral/REPORT.md',
 'work/backend-costs-20261112/forecast-audit-20261113/WIDTH_RESOLVED_LEDGER.md',
 'work/backend-costs-20261112/forecast-audit-20261113/WIDTH_RESOLVED_LEDGER.json',
 'work/backend-costs-20261112/forecast-audit-20261113/FINITE_FRONTIER.md',
]
result['evidence']=[dict(path=p,sha256=hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()) for p in evidence]
dest=HERE/'end_to_end_model.json'
with dest.open('w',encoding='utf8') as f:json.dump(result,f,indent=2)
for b,sc in result['backends'].items():
 print(b,[(s,round(d['total_core_years'],2),round(d['one_io_pass_years'],3)) for s,d in sc.items()])
print('PA',[(s,round(d['total_core_years'],2)) for s,d in pa.items()])
