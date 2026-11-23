open HolKernel Parse boolLib bossLib SourceArithmeticTheory;
fun require b msg = if b then () else raise Fail msg;
val allowed = ["bool.BOOL_CASES_AX", "bool.ETA_AX", "bool.SELECT_AX", "bool.INFINITY_AX"];
val ancestry = "SourceArithmetic" :: Theory.ancestry "SourceArithmetic";
val axs = List.concat (map (fn thy => map (fn (name,_) => thy ^ "." ^ name)
  (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs)
  "unexpected ancestry axiom";
val _ = print ("SOURCE_ANCESTRY," ^ String.concatWith ";" ancestry ^ "\n");
val _ = print ("SOURCE_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val program_types = [
 ("source_initial",type_of ``source_initial``,``:num -> num -> num -> num -> (int # int) option``),
 ("source_raw_initial",type_of ``source_raw_initial``,``:num -> (int # int) option``),
 ("source_em_initial",type_of ``source_em_initial``,``:num -> (int # int) option``),
 ("source_inverse_root",type_of ``source_inverse_root``,``:num -> num -> num -> num``),
 ("source_exp_horner",type_of ``source_exp_horner``,``:num -> int -> num -> num -> num -> int # int``),
 ("source_mul",type_of ``source_mul``,``:num -> (int # int) -> (int # int) -> int # int``),
 ("source_state",type_of ``source_state``,``:num -> (int # int) -> (int # int) -> num -> int # int``)
];
val _ = List.app (fn (n,actual,expected) =>
  (require (actual = expected) (n ^ ": wrong program type");
   print ("SOURCE_PROGRAM_TYPE," ^ n ^ "," ^ type_to_string actual ^ "\n"))) program_types;
val roots = [
  ("source_initial_def",source_initial_def,
   ``!A D amplitude_bits state_bits.
      source_initial A D amplitude_bits state_bits =
        if 0 < D /\ D <= A /\ amplitude_bits <= state_bits then
          SOME (((&(source_inverse_root A D (2 ** amplitude_bits)):int) *
                 &(2 ** (state_bits-amplitude_bits)), (0:int)))
        else NONE``),
  ("source_log_checked_domain", source_log_checked_domain,
   ``!S n out_div l2 k A D q.
       source_log_checked S n out_div l2 k A D = SOME q ==>
       0 < S /\ 0 < out_div /\ source_log_domain A D k``),
  ("source_pool_tick_length", source_pool_tick_length,
   ``!step_scale entries. LENGTH (source_pool_tick step_scale entries) = LENGTH entries``),
  ("source_mul_residuals", source_mul_residuals,
   ``!step_scale ur ui vr vi. 0 < (&step_scale:int) ==>
       -(&step_scale) <= 2*((ur*vr-ui*vi) - FST (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) /\
       2*((ur*vr-ui*vi) - FST (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) < &step_scale /\
       -(&step_scale) <= 2*((ur*vi+ui*vr) - SND (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) /\
       2*((ur*vi+ui*vr) - SND (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) < &step_scale``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,axioms) = Tag.dest_tag (tag th)
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (List.all (fn x => x="DISK_THM") oracles) (name ^ ": unexpected oracle")
  val _ = require (null axioms) (name ^ ": unexpected axiom tags")
  in print ("SOURCE_THEOREM," ^ name ^ ",oracles=" ^ String.concatWith ";" oracles ^
       ",axiom_tags=" ^ String.concatWith ";" axioms ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "SOURCE_AUDIT_DONE_GENERIC_ONLY_NO_ANALYTIC_PRODUCER\n";
