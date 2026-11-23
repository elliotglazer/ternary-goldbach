Theory InclusiveBracket
Ancestors ZeroFreeGap FullCount real lim list arithmetic
Libs realLib

Theorem endpoint_flip_witness:
  !f a b. a <= b /\ f a <> 0 /\ f b <> 0 /\
  (!t. a <= t /\ t <= b ==> $contl f t) /\
  ((0 < f a) <> (0 < f b)) ==>
  ?r. a < r /\ r < b /\ f r=0
Proof
  rpt gen_tac >> strip_tac >> CCONTR_TAC >>
  `zero_free_gap f a b` by
    (PURE_REWRITE_TAC [ZeroFreeGapTheory.zero_free_gap_def] >>
     rpt conj_tac >> TRY (first_assum ACCEPT_TAC) >> metis_tac[]) >>
  drule ZeroFreeGapTheory.gap_sign >> asm_rewrite_tac[]
QED

Theorem shared_boundary_disjoint:
  !a t b x y:real. a<x /\ x<t /\ t<y /\ y<b ==> x<>y
Proof
  REAL_ARITH_TAC
QED

Theorem conservative_aux_weight:
  !t r v h:real. t<r /\ r<v /\ v<=h ==> 0<=h-v /\ h-v<=h-r
Proof
  REAL_ARITH_TAC
QED

Theorem translated_sample_admissible:
  !lower upper t:num. (lower<t+1 /\ t+1<upper+2) <=> lower<=t /\ t<=upper
Proof
  decide_tac
QED

(* Physical upper endpoints of the selected flips; each occurrence corresponds
   to one counted bracket. The mapped positions are strict-scan ticks. *)
Theorem translated_aux_weights:
  !vs h. EVERY (\v. v<=h) vs ==>
  SUM (MAP (\v. (h+2)-(v+1)) vs) =
  SUM (MAP (\v. h-v) vs)+LENGTH vs
Proof
  Induct >> simp[] >> rpt strip_tac >>
  first_x_assum (qspec_then `h':num` mp_tac) >>
  simp[] >> decide_tac
QED
