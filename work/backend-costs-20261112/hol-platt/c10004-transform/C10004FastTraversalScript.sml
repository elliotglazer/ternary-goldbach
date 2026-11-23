(* Candidate outer traversal. Inner 40/60 nodes remain the frozen reference.
   No equivalence theorem or performance result is asserted by this file. *)
Theory C10004FastTraversal
Ancestors C10004Transform integer list option
Libs cv_transLib

Definition ft_pairs_def:
  (ft_pairs ([]:(int # int) list) = SOME []) /\
  (ft_pairs [x] = NONE) /\
  (ft_pairs (x::y::xs) =
    case ft_pairs xs of NONE => NONE
    | SOME zs => SOME (tx_sub x y :: zs))
End

(* Return a prefix and the remaining suffix in the same traversal. *)
Definition ft_take_def:
  (ft_take 0 (xs:(int # int) list) = SOME ([],xs)) /\
  (ft_take (SUC n) [] = NONE) /\
  (ft_take (SUC n) (x::xs) =
    case ft_take n xs of NONE => NONE
    | SOME (pre,rest) => SOME (x::pre,rest))
End

Definition ft_chunks_def:
  (ft_chunks 0 width xs = if xs = [] then SOME [] else NONE) /\
  (ft_chunks (SUC count) width xs =
    case ft_take width xs of NONE => NONE
    | SOME (row,rest) =>
      case ft_chunks count width rest of NONE => NONE
      | SOME rows => SOME (row::rows))
End

(* Extract all heads and all tails together, without indexed lookup. *)
Definition ft_heads_tails_def:
  (ft_heads_tails ([]:(int # int) list list) = SOME ([],[])) /\
  (ft_heads_tails ([]::rows) = NONE) /\
  (ft_heads_tails ((x::xs)::rows) =
    case ft_heads_tails rows of NONE => NONE
    | SOME (heads,tails) => SOME (x::heads,xs::tails))
End

Definition ft_transpose_def:
  (ft_transpose 0 rows =
    if EVERY (\row. row = []) rows then SOME [] else NONE) /\
  (ft_transpose (SUC columns) rows =
    case ft_heads_tails rows of NONE => NONE
    | SOME (heads,tails) =>
      case ft_transpose columns tails of NONE => NONE
      | SOME output => SOME (heads::output))
End

Definition ft_rows40_def:
  ft_rows40 cache rows = MAP (tx_omit 6 40 cache) rows
End
Definition ft_rows60_def:
  ft_rows60 cache rows = MAP (tx_omit 6 60 cache) rows
End

(* Each row is traversed once by append; no growing-prefix left fold. *)
Definition ft_concat_def:
  (ft_concat ([]:(int # int) list list) = []) /\
  (ft_concat (row::rows) = row ++ ft_concat rows)
End

Definition ft_tensor_def:
  ft_tensor cache xs =
    case ft_pairs xs of NONE => NONE
    | SOME axis2 =>
      case ft_chunks 60 40 axis2 of NONE => NONE
      | SOME rows40 =>
        case ft_transpose 39 (ft_rows40 cache rows40) of NONE => NONE
        | SOME rows60 => SOME (ft_concat (ft_rows60 cache rows60))
End

Definition ft_checked_def:
  ft_checked roots xs =
    if tx_roots_ok roots /\ tx_input_ok xs then
      case ft_tensor (tx_cache roots) xs of NONE => NONE
      | SOME ys => if tx_output_ok ys then SOME ys else NONE
    else NONE
End

(* This theorem exposes only the checks the program actually performs.
   It is not the pending refinement to tx_checked. *)
Theorem ft_checked_guards:
  ft_checked roots xs = SOME ys ==>
    tx_roots_ok roots /\ tx_input_ok xs /\ tx_output_ok ys /\
    ft_tensor (tx_cache roots) xs = SOME ys
Proof
  rw [ft_checked_def] >>
  Cases_on `ft_tensor (tx_cache roots) xs` >> fs []
QED

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

val _ = print "C10004_SEQUENTIAL_OUTER_CANDIDATE_NO_REFINEMENT_YET\n";
