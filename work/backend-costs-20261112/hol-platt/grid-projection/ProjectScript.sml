Theory Project
Ancestors arithmetic integer list
Libs intLib cv_transLib

(* Source fields encode raw+2^255, four 256-bit fields per word. The
   destination fields encode the signed quotient plus 2^(width-1). *)
Definition fields_def:
  (fields 0 b u adj bias raw head <=> raw=0 /\ head=0) /\
  (fields (SUC n) b u adj bias raw head <=>
     (raw MOD (2**256)) DIV u + bias = head MOD b + adj /\
     fields n b u adj bias (raw DIV (2**256)) (head DIV b))
End
Definition verify_words_def:
  (verify_words count b u adj bias [] heads <=> count=0 /\ heads=[]) /\
  (verify_words count b u adj bias (x::xs) heads <=>
     case heads of [] => F | h::hs =>
       0<count /\ fields (MIN count 4) b u adj bias x h /\
       verify_words (count-4) b u adj bias xs hs)
End
Definition project_ok_def:
  project_ok width ex count xs hs <=>
    0<width /\ width<=32 /\ ex<=255 /\ 0<count /\ count<=64 /\
    verify_words count (2**width) (2**ex) (2**(255-ex)) (2**(width-1)) xs hs
End
val _=cv_auto_trans project_ok_def;

Theorem integer_field_bounds:
  !v k r u a b h:int. v=k*u+r /\ 0<=r /\ r<u /\ k+b=h+a ==>
    (h-b)*u <= v-a*u /\ v-a*u < (h-b)*u+u
Proof
  rpt strip_tac >>
  `k=(h-b)+a` by intLib.ARITH_TAC >>
  `k*u=(h-b)*u+a*u` by
     (qpat_x_assum `k=(h-b)+a` SUBST1_TAC >> intLib.INT_RING_TAC) >>
  intLib.ARITH_TAC
QED

Theorem field_bounds:
  !raw u adj bias h:num. 0<u /\ raw DIV u + bias = h+adj ==>
   ((&h - &bias):int)* &u <= &raw - &(adj*u) /\
   &raw - &(adj*u) < ((&h - &bias):int)* &u + &u
Proof
  rpt gen_tac >> strip_tac >>
  match_mp_tac (PURE_REWRITE_RULE[INT_MUL,INT_ADD,INT_INJ,INT_LT,INT_POS,AND_CLAUSES]
    (Q.SPECL [`&raw`,`&(raw DIV u)`,`&(raw MOD u)`,`&u`,`&adj`,`&bias`,`&h`]
       integer_field_bounds)) >>
  mp_tac (Q.SPEC `raw` (MATCH_MP (Q.SPEC `u` DIVISION) (ASSUME ``0 < u:num``))) >>
  metis_tac[]
QED
