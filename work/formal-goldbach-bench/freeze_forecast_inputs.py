"""Extract measured calibrations and explicitly record modeling allowances."""
from pathlib import Path
import hashlib
import json

R=Path(__file__).resolve().parent
def read(p): return json.loads((R/p).read_text())
inputs=['lean/LargeBench.strict.json','lean/PackedBench.strict.json',
 'prime-cert/results.json','mm0/summary.json','prime-cover/simd_summary.json',
 'prime-cover/pool_grid_summary.json','prime-cover/packed_large_timings.json']
l=next(x for x in read(inputs[0])['results'] if x['label']=='large_packed_check' and x['width']==262144)
p=next(x for x in read('prime-cert/results.json')['cohort32']['stages'] if x['label']=='full_shared_closure')
m=read('mm0/summary.json')
o=next(x for x in m['cases'] if x['name']=='actual-reset-or')
s=next(x for x in m['cases'] if x['name']=='sparse-reset-slice-or')
n=next(x for x in read('prime-cover/packed_large_timings.json') if x['width']==262144)
q=next(x for x in read('prime-cover/pool_grid_summary.json')['cases'] if x['method']=='sequential_productive')
assert l['accepted']==l['reps'] and l['rejected']
assert p['accepted']==p['nodes']*p['reps'] and p['bad_rejected']
assert all(x['valid_accepted'] and x['corruption_rejected'] for x in (o,s))
out={
 'scope':'Current-checker conditional planning model. Allowances are judgments, not measurements.',
 'lean':{'width':l['width'],'kernel_seconds_per_chunk':l['kernel_seconds']/l['reps'],
  'build_ratio':1.05,'layout_factor':1.25,
  'prime_seconds_per_root':p['per_anchor_process_cpu_ms']/1000,
  'native_construction_core_years':100,'assembly_core_years':200},
 'mm0':{'or_check_seconds':o['checker_cpu_seconds_per_update'],
  'or_emit_seconds':o['emitter_cpu_seconds_per_update'],
  'slice_check_seconds':s['checker_cpu_seconds_per_update'],
  'slice_emit_seconds':s['emitter_cpu_seconds_per_update'],
  'index_seconds':0.25e-6,'other_core_years':1000},
 'sequential_search':{'selected':q['mean_selected'],'seconds_per_word':q['median_wall_us']*1e-6},
 'native_packed':{'width':n['width'],'seconds_per_chunk':n['flint_packed']['median_us']*1e-6},
 'native_shift_or':{'width':n['width'],'seconds_per_chunk':n['flint_shift_or']['median_us']*1e-6},
 'measured_fields':[
   'lean.width','lean.kernel_seconds_per_chunk','lean.prime_seconds_per_root',
   'mm0.or_check_seconds','mm0.or_emit_seconds','mm0.slice_check_seconds','mm0.slice_emit_seconds',
   'sequential_search.*','native_packed.*','native_shift_or.*'],
 'assumption_explanations':{
   'lean.build_ratio':'5% allowance based on nearby 65536-bit cached-input construction/check comparison; not measured at262144.',
   'lean.layout_factor':'25% allowance for radix/halo/layout adaptation. Prefix polynomials must be cached; not a guarantee for fixed512-anchor products.',
   'lean.native_construction_core_years':'100core-years allowance for source data, native coverage selection, certificate production and packing. Native Pratt construction alone is much smaller.',
   'lean.assembly_core_years':'200core-years unmeasured allowance for certified access, aggregation and shared data. No complete distributed pipeline exists.',
   'mm0.index_seconds':'0.25microseconds perselectedmask allowance for source-index/prime provenance and perword full-mask closure. Schematic benchmark omits these; sensitivity is large.',
   'mm0.other_core_years':'1000core-years unmeasured allowance for prime certificates, PA library/source preparation, amortized bootstrap and assembly. Assumes sufficiently large sound shards.'},
 'warnings':[
   'No complete Goldbach proof or globally successful fixed-size anchor cover was built.',
   'MM0 benchmark library uses schematic axioms and concludes ok, not PA Goldbach; actual word coverage was independently checked in Python.',
   'Current-checker estimates are not lower bounds on optimized proof systems or all possible mathematics.',
   'Native arithmetic figures exclude a complete verified accelerator. Both provers must be allowed kernel changes under that broader comparison.',
   'Most timed inner loops are warmed; host load, memory hierarchy, large dependency stores and I/O can change extrapolation.',
   'Lean timing is inner monotonic wall time; prime certificate and MM0 timing use process CPU. Dedicated-core projection is an assumption.',
   'The idealized fusion scenario removes separate emission cost without benchmarking the resulting implementation.',
   'Planning envelopes are judgments, not statistical confidence intervals or proved upper bounds.'],
 'source_sha256':{x:hashlib.sha256((R/x).read_bytes()).hexdigest() for x in inputs}}
(R/'forecast_inputs.json').write_text(json.dumps(out,indent=2)+'\n')
print('Wrote forecast_inputs.json with measured fields and explicit allowances.')
