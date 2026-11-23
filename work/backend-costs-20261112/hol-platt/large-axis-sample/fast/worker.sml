open HolKernel Parse boolLib bossLib cv_transLib FastAxisTheory;
val _=new_theory "FastAxisTrial";
val _=print "AXIS_START\n";
val f=TextIO.openIn (valOf(OS.Process.getEnv "AXIS_INPUT"));
val first=valOf(Int.fromString(valOf(OS.Process.getEnv "AXIS_FIRST")));
val last=valOf(Int.fromString(valOf(OS.Process.getEnv "AXIS_LAST")));
val count=ref 0;

fun run line =
 let val toks=ref(String.tokens Char.isSpace line)
     fun take()=case !toks of a::xs=>(toks:=xs;a)|_=>raise Fail "empty"
     fun number()=valOf(Int.fromString(take()))
     fun nu i=numSyntax.mk_numeral(Arbnum.fromInt i)
     fun integer()=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x)(take())))
     fun pair()=pairSyntax.mk_pair(integer(),integer())
     val n=number() val p=number() val cap=integer() val w=number() val d=number()
     val rat=pair() val step=pair() val c=number() val check=number()
     val expct=listSyntax.mk_list(List.tabulate(4,fn _=>pair()),type_of rat)
     fun trial mode r =
      let val timer=Timer.startCPUTimer()
          fun cpu()=let val {usr,sys}=Timer.checkCPUTimer timer in Time.toReal(Time.+(usr,sys)) end
          val tm=list_mk_comb(``fast_top``,[nu mode,nu n,nu p,cap,nu w,nu d,rat,step,nu r,expct])
          val rep=cv_repLib.cv_rep_for [] tm
          val ft=cv_typeLib.from_to_thm_for(type_of tm)
          val ctx=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
          val conv=cv_computeLib.cv_compute(cv_eqs_for(rand(rhs(concl ctx))))
          val t1=cpu()
          val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) ctx
          val t2=cpu()
          val dec=CONV_RULE(RAND_CONV EVAL) raw
          val th=List.foldl(fn(h,t)=>PROVE_HYP(prove(h,SIMP_TAC (srw_ss()) [])) t) dec (hyp dec)
          val ans=intSyntax.term_of_int(Arbint.fromInt(c+r*check))
          val (oracles,axs)=Tag.dest_tag(tag th)
          val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM") oracles andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) ans then () else raise Fail ("mismatch " ^ Int.toString n ^ " " ^ Int.toString r)
          val _=print("FAST " ^ Int.toString mode ^ " " ^ Int.toString n ^ " " ^ Int.toString p ^ " " ^ term_to_string cap ^ " " ^ Int.toString w ^ " " ^ Int.toString r ^ " " ^ String.concatWith " " (map Real.toString[t1,t2-t1,cpu()-t2]) ^ "\n")
      in () end
 in List.app (fn (mode,r)=>trial mode r)
  (if n<=8192 then [(0,0),(1,0),(2,0),(0,2),(1,2),(2,2),(2,2),(1,2),(0,2),(2,0),(1,0),(0,0)]
   else [(0,0),(1,0),(2,0),(0,1),(1,1),(2,1),(2,1),(1,1),(0,1),(2,0),(1,0),(0,0)]) end;
fun loop()=case TextIO.inputLine f of NONE=>()|SOME l=>(count:=(!count)+1; if first<=(!count) andalso (!count)<=last then run l else (); loop());
val _=loop();
val _=TextIO.closeIn f;


val _=print "AXIS_DONE\n";
