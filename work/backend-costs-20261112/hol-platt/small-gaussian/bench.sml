open HolKernel Parse boolLib bossLib cv_transLib GaussTheory;
val _=intLib.ARITH_TAC;
val _=new_theory "GaussActual";
fun nat s=numSyntax.mk_numeral(Arbnum.fromString s);
fun integer s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~" | c=>String.str c) s));
fun pair a b=pairSyntax.mk_pair(integer a,integer b);
val clock=Timer.startCPUTimer();
fun cpu()=let val {usr,sys}=Timer.checkCPUTimer clock in Time.toReal(Time.+(usr,sys)) end;
fun vars args=ListPair.map(fn(a,i)=>mk_var("argument"^Int.toString i,type_of a))(args,List.tabulate(length args,fn i=>i));
fun setup f args expected=let
  val tm=list_mk_comb(f,args)
  val vs=vars args
  val rep=cv_repLib.cv_rep_for [] (list_mk_comb(f,vs))
  val ft=cv_typeLib.from_to_thm_for(type_of tm)
  val ctx=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
  val inst=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args)) ctx
  fun enc tm=CONV_RULE(RAND_CONV(REWRITE_CONV[cv_primTheory.cv_rep_T,cv_primTheory.cv_rep_F]))(EVAL tm)
  fun encs 0=ALL_CONV | encs n=RATOR_CONV(encs(n-1)) THENC RAND_CONV enc
  val base=CONV_RULE(RAND_CONV(RAND_CONV(encs(length args)))) inst
  val (cf,aa)=strip_comb(rand(rhs(concl base)))
  val conv=cv_computeLib.cv_compute(cv_eqs_for(list_mk_comb(cf,vars aa)))
  fun run()=let
    val t=cpu()
    val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) base
    val dt=cpu()-t
    val dec=CONV_RULE(RAND_CONV EVAL) raw
    val th=List.foldl(fn(a,z)=>PROVE_HYP(prove(a,SIMP_TAC(srw_ss())[])) z) dec (hyp dec)
    val (oracles,axs)=Tag.dest_tag(tag th)
    val _=if null(hyp th) andalso null axs andalso List.all(fn x=>x="DISK_THM") oracles andalso
      aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) expected then () else raise Fail "result mismatch"
  in (dt,th) end
in run end;
val fs=TextIO.openIn "full.txt";
fun next()=String.tokens Char.isSpace(valOf(TextIO.inputLine fs));
fun cells(a::b::c::d::rs)=pairSyntax.mk_pair(pair a b,pair c d)::cells rs
  | cells []=[] | cells _=raise Fail "incomplete cell";
fun full name=let
  val [c,m,p,a,b]=next()
  val ex=cells(next())
  val _=if length ex=Int.min(valOf(Int.fromString c),valOf(Int.fromString m)) then () else raise Fail "length"
  val output=listSyntax.mk_list(ex,``:(int#int)#(int#int)``)
  val (dt,th)=setup ``Gauss$produce`` [nat c,nat m,nat p,pair a b] output ()
  val _=save_thm(name,th)
in print("FULL "^c^" "^m^" "^p^" "^Int.toString(length ex)^" "^Real.toString dt^"\n") end;
val _=List.app full ["c3_buckets","c10000_buckets"];
val _=if Option.isSome(TextIO.inputLine fs) then raise Fail "extra input" else TextIO.closeIn fs;
val ins=TextIO.openIn "bench.txt";
fun panel line=let
  val [id,c,m,p,a,b,x,y,reps]=String.tokens Char.isSpace line
  val args=[nat c,nat m,nat p,pair a b]
  fun make flag digest r answer=setup ``Gauss$test`` (args@[digest,flag,nat r]) answer
  val _=if id="0" then (ignore(make T (pair "0" "0") "1" F ());print "DAMAGED_OK\n") else ()
  val doFull=make T (pair x y) reps T
  val control=make F (pair x y) reps T
  fun run j=let
    val (f,t)=if j mod 2=0 then let val (dt,_)=doFull() in (dt,#1(control())) end
                 else let val (dt,_)=control() in (#1(doFull()),dt) end
  in print("GAUSS "^id^" "^Int.toString j^" "^reps^" "^Real.toString f^" "^Real.toString t^"\n") end
in List.app run [0,1,2] end;
fun loop()=case TextIO.inputLine ins of NONE=>TextIO.closeIn ins | SOME line=>(panel line;loop());
val _=loop();
val _=export_theory();
val _=print "GAUSS_DONE\n";
