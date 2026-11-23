Theory FusedCount
Ancestors SparseHead Enclosure
Libs cv_transLib intLib
Definition raw_window_def:
 (raw_window tab j [] bits (a:int) = if bits=0 then SOME a else NONE) /\
 (raw_window tab j (w::ws) bits a =
  case sptree$lookup j tab of NONE => NONE | SOME sample =>
    let raw=bits MOD (2**256) in
    if Enclosure$encloses raw sample then
      raw_window tab (SUC j) ws (bits DIV (2**256)) (a+w*(&raw- &(2**255)))
    else NONE)
End
Definition join_words_def:
 (join_words ([]:num list)=0) /\ (join_words (w::ws)=w+2**1024*join_words ws)
End
Definition margins_def:
 (margins tab ks fixes [] [] <=> T) /\
 (margins tab ks fixes (j::js) [] <=> F) /\
 (margins tab ks fixes [] (x::xs) <=> F) /\
 (margins tab ks fixes ((t,k)::js) (bits::xs) <=>
  (case sptree$lookup k ks of NONE => F | SOME(r,off,den,err,ws) =>
   case raw_window tab (129+t DIV 4096-r DIV 2) ws (join_words bits) 0 of NONE => F | SOME v =>
    (sptree$lookup t fixes=SOME (2:num) /\ &(den*err)<v) \/
    (sptree$lookup t fixes=SOME (1:num) /\ v < -&(den*err))) /\
    margins tab ks fixes js xs)
End
Definition optionally_def:
 (optionally NONE tab ks fixes jobs <=> T) /\
 (optionally (SOME bits) tab ks fixes jobs <=> margins tab ks fixes jobs bits)
End
Definition fused_def:

  fused words kernels (rows,jobs,mb,m,ab,a,ea,eb) =
    let rad=54315217; cut=232574976; last=235196416 in
    case load_grid rows 0 sptree$LN of NONE => NONE | SOME tab =>
    case GridSigns$repairs tab (sptree$fromList kernels) jobs sptree$LN of NONE => NONE
    | SOME fixes =>
      if optionally words tab (sptree$fromList kernels) fixes jobs /\ (2*(512*4*3**78*2**80)+5*262144*2**220 <= rad*(512*4*3**78*2**80)) /\ 0<ea /\ ea<=2 /\ 0<eb /\ eb<=2 /\
         GridSigns$sign_at tab fixes rad 0=ea /\ GridSigns$sign_at tab fixes rad 1=ea /\
         GridSigns$sign_at tab fixes rad cut=eb /\ GridSigns$sign_at tab fixes rad (cut-1)=eb /\
         GridSigns$sign_at tab fixes rad last<>0 then
        case (region tab fixes rad 0 cut mb m, region tab fixes rad cut last ab a) of
          (SOME v,SOME w) => SOME (v,w) | _ => NONE
      else NONE
End

Definition outcome_def:
 outcome words kernels data res <=> fused words kernels data = SOME res
End
val _=cv_auto_trans outcome_def;
Theorem implies_observation:
 !w ks d r. outcome w ks d r ==> SparseHead$observation ks d=SOME r
Proof
 rpt gen_tac >> PairCases_on `d` >> simp[outcome_def,fused_def,SparseHeadTheory.observation_def,LET_THM] >>
 strip_tac >> gvs[AllCaseEqs()]
QED
