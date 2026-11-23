(* Reuse the already proved numeral-presentation conversion. *)
let certified_residual_fixture = end_itlist CONJ (map snd (rev (!dresults)));;
#use "../compact_export.ml";;
check_axioms ();;
print_string "DEPENDENT_EXPORT_DONE\n";;
