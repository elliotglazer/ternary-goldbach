"""Bind the Candle dependent-network experiment to the HOL/native/Lean fixture."""
from pathlib import Path
import copy
import hashlib
import json

home = Path(__file__).resolve().parent
source = home.parent / 'hol4-setup/dependent_fixture.json'
data = json.loads(source.read_text())
presentation = (home/'compact_export.ml').read_text().split('bench_mark "compact_conclusion_start"')[0]
(home/'dependent_numeral_presentation.ml').write_text(presentation, encoding='utf-8')


def rows(values):
    return '[' + ';\n'.join(f'("{r}","{i}")' for r, i in values) + ']'


text = r'''(* Exact source integers become ordinary closed definitions. *)
let dnum s = mk_comb (`numc`,mk_numeral (num_of_string s));;
let dpair a b = list_mk_comb (`pairc`,[a;b]);;
let dz s = if String.get s 0 = '-' then
    dpair (dnum "0") (dnum (String.sub s 1 (String.length s-1)))
  else dpair (dnum s) (dnum "0");;
let rec dlist xs = match xs with [] -> dnum "0"
  | x::xt -> dpair x (dlist xt);;
let rec dbalanced xs = match xs with [] -> dnum "0" | [x] -> dpair x (dnum "0")
  | _ -> let a,b = chop_list (length xs / 2) xs in
      list_mk_comb (`Dappend`,[dbalanced a;dbalanced b]);;
let dcoordinates rs = dbalanced (map (fun (r,i) -> dpair (dz r) (dz i)) rs);;
let rec dclock n = if n = 0 then dnum "0" else dpair (dnum "0") (dclock(n-1));;
let ddef name tm =
  let expanded = REWRITE_CONV [dappend_rec] tm in
  let compact = ONCE_DEPTH_CONV export_numeral_conv tm in
  let definition = new_definition (mk_eq (mk_var(name,`:cval`),rand(concl compact))) in
  definition,TRANS definition (TRANS (SYM compact) expanded);;
let dconst name = mk_const(name,[]);;
bench_mark "dependent_inputs_start";;
'''
text += 'let dependent_inputs_def,dependent_inputs_eval = ddef "DInput" (dcoordinates ' + rows(data['inputs']) + ');;\n'
text += 'let dependent_coefficients_def,dependent_coefficients_eval = ddef "DCoeff" (dcoordinates ' + rows(data['coefficients']) + ');;\n'
text += r'''
let dependent_input_well = prove (`Dwell DInput`,
  REWRITE_TAC [dependent_inputs_eval;dwell;dcomplex;cexp_fst_def;cexp_snd_def;zvalid_pair]);;
let dependent_coefficients_well = prove (`Dwell DCoeff`,
  REWRITE_TAC [dependent_coefficients_eval;dwell;dcomplex;cexp_fst_def;cexp_snd_def;zvalid_pair]);;
let dependent_defs = dependent_inputs_eval::dependent_coefficients_eval::ddefs;;
bench_mark "dependent_inputs_end";;
let dpayload out label tm =
  let rec loop index tm =
    if tm = dnum "0" then () else
    let z = rand (rator tm) in
    let r = rand (rator z) and i = rand z in
    let valtext v = string_of_num (dest_numeral (rand v)) in
    let _ = output_string out (label ^ "," ^ string_of_int index ^ "," ^
      valtext (rand (rator r)) ^ "," ^ valtext (rand r) ^ "," ^
      valtext (rand (rator i)) ^ "," ^ valtext (rand i) ^ "\n") in
    loop (index+1) (rand tm)
  in loop 0 tm;;
let dout = open_out "../dependent_coordinates.csv";;
dpayload dout "inputs" (rand (concl dependent_inputs_eval));;
dpayload dout "coefficients" (rand (concl dependent_coefficients_eval));;
'''
text += f'let dependent_scale_nat = mk_numeral (num_of_string "{data["scale"]}");;\n'
text += 'let dependent_scale = mk_comb (`numc`,dependent_scale_nat);;\n'
text += r'''
let dmath clock bound expected accepted =
  let rule = INST [dependent_scale_nat,`n:num`;`DCoeff`,`ws:cval`;
    clock,`clock:cval`;`DInput`,`xs:cval`;bound,`b:cval`;expected,`expected:cval`]
    daccept_sound in
  MATCH_MP rule (end_itlist CONJ [dependent_coefficients_well;dependent_input_well;
    prove (mk_comb (`Zvalid`,bound),REWRITE_TAC [zvalid_pair]);
    prove (mk_comb (`Zvalid`,expected),REWRITE_TAC [zvalid_pair]);accepted]);;
let dresults : (string * thm) list ref = ref [];;
let dcase_run label depth bound expected =
  let clock = dclock depth in
  let tm = list_mk_comb (`Daccept`,
    [dependent_scale;`DCoeff`;clock;`DInput`;bound;expected]) in
  let rec sample k = if k = 3 then () else
    let prefix = "dependent_" ^ label ^ "_sample" ^ string_of_int k in
    let _ = bench_mark (prefix ^ "_start") in
    let accepted = compute dependent_defs tm in
    let _ = if rand(concl accepted) = `numc 1` then () else failwith "dependent rejected" in
    let mathematical = dmath clock bound expected accepted in
    let _ = if hyp mathematical = [] then () else failwith "dependent theorem has hypotheses" in
    let _ = bench_mark (prefix ^ "_end") in
    let _ = if k = 0 then dresults := (label,mathematical)::(!dresults) else () in
    let _ = print_string ("DEPENDENT_ACCEPTED," ^ label ^ "," ^ string_of_int k ^ "\n") in
    sample (k+1)
  in let _ = sample 0 in
  let full = compute dependent_defs (list_mk_comb (`Drun`,
      [clock;`DInput`;`DCoeff`;dependent_scale])) in
  dpayload dout label (rand(concl full));;
'''
for case in data['cases']:
    text += f'dcase_run "{case["butterflies"]}" {case["depth"]} (dz "{case["bound"]}") (dz "{case["checksum"]}");;\n'

