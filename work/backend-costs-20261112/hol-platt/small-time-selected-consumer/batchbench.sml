open HolKernel Parse boolLib bossLib cv_transLib GenuineBatchTheory;
val leaf=Array.array(65536,NONE:term option);
fun literal s=let val n=Arbnum.fromHexString s val k=Arbnum.toInt n in case Array.sub(leaf,k) of
  SOME v=>v | NONE=>let val v=numSyntax.mk_numeral n in Array.update(leaf,k,SOME v);v end end;
val levels=Vector.tabulate(24,fn k=>mk_comb(``treeword``,numSyntax.term_of_int k));
fun packed s=let val n=String.size s val size=(n+3) div 4
  fun width w=if w>=size then w else width(2*w)
  fun get j=if j>=size then literal "0" else
      let val z=n-4*j val i=Int.max(0,z-4) in literal(String.substring(s,i,z-i)) end
  fun join n k j=if j>=size then literal "0" else if n=1 then get j else
      list_mk_comb(Vector.sub(levels,k-1),[join(n div 2)(k-1)j,join(n div 2)(k-1)(j+n div 2)])
  fun lg n=if n=1 then 0 else 1+lg(n div 2)
  val w=width 1 in join w (lg w) 0 end;
fun integer s=if String.isPrefix "-" s then intSyntax.mk_negated(intSyntax.mk_injected(packed(String.extract(s,1,NONE)))) else intSyntax.mk_injected(packed s);
fun truthimp th = MP th TRUTH handle HOL_ERR _ => th;
fun timed_cv tm =
 let val rep=cv_repLib.cv_rep_for [] tm
     val cvtm=cv_miscLib.cv_rep_cv_tm(concl rep)
     val solve=cv_computeLib.cv_compute(cv_eqs_for cvtm)
     val raw=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep)(cv_typeLib.from_to_thm_for(type_of tm)))
     val timer=Timer.startCPUTimer()
     val out=CONV_RULE(RAND_CONV(RAND_CONV solve))raw
     val {usr,sys}=Timer.checkCPUTimer timer
     val fin=truthimp(DISCH_ALL(CONV_RULE(RAND_CONV EVAL)(UNDISCH_ALL(truthimp(DISCH_ALL out)))))
 in (fin,Time.toString(Time.+(usr,sys))) end;
fun run l k=
 let val inp=TextIO.openIn("b-"^l^"-"^Int.toString k^".hex")
     fun lines ()=case TextIO.inputLine inp of NONE => [] | SOME s=>String.tokens Char.isSpace s::lines()
     val cols::rows=lines() val _=TextIO.closeIn inp
     val args=map integer cols
     val spec=listSyntax.mk_list(map (pairSyntax.list_mk_pair o map packed) rows,``:num # num # num # num # num # num # num``)
     fun evalmode mode=let val tm=list_mk_comb(``batchhead``,[numSyntax.term_of_int mode,numSyntax.term_of_int k,spec]@args)
       val wall=Time.now() val timer=Timer.startCPUTimer() val (th,kern)=timed_cv tm val {usr,sys}=Timer.checkCPUTimer timer val (o1,axs)=Tag.dest_tag(tag th)
       val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM")o1 andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) boolSyntax.T then () else raise Fail "incorrect genuine batch"
       in print(String.concatWith "," [l,Int.toString k,Int.toString mode,kern,Time.toString(Time.+(usr,sys)),Time.toString(Time.-(Time.now(),wall))]^"\n");TextIO.flushOut TextIO.stdOut end
 in List.app evalmode (if l="3" orelse l="11" then [1,2] else [2,1]) end;
val _=List.app(fn k=>List.app(fn l=>run l k)["3","6667","11","9091"])[0,2,4];
val _=print "SELECT_DONE\n";
