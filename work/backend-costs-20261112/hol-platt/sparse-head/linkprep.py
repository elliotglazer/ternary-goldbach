"""Bind the first saved projection to the original sparse-head scatter mask and actual lookup table."""
from pathlib import Path
from prepare import HERE,write

head=(HERE/"heads-3.txt").read_text().splitlines()[1].split()
mask,w,e,bits=map(int,head[:3]+[str(int(head[3],16))])
records=(HERE/"retained.hex").read_text().splitlines()
label,idx,pm,pw,pe,n=map(int,records[0].split())
assert (label,idx,pm,pw,pe)==(3,1,mask,w,e)
raw=[int(x,16) for x in records[1].split()]
heads=list(map(int,records[2].split()))
slots=[64+j for j in range(64) if mask>>j&1]
assert len(slots)==n
script=r"""Theory SparseHeadLink
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
 example_tab = THE (SparseHead$load_row 64 64 MASK BITS (2**WIDTH) (2**EXPONENT) sptree$LN)
End

Theorem example_agrees:
 row_agrees 64 64 MASK example_tab WIDTH EXPONENT COUNT HEADS
Proof
 EVAL_TAC
QED

val concrete = MATCH_MP projected_masked_row
 (CONJ HeadProjectionTheory.admit_3_1 example_agrees);
val _=if null(hyp concrete) then ignore(save_thm("all_example_selected_enclosures",concrete)) else raise Fail "tag";
val _=print "SPARSE_HEAD_LINKED\n";
"""
for src,val in [("MASK",mask),("BITS",bits),("WIDTH",w),("EXPONENT",e),("COUNT",n)]:
    script=script.replace(src,str(val))
script=script.replace("HEADS","["+";".join(map(str,heads))+"]")
write("SparseHeadLinkScript.sml",script)
hf=(HERE/"Holmakefile").read_text().strip()
if "../grid-enclosure" not in hf:
    write("Holmakefile",hf+" ../grid-enclosure\n")
runner=(HERE/"run.sh").read_text()
if "|SparseHeadLink" not in runner:
    runner=runner.replace("|HeadProjection) theory","|HeadProjection|SparseHeadLink) theory")
    runner=runner.replace(" HeadProjection) sha256sum"," SparseHeadLink) sha256sum .hol/objs/HeadProjectionTheory.dat .hol/objs/SparseHeadTheory.dat ../grid-enclosure/.hol/objs/EnclosureTheory.dat >> \"$label.sha256\";;\n HeadProjection) sha256sum")
    write("run.sh",runner)
print(label,idx,n,slots)

