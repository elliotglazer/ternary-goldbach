open HolKernel Parse boolLib bossLib SourceRawHeadBoundsTheory SourceRawHeadBridgeTheory;
fun require ok msg = if ok then () else raise Fail msg;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy))
  ("SourceRawHeadBounds" :: Theory.ancestry "SourceRawHeadBounds"));
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val roots = [
 ("srh_target",srh_target,
  ``!a c:num. !t:real. 0<a /\ 0<c ==> (&c:real)*(conj (srb_target c t) * srb_target a t) =
    complex_exp ((~(1/2),~t)*complex_of_real (ln ((&a:real)/ &c)))``),
 ("srh_rounding",srh_rounding,
  ``!c:num. !U V:int#int. modu (source_pair_value (2**100) (raw_head (&c) U V) -
   (&c:real)*(conj (source_pair_value (2**120) U)*source_pair_value (2**120) V)) <= 1/(2:real) pow 100``),
 ("srh_c_state",srh_c_state,
  ``!n:num. n<=84200 ==> modu (source_pair_value (2**120) (srh_state 10004 n) -
    srb_target 10004 (5*(&n:real)/64)) <= (3/5)/(2:real) pow 98``),
 ("c10004_raw_head_error",c10004_raw_head_error,
  ``!a h:num. 1<=a /\ a<=10004 /\ h<=84200 ==>
    modu (source_pair_value (2**100) (raw_head 10004 (srh_state 10004 h) (srh_state a h)) -
      complex_exp ((~(1/2),~(5*(&h:real)/64))*complex_of_real (ln ((&a:real)/10004)))) < 1/(2:real) pow 85``)];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": different conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_RAW_HEAD_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print ("SOURCE_RAW_HEAD_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val _ = print "SOURCE_RAW_HEAD_AUDIT_DONE\n";
