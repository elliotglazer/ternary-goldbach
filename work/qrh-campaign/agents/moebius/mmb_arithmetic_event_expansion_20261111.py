"""Static source/shape metadata only. Emits no proof or arithmetic evaluation."""
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
OUT = Path(__file__).with_suffix('.json')
PINS = {
    'work/mm0-efficient/toolchain-sources/examples__peano.mm0': '463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052',
    'work/mm0-efficient/toolchain-sources/examples__peano.mm1': '13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079',
    'work/mm0-efficient/toolchain-sources/examples__peano_hex.mm0': 'E2F5E461C568E0E3EF784B507E9111272B38956093DF98B943CCC4CD806E351B',
    'work/mm0-efficient/toolchain-sources/examples__peano_hex.mm1': '76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94',
    'work/formal-goldbach-bench/mm0/src/mmb.md': 'E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0',
    'work/formal-goldbach-bench/mm0/src/verifier.c': '71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5',
    'work/formal-goldbach-bench/mm0/src/verifier_types.c': '87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E',
    'work/formal-goldbach-bench/mm0/src/types.c': 'B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1',
    'work/qrh-campaign/agents/integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md': '3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227',
    'work/qrh-campaign/agents/moebius/SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md': '531DD23307CED3ED958198C750393D933287809B9E42EF738888370AA4DE4474',
    'work/qrh-campaign/agents/moebius/signed_horner_schedule_costs_20261111.json': '0DF6FF38D7F14A9C3596423BE109E5EEC6CAF18E031F4329B907E43F5A60FF37',
    'work/qrh-campaign/agents/moebius/fixed_horner_degree_envelope_costs_20261111.json': '4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9',
    'work/qrh-campaign/agents/independent-feasibility/REVIEW_SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md': '40AE12EEFE142B932820F6462E6DE7CE127679A0CE220010148C698E984BBFF1',
}
checks = 0
def check(condition):
    global checks
    assert condition
    checks += 1

texts = {}
for path, digest in PINS.items():
    raw = (ROOT / path).read_bytes()
    check(hashlib.sha256(raw).hexdigest().upper() == digest)
    texts[path] = raw.decode('utf-8')

hex_source = texts['work/mm0-efficient/toolchain-sources/examples__peano_hex.mm1']
check('theorem add_xx0 (h1: $ a + c = e $) (h2: $ b + d = f $)' in hex_source)
check('theorem mul_x2x (h1: $ a * b = d $) (h2: $ a * c = e :x f $) (h3: $ d + e = g $)' in hex_source)
check('(add_xx0 ,a (,b) ,c (,d) ,e ,f ,p1 (,p2))' in hex_source)
check('(mul_x2x ,a ,b ,c ,d ,e ,f ,g ,p1 ,p2 ,p3)' in hex_source)
check('@eval-check axiom h2n0' in hex_source)

cv = texts['work/formal-goldbach-bench/mm0/src/verifier.c']
for snippet in ['sizeof(store_term) + 4 * t->num_args',
                'g_uheap_size = t->num_args;',
                'g_heap_size = 0;',
                'g_store_size = 0;',
                'run_unify(UThm, (u8*)&targs[t->num_args], e);']:
    check(snippet in cv)

# Formal syntactic trees only, with all coercions made explicit.
# These are source-level header stencils, not compiled MMB or concrete values.
def node(name, *children):
    return (name, children)
def shape(t):
    if isinstance(t, str):
        return (0, 1, 0)  # constructor, variable leaf, constructor child edges
    cs = [shape(x) for x in t[1]]
    return (1 + sum(x[0] for x in cs), sum(x[1] for x in cs),
            len(t[1]) + sum(x[2] for x in cs))
def eq(a, b): return node('eq', a, b)
def add(a, b): return node('add', a, b)
def mul(a, b): return node('mul', a, b)
def hx(a, b): return node('hex', a, b)
def hn(a): return node('h2n', a)

stencils = {
    'add_xx0': (6, [eq(add(hx('a','b'),hx('c','d')),hx('e','f')),
                       eq(add('a','c'),'e'), eq(add(hn('b'),hn('d')),hn('f'))]),
    'mul_x2x': (7, [eq(mul('a',hx('b','c')),hx('g','f')),
                       eq(mul('a','b'),'d'), eq(mul('a',hn('c')),hx('e','f')),
                       eq(add('d','e'),'g')]),
}
headers = {}
for name, (a, trees) in stencils.items():
    h = len(trees)-1
    shapes = [shape(t) for t in trees]
    constructors = sum(x[0] for x in shapes)
    leaves = sum(x[1] for x in shapes)
    header = constructors + leaves + h + 1  # includes END
    fresh = h + a + 3 + 2 + 1
    cached = h + a + 1 + 1
    check(fresh == h+(a+1)+4+1)
    check(cached == a+h+2)
    headers[name] = dict(expression_args=a, hypotheses=h,
                         formal_expression_shapes=shapes,
                         unshared_unify_constructors=constructors,
                         unshared_unify_variable_refs=leaves,
                         unshared_unify_commands_including_end=header,
                         call_commands_fresh_binary_equality=fresh,
                         call_commands_cached_conclusion=cached)
    references = h+a+3
    check(references+2+1 == fresh)
    headers[name]['fresh_call_shortest_encoding_upper_bytes'] = 3*references+5*3
