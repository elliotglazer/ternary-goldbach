open HolKernel Parse boolLib bossLib cv_transLib TileCostTheory;
fun measure mode k w rep =
  let val s=123457+2*rep
      val tm=list_mk_comb(``benchfn``,intSyntax.term_of_int (Arbint.fromInt mode) :: map numSyntax.term_of_int [k,w,s])
      val wall=Time.now() val clk=Timer.startCPUTimer()
      val th=cv_eval tm
      val {usr,sys}=Timer.checkCPUTimer clk
      val cpu=Time.toReal(Time.+(usr,sys)) val dt=Time.toReal(Time.-(Time.now(),wall))
      val (ora,axs)=Tag.dest_tag(tag th)
      val _=if null(hyp th) andalso null axs andalso List.all (fn x=>x="DISK_THM") ora
        andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) boolSyntax.T
        then () else raise Fail "unexpected benchmark theorem"
  in print(String.concatWith "," (["TILE"] @ map Int.toString [mode,k,w,rep] @ map Real.toString [cpu,dt]) ^ "\n"); TextIO.flushOut TextIO.stdOut end;
val _=List.app (fn k=>List.app (fn mode=>measure mode k 616 0) [0,3,2,5,1,4]) [6,8,10,12];
val _=List.app (fn w=>List.app (fn k=>List.app(fn rep=>List.app(fn mode=>measure mode k w rep)
  (if k=16 then [0,3,2,5] else [0,3,2,5,1,4])) [1,2,3]) [8,10,12,16]) [544,552,616,744];
val _=print "TILE_COST_DONE\n";

