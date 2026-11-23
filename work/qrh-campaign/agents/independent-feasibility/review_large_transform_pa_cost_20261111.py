"""Independent saved-data and integer/Fraction checks. No author code import."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
AG=HERE.parent
checks=0
pins={}
def check(condition):
    global checks
    assert condition
    checks+=1
def read(rel):
    p=AG/rel
    pins[str(p.relative_to(ROOT))]=hashlib.sha256(p.read_bytes()).hexdigest().upper()
    return json.loads(p.read_text(encoding='utf-8'))
author=read('integration/large_transform_pa_templates_20261111.json')
for rel,h in {
    'integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md':'DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C',
    'integration/large_transform_pa_templates_20261111.py':'B9D4D1333FC83ECC70D6C82CB96159B4E0A98EB29C4453AF66B632C6295D6589',
    'integration/large_transform_pa_templates_20261111.json':'B13699002FCB232B67FD9F973C8E2497D8984A14179C7D7ABCA6D306890CFFB5',
}.items():
    path=AG/rel
    check(hashlib.sha256(path.read_bytes()).hexdigest().upper()==h)
    pins[str(path.relative_to(ROOT))]=h
for path,h in author['pins'].items():
    check(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()==h)
    pins[path]=h
ledger=read('major-constants/reconciled_nonprincipal_schedule_20261111.json')
hp=read('prime-estimates/short_horner_prefix_composition_20261111.json')
precision=read('zero-sum/mixed_radix_precision_metadata_20261111.json')
width=read('independent-feasibility/mixed_radix_width_metadata_20261111.json')

def bits(x):
    x=F(x)
    k=max(0,x.numerator.bit_length()-x.denominator.bit_length())
    while F(2)**k<=x:k+=1
    while k and F(2)**(k-1)>x:k-=1
    check(x<F(2)**k and (k==0 or F(2)**(k-1)<=x))
    return k
def byte(w):return (w+7)//8
def product(a,b):
    x,y=byte(a),byte(b)
    return 5*x*y+2*min(x,y)+1
def addition(w):return 2*byte(w)+1

# Derive Horner cores directly from saved magnitude envelopes and raw witnesses.
hcores={}
stage_count=0
for family,profiles in hp['results'].items():
    hcores[family]={}
    for name,cases in profiles.items():
        hcores[family][name]={}
        for case in cases:
            add_total=0
            for st in case['stages']:
                stage_count+=1
                input_cap=F(st['input_norm_cap'])*2**st['input_grid']
                output_cap=F(st['output_norm_cap'])*2**st['output_grid']
                nearest_cap=F(st['rounded_product_norm_cap'])*2**st['output_grid']
                # Raw residual and its doubled lower-range witness precede validation.
                raw=132900*input_cap*2**st['alignment_bits']+531600*nearest_cap
                add_total+=2*sum(addition(w) for w in
                    [bits(raw),bits(2*raw+531600),22,bits(output_cap)])
            hcores[family][name][case['K']]=(case['product_template_events'],add_total)
            check(author['horner_prefix_addition_events'][family][name][str(case['K'])]==add_total)

maxima=(precision['max_new_sum_C'],precision['max_old_D'],precision['max_old_sum_C'],width['max_mixed_conductor_peak']['bits'])
check(maxima==(202305920,29961461170177,424706204,54))
S,D,Sold,q=maxima
check(8192+633+2<2**14)
results=[]
for row in author['candidate_allocations']:
    s=row['L_arithmetic_budget_bits']
    requirement=max(D,2*Sold,1266*S*2**(14+s))
    p=0
    while 2**p<requirement:p+=1
    check(row['p']==p)
    check(F(1266*S*2**14,2**p)<=F(1,2**s))
    check(F(1,2**p)<=F(1,D) and 2*Sold<=2**p)
    a=p+68
    check(row['input_stored_signed_bits']==a+1)
    check(row['semantic_three_raw_signed_cap']==2*p+73)
    cores={}
    for kind,b in [('root',p+1),('kernel',p+18)]:
        cores[kind]={}
        for option,three in [('three',True),('four',False)]:
            r=a+b+1+int(three)
            prod=product(a+1,b)+2*product(a,b+1) if three else 4*product(a,b)
            center=2*addition(r)+(addition(a+1) if three else 0)
            rounding=4*addition(r+2)
            t=row['types'][kind][option]
            expected=dict(input_magnitude_bits=a,coefficient_magnitude_bits=b,
                data_presum_signed_bits=a+2 if three else None,
                coefficient_presum_signed_bits=b+2 if three else None,
                generic_raw_signed_bits=r+1,dyadic_witness_add_signed_bits=r+3,
                product_events=prod,exact_add_events=center,round_add_events=rounding,
                core_events=prod+center+rounding,real_products=3 if three else 4,
                signed_additions=7 if three else 6,scalar_dyadic_rounds=2)
            for key,value in expected.items():check(t[key]==value)
            cores[kind][option]=prod+center+rounding
    ca=2*addition(a+1);cd=4*addition(a+2)
    check(row['complex_add_core']==ca and row['complex_dyadic_scale_core']==cd)
    for got,source,hs in zip(row['scenarios'],ledger['scenarios'],hp['scenarios']):
        ops=source['large']['transform_operations']
        G=ops['general_complex_products'];A=ops['complex_add_sub'];T=ops['dyadic_scales']
        check(got['extra_nodes']==source['extra_nodes']==hs['extra_nodes'])
        check((got['G'],got['A'],got['dyadic_scales'])==(G,A,T))
        check(got['kernel_product_count']==T and got['root_product_count']==G-T)
        check(0<=T<=G)
        for option in ['three','four']:
            actual=(G-T)*cores['root'][option]+T*cores['kernel'][option]+A*ca+T*cd
            check(got['padded_typed_transform_core'][option]==actual)
            for kind in ['root','kernel']:
                check(got['padded_transform_core_envelopes'][kind][option]==G*cores[kind][option]+A*ca+T*cd)
        for name in ['uniform100','root_linear','fixed_15442']:
            prod=adds=0
            for band in hs['bands']:
                family='first_four' if band['band']<5 else 'final'
                pc,ac=hcores[family][name][band['K']]
                prod+=band['unit_residue_height_inputs']*pc
                adds+=band['unit_residue_height_inputs']*ac
            check(got['horner_unsigned_product_events'][name]==prod)
            check(got['horner_natural_addition_events'][name]==adds)
            check(got['horner_product_addition_core'][name]==prod+adds)
            check(F(got['horner_product_events_per_G'][name])==F(prod,G))
        check(F(got['product_gates_per_unit'])==F(G,source['large']['residue_inputs']))
    results.append(dict(epsilon_bits=s,p=p,cores=cores,main=row['scenarios'][0]['padded_typed_transform_core']))

setup=ledger['setup']['large_transform_unchanged']
check(author['setup']==setup)
count=sum(setup[k] for k in ['kernel_entries','chirp_entries','CT_full_root_table_entry_upper'])+2**18+26
check(count==author['cache_entry_upper']==1594383871)
check(author['cache_sum_count_upper']==2*count)

# Universal dyadic witness implication is algebraic: 2R=2t-2^d.
# Boundary examples here use integers only, not transform inputs or coefficients.
for d in range(1,19):
    v=2**d
    for n in [-3*v,-v-v//2,-v//2,-1,0,1,v//2,3*v]:
        quotient=(n+v//2)//v
        residue=n+v//2-quotient*v
        check(0<=residue<v)
        check(2*(n-quotient*v)==2*residue-v)
        check(-v<=2*(n-quotient*v)<v)

out=dict(scope='Independent saved-data arithmetic only. No source script import or numerical transform.',checks=checks,
    pins=pins,horner_stages=stage_count,precision_and_cores=results,
    limitations=['Candidate precision, not a selected sign budget.','Uniform padded schedule, not a lower bound or runtime.','Per-stage width multiplicities and full ordinary proof wrappers remain open.'])
dest=HERE/'review_large_transform_pa_cost_20261111.json'
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'horner_stages':stage_count,'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
