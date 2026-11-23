"""Reproduce the conditional forecasts, with measurement/assumption separation.

Run after forecast_inputs.json has been frozen. This is an arithmetic model,
not a formal proof, implementation benchmark, or bound on optimal algorithms.
"""
from pathlib import Path
import hashlib
import json

ROOT=Path(__file__).resolve().parent
SECONDS_PER_YEAR=365.25*24*3600
LIMIT=4*10**18
EVENS=(LIMIT-4)//2+1
ANCHOR_BLOCK_EVENS=2**32
BLOCKS=(EVENS+ANCHOR_BLOCK_EVENS-1)//ANCHOR_BLOCK_EVENS
ANCHORS=512*BLOCKS
WORDS=(EVENS+63)//64

def years(seconds):
    return seconds/SECONDS_PER_YEAR

def main():
    data=json.loads((ROOT/'forecast_inputs.json').read_text())
    grid=json.loads((ROOT/'prime-cover/simd_summary.json').read_text())
    search=[]
    for row in grid['cases']:
        search.append({'pool':row['pool'],'selected':row['mean_selected'],
          'search_seconds':row['variants']['pool_grid_simd_key']['median_us']*1e-6})
    # Sequential productive-mask route, measured independently in the same grid.
    seq=data['sequential_search']
    search.append({'pool':'sequential','selected':seq['selected'],
                   'search_seconds':seq['seconds_per_word']})

    def mm0_route(check,emit,index):
        variants=[]
        for s in search:
            components={'native_search':years(WORDS*s['search_seconds']),
              'coverage_check':years(WORDS*s['selected']*check),
              'proof_emission':years(WORDS*s['selected']*emit),
              'index_provenance_allowance':years(WORDS*s['selected']*index)}
            variants.append({**s,'components_core_years':components,
                             'subtotal_core_years':sum(components.values())})
        return {'all_search_variants':variants,
                'best':min(variants,key=lambda r:r['subtotal_core_years'])}

    lean=data['lean']
    chunks=(EVENS+lean['width']-1)//lean['width']
    measured_lean=years(chunks*lean['kernel_seconds_per_chunk'])
    lean_components={
      'coverage_kernel_measured_extrapolation':measured_lean,
      'coverage_build_and_layout_allowance':measured_lean*(lean['build_ratio']*lean['layout_factor']-1),
      'primality_full_cohort_extrapolation':years(ANCHORS*lean['prime_seconds_per_root']),
      'native_construction_allowance':lean['native_construction_core_years'],
      'assembly_and_shared_data_allowance':lean['assembly_core_years']}
    mm=data['mm0']
    routes={
      'prealigned_serial':mm0_route(mm['or_check_seconds'],mm['or_emit_seconds'],mm['index_seconds']),
      'slice_serial':mm0_route(mm['slice_check_seconds'],mm['slice_emit_seconds'],mm['index_seconds']),
      'prealigned_idealized_fusion':mm0_route(mm['or_check_seconds'],0,mm['index_seconds'])}
    for route in routes.values():
        route['other_allowance_core_years']=mm['other_core_years']
        route['total_core_years']=route['best']['subtotal_core_years']+mm['other_core_years']
    central_lean=sum(lean_components.values())
    central_mm=routes['prealigned_serial']['total_core_years']
    native=data['native_packed']
    native_packed_years=years(((EVENS+native['width']-1)//native['width'])*native['seconds_per_chunk'])
    native_or=data['native_shift_or']
    native_or_years=years(((EVENS+native_or['width']-1)//native_or['width'])*native_or['seconds_per_chunk'])
    out={'scope':'Conditional future architecture forecasts, not complete-proof timings or optimality bounds.',
      'constants':{'seconds_per_core_year':SECONDS_PER_YEAR,'target_limit':LIMIT,
       'even_targets':EVENS,'anchor_blocks':BLOCKS,'anchor_count':ANCHORS,'words_64':WORDS,
       'lean_chunks':chunks},
      'lean':{'components_core_years':lean_components,'total_core_years':central_lean},
      'mm0':routes,
      'native_packed_arithmetic_only_core_years':native_packed_years,
      'native_shift_or_arithmetic_only_core_years':native_or_years,
      'accelerated_mm0_conditional_scenario':{
        'status':'Unbuilt checker, not ordinary MMB verification. These arithmetic references apply equally to a proposed Lean accelerator. No total forecast is validated.',
        'packed_arithmetic_core_years':native_packed_years,
        'shift_or_arithmetic_core_years':native_or_years},
      'wall_years_at_70_percent_efficiency':{
        str(cores):{'lean':central_lean/(cores*.7),'mm0_prealigned_serial':central_mm/(cores*.7)}
        for cores in (1000,10000,100000)},
      'input_sha256':hashlib.sha256((ROOT/'forecast_inputs.json').read_bytes()).hexdigest(),
      'warnings':data['warnings']}
    (ROOT/'forecast.json').write_text(json.dumps(out,indent=2))
    print(json.dumps({'lean_core_years':central_lean,'mm0_prealigned_core_years':central_mm,
       'mm0_slice_core_years':routes['slice_serial']['total_core_years'],
       'native_packed_arithmetic_only':native_packed_years},indent=2))

if __name__=='__main__':
    main()
