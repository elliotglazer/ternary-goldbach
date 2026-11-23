"""Independent bounded saved-metadata audit; no arithmetic instances or writer imports."""
from pathlib import Path
from fractions import Fraction
from collections import Counter
import hashlib, json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
BASE = ROOT / 'work/qrh-campaign/agents'
checks = 0
def eq(x, y):
    global checks
    assert type(x) is type(y) and x == y, (x, y)
    checks += 1
def load(path, pin):
    assert path.stat().st_size < 524288
    raw = path.read_bytes()
    eq(hashlib.sha256(raw).hexdigest().upper(), pin)
    return json.loads(raw)

author = BASE/'prime-estimates/GENERAL_RADIX_PA_COST_FRONTIER_2026-11-11.md'
eq(hashlib.sha256(author.read_bytes()).hexdigest().upper(), '0C69D1774C2D0AE2A2A0DA849F30962D66304A13C07C66AEA50BA942E2BB5827')
script = BASE/'prime-estimates/general_radix_saved_horner_20261111.py'
eq(hashlib.sha256(script.read_bytes()).hexdigest().upper(), 'A1F5415BD92F7F3906FDF4CE7DDC441556A10A15CF60BEE6AAC51292FB818E49')
r = load(script.with_suffix('.json'), '87948E77ECF813E05B53893F22397D984E64B664E3EC2DC84212A268B212CFF0')
a = load(HERE/'fixed_horner_degree_envelope_costs_20261111.json', '4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9')
b = load(BASE/'prime-estimates/large_residue_bucket_occupancy_20261111.json', '19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB')
for path, pin in r['pins'].items():
    eq(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper(), pin)

for t in r['table_metadata']:
    w = t['w']; beta = 2**w; facts = 3*beta**2
    # Group numeral lengths, without enumerating any digits.
    digit_nodes = 2 + sum(k * 2**(k-1) for k in range(2,w+1))
    eq(digit_nodes, (w-1)*beta+2)
    low = beta**2*(w+8)+2*beta*digit_nodes + 2*beta**2*(w+10)+4*beta*digit_nodes
    high = beta**2*((5*w+6)+2*(4*w+9))
    expected = dict(beta=beta, closed_facts=facts, theorem_entry_bytes=8*facts,
        digit_binary_nodes_sum=digit_nodes, unshared_table_header_command_lower=low,
        unshared_table_header_command_upper=high,
        two_byte_term_ID_headers_only_bytes_lower=2*low-facts,
        two_byte_term_ID_max_single_header_bytes=2*(5*w+6)-1,
        disjoint_header_start_offsets_impossible=2*low-facts > 2**32-1+2*(5*w+6)-1,
        two_byte_term_ID_table_plus_header_bytes_lower=8*facts+2*low-facts,
        two_byte_term_ID_table_plus_header_bytes_upper=8*facts+2*high-facts,
        fits_u32_theorem_count=facts<=2**32-1,
        chosen_unshared_two_byte_layout_lower_fits_p32=2*low+7*facts<2**32,
        full_cell_header=84+11*w+10, row_header=88+4*w, terminal_header=64+2*w)
    for k,v in expected.items(): eq(t[k],v)

keys = ['real_products','cells','rows','template_events','core_body_commands_excluding_D_C',
        'macro_header_commands_excluding_tables','all_uncached_arithmetic_table_and_macro_header_commands_upper']
fresh = {}; repricings=0
for kind, profiles in a['results'].items():
    for name, case in profiles.items():
        histogram=Counter(); fresh[kind,name]={}
        for stage in case['stages']:
            histogram[stage['input_magnitude_bits'],18]+=2
            histogram[stage['rounded_product_magnitude_bits'],20]+=2
        eq(r['cases'][kind][name]['bit_capacity_histogram'], [dict(x=x,y=y,multiplicity=n) for (x,y),n in sorted(histogram.items())])
        for saved in r['cases'][kind][name]['rows']:
            w=saved['w']; sums=dict.fromkeys(keys,0)
            for stage in case['stages']:
                for x,y in [(stage['input_magnitude_bits'],18),(stage['rounded_product_magnitude_bits'],20)]:
                    repricings+=1
                    m,n=sorted(((x+w-1)//w,(y+w-1)//w),reverse=True)
                    # Count actual core nodes/edges and row macro headers separately.
                    V=m*n+2*n+1; H=9*m*n+7*n-2; R=16*m*n+15*n+1
                    headers=m*n*(94+11*w)+n*10+26+(n-1)*(88+4*w)+(64+2*w)
                    vals=[1,m*n,n,4*m*n+m*n+n+(n-1)+1+1,H+R+2,
                          headers,headers+m*n*((5*w+6)+3*(4*w+9))]
                    eq(V, m*n+2*n+1)
                    for k,v in zip(keys,vals): sums[k]+=2*v
            for k,v in sums.items(): eq(saved[k],v)
            fresh[kind,name][w]=sums
        eq(fresh[kind,name][8]['template_events'],case['product_template_events'])
eq(repricings,912)

for saved in r['weighted_saved_inventory']:
    sc=next(s for s in b['scenarios'] if s['extra_nodes']==saved['extra_nodes'])
    U=[sum(c['unit_outputs'] for c in band['cohorts']) for band in sc['bands']]
    eq(U,saved['saved_band_unit_totals'])
    eq(sum(U),sc['unit_residue_height_inputs']); eq(19*sum(U),sc['old_Horner_stages'])
    name=saved['profile']; baseline=None
    for row in saved['rows']:
        w=row['w']
        vals={k:sum(U[i]*fresh['final' if i==4 else 'first_four',name][w][k] for i in range(5)) for k in keys}
        for k,v in vals.items(): eq(row[k],v)
        if w==8: baseline=vals['template_events']
        else:
            delta=baseline-vals['template_events']
            eq(row['template_event_difference_from8'],delta)
            eq(row['toy_max_equal_setup_event_price_per_extra_fact_one_import'],str(Fraction(delta,3*(2**(2*w)-2**16))))
eq(3*2**16*(2**16+1)//2 > 2**32-1,True)
out={'status':'PASS bounded exact metadata only','checks':checks,'capacity_pair_repricings':repricings,
     'source_pins_checked':len(r['pins']),'author_sha256':hashlib.sha256(author.read_bytes()).hexdigest().upper(),
     'limits':'No table/digit/conductor enumeration, writer import, arithmetic instance, proof generation or build.'}
with (HERE/'review_general_radix_frontier_20261111.json').open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2); f.write('\n')
print(json.dumps(out))
