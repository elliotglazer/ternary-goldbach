open HolKernel Parse boolLib bossLib LaneReciprocalTheory;
val expected = ``!n b h v:num. n < b /\ 0 < v /\ b*v <= h ==>
   (n*((h+v-1) DIV v)) DIV h = n DIV v``;
val th = lane_ceil_reciprocal;
val (os,_) = Tag.dest_tag (tag th);
val allowed = ["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
val axs=List.concat (map (fn thy=>map (fn (n,_)=>thy^"."^n) (DB.axioms thy))
  ("LaneReciprocal"::Theory.ancestry "LaneReciprocal"));
val _=if null(hyp th) andalso aconv(concl th) expected andalso
  List.all (fn x=>x="DISK_THM") os andalso
  List.all (fn ax=>List.exists (fn a=>a=ax) allowed) axs
  then print ("RECIPROCAL_PASS "^Parse.thm_to_string th^"\n")
  else raise Fail "unexpected theorem";
