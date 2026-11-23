(* Change only the presentation of the two literal lists. Every APPEND tree
   is rewritten to the original list by a proved conversion before use. *)
let rec balanced_cval_list xs =
  if length xs <= 1 then mk_list (xs,`:cval`) else
  let left,right = chop_list (length xs / 2) xs in
  let append = mk_const ("APPEND",[`:cval`,`:A`]) in
  mk_comb (mk_comb (append,balanced_cval_list left),balanced_cval_list right);;
let balanced_xs = balanced_cval_list (unlist_cval fx);;
let balanced_ys = balanced_cval_list (unlist_cval fy);;
let balanced_xs_eq = REWRITE_CONV [APPEND] balanced_xs;;
let balanced_ys_eq = REWRITE_CONV [APPEND] balanced_ys;;
let _ = if rand (concl balanced_xs_eq) = fx_list &&
           rand (concl balanced_ys_eq) = fy_list then ()
  else failwith "balanced lists differ from the literal fixture";;
let original_residual_fixture = certified_residual_fixture;;
let certified_residual_fixture =
  SUBS [SYM balanced_xs_eq;SYM balanced_ys_eq] original_residual_fixture;;
let _ = if hyp certified_residual_fixture = [] then ()
  else failwith "open balanced theorem";;
print_string "BALANCED_LISTS_DONE\n";;
