(* Stock CV translations of the proved sequential traversal.
   Synthetic diagnostics only; no actual analytic source or root claim. *)
Theory C10004TraversalCV
Ancestors C10004TraversalBase C10004TraversalRefinement
          C10004Transform C10004TransformTests cv_std
Libs cv_transLib

val _ = numLib.prefer_num ();

val _ = cv_trans ft_pairs_def;
val _ = cv_trans ft_take_def;
val _ = cv_trans ft_chunks_def;
val _ = cv_trans ft_heads_tails_def;
val _ = cv_auto_trans ft_transpose_def;
val _ = cv_auto_trans ft_rows40_def;
val _ = cv_auto_trans ft_rows60_def;
val _ = cv_trans ft_concat_def;
val _ = cv_trans ft_tensor_def;
val _ = cv_trans ft_checked_def;

Definition cvfast_public_success_def:
  cvfast_public_success (fixture:num) <=>
    case ft_checked test_roots (test_input fixture 4800) of
      NONE => F | SOME ys => LENGTH ys = 2301
End

Definition cvfast_output_matches_def:
  cvfast_output_matches (fixture:num) <=>
    ft_checked test_roots (test_input fixture 4800) =
    tx_checked test_roots (test_input fixture 4800)
End

Definition cvfast_wrong_output_def:
  cvfast_wrong_output <=>
    case ft_checked test_roots (test_input 1 4800) of
      NONE => F | SOME ys => ys = test_corrupt ys
End

(* This equality is not a CV inlining rule. Both programs must execute. *)
Theorem cvfast_public_refines:
  !fixture. cvfast_public_success fixture = test_public_success fixture
Proof
  simp [cvfast_public_success_def,test_public_success_def,ft_checked_refines]
QED

val _ = cv_trans cvfast_public_success_def;
val _ = cv_trans cvfast_output_matches_def;
val _ = cv_trans cvfast_wrong_output_def;

val _ = print "C10004_TRAVERSAL_CV_TRANSLATIONS_DONE\n";
