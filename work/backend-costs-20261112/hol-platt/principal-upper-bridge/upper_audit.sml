open HolKernel Parse boolLib bossLib realTheory listTheory pred_setTheory PrincipalUpperTheory;
val allowed = ["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
fun require b = if b then () else raise Fail "interval theorem audit";
val _ = List.app (fn thy => List.app (fn (ax,_) =>
  require (List.exists (fn a => a=thy^"."^ax) allowed)) (DB.axioms thy))
  ("PrincipalUpper"::Theory.ancestry "PrincipalUpper");
fun check (name,th,expected) =
  let val (os,_) = Tag.dest_tag (tag th)
  in require (null (hyp th) andalso aconv (concl th) expected andalso
              List.all (fn x => x="DISK_THM") os);
     print (name ^ " oracles=" ^ String.concatWith ";" os ^ " " ^ Parse.thm_to_string th ^ "\n")
  end;
val _ = check ("line_from_principal_upper",line_from_principal_upper,``!m top w (U:real).
    FINITE (units m top) /\ w SUBSET units m top /\
    (!b g i. (b,g,i) IN w ==> b=1/2) /\
    (!b g. 0<b /\ b<1 /\ 0<g /\ g<=top ==> m (1-b) g = m b g) /\
    &(CARD (units m top)) <= U /\ U < &(CARD w + 2) ==>
    !b g. 0<b /\ b<1 /\ 0<g /\ g<=top /\ 0<m b g ==> b=1/2``);
val _ = check ("weighted_upper",weighted_upper,``!main top (g:'a->real) e xs A. main<top /\
    EVERY (\x. g x<=top /\ !r. e x=SOME r ==> main<g x /\ g x<=r /\ r<=top) xs /\
    weighted (\x. if g x<=main then top-main else top-g x) xs <= A ==>
    &(low main g xs) <= (A-weighted (\x. credit top (e x)) xs)/(top-main)``);
val _ = check ("weighted_lower",weighted_lower,``!main top (g:'a->real) e xs. main < top /\
    EVERY (\x. g x<=top /\ !r. e x=SOME r ==> main<g x /\ g x<=r /\ r<=top) xs ==>
    (top-main)* &(low main g xs) + weighted (\x. credit top (e x)) xs <=
      weighted (\x. if g x<=main then top-main else top-g x) xs``);
val _ = print "UPPER_AUDIT_PASS\n";
