open HolKernel Parse boolLib bossLib SourceExpHornerTheory;
fun require b s = if b then () else raise Fail s;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "SourceExpHorner" :: Theory.ancestry "SourceExpHorner";
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val _ = print ("SOURCE_EXP_HORNER_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val program_types = [
 ("source_exp_horner",type_of ``source_exp_horner``,``:num -> int -> num -> num -> num -> int # int``),
 ("source_exp_step",type_of ``source_exp_step``,``:num -> int -> num -> num -> (int # int) -> int # int``),
 ("seh_affine",type_of ``seh_affine``,``:real -> real -> complex -> complex``),
 ("seh_ideal",type_of ``seh_ideal``,``:real -> num -> num -> complex``),
 ("seh_bound",type_of ``seh_bound``,``:num -> real``)
];
val _ = List.app (fn (name,actual,expected) =>
  (require (actual = expected) (name ^ ": wrong program type");
   print ("SOURCE_EXP_HORNER_TYPE," ^ name ^ "," ^ type_to_string actual ^ "\n"))) program_types;
val roots = [
 ("seh_round_pair_error",seh_round_pair_error,
  ``!s r t:int. 0 < s ==>
    modu (pair_value 1 (round_scaled s r,round_scaled s t) - pair_value s (r,t)) <= 1``),
 ("seh_affine_distance",seh_affine_distance,
  ``!a t:real. !u v:complex.
    modu (seh_affine a t u-seh_affine a t v) = abs t * modu (u-v)``),
 ("seh_affine_scale",seh_affine_scale,
  ``!a t:real. !z:complex. seh_affine a t (a*z) = a * seh_affine 1 t z``),
 ("seh_den_positive",seh_den_positive,
  ``!d k:num. 0 < d ==> 0 < ((&d:int) * &(k+1))``),
 ("seh_exact_affine",seh_exact_affine,
  ``!grid d k:num. !p:int. !u:int#int. 0 < d ==>
    seh_affine (&grid) (real_of_int p / (&d:real) / &(k+1)) (pair_value 1 u) =
    pair_value ((&d:int)* &(k+1))
      ((&grid:int)*((&d:int)* &(k+1))-p*SND u,p*FST u)``),
 ("seh_actual_step_error",seh_actual_step_error,
  ``!grid d k:num. !p:int. !u:int#int. 0 < d ==>
    modu (pair_value 1 (source_exp_step grid p d k u) -
      seh_affine (&grid) (real_of_int p / (&d:real) / &(k+1)) (pair_value 1 u)) <= 1``),
 ("seh_update_error",seh_update_error,
  ``!a t eps:real. !z u v:complex.
    modu (z-seh_affine a t u) <= 1 /\ modu (u-v) <= eps ==>
    modu (z-seh_affine a t v) <= 1 + abs t * eps``),
 ("seh_bound_nonnegative",seh_bound_nonnegative,
  ``!k:num. 0 <= seh_bound k``),
 ("seh_bound_step",seh_bound_step,
  ``!k:num. !phase:real. abs phase <= 2 ==>
    1 + abs (phase / &(k+1)) * seh_bound (SUC k) <= seh_bound k``),
 ("seh_initial_exact",seh_initial_exact,
  ``!grid k:num. !phase:real.
    pair_value 1 ((&grid:int),0) = (&grid:real) * seh_ideal phase 0 k``),
 ("source_exp_horner_error",source_exp_horner_error,
  ``!grid d:num. !p:int. 0 < d /\ abs (real_of_int p / (&d:real)) <= 2 ==>
    !n k:num.
      modu (pair_value 1 (source_exp_horner grid p d n k) -
        (&grid:real) * seh_ideal (real_of_int p / (&d:real)) n k) <= seh_bound k``),
 ("source_exp_horner_zero_error",source_exp_horner_zero_error,
  ``!grid d:num. !p:int. 0 < d /\ abs (real_of_int p / (&d:real)) <= 2 ==>
    !n:num. modu (pair_value 1 (source_exp_horner grid p d n 0) -
      (&grid:real) * seh_ideal (real_of_int p / (&d:real)) n 0) <= 9``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_EXP_HORNER_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "SOURCE_EXP_HORNER_EXACT_AUDIT_DONE\n";
