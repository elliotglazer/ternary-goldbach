"""Dependent arithmetic blocks. The Python result is a claim checked by HOL4.

This is not an FFT: the coefficients are exact dyadic integers and do not have
a certified root interpretation. The checksum is an exact output statistic,
not a cryptographic commitment or a substitute for vector equality.
"""
from pathlib import Path
import hashlib
import json

home = Path(__file__).resolve().parent
source = home.parents[1] / 'lean-pilots/batched-transform/P343N64.json'
rows = json.loads(source.read_text())['rows']
scale = 2**343
coeffs = [row['input'][4:6] for row in rows]
inputs = [xy for row in rows for xy in
          (row['input'][0:2], row['input'][2:4])]
depths = [1, 8, 32, 128]


def run(depth, xs=inputs, ws=coeffs):
    xs = [list(xy) for xy in xs]
    peak = max(abs(a).bit_length() for xy in xs for a in xy)
    for _ in range(depth):
        ys = []
        for j, (wr, wi) in enumerate(ws):
            ur, ui = xs[2*j]
            vr, vi = xs[2*j+1]
            t, u, v = wr*(vr+vi), vi*(wr+wi), vr*(wi-wr)
            qr, qi = (2*(t-u)+scale)//(2*scale), (2*(t+v)+scale)//(2*scale)
            ys.extend(((ur+qr, ui+qi), (ur-qr, ui-qi)))
        xs = ys[1:] + ys[:1]
        peak = max(peak, max(abs(a).bit_length() for xy in xs for a in xy))
    checksum = 0
    for r, i in reversed(xs):
        checksum = r+3*i+9*checksum
    maximum = max(abs(a) for xy in xs for a in xy)
    return {'depth': depth, 'butterflies': depth*len(ws),
            'checksum': str(checksum), 'bound': str(1 << maximum.bit_length()),
            'maximum_coordinate_bits': peak, 'output': xs}


cases = [run(n) for n in depths]
base = cases[1]
changed = [xy[:] for xy in inputs]
changed[0][0] += 1
changed_ws = [xy[:] for xy in coeffs]
changed_ws[1][0] += scale//8
assert run(8, changed)['checksum'] != base['checksum']
assert run(8, ws=changed_ws)['checksum'] != base['checksum']
assert run(7)['checksum'] != base['checksum']
pins = {'fixture_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
        'scale': str(scale), 'inputs': inputs, 'coefficients': coeffs,
        'cases': cases, 'controls': ['checksum', 'bound', 'depth', 'input', 'coefficient'],
        'contract': 'Exact integer local-residual network, length, final bound and checksum. '
                    'No roots, real interpretation, global error bound or zero count.'}
(home / 'dependent_fixture.json').write_text(json.dumps(pins, indent=2)+'\n')

header = (home / 'benchmark.sml').read_text().split('val fixture_P100N64')[0]
header = header.replace('StageCheckTheory', 'StageCheckTheory DependentBlockTheory')
header = header.replace('StageFixtureResults', 'DependentBlockResults')
header = header.replace('("StageCheck" :: Theory.ancestry "StageCheck")',
                        '("DependentBlock" :: Theory.ancestry "DependentBlock")')
header = header.replace('fun check_true tm =', '''val preconditions = ref ([]:thm list);
fun normalize_result tm raw =
  let val result = SIMP_RULE bool_ss (!preconditions) raw
      val _ = if is_eq (concl result) orelse aconv (concl result) tm orelse
                 aconv (concl result) (mk_neg tm) then ()
              else print ("HOL4_UNCLOSED_RESULT," ^ thm_to_string result ^ "\\n")
  in if aconv (concl result) tm then EQT_INTRO result
     else if aconv (concl result) (mk_neg tm) then EQF_INTRO result
     else result end;
fun check_true tm =''')
header = header.replace('val result = cv_eval tm',
                        'val result = normalize_result tm (cv_eval tm)')
header = header.replace('in require (aconv (rand (concl result))',
                        'in require (aconv (lhs (concl result)) tm) "wrong checked input";\n'
                        '     require (aconv (rand (concl result))')
