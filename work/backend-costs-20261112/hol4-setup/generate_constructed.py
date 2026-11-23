"""Same fixtures and rejection checks, avoiding HOL's large quoted-term parser."""
from pathlib import Path
import copy
import hashlib
import json

home = Path(__file__).resolve().parent
fixtures = home.parents[1] / 'lean-pilots/batched-transform'
header = (home / 'benchmark.sml').read_text().split('val fixture_P100N64')[0]
header = header.replace('StageFixtureResults', 'StageConstructedResults')
helpers = (home / 'profile.sml').read_text().split('fun int_term text =', 1)[1]
helpers = 'fun int_term text =' + helpers.split('val input_data =', 1)[0]

def literal(rows, field):
    return '[' + ',\n'.join('[' + ','.join(json.dumps(str(v).replace('-', '~'))
        for v in row[field]) + ']' for row in rows) + ']'

def term(case, ins, outs):
    precision = int(case[1:].split('N')[0])
    return ('list_mk_comb (``stage_check``, [int_term "' + str(2**precision) +
            '",int_term "' + str(1024*2**precision) + '",rows_term ' +
            literal(ins, 'input') + ',rows_term ' + literal(outs, 'output') + '])')

lines = [header, helpers]
pins = {}
data = {}
for case in ['P100N64', 'P343N64', 'P415N64', 'P343N256']:
    source = fixtures / (case + '.json')
    rows = json.loads(source.read_text())['rows']
    assert len(set(tuple(row['input']) for row in rows)) == len(rows)
    data[case] = rows
    pins[case] = hashlib.sha256(source.read_bytes()).hexdigest()
    lines.append(f'val fixture_{case} = timed "construct_{case}" '
                 f'(fn () => {term(case, rows, rows)});')
    for rep in range(3):
        lines.append(f'val checked_{case}_{rep} = timed "{case}_r{rep}" '
                     f'(fn () => check_true fixture_{case});')
    lines.append(f'val certified_{case} = MATCH_MP stage_check_sound '
                 f'(EQT_ELIM checked_{case}_0);')
    lines.append(f'val _ = audit "{case}" certified_{case};')
    lines.append(f'val _ = save_thm ("certified_{case}",certified_{case});')

rows = data['P343N64']
rounding = copy.deepcopy(rows)
rounding[0]['output'][0] += 1
rounding[0]['output'][2] -= 1
coefficient = copy.deepcopy(rows)
coefficient[0]['input'][4] = 0
for label, ins, outs in [
    ('rounding', rows, rounding), ('missing', rows, rows[1:]),
    ('reordered', rows, [rows[1], rows[0]] + rows[2:]),
    ('coefficient', coefficient, rows)]:
    lines.append(f'val _ = timed "control_{label}" (fn () => '
                 f'check_false "{label}" ({term("P343N64", ins, outs)}));')
lines.append('val _ = timed "theory_export" export_theory;')
lines.append('val _ = print "HOL4_CONSTRUCTED_BENCHMARK_DONE\\n";')
(home / 'constructed.sml').write_text('\n'.join(lines) + '\n', newline='\n')
(home / 'constructed_pins.json').write_text(json.dumps(pins, indent=2) + '\n')
print('Generated four constructed fixtures and four exact rejection controls.')
