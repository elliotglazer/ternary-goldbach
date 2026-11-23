(* Diagnostic: repeated work on the SAME data inside one kernel call.
   This is not an independent-data throughput benchmark. *)
let repeat_rec = new_recursive_definition cval_RECURSION
 `(RepeatStage (numc n) xs ys s b = numc 1) /\
  (RepeatStage (pairc h t) xs ys s b =
    Zand (Zstage xs ys s b) (RepeatStage t xs ys s b))`;;
let repeat_eq = prove
 (`RepeatStage clock xs ys s b = ifc (ispairc clock)
      (Zand (Zstage xs ys s b) (RepeatStage (sndc clock) xs ys s b)) (numc 1)`,
  STRUCT_CASES_TAC (SPEC `clock:cval` (cases "cval")) THEN
  REWRITE_TAC [repeat_rec;cexp_ispair_def;cexp_snd_def;cexp_if_def;ONE]);;
let inside_defs = repeat_eq::zdefs;;
let rec make_clock n = if n = 0 then `numc 0` else
  mk_comb(mk_comb(`pairc`, `numc 0`),make_clock(n-1));;
let make_repeat n =
  let _,args = strip_comb fixture in
  list_mk_comb (`RepeatStage`,make_clock n::args);;
let run_inside n =
  let tm = make_repeat n in
  let _ = bench_mark ("inside" ^ string_of_int n ^ "_start") in
  let th = compute inside_defs tm in
  let _ = bench_mark ("inside" ^ string_of_int n ^ "_end") in
  if rand (concl th) = `numc 1` then print_string "INSIDE_ACCEPTED\n"
  else failwith "inside rejected";;
run_inside 1;;
run_inside 10;;
run_inside 100;;
check_axioms ();;
print_string "INSIDE_DONE\n";;