changed_inputs = copy.deepcopy(data['inputs'])
changed_inputs[0][0] += 1
changed_coeffs = copy.deepcopy(data['coefficients'])
changed_coeffs[0][0] += 1
text += 'let dependent_changed_input = dcoordinates ' + rows(changed_inputs) + ';;\n'
text += 'let dependent_changed_coefficient = dcoordinates ' + rows(changed_coeffs) + ';;\n'
case = data['cases'][0]
text += f'let dcontrol_bound = dz "{case["bound"]}";;\n'
text += f'let dcontrol_expected = dz "{case["checksum"]}";;\n'
text += r'''
let dcontrol label xs ws clock bound expected =
  let tm = list_mk_comb (`Daccept`,[dependent_scale;ws;clock;xs;bound;expected]) in
  let th = compute dependent_defs tm in
  if rand(concl th) = `numc 0` && hyp th = [] then
    print_string ("DEPENDENT_REJECTED," ^ label ^ "\n")
  else failwith ("dependent control accepted: " ^ label);;
'''
text += f'dcontrol "checksum" `DInput` `DCoeff` (dclock 1) dcontrol_bound (dz "{int(case["checksum"])+1}");;\n'
text += r'''
dcontrol "bound" `DInput` `DCoeff` (dclock 1) (dz "0") dcontrol_expected;;
dcontrol "depth" `DInput` `DCoeff` (dclock 2) dcontrol_bound dcontrol_expected;;
dcontrol "input" dependent_changed_input `DCoeff` (dclock 1) dcontrol_bound dcontrol_expected;;
dcontrol "coefficient" `DInput` dependent_changed_coefficient (dclock 1) dcontrol_bound dcontrol_expected;;
close_out dout;;
check_axioms ();;
print_string "DEPENDENT_MATHEMATICAL_RESULTS_DONE\n";;
'''
(home/'dependent_fixture.ml').write_text(text, encoding='utf-8')
(home/'dependent_fixture_pin.json').write_text(json.dumps({
    'path': str(source), 'sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
    'generated_sha256': hashlib.sha256((home/'dependent_fixture.ml').read_bytes()).hexdigest(),
    'cases': [{k: c[k] for k in ['depth','butterflies','maximum_coordinate_bits']} for c in data['cases']],
    'contract': 'Explicit integer encoding, all local residuals, length, final bound, checksum. No analytic interpretation.'
}, indent=2)+'\n')
print('Generated exact dependent inputs, four cases, full-output dumps and five controls.')
