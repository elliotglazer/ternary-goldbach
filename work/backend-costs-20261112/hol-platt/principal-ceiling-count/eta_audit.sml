open HolKernel Parse boolLib bossLib realTheory seqTheory transcTheory ZetaEtaSignTheory;
val allowed = ["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
fun require b = if b then () else raise Fail "interval theorem audit";
val _ = List.app (fn thy => List.app (fn (ax,_) =>
  require (List.exists (fn a => a=thy^"."^ax) allowed)) (DB.axioms thy))
  ("ZetaEtaSign"::Theory.ancestry "ZetaEtaSign");
fun check (name,th,expected) =
  let val (os,_) = Tag.dest_tag (tag th)
  in require (null (hyp th) andalso aconv (concl th) expected andalso
              List.all (fn x => x="DISK_THM") os);
     print (name ^ " oracles=" ^ String.concatWith ";" os ^ " " ^ Parse.thm_to_string th ^ "\n")
  end;
val _ = check ("positive_eta",positive_eta,``!s. 0<s ==> summable (paired s) /\ 0<suminf (paired s)``);
val _ = check ("eta_quotient_negative",eta_quotient_negative,``!s:real. 0<s /\ s<1 ==> suminf (paired s) / (1-exp((1-s)*ln 2)) < 0``);
val _ = print "ETA_AUDIT_PASS\n";
