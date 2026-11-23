(* Sequential outer traversal definitions and generic list contracts.
   Integer arithmetic and the inner 40/60 transforms are unchanged. *)
Theory C10004TraversalBase
Ancestors C10004Transform integer list option arithmetic
Libs intLib

val _ = numLib.prefer_num ();

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
  (ft_chunks (SUC rowCount) width xs =
    case ft_take width xs of NONE => NONE
    | SOME (row,rest) =>
      case ft_chunks rowCount width rest of NONE => NONE
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
  Cases_on `ft_tensor (tx_cache roots) xs` >> fs [] >>
  BasicProvers.every_case_tac >> fs []
QED

Theorem ft_take_spec:
  !n xs. ft_take n xs =
    if n <= LENGTH xs then SOME (TAKE n xs,DROP n xs) else NONE
Proof
  Induct_on `n` >> Cases_on `xs` >>
  simp [ft_take_def,TAKE_def,DROP_def] >>
  Cases_on `n <= LENGTH t` >> simp []
QED

Theorem ft_pairs_genlist:
  !n f. ft_pairs (GENLIST f (2*n)) =
    SOME (GENLIST (\j. tx_sub (f (2*j)) (f (2*j+1))) n)
Proof
  Induct_on `n`
  >- simp [ft_pairs_def] >>
  gen_tac >>
  `2*SUC n = SUC (SUC (2*n))` by intLib.ARITH_TAC >>
  ASM_SIMP_TAC arith_ss [GENLIST_CONS,ft_pairs_def,combinTheory.o_DEF] >>
  SIMP_TAC arith_ss [MULT_CLAUSES,ADD1]
QED

Theorem ft_chunks_genlist:
  !n width f. ft_chunks n width (GENLIST f (n*width)) =
    SOME (GENLIST (\i. GENLIST (\j. f (width*i+j)) width) n)
Proof
  Induct_on `n`
  >- simp [ft_chunks_def] >>
  rpt gen_tac >> ONCE_REWRITE_TAC [ft_chunks_def] >>
  ASM_SIMP_TAC arith_ss [ft_take_spec,LENGTH_GENLIST,TAKE_GENLIST,
    DROP_GENLIST,MULT_CLAUSES,MIN_DEF,GENLIST_CONS,combinTheory.o_DEF,
    ADD_ASSOC]
QED

Theorem ft_heads_tails_genlist:
  !n columns f.
  ft_heads_tails (GENLIST (\i. GENLIST (f i) (SUC columns)) n) =
    SOME (GENLIST (\i. f i 0) n,
      GENLIST (\i. GENLIST (\j. f i (SUC j)) columns) n)
Proof
  Induct_on `n` >>
  simp [GENLIST_CONS,ft_heads_tails_def,combinTheory.o_DEF]
QED

Theorem ft_transpose_genlist:
  !columns n f.
  ft_transpose columns (GENLIST (\i. GENLIST (f i) columns) n) =
    SOME (GENLIST (\j. GENLIST (\i. f i j) n) columns)
Proof
  Induct_on `columns`
  >- simp [ft_transpose_def,EVERY_GENLIST] >>
  rpt gen_tac >> ONCE_REWRITE_TAC [ft_transpose_def] >>
  REWRITE_TAC [ft_heads_tails_genlist] >>
  ASM_SIMP_TAC bool_ss [optionTheory.option_CLAUSES,
    GENLIST_CONS,combinTheory.o_DEF]
QED

Theorem ft_concat_flat:
  !rows. ft_concat rows = FLAT rows
Proof
  Induct >> simp [ft_concat_def]
QED

Theorem ft_concat_blocks:
  !n width f.
  ft_concat (GENLIST (\i. GENLIST (\j. f (width*i+j)) width) n) =
    GENLIST f (n*width)
Proof
  Induct_on `n`
  >- simp [ft_concat_def] >>
  rpt gen_tac >>
  ASM_SIMP_TAC arith_ss [GENLIST_CONS,ft_concat_def,combinTheory.o_DEF,
    MULT_CLAUSES,GENLIST_APPEND,ADD_ASSOC]
QED

val _ = print "C10004_TRAVERSAL_BASE_PROOF_DONE\n";
