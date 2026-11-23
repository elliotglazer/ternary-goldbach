import RawLogCases
import RawLogCases64
import RawSourceControls
import RawPowerIdentity
import RawRecurrence

#check RawHead.log129Center_error
#check RawHead.inverse_sqrt_sub_div_bounds
#check RawHead.integerPower_raw_head
#check RawHead.integerPower_zero_eq_inv_sqrt
#check RawHead.power_state_error_lt_dyadic96
#check RawLogCases.all_logs
#check RawLogCases.all_inverse_roots
#check RawLogCases64.all_logs
#check RawLogCases64.all_inverse_roots
#print axioms RawHead.log129Center_error
#print axioms RawHead.inverse_sqrt_sub_div_bounds
#print axioms RawHead.integerPower_raw_head
#print axioms RawHead.integerPower_zero_eq_inv_sqrt
#print axioms RawHead.power_state_error_lt_dyadic96
#print axioms RawLogCases.all_logs
#print axioms RawLogCases.all_inverse_roots
#print axioms RawLogCases64.all_logs
#print axioms RawLogCases64.all_inverse_roots
#print axioms RawSourceControls.wrong_log_output
#print axioms RawSourceControls.wrong_log_input
#print axioms RawSourceControls.wrong_log_cache
#print axioms RawSourceControls.excessive_inverse_root
#print axioms RawSourceControls.deficient_inverse_root


-- Compare the compiled expressions, not a pretty-printed or re-elaborated formula.
run_cmd do
  let env ← Lean.getEnv
  let names : List Lean.Name := [
    ``RawLogCases64.inverse_sqrt_1,
    ``RawLogCases64.inverse_sqrt_2,
    ``RawLogCases64.inverse_sqrt_3,
    ``RawLogCases64.inverse_sqrt_41,
    ``RawLogCases64.inverse_sqrt_61,
    ``RawLogCases64.inverse_sqrt_4664,
    ``RawLogCases64.inverse_sqrt_9327,
    ``RawLogCases64.inverse_sqrt_10004,
    ``RawLogCases64.inverse_sqrt_13990,
    ``RawLogCases64.inverse_sqrt_18653,
    ``RawLogCases64.inverse_sqrt_23316,
    ``RawLogCases64.inverse_sqrt_27979,
    ``RawLogCases64.inverse_sqrt_32642,
    ``RawLogCases64.inverse_sqrt_37306,
    ``RawLogCases64.inverse_sqrt_41969,
    ``RawLogCases64.inverse_sqrt_46632,
    ``RawLogCases64.inverse_sqrt_51295,
    ``RawLogCases64.inverse_sqrt_55958,
    ``RawLogCases64.inverse_sqrt_60621,
    ``RawLogCases64.inverse_sqrt_65284,
    ``RawLogCases64.inverse_sqrt_69948,
    ``RawLogCases64.inverse_sqrt_74611,
    ``RawLogCases64.inverse_sqrt_79274,
    ``RawLogCases64.inverse_sqrt_83937,
    ``RawLogCases64.inverse_sqrt_88600,
    ``RawLogCases64.inverse_sqrt_93263,
    ``RawLogCases64.inverse_sqrt_97926,
    ``RawLogCases64.inverse_sqrt_102590,
    ``RawLogCases64.inverse_sqrt_107253,
    ``RawLogCases64.inverse_sqrt_111916,
    ``RawLogCases64.inverse_sqrt_116579,
    ``RawLogCases64.inverse_sqrt_121242,
    ``RawLogCases64.inverse_sqrt_125905,
    ``RawLogCases64.inverse_sqrt_130568,
    ``RawLogCases64.inverse_sqrt_135232,
    ``RawLogCases64.inverse_sqrt_139895,
    ``RawLogCases64.inverse_sqrt_144558,
    ``RawLogCases64.inverse_sqrt_149221,
    ``RawLogCases64.inverse_sqrt_153884,
    ``RawLogCases64.inverse_sqrt_158547,
    ``RawLogCases64.inverse_sqrt_163210,
    ``RawLogCases64.inverse_sqrt_167874,
    ``RawLogCases64.inverse_sqrt_172537,
    ``RawLogCases64.inverse_sqrt_177200,
    ``RawLogCases64.inverse_sqrt_181863,
    ``RawLogCases64.inverse_sqrt_186526,
    ``RawLogCases64.inverse_sqrt_191189,
    ``RawLogCases64.inverse_sqrt_195852,
    ``RawLogCases64.inverse_sqrt_200516,
    ``RawLogCases64.inverse_sqrt_205179,
    ``RawLogCases64.inverse_sqrt_209842,
    ``RawLogCases64.inverse_sqrt_214505,
    ``RawLogCases64.inverse_sqrt_219168,
    ``RawLogCases64.inverse_sqrt_223831,
    ``RawLogCases64.inverse_sqrt_228494,
    ``RawLogCases64.inverse_sqrt_233158,
    ``RawLogCases64.inverse_sqrt_237821,
    ``RawLogCases64.inverse_sqrt_242484,
    ``RawLogCases64.inverse_sqrt_247147,
    ``RawLogCases64.inverse_sqrt_251810,
    ``RawLogCases64.inverse_sqrt_256473,
    ``RawLogCases64.inverse_sqrt_261136,
    ``RawLogCases64.inverse_sqrt_262144,
    ``RawLogCases64.inverse_sqrt_265800]
  let mut types : List Lean.Expr := []
  for name in names do
    let some (.thmInfo info) := env.find? name
      | throwError "aggregate audit: missing theorem {name}"
    types := info.type :: types
  let head :: rest := types
    | throwError "aggregate audit: empty leaf list"
  let mut expected := head
  for ty in rest do
    expected := Lean.mkApp2 (Lean.mkConst ``And) ty expected
  let some (.thmInfo actual) := env.find? ``RawLogCases64.all_inverse_roots
    | throwError "aggregate audit: aggregate is not a theorem"
  unless Lean.Expr.equal actual.type expected do
    throwError "aggregate audit: compiled type differs from ordered 64-leaf conjunction"
  Lean.logInfo "AGGREGATE_TYPE,64,exact_ordered_conjunction"
