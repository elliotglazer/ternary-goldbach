open HolKernel Parse boolLib bossLib C10004RootNormTheory complexTheory C10004RootRowsTheory RootRowsTheory C10004RootIntervalsTheory
     C10004RootBridgeTheory C10004RootOrderTheory C10004RootAnalyticTheory
     RootBinsTheory transcTheory realTheory intrealTheory listTheory;
val _ = realLib.prefer_real ();
val allowed = ["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
fun require b = if b then () else raise Fail "interval theorem audit";
val _ = List.app (fn thy => List.app (fn (ax,_) =>
  require (List.exists (fn a => a=thy^"."^ax) allowed)) (DB.axioms thy))
  ("C10004RootNorm"::Theory.ancestry "C10004RootNorm");
fun check (name,th,expected) =
  let val (os,_) = Tag.dest_tag (tag th)
  in require (null (hyp th) andalso aconv (concl th) expected andalso
              List.all (fn x => x="DISK_THM") os);
     print (name ^ " oracles=" ^ String.concatWith ";" os ^ " " ^ Parse.thm_to_string th ^ "\n")
  end;
val _ = check ("actual_coordinates",actual_coordinates,
  ``!n r k. MEM (n,r) rows /\ k<n ==>
      near (FST (EL k r)) (cos (2*pi* &k / &n)) /\ near (SND (EL k r)) (sin (2*pi* &k / &n))``);
val _ = check ("near_def",near_def,``!q x. near q x <=> abs (real_of_int q-scale*x)<1/2``);
val _ = check ("scale_def",scale_def,``scale = (2417851639229258349412352:real)``);

val _ = check ("actual_complex_error",actual_complex_error,
  ``!n r k. MEM (n,r) rows /\ k<n ==>
    modu ((real_of_int (FST (EL k r))/scale,real_of_int (SND (EL k r))/scale) -
          (cos (2*pi* &k / &n),sin (2*pi* &k / &n))) < 1/scale``);
val _ = print "NORM_AUDIT_PASS\n";
