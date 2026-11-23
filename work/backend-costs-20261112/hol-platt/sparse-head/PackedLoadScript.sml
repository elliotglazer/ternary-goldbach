Theory PackedLoad
Ancestors SparseHead ProducedHead arithmetic list
Definition word_def:
 (word B []=0:num) /\ (word B (d::ds)=d+B*word B ds)
End
Definition from_digits_def:
 (from_digits 0 pos m ds B u tab=if m=0 /\ ds=[] then SOME tab else NONE) /\
 (from_digits (SUC n) pos m ds B u tab=
  if m=0 then (if ds=[] then SOME tab else NONE) else
  if m MOD 2=0 then from_digits n (SUC pos) (m DIV 2) ds B u tab else
   case ds of []=>NONE | d::rest=>
    from_digits n (SUC pos) (m DIV 2) rest B u
     (sptree$insert pos ((&d- &(B DIV 2)):int,u:num) tab))
End
Theorem unpack_word:
 !B d ds. 0<B /\ d<B ==>
 word B (d::ds) MOD B=d /\ word B (d::ds) DIV B=word B ds
Proof
 rpt strip_tac >> simp[word_def,ADD_COMM,MULT_COMM,DIV_MULT,MOD_MULT,DIV_LT_X,LESS_MOD] >> irule DIV_UNIQUE >> qexists_tac `d` >> simp[ADD_COMM,MULT_COMM]
QED
Theorem packed_row:
 !len pos m ds B u tab z. 0<B /\ EVERY (\d. d<B) ds /\
 from_digits len pos m ds B u tab = SOME z ==>
 SparseHead$load_row len pos m (word B ds) B u tab = SOME z
Proof
 Induct >> rpt gen_tac
 >- (Cases_on `m=0` >> Cases_on `ds` >> simp[from_digits_def,SparseHeadTheory.load_row_def,word_def]) >>
 Cases_on `m=0`
 >- (Cases_on `ds` >> simp[from_digits_def,SparseHeadTheory.load_row_def,word_def]) >>
 Cases_on `m MOD 2=0`
 >- (simp[from_digits_def,SparseHeadTheory.load_row_def] >> metis_tac[]) >>
 Cases_on `ds` >> simp[from_digits_def,SparseHeadTheory.load_row_def] >>
 rpt strip_tac >> drule_all unpack_word >>
 disch_then(qspec_then `t:num list` strip_assume_tac) >>
 asm_rewrite_tac[] >> metis_tac[]
QED
