open HolKernel Parse boolLib bossLib cv_transLib DiagonalTheory;
val _=new_theory "DiagonalTrials";
val _=if null(hyp split_diagonal) andalso null(hyp joined_value) then () else raise Fail "hyp";
val _=print("DIAGONAL_THEOREM "^thm_to_string split_diagonal^"\n");
fun trial w t n mode rep=let
  val tm=list_mk_comb(``trial``,map numSyntax.term_of_int [mode,w,t,n])
  val clk=Timer.startCPUTimer()
  val th=cv_eval tm
  val {usr,sys}=Timer.checkCPUTimer clk
  val time=Time.toReal(Time.+(usr,sys))
  val (ora,axs)=Tag.dest_tag(tag th)
  val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM") ora andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) T then () else raise Fail "trial"
  in print("DIAG "^String.concatWith " " (map Int.toString [w,t,n,mode,rep])^" "^Real.toString time^"\n"); TextIO.flushOut TextIO.stdOut end;
fun run (w,t,n)=List.app(fn rep=>List.app (fn mode=>trial w t n mode rep) (if rep mod 2=0 then [0,1,2] else [2,1,0])) [1,2];
val _=List.app run [(552,4096,2),(552,65536,2),(552,65536,8),(616,65536,8),(680,65536,8),(744,65536,8),(616,65536,16)];
val _=print "DIAGONAL_DONE\n";
