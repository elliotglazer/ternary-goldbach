open HolKernel Parse boolLib bossLib cv_transLib DirectRateTheory;
val _=new_theory "DirectRates";
val clock=Timer.startCPUTimer();
fun cpu()=let val {usr,sys}=Timer.checkCPUTimer clock in Time.toReal(Time.+(usr,sys)) end;
val io=TextIO.openIn "integer-samples.txt";
fun tokens()=case TextIO.inputLine io of SOME s=>String.tokens Char.isSpace s | NONE=>raise Fail "eof";
fun nn s=numSyntax.mk_numeral(Arbnum.fromString s);
fun zig s=let val neg=String.isPrefix "-" s
              val z=Arbnum.fromString(if neg then String.extract(s,1,NONE) else s)
              val m=Arbnum.+(Arbnum.+(z,z),Arbnum.fromInt(if neg then 1 else 0))
          in numSyntax.mk_numeral m end;
fun nl f row=listSyntax.mk_list(map f row,numSyntax.num);
val templates=ref ([]:(int * (term list * thm)) list);
fun encode tm = if type_of(rand tm) <> ``:num list`` then EVAL tm else
  let val (f,xs)=dest_comb tm val (items,ty)=listSyntax.dest_list xs
      val (vs,pat)=case List.find(fn (n,_)=>n=length items) (!templates) of SOME(_,p)=>p
        | NONE=>let val vs=List.tabulate(length items,fn j=>mk_var("slot"^Int.toString j,ty))
                    val pat=EVAL(mk_comb(f,listSyntax.mk_list(vs,ty)))
                    val _=templates:=(length items,(vs,pat))::(!templates)
                in (vs,pat) end
  in INST(ListPair.map(fn(v,a)=>v |-> a)(vs,items)) pat end;
fun stage label tm = let val start=cpu()
  val (f,args)=strip_comb tm
  fun fresh a j=mk_var("argument"^Int.toString j,type_of a)
  fun vars aa=ListPair.map (fn(a,j)=>fresh a j)(aa,List.tabulate(length aa,fn j=>j))
  val vs=vars args
  val rep=cv_repLib.cv_rep_for [] (list_mk_comb(f,vs))
  val ft=cv_typeLib.from_to_thm_for(type_of tm)
  val ctx=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
  val concrete=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args)) ctx
  fun goargs 0=ALL_CONV | goargs n=RATOR_CONV(goargs(n-1)) THENC RAND_CONV encode
  val base=CONV_RULE(RAND_CONV (RAND_CONV (goargs(length args)))) concrete
  val (cvf,cvargs)=strip_comb(rand(rhs(concl base)))
  val conv=cv_computeLib.cv_compute(cv_eqs_for(list_mk_comb(cvf,vars cvargs)))
  val _=print("SETUP "^label^" "^Real.toString(cpu()-start)^"\n")
  fun run i=let val t=cpu()
    val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) base
    val b=cpu() val dec=CONV_RULE(RAND_CONV EVAL) raw
    val th=List.foldl(fn(h,t)=>PROVE_HYP(prove(h,SIMP_TAC(srw_ss()) [])) t) dec (hyp dec)
    val (oracles,axs)=Tag.dest_tag(tag th)
    val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM")oracles
          andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) T then () else raise Fail label
    in print("SLAB "^label^" "^Int.toString i^" "^Real.toString(b-t)^" "^Real.toString(cpu()-b)^"\n") end
  in run end;


fun test i=let val begin=cpu() val [id,depth,width,prec]=tokens()
 val xs=nl nn (tokens()) val ys=nl nn (tokens())
 val es=nl nn (tokens()) val fs=nl nn (tokens())
 val common=[nn depth,nn width,nn prec,xs,ys,es,fs]
 fun make n=stage (id^"_"^n) (list_mk_comb(``dtest``,nn n::common))
 val _=print("ADMIT "^id^" "^Real.toString(cpu()-begin)^"\n")
 val t=cpu() val runs=map make ["0","128","129"]
 val _=print("PREP "^id^" "^Real.toString(cpu()-t)^"\n")
 val _=List.app(fn j=>List.app(fn f=>f j)(if j mod 2=0 then runs else rev runs))[0,1,2]
 val _=if i<>0 then () else let val (zs,ty)=listSyntax.dest_list es
  val damaged=listSyntax.mk_list(List.take(zs,128)@[numSyntax.mk_numeral(Arbnum.+(numSyntax.dest_numeral(List.last zs),Arbnum.one))],ty)
  in stage "bad_last" (list_mk_comb(``dreject``,[nn depth,nn width,nn prec,xs,ys,damaged,fs])) 0 end
 in () end;
val _=List.app test [0,1,2,3,4,5];
val _=TextIO.closeIn io;
val _=print "DIRECT_RATE_DONE\n";