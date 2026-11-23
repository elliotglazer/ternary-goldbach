open HolKernel Parse boolLib bossLib cv_transLib SmallFFTTheory;
val _ = new_theory "SmallFFTTrial";
val _ = intLib.ARITH_TAC;
val input = TextIO.openIn "panels.txt";
fun nat s = numSyntax.mk_numeral (Arbnum.fromString s);
fun intt s = intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-" => "~" | c=>String.str c) s));
fun pair a b = pairSyntax.mk_pair(intt a,intt b);
fun vargs args = ListPair.map (fn (x,i)=>mk_var("arg"^Int.toString i,type_of x))
  (args,List.tabulate(length args,fn i=>i));
val timer=Timer.startCPUTimer();
fun cpu()=let val {usr,sys}=Timer.checkCPUTimer timer in Time.toReal(Time.+(usr,sys)) end;
fun prep args answer = let
  val f = ``SmallFFT$panel``
  val vs = vargs args
  val tm = list_mk_comb(f,args)
  val rep = cv_repLib.cv_rep_for [] (list_mk_comb(f,vs))
  val ft = cv_typeLib.from_to_thm_for(type_of tm)
  val template = UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
  val inst = INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args)) template
  fun enc tm = CONV_RULE(RAND_CONV(REWRITE_CONV[cv_primTheory.cv_rep_T,cv_primTheory.cv_rep_F])) (EVAL tm)
  fun encs 0 = ALL_CONV | encs n = RATOR_CONV(encs(n-1)) THENC RAND_CONV enc
  val base = CONV_RULE(RAND_CONV(RAND_CONV(encs(length args)))) inst
  val (cf,aa) = strip_comb(rand(rhs(concl base)))
  val _ = if exists (can boolSyntax.dest_cond) (List.concat(map (find_terms (can boolSyntax.dest_cond)) aa))
          then raise Fail ("residual conditional in CV argument: "^term_to_string(rand(rhs(concl base)))) else ()
  val conv = cv_computeLib.cv_compute(cv_eqs_for(list_mk_comb(cf,vargs aa)))
  fun run()=let
    val t=cpu()
    val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) base
    val dt=cpu()-t
    val dec=CONV_RULE(RAND_CONV EVAL) raw
    val th=List.foldl(fn(h,z)=>PROVE_HYP(prove(h,SIMP_TAC(srw_ss())[]) ) z) dec (hyp dec)
    val (oracles,axs)=Tag.dest_tag(tag th)
    val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM") oracles andalso
      aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) answer then () else raise Fail "panel result"
  in dt end
  in run end;
fun bound name otherwise = case OS.Process.getEnv name of SOME s=>valOf(Int.fromString s) | NONE=>otherwise;
val first=bound "FFT_FIRST" 0 and last=bound "FFT_LAST" 1000;
fun panel line=let
  val [ix,mode,d,p,e,fill,a,b,x,y,u,v,reps]=String.tokens Char.isSpace line
  val id=valOf(Int.fromString ix)
  fun make flag r fixed answer=prep ([nat mode,nat d,nat p,nat e,nat fill,pair a b,flag,nat r,
                                       if fixed then pair x y else pair "0" "0",pair u v]) answer
  fun go()=let
    val _=if id=0 then print("DAMAGED "^Real.toString(make T "1" false F ())^"\n") else ()
    val full=make T reps true T and control=make F reps true T
    fun trial j=let val (f,c)=if j mod 2 = 0 then let val t=full() in (t,control()) end
                              else let val t=control() in (full(),t) end
                in print("FFT_PANEL "^ix^" "^Int.toString j^" "^reps^" "^Real.toString f^" "^Real.toString c^"\n") end
  in List.app trial [0,1,2] end
  in if first<=id andalso id<=last then go() else () end;
fun read()=case TextIO.inputLine input of NONE=>TextIO.closeIn input | SOME line=>(panel line;read());
val _=read();
val _=print "FFT_DONE\n";
