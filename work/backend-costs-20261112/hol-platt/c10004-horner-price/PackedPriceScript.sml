Theory PackedPrice
Ancestors integer list cv_std
Libs cv_transLib

Definition actual_round_def:
  actual_round (r:int) m d = (r*m*d+10004) / 20008
End
val round_pre_def = cv_trans_pre "actual_rpre" actual_round_def;
Theorem actual_rpre_ok[cv_pre]:
  !r m d. actual_rpre r m d
Proof
  simp [round_pre_def]
QED

Definition actual_steps_def:
  (actual_steps (r:int) (xy:int # int) ([]:(int # int # int) list) =
    (64*FST xy,64*SND xy)) /\
  (actual_steps r xy (z::ss) =
    actual_steps r (actual_round r (FST xy) (FST z)+FST(SND z),actual_round r (SND xy) (FST z)+SND(SND z)) ss)
End
Definition actual_cell_def:
  (actual_cell k top ss ([]:num list) = []) /\
  (actual_cell k top ss (a::xs) =
    actual_steps (&(1024*a)- &(10004*k)) top ss :: actual_cell k top ss xs)
End
Definition actual_groups_def:
  (actual_groups [] = []) /\
  (actual_groups (g::gs) =
     actual_cell (FST g) (FST(SND g)) (FST(SND(SND g))) (SND(SND(SND g))) ++ actual_groups gs)
End
val _ = cv_auto_trans actual_steps_def;
val _ = cv_auto_trans actual_cell_def;
val _ = cv_auto_trans actual_groups_def;
val f = TextIO.openIn "packed.txt";
fun groups i = case TextIO.inputLine f of NONE => () | SOME input =>
  let val tokens = ref (String.tokens Char.isSpace input)
      fun take () = case !tokens of [] => raise Fail "missing token" | s::rest => (tokens:=rest;s)
      fun int () = intSyntax.term_of_int(Arbint.fromString(take()))
      fun nat () = numSyntax.mk_numeral(Arbnum.fromString(take()))
      fun count () = valOf(Int.fromString(take()))
      fun rows n f = List.tabulate(n,fn _ => f())
      fun list xs = listSyntax.mk_list(xs,type_of(hd xs))
      fun pair () = pairSyntax.mk_pair(int(),int())
      fun stage () = pairSyntax.list_mk_pair [int(),int(),int()]
      fun cell () = let val k=nat() val top=pair() val ss=list(rows 19 stage)
                        val us=list(rows (count()) nat)
                    in pairSyntax.list_mk_pair [k,top,ss,us] end
      val tm = mk_comb(``actual_groups``,list(rows (count()) cell))
      val ans = list(rows (count()) pair)
      val _ = if null(!tokens) then () else raise Fail "extra token"
      val c = Timer.startCPUTimer ()
      val rep = cv_repLib.cv_rep_for [] tm
      val ft = cv_typeLib.from_to_thm_for (type_of tm)
      val cvtm = cv_miscLib.cv_rep_cv_tm (concl rep)
      val conv = cv_computeLib.cv_compute (cv_eqs_for cvtm)
      val ctx = UNDISCH_ALL (MATCH_MP (MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
      fun cpu () = let val {usr,sys} = Timer.checkCPUTimer c in Time.toReal(Time.+(usr,sys)) end
      val t1 = cpu()
      val raw = CONV_RULE (RAND_CONV (RAND_CONV conv)) ctx
      val t2 = cpu()
      val decoded = CONV_RULE (RAND_CONV EVAL) raw
      fun discharge (h,t) = PROVE_HYP (prove(h,SIMP_TAC (srw_ss()) [actual_rpre_ok])) t
      val th = List.foldl discharge decoded (hyp decoded)
      val t3 = cpu()
      val _ = if null (hyp th) andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) ans then () else (print ("lhs " ^ Bool.toString(aconv(lhs(concl th)) tm) ^ " rhs " ^ Bool.toString(aconv(rhs(concl th)) ans) ^ " expected " ^ String.substring(term_to_string ans,0,70) ^ " actual " ^ String.substring(term_to_string(rhs(concl th)),0,70) ^ "\n"); raise Fail "coordinate mismatch or hypothesis")
      val _ = print ("ACTUAL_GROUP " ^ Int.toString i ^ " " ^ String.concatWith " " (map Real.toString [t1,t2-t1,t3-t2]) ^ "\n")
  in groups (i+1) end;
val _ = groups 0;
val _ = TextIO.closeIn f;



