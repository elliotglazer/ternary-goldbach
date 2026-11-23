"""Bounded saved-capacity fold only. No digits, arithmetic instances or new inventory."""
from pathlib import Path
from fractions import Fraction
from collections import Counter
import hashlib,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3]
P1='work/qrh-campaign/agents/moebius/fixed_horner_degree_envelope_costs_20261111.json'
P2='work/qrh-campaign/agents/prime-estimates/large_residue_bucket_occupancy_20261111.json'
def read(p,pin):
 path=ROOT/p;assert path.stat().st_size<=524288
 data=path.read_bytes();assert hashlib.sha256(data).hexdigest().upper()==pin
 return json.loads(data)
a=read(P1,'4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9')
b=read(P2,'19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB')
assert set(a['results'])=={'first_four','final'}
assert len(b['scenarios'])==4
radices=[8,10,12,16];tables=[]
for w in radices:
 beta=1<<w;F=3*beta*beta
 low=beta*beta*(9*w+22)+12*beta;high=beta*beta*(13*w+24)
 tables.append({'w':w,'beta':beta,'closed_facts':F,'theorem_entry_bytes':8*F,
 'digit_binary_nodes_sum':(w-1)*beta+2,
 'unshared_table_header_command_lower':low,'unshared_table_header_command_upper':high,
 'two_byte_term_ID_headers_only_bytes_lower':2*low-F,
 'two_byte_term_ID_max_single_header_bytes':2*(5*w+6)-1,
 'disjoint_header_start_offsets_impossible':2*low-F>((1<<32)-1+2*(5*w+6)-1),
 'two_byte_term_ID_table_plus_header_bytes_lower':2*low+7*F,
 'two_byte_term_ID_table_plus_header_bytes_upper':2*high+7*F,
 'fits_u32_theorem_count':F<(1<<32),
 'chosen_unshared_two_byte_layout_lower_fits_p32':2*low+7*F<(1<<32),
 'full_cell_header':94+11*w,'row_header':88+4*w,'terminal_header':64+2*w})
cases={};folds=0
for kind,profiles in a['results'].items():
 assert len(profiles)==3
 cases[kind]={}
 for name,data in profiles.items():
  assert len(data['stages'])==19
  hist=Counter()
  for st in data['stages']:
   i=st['input_magnitude_bits'];q=st['rounded_product_magnitude_bits']
   assert 1<=i<=256 and 1<=q<=256
   assert st['product_variants']['uncancelled']['divisor_magnitude_bits']==20
   hist[(i,18)]+=2;hist[(q,20)]+=2
  rows=[]
  for w in radices:
   cells=rowcount=products=0
   for (x,y),count in hist.items():
    m,n=sorted(((x+w-1)//w,(y+w-1)//w),reverse=True)
    assert m>=n>=1
    cells+=count*m*n;rowcount+=count*n;products+=count
   assert products==76
   rows.append({'w':w,'real_products':products,'cells':cells,'rows':rowcount,
    'template_events':5*cells+2*rowcount+products,
    'core_body_commands_excluding_D_C':25*cells+22*rowcount+products,
    'macro_header_commands_excluding_tables':cells*(94+11*w)+rowcount*(98+4*w)+products*(2-2*w),
    'all_uncached_arithmetic_table_and_macro_header_commands_upper':cells*(127+28*w)+rowcount*(98+4*w)+products*(2-2*w)})
   folds+=19*2
  assert rows[0]['template_events']==data['product_template_events']
  cases[kind][name]={'bit_capacity_histogram':[{'x':x,'y':y,'multiplicity':c} for (x,y),c in sorted(hist.items())],'rows':rows}
assert folds==912
weighted=[]
for sc in b['scenarios']:
 assert len(sc['bands'])==5
 U=[]
 for band in sc['bands']:
  assert len(band['cohorts'])==2
  U.append(sum(co['unit_outputs'] for co in band['cohorts']))
 assert sum(U)==sc['unit_residue_height_inputs']
 assert 19*sum(U)==sc['old_Horner_stages']
 for name in cases['first_four']:
  rows=[]
  for wi,w in enumerate(radices):
   ra=cases['first_four'][name]['rows'][wi];rb=cases['final'][name]['rows'][wi]
   keys=['real_products','cells','rows','template_events','core_body_commands_excluding_D_C','macro_header_commands_excluding_tables','all_uncached_arithmetic_table_and_macro_header_commands_upper']
   rows.append({'w':w,**{k:sum(U[:4])*ra[k]+U[4]*rb[k] for k in keys}})
  for row in rows[1:]:
   delta=rows[0]['template_events']-row['template_events']
   extra=3*((1<<(2*row['w']))-(1<<16))
   row['template_event_difference_from8']=delta
   row['toy_max_equal_setup_event_price_per_extra_fact_one_import']=str(Fraction(delta,extra))
  weighted.append({'extra_nodes':sc['extra_nodes'],'profile':name,'saved_band_unit_totals':U,'rows':rows})
paths=[P1,P2,'work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md',
 'work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/REVIEW_PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/REVIEW_PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md',
 'work/formal-goldbach-bench/mm0/src/types.c','work/formal-goldbach-bench/mm0/src/verifier.c',
 'work/formal-goldbach-bench/mm0/src/verifier_types.c','work/formal-goldbach-bench/mm0/src/mmb.md',
 'work/qrh-campaign/agents/prime-estimates/EFFICIENCY_MM0_DIGIT_TABLES_2026-11-11.md']
out={'scope':'Same-input full20 Horner capacity sensitivity, NOT a selected evaluator, implemented PA library or runtime result.',
 'preflight':{'input_cap_each':524288,'cases':6,'stages_each':19,'types':2,'radices':4,'repricings':folds,'output_cap':262144,'new_conductor_or_digit_loops':0},
 'table_metadata':tables,'cases':cases,'weighted_saved_inventory':weighted,
 'pins':{p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}}
raw=(json.dumps(out,indent=2)+'\n').encode();assert len(raw)<=262144
with (HERE/'general_radix_saved_horner_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps({'folds':folds,'bytes':len(raw),'first_four_fixed':cases['first_four'].get('fixed15442',cases['first_four'].get('fixed',{})),'tables':tables},indent=2))