check(headers['add_xx0']['unshared_unify_commands_including_end'] == 27)
check(headers['mul_x2x']['unshared_unify_commands_including_end'] == 31)
check(headers['add_xx0']['call_commands_fresh_binary_equality'] == 14)
check(headers['mul_x2x']['call_commands_fresh_binary_equality'] == 16)
check(headers['add_xx0']['fresh_call_shortest_encoding_upper_bytes'] == 48)
check(headers['mul_x2x']['fresh_call_shortest_encoding_upper_bytes'] == 54)

# Symbolic counting algebra for local proof DAGs, not instantiated arithmetic.
dag_checks = []
for V, H, R, T, C in [(1,2,7,2,4), (1,3,8,2,4), (7,10,31,19,37),
                       (20,25,94,41,72), (1,0,1,0,0)]:
    check(H >= V-1 and R+C >= T)
    proof_refs = H-(V-1)
    expression_refs = R+C-T
    total = V + proof_refs + T + expression_refs + 1
    check(total == H+R+C+2)
    dag_checks.append(dict(V=V,H=H,R=R,T=T,C=C,body_commands_with_end=total))

def command_bytes(data):
    assert 0 <= data < 2**32
    return 1 if data == 0 else 2 if data < 2**8 else 3 if data < 2**16 else 5
byte_samples = {str(x): command_bytes(x) for x in [0,1,255,256,65535,65536,2**32-1]}
check(list(byte_samples.values()) == [1,2,2,3,3,5,5])
def M(m,n): return 5*m*n+2*n+1
def A(n): return 2*n+1
rectangle = dict(columns=13, rows=3, digit_products=39, full_adders=117,
                 fused_lifts=39, row_steps=6, base=1, template_events=M(13,3))
check(sum(rectangle[k] for k in ['digit_products','full_adders','fused_lifts','row_steps','base']) == 202)

s = json.loads(texts['work/qrh-campaign/agents/moebius/signed_horner_schedule_costs_20261111.json'])
row = next(r for r in s['results']['first_four']['uniform100']['uncancelled']['rows'] if r['stage']==0)
w = json.loads(texts['work/qrh-campaign/agents/moebius/fixed_horner_degree_envelope_costs_20261111.json'])
wr = next(r for r in w['results']['first_four']['uniform100']['stages'] if r['stage']==0)
check(wr['input_magnitude_bits'] == 104)
check(wr['rounded_product_magnitude_bits'] == 102)
check(row['alignment_bits'] == 0)
check(row['product_events'] == 4*M(13,3))
check(row['magnitude_bit_caps'] == dict(residual_add=122,range_add=123,guard_add=22,coefficient_add=113))
add_events = {k:A((b+7)//8) for k,b in row['magnitude_bit_caps'].items()}
check(add_events == dict(residual_add=33,range_add=33,guard_add=7,coefficient_add=31))
check(sum(add_events.values()) == 104)
check(2*M(13,3)+sum(add_events.values()) == 508)
rounding = dict(source='first_four/uniform100/uncancelled/stage0',
                input_magnitude_bits=104,rounded_magnitude_bits=102,
                small_factor_bits=18, divisor_bits=20,
                product_instances=2, unsigned_add_instances=4,
                product_template_events=404, addition_events=add_events,
                signed_add_bridges=3,signed_product_bridges=2,nearest_implications=1,
                real_template_total=508,complex_template_total=1016,
                range_slack_prerejection_bits=row['range_slack_operand_bits'])
check(rounding['range_slack_prerejection_bits'] == 21)

result = dict(status='PASS_STATIC_SOURCE_AND_COUNTING_METADATA', checks=checks,
              scope='No compiled MMB, proof generator, proof execution, arithmetic values or timing. Header stencils are explicit unshared source models.',
              pins=PINS,source_lemma_models=headers,dag_counting_checks=dag_checks,
              command_byte_lengths=byte_samples,rectangle=rectangle,rounding=rounding,
              missing_byte_template_arities='Not assigned: PA-only fused cell, row/base, adder and signed bridges require actual proved statements.')
OUT.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(dict(status=result['status'],checks=checks,output=str(OUT))))
