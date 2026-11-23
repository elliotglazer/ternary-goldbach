"""Symbolic size formulas and bounded old metadata only; no digit definitions emitted."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3]
rel='work/qrh-campaign/agents/prime-estimates/general_radix_saved_horner_20261111.json'
p=ROOT/rel;assert p.stat().st_size<=131072
raw=p.read_bytes();assert hashlib.sha256(raw).hexdigest().upper()=='87948E77ECF813E05B53893F22397D984E64B664E3EC2DC84212A268B212CFF0'
old=json.loads(raw);table=[]
for w in [8,10,12,16]:
 b=1<<w;F=3*b*b;defs=b-1;nodes=(w-1)*b+w+1
 qhi=65537-b;feasible=qhi>=256
 table.append({'w':w,'beta':b,'arithmetic_facts':F,'new_digit_defs':b-2,'new_radix_defs':1,
 'all_new_defs':defs,'canonical_body_nodes':nodes,
 'definition_body_commands':nodes+defs,'definition_header_commands':nodes+defs,
 'definition_entry_and_return_binder_bytes':16*defs,
 'two_byte_oldterm_definition_bytes_without_alignment_names':20*defs+4*nodes,
 'three_byte_alias_ID_q_interval':[256,qhi] if feasible else None,
 'complete_named_header_commands':34*b*b,
 'three_byte_model_header_bytes_lower':74*b*b-12*b if feasible else None,
 'three_byte_model_header_bytes_upper':78*b*b-12*b if feasible else None,
 'three_byte_model_entry_plus_headers_lower':98*b*b-12*b if feasible else None,
 'three_byte_model_entry_plus_headers_upper':102*b*b-12*b if feasible else None,
 'generic_max_five_byte_named_header_bytes_upper':104*b*b,
 'all_term_IDs_five_byte_header_plus_entries_upper':182*b*b,
 'all_term_IDs_five_byte_with_7byte_header_alignment_upper':203*b*b,
 'all_term_IDs_five_byte_definition_bytes_without_alignment_names':20*defs+10*nodes,
 'fits_u32_theorem_count':F<(1<<32),
 'all_digit_plus_radix_heads':b+1,
 'all_heads_conditional_16byte_store_bytes':16*(b+1),
 'all_heads_heap_reference_bytes':4*(b+1),
 'max_product_table_conversion_commands_without_target_build':20,
 'max_fulladder_table_conversion_commands_without_target_build':20,
 'max_product_conversion_definition_unify_commands':5*w+6,
 'max_fulladder_conversion_definition_unify_commands':4*w+5})
cases=[]
for kind,profiles in old['cases'].items():
 assert len(profiles)==3
 for profile,data in profiles.items():
  assert len(data['rows'])==4
  rows=[]
  for r in data['rows']:
   cells=r['cells'];nr=r['rows'];products=r['real_products']
   rows.append({'w':r['w'],'template_events_unchanged':r['template_events'],
    'generic_macro_headers':94*cells+98*nr+2*products,
    'all_uncached_arithmetic_table_macro_headers':140*cells+98*nr+2*products,
    'prior_expanded_header_upper':r['all_uncached_arithmetic_table_and_macro_header_commands_upper'],
    'scope':'Commands in matched header stencil only; conversions/ranges/library proofs/setup remain separate.'})
  cases.append({'kind':kind,'profile':profile,'rows':rows})
assert len(cases)==6
paths=[rel,'work/qrh-campaign/agents/prime-estimates/GENERAL_RADIX_PA_COST_FRONTIER_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/REVIEW_GENERAL_RADIX_PA_COST_FRONTIER_2026-11-11.md',
 'work/formal-goldbach-bench/mm0/src/types.c','work/formal-goldbach-bench/mm0/src/verifier.c',
 'work/formal-goldbach-bench/mm0/src/verifier_types.c','work/formal-goldbach-bench/mm0/src/mmb.md',
 'work/mm0-efficient/toolchain-sources/examples__peano.mm0','work/mm0-efficient/toolchain-sources/examples__peano.mm1']
out={'scope':'Conservative named-natural definitions, source-format and command counts only; no definitions/tables/proofs emitted.',
 'preflight':{'input_cap':131072,'input_bytes':len(raw),'case_rows':24,'radices':4,'digit_loops':0,'output_cap':65536},
 'table_metadata':table,'same_saved_cases':cases,
 'pins':{s:hashlib.sha256((ROOT/s).read_bytes()).hexdigest().upper() for s in paths}}
result=(json.dumps(out,indent=2)+'\n').encode();assert len(result)<=65536
with (HERE/'named_natural_digit_format_20261111.json').open('xb') as f:f.write(result)
print(json.dumps({'bytes':len(result),'w12':table[2],'first_fixed':[x for x in cases if x['kind']=='first_four' and x['profile']=='fixed_15442']},indent=2))
