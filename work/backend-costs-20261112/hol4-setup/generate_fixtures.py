from pathlib import Path
import copy
import hashlib
import json

home = Path(__file__).resolve().parent
fixtures = home.parents[1] / 'lean-pilots/batched-transform'
cases = ['P100N64', 'P343N64', 'P415N64', 'P343N256']

def integer(value):
    return str(value) if value >= 0 else '(~' + str(-value) + ')'

def tuples(rows, field):
    return '[' + ';'.join('(' + ','.join(map(integer, row[field])) + ')'
                          for row in rows) + ']'

def term(case, inputs, outputs):
    precision = int(case[1:].split('N')[0])
    scale = 2**precision
    return f'stage_check ({scale}:int) ({1024*scale}:int) ' + \
        tuples(inputs, 'input') + ' ' + tuples(outputs, 'output')

lines = ['''open HolKernel Parse boolLib bossLib StageCheckTheory cv_transLib;
fun require condition message = if condition then () else raise Fail message;
val _ = new_theory "StageFixtureResults";
val context_axioms = List.concat (map (fn theory =>
  map (fn (name,_) => theory ^ "." ^ name) (DB.axioms theory))
  ("StageCheck" :: Theory.ancestry "StageCheck"));
(* These are HOL4's four upstream bool-theory axioms. This audit does not
   claim that they are Lean's three axioms or an already translated result. *)
val allowed_axioms = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX",
                      "bool.BOOL_CASES_AX"];
val _ = print ("HOL4_CONTEXT_AXIOMS," ^
  String.concatWith ";" context_axioms ^ "\\n");
val _ = require (List.all (fn name => List.exists (fn a => a = name)
  allowed_axioms) context_axioms) "unexpected context axiom";
fun timed label work =
  let val cpu = Timer.startCPUTimer ()
      val wall = Time.now ()
      val result = work ()
      val {usr,sys} = Timer.checkCPUTimer cpu
      val elapsed = Time.- (Time.now (),wall)
  in print ("HOL4_TIME," ^ label ^ "," ^
            Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal (Time.+ (usr,sys))) ^ "," ^
            Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal elapsed) ^ "\\n"); result end;
fun audit label th =
  let val (oracles,axioms) = Tag.dest_tag (tag th)
  in require (null (hyp th)) "theorem has hypotheses";
     require (List.all (fn x => x = "DISK_THM") oracles)
             "unexpected oracle dependency";
     print ("HOL4_TAG," ^ label ^ ",oracles=" ^
            String.concatWith ";" oracles ^ ",axioms=" ^
            String.concatWith ";" axioms ^ "\\n") end;
fun check_true tm =
  let val result = cv_eval tm
  in require (aconv (rand (concl result)) boolSyntax.T) "fixture rejected"; result end;
fun check_false label tm =
  let val result = cv_eval tm
  in require (aconv (rand (concl result)) boolSyntax.F) "corruption accepted";
     audit label result; ignore (save_thm ("rejected_" ^ label,result));
     print ("HOL4_REJECTED_" ^ label ^ "\\n") end;
''']
pins = {}
all_rows = {}
for case in cases:
    path = fixtures / (case + '.json')
    rows = json.loads(path.read_text())['rows']
    assert len({tuple(row['input']) for row in rows}) == len(rows)
    all_rows[case] = rows
    pins[case] = {'source': str(path), 'rows': len(rows),
                  'sha256': hashlib.sha256(path.read_bytes()).hexdigest()}
    lines.append(f'val fixture_{case} = timed "parse_{case}" (fn () =>\n'
                 f'  ``{term(case, rows, rows)}``);')
    for repetition in range(3):
        lines.append(f'val accepted_{case}_{repetition} = '
                     f'timed "{case}_r{repetition}" '
                     f'(fn () => check_true fixture_{case});')
    lines.append(f'val certified_{case} = MATCH_MP stage_check_sound '
                 f'(EQT_ELIM accepted_{case}_0);')
    lines.append(f'val _ = audit "{case}" certified_{case};')
    lines.append(f'val _ = save_thm ("certified_{case}",certified_{case});')

rows = all_rows['P343N64']
rounding = copy.deepcopy(rows)
rounding[0]['output'][0] += 1
rounding[0]['output'][2] -= 1
coefficient = copy.deepcopy(rows)
coefficient[0]['input'][4] = 0
controls = [('rounding', rows, rounding), ('missing', rows, rows[1:]),
            ('reordered', rows, [rows[1], rows[0]] + rows[2:]),
            ('coefficient', coefficient, rows)]
for label, inputs, outputs in controls:
    lines.append(f'val _ = check_false "{label}"\n'
                 f'  ``{term("P343N64", inputs, outputs)}``;')
lines.append('val _ = timed "theory_export" export_theory;')
lines.append('val _ = print "HOL4_MATCHED_BENCHMARK_DONE\\n";')
(home / 'benchmark.sml').write_text('\n'.join(lines) + '\n', newline='\n')
(home / 'fixture_pins.json').write_text(json.dumps(pins, indent=2) + '\n')
print('Generated four matched cases and four corruption controls.')
