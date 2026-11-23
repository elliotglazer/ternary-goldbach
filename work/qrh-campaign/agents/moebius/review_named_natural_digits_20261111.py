"""Independent symbolic header/layout check. No digit tables or proof instances."""
from pathlib import Path
import hashlib, json
HERE=Path(__file__).resolve().parent; ROOT=HERE.parents[3]
BASE=ROOT/'work/qrh-campaign/agents/prime-estimates'
checks=0
def eq(a,b):
    global checks
    assert type(a) is type(b) and a==b,(a,b)
    checks+=1
def read(p,pin):
    assert p.stat().st_size<131072
    raw=p.read_bytes();eq(hashlib.sha256(raw).hexdigest().upper(),pin)
    return json.loads(raw)
note=BASE/'NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md'
eq(hashlib.sha256(note.read_bytes()).hexdigest().upper(),'99A9F90BB5C7D4EBB8C63A24CD7BFA8CDB5D13DCA54790EAADA658E3A24BF988')
script=BASE/'named_natural_digit_format_20261111.py'
eq(hashlib.sha256(script.read_bytes()).hexdigest().upper(),'86867B6612B4C6A22A317FCF140273E1F9F0BD1CFA92B8EEADA85BD5015F6417')
r=read(script.with_suffix('.json'),'AB5DEE833A8181D03F2F51798DCC78FB16ADFD746FCF0F9D95F019B49645F051')
old=read(BASE/'general_radix_saved_horner_20261111.json','87948E77ECF813E05B53893F22397D984E64B664E3EC2DC84212A268B212CFF0')
for p,h in r['pins'].items():eq(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper(),h)

prod=('eq',('mul','a','b'),('add',('mul','B','h'),'l'))
adder=('eq',('add',('add','a','b'),'c'),('add',('mul','B','u'),'v'))
def nodes(t):return 1 if isinstance(t,str) else 1+sum(nodes(x) for x in t[1:])
eq(nodes(prod),9);eq(nodes(adder),11)
eq(1+4+3*5,20);eq(1+5+3*4+2,20)
for row in r['table_metadata']:
    w=row['w'];b=2**w;F=3*b*b;defs=b-1
    # Sum lengths by bit-length cohorts, without digit enumeration.
    body=sum(k*2**(k-1) for k in range(2,w+1))+(w+1)
    eq(body,(w-1)*b+w+1)
    feasible=256+b-2<65536
    lower=(4*2+3+2*2+1)*b*b+2*b*(3*b-2) + 2*((5*2+3+2*2+2+1)*b*b+2*b*(3*b-2))
    upper=lower+4*b*b
    eq(lower,74*b*b-12*b);eq(upper,78*b*b-12*b)
    expect=dict(beta=b,arithmetic_facts=F,new_digit_defs=b-2,new_radix_defs=1,
      all_new_defs=defs,canonical_body_nodes=body,definition_body_commands=body+defs,
      definition_header_commands=body+defs,definition_entry_and_return_binder_bytes=16*defs,
      two_byte_oldterm_definition_bytes_without_alignment_names=16*defs+4*body+4*defs,
      three_byte_alias_ID_q_interval=[256,65535-(b-2)] if feasible else None,
      complete_named_header_commands=((nodes(prod)+1)+2*(nodes(adder)+1))*b*b,
      three_byte_model_header_bytes_lower=lower if feasible else None,
      three_byte_model_header_bytes_upper=upper if feasible else None,
      three_byte_model_entry_plus_headers_lower=lower+8*F if feasible else None,
      three_byte_model_entry_plus_headers_upper=upper+8*F if feasible else None,
      generic_max_five_byte_named_header_bytes_upper=((4*2+5*5+1)+2*(5*2+4*5+2*2+1))*b*b,
      all_term_IDs_five_byte_header_plus_entries_upper=((5*nodes(prod)+1)+2*(5*nodes(adder)+1))*b*b+8*F,
      all_term_IDs_five_byte_with_7byte_header_alignment_upper=((5*nodes(prod)+1)+2*(5*nodes(adder)+1))*b*b+15*F,
      all_term_IDs_five_byte_definition_bytes_without_alignment_names=16*defs+10*body+4*defs,
      fits_u32_theorem_count=F<=2**32-1,all_digit_plus_radix_heads=b+1,
      all_heads_conditional_16byte_store_bytes=16*(b+1),all_heads_heap_reference_bytes=4*(b+1),
      max_product_table_conversion_commands_without_target_build=20,
      max_fulladder_table_conversion_commands_without_target_build=20,
      max_product_conversion_definition_unify_commands=4*(w+1)+(w+2),
      max_fulladder_conversion_definition_unify_commands=3*(w+1)+(w+2))
    for k,v in expect.items():eq(row[k],v)
    eq(5*(w+1)+1+2<256,True) # longest definition proof and two-byte statement prefix
    if feasible:
        eq(row['three_byte_alias_ID_q_interval'][1]+b-2,65535)
        eq(row['three_byte_alias_ID_q_interval'][1]+1+b-2,65536)

count=0
for case in r['same_saved_cases']:
    prior=old['cases'][case['kind']][case['profile']]['rows']
    for new,prev in zip(case['rows'],prior):
        count+=1;c=prev['cells'];n=prev['rows'];p=prev['real_products']
        macro=94*c+10*n+26*p+88*(n-p)+64*p
        eq(new['w'],prev['w']);eq(new['template_events_unchanged'],prev['template_events'])
        eq(new['generic_macro_headers'],macro)
        eq(new['all_uncached_arithmetic_table_macro_headers'],macro+c*(10+3*12))
        eq(new['prior_expanded_header_upper'],prev['all_uncached_arithmetic_table_and_macro_header_commands_upper'])
eq(count,24)
out={'status':'PASS static symbolic metadata only','checks':checks,'saved_case_rows':count,
 'pins_checked':len(r['pins']),'author_sha256':hashlib.sha256(note.read_bytes()).hexdigest().upper(),
 'qualification_104':'Only named heads use up to five bytes; old heads remain two bytes. The all-head bound is separately checked.',
 'limits':'No digit enumeration, emitted definitions/proofs, writer execution, arithmetic values or builds.'}
with (HERE/'review_named_natural_digits_20261111.json').open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(out))
