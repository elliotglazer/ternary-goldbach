Theory ActualSign
Ancestors CompactSign PanelBatch real intreal
Libs intLib realLib
Definition actual_def:
 actual (f:num->real) (z:num->real) = [(- 1826:int,44186:int,f 0:real,z 0:real);(24427:int,34289:int,f 1:real,z 1:real);(- 155830:int,23161:int,f 2:real,z 2:real);(645582:int,12796:int,f 3:real,z 3:real);(- 2085728:int,4906:int,f 4:real,z 4:real);(7592049:int,577:int,f 5:real,z 5:real);(12653414:int,81:int,f 6:real,z 6:real);(- 2464951:int,2857:int,f 7:real,z 7:real);(713538:int,7675:int,f 8:real,z 8:real);(- 167373:int,12938:int,f 9:real,z 9:real);(25823:int,17053:int,f 10:real,z 10:real);(- 1911:int,18790:int,f 11:real,z 11:real)]
End
Theorem actual_metrics:
 !f z. idot (actual f z) = - 2745441154 /\
       knorm (actual f z) = 26532452 /\ vnorm (actual f z) = 179321
Proof
 rpt gen_tac >> simp [actual_def,idot_def,knorm_def,vnorm_def,integerTheory.INT_ABS] >> EVAL_TAC
QED
Theorem actual_radius:
 margin 16777216 (544987/16777216) (actual f z) = 27167100
Proof
 simp [margin_def,actual_metrics] >> EVAL_TAC
QED
Theorem q10000_label3_tick8010240_negative:
 !f z y. admitted 16777216 (actual f z) /\
   abs (y - ideal (actual f z)) <= 544987/16777216 ==> y<0
Proof
 rpt gen_tac >> strip_tac >>
 mp_tac (Q.SPECL [`actual f z`,`16777216:real`,`544987/16777216:real`,`y:real`] stencil_sign) >>
 simp [actual_metrics, actual_radius] >> metis_tac[]
QED
