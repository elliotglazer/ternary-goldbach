open HolKernel Parse boolLib bossLib C10004RootIntervalsTheory
     C10004RootBridgeTheory C10004RootOrderTheory C10004RootAnalyticTheory
     RootBinsTheory transcTheory realTheory intrealTheory listTheory;
val _ = realLib.prefer_real ();
val allowed = ["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
fun require b = if b then () else raise Fail "interval theorem audit";
val _ = List.app (fn thy => List.app (fn (ax,_) =>
  require (List.exists (fn a => a=thy^"."^ax) allowed)) (DB.axioms thy))
  ("C10004RootIntervals"::Theory.ancestry "C10004RootIntervals");
fun check (name,th,expected) =
  let val (os,_) = Tag.dest_tag (tag th)
  in require (null (hyp th) andalso aconv (concl th) expected andalso
              List.all (fn x => x="DISK_THM") os);
     print (name ^ " oracles=" ^ String.concatWith ";" os ^ " " ^ Parse.thm_to_string th ^ "\n")
  end;
val _ = check ("all_center_intervals",all_center_intervals,
  ``!i:num. 0<i /\ i<=29 ==> endpoint (2*EL (i-1) centers-1) < cos (&i*pi/60) /\
    cos (&i*pi/60) < endpoint (2*EL (i-1) centers+1)``);
val _ = check ("endpoint_def",endpoint_def,``!a. endpoint a = real_of_int a / grid``);
val _ = check ("grid_def",grid_def,``grid = (4835703278458516698824704:real)``);
val _ = print "INTERVAL_AUDIT_PASS\n";
