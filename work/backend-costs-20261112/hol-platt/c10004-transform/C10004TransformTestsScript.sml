(* Synthetic integer diagnostics, not actual roots or source values. *)
Theory C10004TransformTests
Ancestors C10004Transform integer list
Libs intLib cv_transLib

val _ = intLib.prefer_int ();

Definition test_root_def:
  test_root (n:num) (k:num) =
    case tx_special n k of SOME z => z | NONE =>
      (2 ** 80 + (&k:int), -(2 ** 79) + (&n:int))
End
Definition test_roots_def:
  test_roots = MAP (\n. GENLIST (test_root n) n) tx_lengths
End
Definition test_bad_special_def:
  test_bad_special = [(tx_scale-1,0);(-tx_scale,0)] :: TL test_roots
End
Definition test_bad_bound_def:
  test_bad_bound = [(tx_scale+2,0);(-tx_scale,0)] :: TL test_roots
End
Definition test_input_def:
  test_input (height:num) (n:num) = GENLIST (\i.
    (((&((17*i+height) MOD 97):int)-48) * 2 ** 78 + (&i:int),
     ((&((29*i+3*height) MOD 89):int)-44) * 2 ** 77 - (&i:int))) n
End
Definition test_impulse_def:
  test_impulse = (tx_scale,0) :: GENLIST (\i. (0:int,0:int)) 4799
End
(* The exact expected impulse output, named so its GENLIST body receives
   an explicit proved CV translation. *)
Definition test_impulse_expected_def:
  test_impulse_expected = GENLIST (\i:num. (tx_scale,(0:int))) 2301
End
Definition test_corrupt_def:
  (test_corrupt [] = [(1:int,0:int)]) /\
  (test_corrupt ((r,i)::ys) = (r+1,i)::ys)
End
Definition test_local_projection_def:
  test_local_projection <=> EVERY (\n.
    tx_omit 6 n (tx_cache test_roots) (test_input 1 n) =
    TL (tx_full 6 n (tx_cache test_roots) (test_input 1 n))) tx_lengths
End
Definition test_tensor_projection_def:
  test_tensor_projection (height:num) <=>
    let cache = tx_cache test_roots;
        xs = test_input height 4800;
        full = tx_tensor_full cache xs;
        kept = tx_tensor_selected cache xs
    in LENGTH full = 4800 /\ LENGTH kept = 2301 /\
       kept = tx_project full
End
Definition test_public_success_def:
  test_public_success (height:num) <=>
    case tx_checked test_roots (test_input height 4800) of
      NONE => F | SOME ys => LENGTH ys = 2301
End
Definition test_wrong_output_def:
  test_wrong_output <=>
    let ys = tx_tensor_selected (tx_cache test_roots) (test_input 1 4800)
    in ys = test_corrupt ys
End

val _ = cv_trans test_root_def;
val _ = cv_auto_trans test_roots_def;
val _ = cv_trans test_bad_special_def;
val _ = cv_trans test_bad_bound_def;
val _ = cv_auto_trans test_input_def;
val _ = cv_auto_trans test_impulse_def;
val _ = cv_auto_trans test_impulse_expected_def;
val _ = cv_trans test_corrupt_def;
val _ = cv_auto_trans test_local_projection_def;
val _ = cv_trans test_tensor_projection_def;
val _ = cv_trans test_public_success_def;
val _ = cv_trans test_wrong_output_def;

val _ = print "C10004_TRANSFORM_TEST_DEFINITIONS_ONLY\n";
