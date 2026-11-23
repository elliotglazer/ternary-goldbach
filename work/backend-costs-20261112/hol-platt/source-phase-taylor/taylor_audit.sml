open HolKernel Parse boolLib bossLib SourceRawStepTheory SourceRawTaylorTheory SourcePhaseTaylorTheory;
fun require b message = if b then () else raise Fail message;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy))
  ("SourceRawStep" :: Theory.ancestry "SourceRawStep"));
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val roots = [
 ("spt_sum_horner", spt_sum_horner,
   ``!n k u (d:num->real). (!j. d (SUC (SUC j)) = ~(d j)) ==>
      sum (k,SUC n) (\j. d j / &(FACT j) * u pow j) =
      u pow k / &(FACT k) * (d k * RE (seh_ideal u n k) + d (SUC k) * IM (seh_ideal u n k))``),
 ("source_raw_taylor72_error", source_raw_taylor72_error,
  ``!u. abs u <= 2 ==> modu (seh_ideal u 72 0 - (cos u,sin u)) <= (2:real) pow 74 / &(FACT 73)``),
 ("srs_raw_regrid9", srs_raw_regrid9,
  ``!q:int. modu (source_pair_value (2**122) (source_raw_step q) -
     source_pair_value (2**131) (source_exp_horner (2**131) (~5*q) (2**135) 72 0)) <= 1 / (2:real) pow 122``),
 ("source_raw_step_error", source_raw_step_error,
  ``!k x:num. source_log_domain x 1 k /\ k <= 18 ==>
    modu (source_pair_value (2**122) (source_raw_step (source_raw_log129 k x)) -
      (cos (~(5/64)*ln (&x)),sin (~(5/64)*ln (&x)))) <= 1 / (2:real) pow 120``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_PHASE_TAYLOR_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print ("SOURCE_PHASE_TAYLOR_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val _ = print "SOURCE_PHASE_TAYLOR_AUDIT_DONE\n";
