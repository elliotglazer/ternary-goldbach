Theory JoinCount
Ancestors Label3 Label6667 Label11 Label9091 JoinTables CountReceipt
Libs meter

open meter;

Definition joined_pair_def:
  joined_pair h phase allowance kernels rad
      lt lj lm la l0 lT rt rj rm ra r0 rT <=>
    GridSigns$valid_kernels kernels /\
    GridSigns$channel lt kernels lj rad lm la l0 lT /\
    GridSigns$channel rt kernels rj rad rm ra r0 rT /\
    CountReceipt$pair_test h phase allowance
      (FullCount$scan_between 0 344981504 lm)
      (FullCount$scan_between 344981504 347602944 la)
      (FullCount$scan_between 0 344981504 rm)
      (FullCount$scan_between 344981504 347602944 ra)
End

fun join name left right count =
  let fun parts th = #2(strip_comb(concl th))
      val [lt,k,lj,d,lm,la,l0,lT]=parts left
      val [rt,k2,rj,d2,rm,ra,r0,rT]=parts right
      val args= #2(strip_comb(lhs(concl count)))
      val guards=List.take(args,3) and scans=List.drop(args,3)
      fun same (a,b)=aconv a b
      val _=if ListPair.allEq same ([k,d],[k2,d2]) andalso
             ListPair.allEq same (map rand scans,[lm,la,rm,ra]) then ()
            else raise Fail "count packet mismatch"
      val goal=list_mk_comb(``joined_pair``,guards@[k,d,lt,lj,lm,la,l0,lT,rt,rj,rm,ra,r0,rT])
      val th=prove(goal,PURE_REWRITE_TAC[joined_pair_def,JoinTablesTheory.tables_valid,
                  left,right,EQT_ELIM count,AND_CLAUSES])
  in if closed th then save_thm(name,th) else raise Fail name end;
val _=join "even_pair_from_samples" Label3Theory.samples_certify_3 Label6667Theory.samples_certify_6667
          CountReceiptTheory.pair0_full_count_test;
val _=join "odd_pair_from_samples" Label11Theory.samples_certify_11 Label9091Theory.samples_certify_9091
          CountReceiptTheory.pair1_full_count_test;
val _=print "JOINED_PAIRS_DONE\n";
