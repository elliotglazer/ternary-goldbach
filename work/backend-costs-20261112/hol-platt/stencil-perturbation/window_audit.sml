open HolKernel Parse boolLib bossLib integerTheory listTheory StencilPerturbationTheory KernelPerturbationTheory WindowPerturbationTheory;
val allowed=["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
val axs=List.concat(map(fn thy=>map(fn(n,_)=>thy^"."^n)(DB.axioms thy))
  ("WindowPerturbation"::Theory.ancestry "WindowPerturbation"));
val _=if List.all(fn x=>List.exists(fn a=>a=x)allowed)axs then () else raise Fail "axioms";
fun check n th tm =
  let val(os,_)=Tag.dest_tag(tag th)
  in if null(hyp th) andalso aconv(concl th)tm andalso List.all(fn x=>x="DISK_THM")os
     then print(n^" "^Parse.thm_to_string th^"\n") else raise Fail n end;
val _=check "dot_perturbation_l1" dot_perturbation_l1
  ``!ws xs ys e. LENGTH ws=LENGTH xs /\ LIST_REL (\x y. ABS (x-y)<=e) xs ys ==>
  ABS (StencilReceipt$dot ws xs - StencilReceipt$dot ws ys) <= weight_l1 ws * e``;
val _=check "compressed_dot_perturbation" compressed_dot_perturbation
  ``!r off den ws xs ys a e. KernelWeights$kernel_ok r off den ws /\
   LENGTH ws=LENGTH xs /\ 0<=e /\ LIST_REL (\x y. ABS(x-y)<=e) xs (MAP (\y. a*y) ys) ==>
   ABS (StencilReceipt$dot ws xs - a*StencilReceipt$dot ws ys) <= (5*den)*e``;
val _=print "STENCIL_PERTURBATION_AUDIT_PASS\n";
val _=check "window_sign_margin" window_sign_margin
  ``!ws ps raw tab j z cap r off den err.
  KernelWeights$kernel_ok r off (&den) ws /\ LENGTH ws = LENGTH ps /\
  reads tab j ps /\ LIST_REL Enclosure$encloses raw ps /\
  GridSigns$dot_window tab j ws 0 0 = SOME(z,cap) ==>
  let v=StencilReceipt$dot ws (MAP raw_center raw) in
  (GridSigns$strict_code z (den*(err+5*cap)) = 2 ==> &(den*err)<v) /\
  (GridSigns$strict_code z (den*(err+5*cap)) = 1 ==> v < -&(den*err))``;
val _=print "WINDOW_AUDIT_PASS\n";
