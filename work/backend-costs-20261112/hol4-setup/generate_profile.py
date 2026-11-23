"""Profile the public cv_eval stages, with direct exact term construction."""
from pathlib import Path
import hashlib
import json

home = Path(__file__).resolve().parent
source = home.parents[1] / 'lean-pilots/batched-transform/P343N64.json'
rows = json.loads(source.read_text())['rows']
header = (home / 'benchmark.sml').read_text().split('val fixture_P100N64')[0]
header = header.replace('StageFixtureResults', 'StageProfileResults')

def sml_strings(values):
    return '[' + ','.join(json.dumps(str(x).replace('-', '~')) for x in values) + ']'

def rows_literal(field):
    return '[' + ',\n'.join(sml_strings(row[field]) for row in rows) + ']'

body = r'''
fun int_term text =
  let val n = Arbint.fromString text
      val tm = intSyntax.term_of_int n
  in require (Arbint.toString (intSyntax.int_of_term tm) = Arbint.toString n)
       "integer construction failed round trip"; tm end;
fun row_term data = pairSyntax.list_mk_pair (map int_term data);
fun rows_term data =
  let val rows = map row_term data
  in listSyntax.mk_list (rows,type_of (hd rows)) end;
'''
body += 'val input_data = ' + rows_literal('input') + ';\n'
body += 'val output_data = ' + rows_literal('output') + ';\n'
body += f'''val fixture = timed "construct_P343N64" (fn () =>
  list_mk_comb (``stage_check``,
    [int_term "{2**343}",int_term "{1024*2**343}",
     rows_term input_data,rows_term output_data]));
'''
body += r'''
val represented = timed "input_representation" (cv_repLib.cv_rep_for [] o K fixture);
val cv_term = cv_miscLib.cv_rep_cv_tm (concl represented);
val conversion_theorem = timed "from_to_theorem"
  (fn () => cv_typeLib.from_to_thm_for (type_of fixture));
val equations = timed "code_equations" (fn () => cv_eqs_for cv_term);
val conversion = timed "prepare_kernel_conversion"
  (fn () => cv_computeLib.cv_compute equations);
val raw0 = timed "raw_kernel_r0" (fn () => conversion cv_term);
val raw1 = timed "raw_kernel_r1" (fn () => conversion cv_term);
val raw2 = timed "raw_kernel_r2" (fn () => conversion cv_term);
val result_context = timed "proof_context" (fn () =>
  UNDISCH_ALL (MATCH_MP (MATCH_MP cv_repTheory.cv_rep_eval represented)
                         conversion_theorem));
fun execute () =
  let val result = CONV_RULE (RAND_CONV (RAND_CONV conversion)) result_context
      val decoded = CONV_RULE (RAND_CONV EVAL) result
      val closed = SIMP_RULE bool_ss [] (DISCH_ALL decoded)
  in require (aconv (concl closed) fixture) "unexpected residual precondition";
     EQT_INTRO closed end;
val checked0 = timed "prepared_eval_r0" execute;
val checked1 = timed "prepared_eval_r1" execute;
val checked2 = timed "prepared_eval_r2" execute;
val _ = require (aconv (lhs (concl checked0)) fixture) "wrong input in result";
val _ = require (aconv (rhs (concl checked0)) boolSyntax.T) "fixture rejected";
val certified = MATCH_MP stage_check_sound (EQT_ELIM checked0);
val _ = audit "prepared_P343N64" certified;
val _ = save_thm ("certified_P343N64",certified);
val ordinary = timed "ordinary_eval" (fn () => check_true fixture);
val _ = require (aconv (concl ordinary) (concl checked0)) "different conclusion";
val _ = timed "theory_export" export_theory;
val _ = print "HOL4_PROFILE_DONE\n";
'''
(home / 'profile.sml').write_text(header + body, newline='\n')
(home / 'profile_source.json').write_text(json.dumps({
    'fixture_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
    'implementation': 'Public APIs reproducing cv_transLib.cv_eval_pat simple_raw path; '
                      'generic DISCH/SIMP closes the precondition and Bool decoding.'}, indent=2) + '\n')
print('Generated P343N64 construction and evaluator-phase profile.')
