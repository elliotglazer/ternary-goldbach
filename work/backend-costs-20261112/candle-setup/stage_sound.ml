let row_integer = new_definition
 `RowInteger s b x y <=> Icheck (Zdecode s) (Zdecode b) (Zdecode (fstc x)) (Zdecode (fstc (sndc x))) (Zdecode (fstc (sndc (sndc x)))) (Zdecode (fstc (sndc (sndc (sndc x))))) (Zdecode (fstc (sndc (sndc (sndc (sndc x)))))) (Zdecode (fstc (sndc (sndc (sndc (sndc (sndc x))))))) (Zdecode (fstc y)) (Zdecode (fstc (sndc y))) (Zdecode (fstc (sndc (sndc y)))) (Zdecode (fstc (sndc (sndc (sndc y)))))`;;
let row_residual = new_definition
 `RowResidual s b x y <=> Ibutterfly (Zdecode s) (Zdecode b) (Zdecode (fstc x)) (Zdecode (fstc (sndc x))) (Zdecode (fstc (sndc (sndc x)))) (Zdecode (fstc (sndc (sndc (sndc x))))) (Zdecode (fstc (sndc (sndc (sndc (sndc x)))))) (Zdecode (fstc (sndc (sndc (sndc (sndc (sndc x))))))) (Zdecode (fstc y)) (Zdecode (fstc (sndc y))) (Zdecode (fstc (sndc (sndc y)))) (Zdecode (fstc (sndc (sndc (sndc y)))))`;;
let row_residual_sound = prove
 (`RowInteger s b x y ==> RowResidual s b x y`,
  REWRITE_TAC [row_integer;row_residual] THEN MATCH_ACCEPT_TAC icheck_sound);;
let zlist = new_recursive_definition list_RECURSION
 `(Zlist [] = numc 0) /\ (Zlist (CONS (x:cval) xs) = pairc x (Zlist xs))`;;
let stage_exact = prove
 (`!xs ys. Zvalid s /\ Zvalid b /\ ALL InputWell xs /\ ALL OutputWell ys ==>
   (Zholds (Zstage (Zlist xs) (Zlist ys) s b) <=> ALL2 (RowInteger s b) xs ys)`,
  LIST_INDUCT_TAC THEN GEN_TAC THEN
  STRUCT_CASES_TAC (ISPEC `ys:cval list` list_CASES) THEN
  REWRITE_TAC [zlist;zstage_rec;ALL;ALL2;cexp_ispair_def;cexp_fst_def;
    cexp_snd_def;cexp_if_def;cexp_eq_def;distinctness "cval";zand_holds;
    zholds_num;NOT_SUC] THEN
  STRIP_TAC THEN ASM_SIMP_TAC [row_integer;zcheck_exact]);;
let stage_residual_sound = prove
 (`!xs ys. ALL2 (RowInteger s b) xs ys ==> ALL2 (RowResidual s b) xs ys`,
  LIST_INDUCT_TAC THEN GEN_TAC THEN
  STRUCT_CASES_TAC (ISPEC `ys:cval list` list_CASES) THEN
  ASM_REWRITE_TAC [ALL2] THEN ASM_MESON_TAC [row_residual_sound]);;
check_axioms ();;
print_string "STAGE_EXACT_DONE\n";;
