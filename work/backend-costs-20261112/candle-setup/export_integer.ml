(* Convert the concrete computed acceptance theorem into the integer statement.
   Requires fixture.ml, stage_sound.ml and the checked encoding theory. *)
let rec unlist_cval tm =
  if tm = `numc 0` then [] else
  let f,args = strip_comb tm in
  if f = `pairc` then (hd args)::unlist_cval(hd(tl args))
  else failwith "malformed encoded list";;
let fixture_args = snd(strip_comb fixture);;
let fx = el 0 fixture_args;;
let fy = el 1 fixture_args;;
let fs = el 2 fixture_args;;
let fb = el 3 fixture_args;;
let fx_list = mk_list(unlist_cval fx,`:cval`);;
let fy_list = mk_list(unlist_cval fy,`:cval`);;
let fixture_equiv =
  let th = INST [fs,`s:cval`;fb,`b:cval`] (SPECL [fx_list;fy_list] stage_exact) in
  let assumptions = lhand(concl th) in
  let well = prove(assumptions,
    REWRITE_TAC [ALL;input_well;output_well;cexp_fst_def;cexp_snd_def;zvalid_pair]) in
  REWRITE_RULE [zlist] (MP th well);;
let holds_one = prove(`Zholds (numc 1)`,REWRITE_TAC [zholds_num;ARITH]);;
let fixture_holds = EQ_MP (SYM (AP_TERM `Zholds` fixture_thm)) holds_one;;
let certified_integer_fixture = EQ_MP fixture_equiv fixture_holds;;
let _ = if hyp certified_integer_fixture = [] then () else failwith "open theorem";;
let certified_residual_fixture =
  let th = INST [fs,`s:cval`;fb,`b:cval`]
    (SPECL [fx_list;fy_list] stage_residual_sound) in
  MP th certified_integer_fixture;;
let _ = if hyp certified_residual_fixture = [] then () else failwith "open residual theorem";;
check_axioms ();;
print_string "INTEGER_EXPORT_DONE\n";;
