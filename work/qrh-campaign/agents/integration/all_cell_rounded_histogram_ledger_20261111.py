"""Fold frozen height-weighted length histograms. No conductor or unit scan."""
from pathlib import Path
from math import comb
import hashlib,json
HERE=Path(__file__).resolve().parent
BASE=HERE.parent
PINS={
 'prime-estimates/large_residue_bucket_occupancy_20261111.json':'19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB',
 'prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md':'99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1',
 'moebius/REVIEW_LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md':'C6096D0C677E09F850065EDD2103B0348E28392D482CCEE568136B387768C86E',
 'integration/TRUNCATED_NEWTON_ALL_CELL_TRAVERSAL_2026-11-11.md':'5213690312A3A4C8BC262439844AF2BE227AF5D13635EEDADD3D720EEDAAAE3F',
 'integration/truncated_newton_all_cells_20261111.json':'D8E01908E80DEF6EE7DCBA98DFD07F69F42168EFE273EEEACB06240F649A990E',
 'zero-sum/REVIEW_TRUNCATED_NEWTON_ALL_CELL_TRAVERSAL_2026-11-11.md':'365EA347A51CB0BE346A5C9447DABD0AC406379FB3871DBE224D6D3E7EDC4FF8',
}
checks=0
def ck(x):
 global checks
 checks+=1
 assert x
for p,h in PINS.items():ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
src=json.loads((BASE/'prime-estimates/large_residue_bucket_occupancy_20261111.json').read_text())
prior=json.loads((HERE/'truncated_newton_all_cells_20261111.json').read_text())
recipe={}
for L in range(1,261):
 m=min(20,L);G=m*(39-m)//2
 binary=sum((20-j)*(j.bit_count()-1) for j in range(1,m))
 shifts=sum((20-j)*j.bit_count() for j in range(1,m))
 small=sum(20-j for j in range(1,m))
 A=sum(max(0,L-1-j) for j in range(19))
 p=102+sum(comb(L-1,j) for j in range(m)).bit_length()
 recipe[L]=dict(L=L,m=m,p=p,G=G,binary=binary,shifts=shifts,small=small,A=A)
 old=prior['lengths'][L-1];init=prior['initialization'][m-1]
 ck(old['L']==L and old['p']==p and old['advances']==A)
 ck(init['general_products']==G and init['binary_additions']==binary and init['shifted_operands']==shifts)
KEYS=['buckets','empty_bucket_height_records','all_numerators','nonunit_visits','unit_outputs','old_unit_horner_stages',
 'coefficient_prescales','newton_general_products','newton_recurrence_additions',
 'newton_binary_scale_additions','newton_initialization_additions','newton_small_scales',
 'newton_shifted_operand_occurrences','new_top_writes','initial_complex_rounds',
 'pruned_traversal_additions','all_initialization_and_traversal_additions','final_dyadic_complex_rounds']
