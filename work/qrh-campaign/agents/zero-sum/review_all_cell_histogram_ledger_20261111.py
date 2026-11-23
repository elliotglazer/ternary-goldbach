"""Independent fold of saved histograms; no conductor or unit enumeration."""
from pathlib import Path
import hashlib, json
BASE=Path(__file__).resolve().parents[1]
AP='integration/ALL_CELL_ROUNDED_DIFFERENCE_CANDIDATE_LEDGER_2026-11-11.md'
SP='integration/all_cell_rounded_histogram_ledger_20261111.py'
JP='integration/all_cell_rounded_histogram_ledger_20261111.json'
PINS={AP:'3560E8441035DEE44E983B6995F473BF51B0B54E40FD79196956D294696AD839',
      SP:'66C0784585FF8311E31880F5475529C7EC1FA99BC4D5E6CAFDF49C11589EE1BF',
      JP:'ED3000A823FE5E0C522D557B68A9E7BDCC2AC22F2890DBCD23AB6C5E0B8FD717'}
checks=0
def ck(x):
    global checks
    assert x
    checks+=1
for p,h in PINS.items():ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
out=json.loads((BASE/JP).read_text())
for p,h in out['pins'].items():ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
src=json.loads((BASE/'prime-estimates/large_residue_bucket_occupancy_20261111.json').read_text())
notes=(BASE/AP).read_text()
cohorts=0
profile_rows=0
def precision(L):
    # Iterative binomial construction instead of the producer's comb sum.
    n=L-1;term=1;S=1
    for k in range(1,min(19,n)+1):
        ck(term*(n-k+1)%k==0)
        term=term*(n-k+1)//k;S+=term
    return 102+S.bit_length()
def fold(c,produced):
    global cohorts,profile_rows
    cohorts+=1
    h={int(k):v for k,v in c['hist'].items()}
    ck(all(0<=L<=260 and type(v)==int and v>0 for L,v in h.items()))
    positive={L:v for L,v in h.items() if L}
    B=sum(positive.values());visits=sum(L*v for L,v in positive.items());U=c['unit_outputs']
    ck(B==c['nonempty_bucket_heights'])
    ck(visits==c['all_numerator_visits'])
    ck(visits-B==c['advance_steps'])
    ck(visits-U==c['skipped_nonunits'])
    tail=[sum(v for L,v in positive.items() if L>j) for j in range(20)]
    advances=[sum(v*sum(1 for n in range(L-1) if j<=min(18,L-2-n))
                  for L,v in positive.items()) for j in range(19)]
    G=small=binary=shifts=0
    for i in range(1,20):
        for j in range(i):G+=tail[j]
        for j in range(1,i+1):
            small+=tail[j]
            bits=[k for k in range(5) if (j>>k)&1]
            binary+=(len(bits)-1)*tail[j]
            shifts+=len(bits)*tail[j]
    rounds=sum(tail);A=sum(advances)
    totals=dict(buckets=B,empty_bucket_height_records=h.get(0,0),all_numerators=visits,
        nonunit_visits=visits-U,unit_outputs=U,old_unit_horner_stages=19*U,
        coefficient_prescales=19*B,newton_general_products=G,newton_recurrence_additions=G,
        newton_binary_scale_additions=binary,newton_initialization_additions=G+binary,
        newton_small_scales=small,newton_shifted_operand_occurrences=shifts,
        new_top_writes=rounds-B,initial_complex_rounds=rounds,
        pruned_traversal_additions=A,all_initialization_and_traversal_additions=G+binary+A,
        final_dyadic_complex_rounds=U)
    ck(produced['totals']==totals)
    ck(produced['retained_order_bucket_counts']==tail)
    ck(produced['advance_additions_by_order']==advances)
    parity=c['conductor_parity'];cap=132900 if parity=='odd' else 265800
    ell=[((2*cap)**i).bit_length() for i in range(20)]
    rows=[]
    for L,v in sorted(positive.items()):
        m=min(20,L);p=precision(L)
        adds=L*(L-1)//2 if L<=20 else 19*L-190
        rows.append(dict(L=L,bucket_height_count=v,m=m,p=p,initial_complex_rounds=v*m,
            pruned_additions=v*adds,rounded_live_signed=p+m+17,
            rounded_raw_add_signed=None if L==1 else p+m+18,
            maximum_initial_comparison_signed=p+ell[19]+m+19))
        profile_rows+=1
    ck(rows==produced['length_precision_profile'])
    pm=max((r['p'] for r in rows),default=None)
    widths=dict(cohort_conductor_cap=cap,power_bits_by_degree=ell,
        final_unit_precision_distribution='NOT PRESENT in source histogram',
        final_unit_p_upper=pm,final_dyadic_scratch_signed_upper=None if pm is None else pm+20,
        exact_input_normalization='unreduced v=2c; no state or target cancellation credited',
        output_numerator_signed_upper=118)
    ck(widths==produced['width_envelope'])
    for key in ('conductor_parity','active_conductors','conductor_heights'):ck(produced[key]==c[key])
    return totals
def total(rows):return {k:sum(r[k] for r in rows) for k in rows[0]}
summaries=[];bandtable=[];totaltable=[]
ck([s['extra_nodes'] for s in src['scenarios']]==[0,167,320,640])
ck(len(out['scenarios'])==4)
for old,new in zip(src['scenarios'],out['scenarios']):
    e=old['extra_nodes'];ck(new['extra_nodes']==e)
    bt=[]
    ck(len(old['bands'])==len(new['bands'])==5)
    for b,nb in zip(old['bands'],new['bands']):
        for k in ('band','D_output','fine_denominator','source_D','first_height_index','last_height_index'):
            ck(b[k]==nb[k])
        ck([c['conductor_parity'] for c in b['cohorts']]==['odd','even'])
        ck(len(nb['cohorts'])==2)
        t=total([fold(c,nc) for c,nc in zip(b['cohorts'],nb['cohorts'])])
        ck(t==nb['totals']);bt.append(t)
        ps=[r['p'] for c in nb['cohorts'] for r in c['length_precision_profile']]
        bandtable.append([e,b['band'],t['buckets'],t['newton_general_products'],
            t['initial_complex_rounds'],t['pruned_traversal_additions'],t['unit_outputs'],max(ps)])
    t=total(bt);ck(t==new['totals'])
    ck(t['unit_outputs']==old['unit_residue_height_inputs'])
    ck(t['old_unit_horner_stages']==old['old_Horner_stages'])
    summaries.append(dict(extra_nodes=e,totals=t))
    totaltable.append([e]+[t[k] for k in ('coefficient_prescales','newton_general_products',
        'newton_initialization_additions','newton_shifted_operand_occurrences',
        'pruned_traversal_additions','initial_complex_rounds','final_dyadic_complex_rounds')])
def table(section,next_section):
    text=notes.split(section,1)[1].split(next_section,1)[0]
    return [[int(x) for x in line.split('|')[1:-1]] for line in text.splitlines()
            if line.startswith('|') and line.split('|')[1] in ('0','167','320','640')]
ck(table('## 2.','## 3.')==bandtable)
ck(table('## 3.','## 4.')==totaltable)
ck(out['complex_operation_units'] is True)
result={'scope':'saved weighted histograms only; no conductor/unit enumeration',
        'checks':checks,'pins':PINS,'dependency_pins':out['pins'],
        'cohorts':cohorts,'length_profile_rows':profile_rows,'scenarios':summaries}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8',newline='\n') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'cohorts':cohorts,'profile_rows':profile_rows,
                 'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
