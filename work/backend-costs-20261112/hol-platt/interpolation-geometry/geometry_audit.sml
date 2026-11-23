open HolKernel Parse boolLib bossLib InterpolationConsumerTheory RadiusBudgetTheory WeightedSampleTheory StencilGeometryTheory CenteredProductTheory;
val roots=["InterpolationConsumer","StencilGeometry","CenteredProduct"];
val allowed=["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
val _=List.app(fn thy=>List.app(fn (n,_)=>if List.exists(fn x=>x=thy^"."^n)allowed then ()
 else raise Fail ("unexpected axiom "^n)) (DB.axioms thy))
 (List.concat(map(fn root=>root::Theory.ancestry root)roots));
fun check (n,th)=let val (os,_)=Tag.dest_tag(tag th) in
 if null(hyp th) andalso List.all(fn a=>a="DISK_THM")os
 then print(n^" "^Parse.thm_to_string th^"\n") else raise Fail n end;
val _=List.app check [("all_55_nodes",all_55_nodes),("centered_product_bound",centered_product_bound),
 ("certified_coarse_samples",certified_coarse_samples),("radius_real",radius_real),("interpolation_consumer",interpolation_consumer)];
val _=print "REAL_INTERPOLATION_AUDIT_PASS\n";