def fold(cohort):
 rawhist={int(k):v for k,v in cohort['hist'].items()}
 ck(all(type(L)==int and 0<=L<=260 and type(h)==int and h>0 for L,h in rawhist.items()))
 hist={L:h for L,h in rawhist.items() if L>0}
 B=sum(hist.values());visits=sum(L*h for L,h in hist.items());U=cohort['unit_outputs']
 ck(B==cohort['nonempty_bucket_heights'])
 ck(visits==cohort['all_numerator_visits'])
 ck(visits-B==cohort['advance_steps'])
 ck(visits-U==cohort['skipped_nonunits'])
 ck(0<=U<=visits)
 sums=lambda field:sum(hist[L]*recipe[L][field] for L in hist)
 G=sums('G');binary=sums('binary');A=sums('A')
 totals=dict(buckets=B,empty_bucket_height_records=rawhist.get(0,0),all_numerators=visits,nonunit_visits=visits-U,unit_outputs=U,
 old_unit_horner_stages=19*U,coefficient_prescales=19*B,newton_general_products=G,
 newton_recurrence_additions=G,newton_binary_scale_additions=binary,
 newton_initialization_additions=G+binary,newton_small_scales=sums('small'),
 newton_shifted_operand_occurrences=sums('shifts'),new_top_writes=sums('m')-B,
 initial_complex_rounds=sums('m'),pruned_traversal_additions=A,
 all_initialization_and_traversal_additions=G+binary+A,final_dyadic_complex_rounds=U)
 tail=[sum(h for L,h in hist.items() if L>=j+1) for j in range(20)]
 advance=[sum(h*max(0,L-1-j) for L,h in hist.items()) for j in range(19)]
 ck(sum((19-j)*tail[j] for j in range(19))==G)
 ck(sum((20-j)*tail[j] for j in range(1,20))==totals['newton_small_scales'])
 ck(sum((20-j)*(j.bit_count()-1)*tail[j] for j in range(1,20))==binary)
 ck(sum((20-j)*j.bit_count()*tail[j] for j in range(1,20))==totals['newton_shifted_operand_occurrences'])
 ck(sum(tail)==totals['initial_complex_rounds'])
 ck(sum(advance)==A)
 parity=cohort['conductor_parity'];ck(parity in ('odd','even'))
 cap=132900 if parity=='odd' else 265800
 ell=[((2*cap)**i).bit_length() for i in range(20)]
 lengths=[]
 for L,h in sorted(hist.items()):
  r=recipe[L];m=r['m'];p=r['p']
  lengths.append(dict(L=L,bucket_height_count=h,m=m,p=p,
    initial_complex_rounds=h*m,pruned_additions=h*r['A'],
    rounded_live_signed=p+m+17,
    rounded_raw_add_signed=None if L==1 else p+m+18,
    maximum_initial_comparison_signed=p+ell[19]+m+19))
 pmax=max((r['p'] for r in lengths),default=None)
 widths=dict(cohort_conductor_cap=cap,power_bits_by_degree=ell,
  final_unit_precision_distribution='NOT PRESENT in source histogram',
  final_unit_p_upper=pmax,final_dyadic_scratch_signed_upper=None if pmax is None else pmax+20,
  exact_input_normalization='unreduced v=2c; no state or target cancellation credited',
  output_numerator_signed_upper=118)
 return dict(conductor_parity=parity,active_conductors=cohort['active_conductors'],
  conductor_heights=cohort['conductor_heights'],totals=totals,
  retained_order_bucket_counts=tail,advance_additions_by_order=advance,
  length_precision_profile=lengths,width_envelope=widths)
def sum_totals(records):return {k:sum(r['totals'][k] for r in records) for k in KEYS}
cases=[]
ck([s['extra_nodes'] for s in src['scenarios']]==[0,167,320,640])
for s in src['scenarios']:
 bands=[]
 ck([b['band'] for b in s['bands']]==[1,2,3,4,5])
 for b in s['bands']:
  cs=[fold(c) for c in b['cohorts']]
  ck(sorted(c['conductor_parity'] for c in cs)==['even','odd'])
  bands.append(dict(band=b['band'],D_output=b['D_output'],fine_denominator=b['fine_denominator'],
   source_D=b['source_D'],first_height_index=b['first_height_index'],last_height_index=b['last_height_index'],
   totals=sum_totals(cs),cohorts=cs))
 totals=sum_totals(bands)
 ck(totals['unit_outputs']==s['unit_residue_height_inputs'])
 ck(totals['old_unit_horner_stages']==s['old_Horner_stages'])
 cases.append(dict(extra_nodes=s['extra_nodes'],totals=totals,bands=bands))
ck(cases[0]['totals']['unit_outputs']==59962061953248)
result=dict(status='EXACT_FROZEN_HISTOGRAM_FOLD_CANDIDATE_NOT_ADOPTED',checks=checks,
 pins=PINS,complex_operation_units=True,
 shared_source_conversion='20 complex conversions per distinct source object/cache lifetime; not inferred from bucket histogram',
 setup='geometry powers, source bindings, factor cache, precision proofs, traffic and proof transport separately charged',
 scenarios=cases)
out=HERE/'all_cell_rounded_histogram_ledger_20261111.json'
out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(dict(checks=checks,bytes=out.stat().st_size,sha256=hashlib.sha256(out.read_bytes()).hexdigest().upper(),
 totals=[dict(extra_nodes=s['extra_nodes'],**s['totals']) for s in cases])))
