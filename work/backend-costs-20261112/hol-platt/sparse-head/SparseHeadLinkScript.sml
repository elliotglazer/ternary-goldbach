Theory SparseHeadLink
Ancestors SparseHead HeadProjection Enclosure
Libs cv_transLib meter

Definition slots_def:
 (slots 0 base m = ([]:num list)) /\
 (slots (SUC n) base m = if m MOD 2=1 then base::slots n (SUC base) (m DIV 2)
                         else slots n (SUC base) (m DIV 2))
End
Definition lookup_encloses_def:
 lookup_encloses raw opt <=> ?z. opt=SOME z /\ Enclosure$encloses raw z
End
Definition row_agrees_def:
 row_agrees len base mask tab w e n hs <=>
   MAP (\i. sptree$lookup i tab) (slots len base mask) =
   MAP SOME (GridSigns$grid [(w,e,n,hs)])
End

Theorem lift_enclosures:
 !xs ys. LIST_REL Enclosure$encloses xs ys ==>
 LIST_REL lookup_encloses xs (MAP SOME ys)
Proof
 Induct >> Cases_on `ys` >> simp[lookup_encloses_def]
QED

Theorem projected_masked_row:
 !w e n xs hs len base mask tab.
   Project$project_ok w e n xs hs /\ row_agrees len base mask tab w e n hs ==>
   LIST_REL lookup_encloses (Enclosure$expanded n (2**256) xs)
       (MAP (\i. sptree$lookup i tab) (slots len base mask))
Proof
 rpt gen_tac >> REWRITE_TAC[row_agrees_def] >> strip_tac >>
 asm_rewrite_tac[] >> irule lift_enclosures >>
 metis_tac[EnclosureTheory.tile_enclosures]
QED

Definition example_tab_def:
 example_tab = THE (SparseHead$load_row 64 64 18446741874686296064 18843673570813072500269882892160096490458820585076524935 (2**8) (2**229) sptree$LN)
End

Theorem example_agrees:
 row_agrees 64 64 18446741874686296064 example_tab 8 229 23 [2257028999;2139194245;2054847357;2273410427;2862651278;12893364]
Proof
 EVAL_TAC
QED

val concrete = MATCH_MP projected_masked_row
 (CONJ HeadProjectionTheory.admit_3_1 example_agrees);
val _=if null(hyp concrete) then ignore(save_thm("all_example_selected_enclosures",concrete)) else raise Fail "tag";
val _=print "SPARSE_HEAD_LINKED\n";
