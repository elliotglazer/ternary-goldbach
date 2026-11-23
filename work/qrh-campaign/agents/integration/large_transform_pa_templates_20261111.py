"""Saved-ledger arithmetic templates only; no transform/geometry/value generation."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib,json

HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3];AG=ROOT/'work/qrh-campaign/agents'
checks=0;pins={}
def ck(p):
 global checks
 assert p
 checks+=1
def pin(rel, expected=None):
 path=ROOT/rel; h=hashlib.sha256(path.read_bytes()).hexdigest().upper()
 if expected: ck(h==expected)
 pins[rel]=h
 return path
def read(rel,h=None):return json.loads(pin(rel,h).read_text(encoding='utf-8'))
prefix='work/qrh-campaign/agents/'
for rel,h in {
 'zero-sum/FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md':'087A3DF1B2DD49C5C0BB38E00DA9CD9830E41807C6F07A8BBB34502CFF65355D',
 'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
 'independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md':'5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A',
 'major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md':'483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716',
 'integration/REVIEW_SHORT_OUTPUT_HORNER_PREFIX_COMPOSITION_2026-11-11.md':'1F536DA236937B61AAF4E44B995956A06E090CFC91A00B40D9CF5896CC96CB03',
 'prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
 'zero-sum/TRANSFORM_SAVED_MULTIPLICITY_EVIDENCE_MAP_2026-11-11.md':'90A9730692DE696AD7F92A1AA5CAAE7FFAF378ED0822E78AD8F01517B325111F',
}.items():pin(prefix+rel,h)
for rel in ['independent-feasibility/REVIEW_FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md',
 'audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md',
 'major-constants/REVIEW_MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md',
 'integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md',
 'audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md',
 'moebius/REVIEW_B100_PRODUCT_ONLY_HORNER_2026-11-11.md',
 'moebius/SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md',
 'independent-feasibility/REVIEW_SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md']:
 pin(prefix+rel)
pin(prefix+'zero-sum/conditional_r132900_pruning_inventory_20261111.py','074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D')
precision=read(prefix+'zero-sum/mixed_radix_precision_metadata_20261111.json','8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E')
width=read(prefix+'independent-feasibility/mixed_radix_width_metadata_20261111.json','364B00C1BA63A06CC5B1C3E0CC777280151BB05E0E5B56063231596B0249B48F')
ledger=read(prefix+'major-constants/reconciled_nonprincipal_schedule_20261111.json','0E83C9AB65725FBD34F0D34FC462E9EC805A040717DA92B1AB262CC7A9345397')
horner=read(prefix+'prime-estimates/short_horner_prefix_composition_20261111.json','99671C5858B20FF3940186D33CCFB19E730C9D364FF3B3EB5B2E6B8641F399FE')
pin(prefix+'zero-sum/transform_saved_evidence_map_20261111.json','4E74C6C9AEA54A42B44EBFB36034AC7AD8663D3A5B0A34F83B410B24EC0E22B4')
S=precision['max_new_sum_C'];D=precision['max_old_D'];Sold=precision['max_old_sum_C']
q=width['max_mixed_conductor_peak']['bits'];b0=14
ck((S,D,Sold,q)==(202305920,29961461170177,424706204,54))
ck(8192+633+1+1<2**b0)
setup=ledger['setup']['large_transform_unchanged']
ck(setup['max_padded_length']==2**18)
Fmax=setup['kernel_entries']+setup['chirp_entries']+setup['CT_full_root_table_entry_upper']+2**18+sum((3,5,7,11))
def ceil_log2(n):return (n-1).bit_length()
def digits(bits):return (bits+7)//8
def mul(a,b):
 m,n=sorted((digits(a),digits(b)),reverse=True)
 return 5*m*n+2*n+1
def add(w):return 2*digits(w)+1
def strictbits(x):
 w=0
 while Q(2)**w<=x:w+=1
 ck(Q(2)**(w-1)<=x<Q(2)**w)
 return w
Hadds={}
for cl,profiles in horner['results'].items():
 Hadds[cl]={}
 for name,cases in profiles.items():
  Hadds[cl][name]={}
  for case in cases:
   fee=0
   for st in case['stages']:
    M=Q(st['input_norm_cap'])*2**st['input_grid']
    L=Q(st['rounded_product_norm_cap'])*2**st['output_grid']
    raw=132900*M*2**st['alignment_bits']+531600*L
    out=Q(st['output_norm_cap'])*2**st['output_grid']
    fee+=2*(add(strictbits(raw))+add(strictbits(2*raw+531600))+add(22)+add(strictbits(out)))
   Hadds[cl][name][case['K']]=fee
  ck(Hadds[cl][name][20]=={'first_four':{'uniform100':3204,'root_linear':2964,'fixed_15442':2860},'final':{'uniform100':3068,'root_linear':2824,'fixed_15442':2716}}[cl][name])
def template(a,b,p,three):
 # Magnitude capacities. Signed wrappers cost separately.
 raw=a+b+(2 if three else 1)
 round_w=raw+2
 prods=mul(a+1,b)+2*mul(a,b+1) if three else 4*mul(a,b)
 exact_adds=(add(a+1) if three else 0)+2*add(raw)
 rounds=4*add(round_w) # Two signed additions per scalar dyadic witness.
 return dict(input_magnitude_bits=a,coefficient_magnitude_bits=b,
  data_presum_signed_bits=a+2 if three else None,
  coefficient_presum_signed_bits=b+2 if three else None,
  generic_raw_signed_bits=raw+1,dyadic_witness_add_signed_bits=round_w+1,
  product_events=prods,exact_add_events=exact_adds,round_add_events=rounds,
  core_events=prods+exact_adds+rounds,
  real_products=3 if three else 4,signed_additions=7 if three else 6,
  scalar_dyadic_rounds=2,
  quote='Template core only; signed wrappers/ranges/shifts/numerals/bindings/cache/proof bytes separate.')
rows=[]
for s in (60,82,100):
 need=max(D,2*Sold,1266*S*2**(b0+s))
 p=ceil_log2(need)
 ck(2**p>=need and (p==0 or 2**(p-1)<need))
 ck(Q(1266*S*2**b0,2**p)<=Q(1,2**s))
 a=p+b0+q
 # Root norm<2. Kernel norm<2n<=Pmax=2^18, under strict eK<1.
 types={kind:{'three':template(a,b,p,True),'four':template(a,b,p,False)}
        for kind,b in [('root',p+1),('kernel',p+18)]}
 for tp in types.values():
  ck(tp['three']['core_events']<tp['four']['core_events'])
 complex_add_core=2*add(a+1)
 complex_scale_core=4*add(a+2)
 scenarios=[]
 for item,hi in zip(ledger['scenarios'],horner['scenarios']):
  l=item['large'];ops=l['transform_operations'];G=ops['general_complex_products'];A=ops['complex_add_sub'];T=ops['dyadic_scales'];U=l['residue_inputs']
  ck(item['extra_nodes']==hi['extra_nodes'])
  ck(U==sum(b['unit_residue_height_inputs'] for b in hi['bands']))
  Hprod={};Hadd={}
  for name in ('uniform100','root_linear','fixed_15442'):
   Hprod[name]=sum(b['unit_residue_height_inputs']*next(r['product_template_events'] for r in horner['results']['first_four' if b['band']<5 else 'final'][name] if r['K']==b['K']) for b in hi['bands'])
   Hadd[name]=sum(b['unit_residue_height_inputs']*Hadds['first_four' if b['band']<5 else 'final'][name][b['K']] for b in hi['bands'])
  totals={kind:{option:G*t['core_events']+A*complex_add_core+T*complex_scale_core for option,t in ts.items()} for kind,ts in types.items()}
  ck(0<=T<=G)
  actual={option:(G-T)*types['root'][option]['core_events']+T*types['kernel'][option]['core_events']+A*complex_add_core+T*complex_scale_core for option in ('three','four')}
  scenarios.append(dict(extra_nodes=item['extra_nodes'],G=G,A=A,dyadic_scales=T,unit_inputs=U,
   product_gates_per_unit=str(Q(G,U)),horner_unsigned_product_events=Hprod,
   horner_natural_addition_events=Hadd,horner_product_addition_core={k:Hprod[k]+Hadd[k] for k in Hprod},
   padded_transform_core_envelopes=totals,
   root_product_count=G-T,kernel_product_count=T,padded_typed_transform_core=actual,
   horner_product_events_per_G={k:str(Q(v,G)) for k,v in Hprod.items()},
   root_core_over_fixed_horner_product_core=str(Q(totals['root']['three'],Hprod['fixed_15442'])),
   root_core_over_fixed_horner_product_add_core=str(Q(totals['root']['three'],Hprod['fixed_15442']+Hadd['fixed_15442'])),
   quarter_turns=ops['quarter_turns'],negations=ops['negations']))
 rows.append(dict(L_arithmetic_budget_bits=s,p=p,input_stored_signed_bits=a+1,
  semantic_three_raw_signed_cap=2*p+b0+q+5,types=types,
  complex_add_core=complex_add_core,complex_dyadic_scale_core=complex_scale_core,
  scenarios=scenarios))
# Formal distributive identities; monomials name independent symbols, not values.
def plus(x,y,sign=1):
 z=x.copy()
 for m,c in y.items():z[m]=z.get(m,0)+sign*c
 return {m:c for m,c in z.items() if c}
def times(x,y):
 z={}
 for a,ca in x.items():
  for b,cb in y.items():
   m=tuple(sorted(a+b));z[m]=z.get(m,0)+ca*cb
 return {m:c for m,c in z.items() if c}
A,B,C,E=({(s,):1} for s in 'ABCD')
t=times(C,plus(A,B));u=times(B,plus(C,E));v=times(A,plus(E,C,-1))
ck(plus(t,u,-1)==plus(times(A,C),times(B,E),-1))
ck(plus(t,v)==plus(times(A,E),times(B,C)))
# Witness N+H=Q*D+t with D=2H yields 2(N-QD)=2t-D.
ck(plus({('t',):2},{('H',):2},-1)=={('t',):2,('H',):-2})
out=dict(scope='Conditional common-grid arithmetic and saved-count model; no evaluated coefficients, roots or circuits.',
 checks=checks,pins=pins,global_bounds=dict(S=S,baseline_safety=D,baseline_S=Sold,q=q,b0=b0),
 cache_entry_upper=Fmax,cache_sum_count_upper=2*Fmax,setup=setup,horner_prefix_addition_events=Hadds,
 candidate_allocations=rows,root_kernel_split_known=True,stage_width_distribution_known=False,
 final_sign_budget_selected=False,proof_templates_implemented=False)
dest=HERE/'large_transform_pa_templates_20261111.json'
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'p':[r['p'] for r in rows],
 'p82':rows[1]['types'],'cache_entry_upper':Fmax,
 'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()},indent=2))