helpers = (home / 'profile.sml').read_text().split('fun int_term text =', 1)[1]
helpers = 'fun int_term text =' + helpers.split('val input_data =', 1)[0]


def sint(n):
    return json.dumps(str(n).replace('-', '~'))


def rows_sml(xs):
    return '[' + ',\n'.join('['+','.join(sint(a) for a in xy)+']' for xy in xs)+']'


lines = [header, helpers, r'''
fun named name tm =
  let val def = new_definition (name ^ "_def",mk_eq (mk_var (name,type_of tm),tm))
      val _ = timed ("translate_" ^ name) (fn () => cv_trans def)
  in lhs (concl def) end;
''']
lines += [f'val scale = named "block_scale" (int_term {sint(scale)});',
          '''val _ = load "intLib";
val positive_scale_raw =
  ((REWRITE_CONV [DB.fetch "DependentBlockResults" "block_scale_def"] THENC intLib.REDUCE_CONV)
    (list_mk_comb (``$< : int -> int -> bool``,[int_term "0",scale])));
val _ = print ("HOL4_POSITIVE_SCALE_RAW," ^ thm_to_string positive_scale_raw ^ "\\n");
val positive_scale = EQT_ELIM positive_scale_raw;
val _ = preconditions := [positive_scale,
  GEN_ALL (MATCH_MP block_accept_pre_ok positive_scale)];''',
          f'val inputs = timed "construct_inputs" (fn () => rows_term {rows_sml(inputs)});',
          'val xs = named "block_inputs" inputs;',
          f'val coefficients = timed "construct_coefficients" (fn () => rows_term {rows_sml(coeffs)});',
          'val ws = named "block_coefficients" coefficients;',
          '''fun acceptance n input coeff bound expected = list_mk_comb
  (``block_accept``,[scale,coeff,numSyntax.term_of_int n,input,int_term bound,int_term expected]);''']
for case in cases:
    d = case['depth']
    lines.append(f'val fixture_{d} = acceptance {d} xs ws {sint(case["bound"])} {sint(case["checksum"])};')
    for rep in range(3):
        lines.append(f'val checked_{d}_{rep} = timed "depth{d}_r{rep}" '
                     f'(fn () => check_true fixture_{d});')
    lines.append(f'val certified_{d} = timed "derive_depth{d}" (fn () => '
                 f'MATCH_MP block_accept_sound (EQT_ELIM checked_{d}_0));')
    lines.append(f'val _ = audit "depth{d}" certified_{d};')
    lines.append(f'val _ = save_thm ("certified_depth{d}",certified_{d});')
    lines.append(f'val _ = print ("HOL4_BLOCK_CONCLUSION,depth{d}," ^ '
                 f'Int.toString (size (term_to_string (concl certified_{d}))) ^ "\\n");')

lines += [f'val changed_xs = named "block_changed_inputs" (rows_term {rows_sml(changed)});',
          f'val changed_ws = named "block_changed_coefficients" (rows_term {rows_sml(changed_ws)});']
for label, d, x, w, b, c in [
    ('checksum',8,'xs','ws',base['bound'],str(int(base['checksum'])+1)),
    ('bound',8,'xs','ws','0',base['checksum']),
    ('depth',7,'xs','ws',base['bound'],base['checksum']),
    ('input',8,'changed_xs','ws',base['bound'],base['checksum']),
    ('coefficient',8,'xs','changed_ws',base['bound'],base['checksum'])]:
    lines.append(f'val _ = timed "control_{label}" (fn () => check_false "{label}" '
                 f'(acceptance {d} {x} {w} {sint(b)} {sint(c)}));')
lines += ['val _ = timed "theory_export" export_theory;',
          'val _ = print "HOL4_DEPENDENT_BLOCK_BENCHMARK_DONE\\n";']
(home / 'dependent.sml').write_text('\n'.join(lines)+'\n', newline='\n')
print('Generated dependent layers, independently computed claims and five rejecting controls.')
