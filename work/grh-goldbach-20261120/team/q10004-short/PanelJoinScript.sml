Theory PanelJoin
Ancestors PanelKernel PanelUnary PanelBatch
Libs meter
open meter;
Theorem panels_append:
 !xs ys. panels xs /\ panels ys ==> panels (xs++ys)
Proof
 Induct >> simp[panels_def] >> metis_tac[]
QED
val start=cpu();
fun leaf i =
 let val id=Int.toString i
     val def=DB.fetch "PanelUnary" ("tsv_"^id^"_def")
     val th=DB.fetch "PanelUnary" ("proved_"^id)
 in (th,def) end;
fun combine ((a,x),(b,y)) =
 let val ap=``APPEND:int list list -> int list list -> int list list``
     val ab=MATCH_MP panels_append (CONJ a b)
     val eq=MK_COMB(MK_COMB(REFL ap,x),y)
     val concrete=TRANS eq (REWRITE_CONV[listTheory.APPEND](rhs(concl eq)))
 in (ab,concrete) end;
fun layer (x::y::rest)=combine(x,y)::layer rest | layer x=x;
fun reduce [r]=r | reduce rs=reduce(layer rs);
val (aggregation,ordered)=reduce(List.tabulate(270,leaf));
val target=DB.fetch "PanelBatch" "tsv_0_def";
val same=TRANS ordered (SYM target);
val th=EQ_MP(AP_TERM ``PanelKernel$panels`` same)aggregation;
val _=if closed th andalso aconv(concl th)(concl(DB.fetch "PanelBatch" "proved_0"))
      then save_thm("same_270_from_unary",th) else raise Fail "aggregate";
val _=print("MATCHED_BATCH_FROM_270 "^Real.toString(cpu()-start)^"\n");
