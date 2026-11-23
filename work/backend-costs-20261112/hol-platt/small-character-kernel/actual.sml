open HolKernel Parse boolLib bossLib cv_transLib SmallFFTTheory;
val _=new_theory "SmallFFTActual";
val _=intLib.ARITH_TAC;
val input=TextIO.openIn "actual.txt";
fun line()=String.tokens Char.isSpace(valOf(TextIO.inputLine input));
fun number s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~" | c=>String.str c) s));
fun pairs (a::b::xs)=pairSyntax.mk_pair(number a,number b)::pairs xs
  | pairs []=[] | pairs _=raise Fail "odd input";
fun vector xs=listSyntax.mk_list(xs,``:int # int``);
fun alternating (x::y::xs)=x::alternating xs | alternating xs=xs;
fun tree []=[] | tree [x]=[vector [x]] | tree xs=vector xs::tree(alternating xs);
val f=``SmallFFT$work``;
fun nu n=numSyntax.mk_numeral(Arbnum.fromInt n);
val s=intSyntax.term_of_int(Arbint.fromString "260740604970814219042361048116400404614587954389239840081425977517360806369707098391474864128");
val h=intSyntax.term_of_int(Arbint.fromString "130370302485407109521180524058200202307293977194619920040712988758680403184853549195737432064");
fun vars args=ListPair.map(fn (a,j)=>mk_var("input"^Int.toString j,type_of a))(args,List.tabulate(length args,fn j=>j));
val clock=Timer.startCPUTimer();
fun cpu()=let val {usr,sys}=Timer.checkCPUTimer clock in Time.toReal(Time.+(usr,sys)) end;
fun stage required=let
  val [name,m,n]=line()
  val mode=valOf(Int.fromString m)
  val inp=pairs(line()) and w=pairs(line()) and ex=pairs(line())
  val _=if required=name andalso length inp=valOf(Int.fromString n) andalso length inp=length ex
    andalso (if mode=0 then 2*length w=length inp else length w=length inp) then () else raise Fail "length"
  val levels=listSyntax.mk_list(if mode=0 then tree w else [],``:(int # int) list``)
  val args=[nu mode,s,h,levels,vector(if mode=0 then [] else w),vector inp]
  val expect=vector ex
  val tm=list_mk_comb(f,args)
  val vs=vars args
  val start=cpu()
  val rep=cv_repLib.cv_rep_for [] (list_mk_comb(f,vs))
  val ft=cv_typeLib.from_to_thm_for(type_of tm)
  val template=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
  val inst=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args)) template
  fun enc 0=ALL_CONV | enc n=RATOR_CONV(enc(n-1)) THENC RAND_CONV EVAL
  val base=CONV_RULE(RAND_CONV(RAND_CONV(enc(length args)))) inst
  val (cf,aa)=strip_comb(rand(rhs(concl base)))
  val conv=cv_computeLib.cv_compute(cv_eqs_for(list_mk_comb(cf,vars aa)))
  val t=cpu()
  val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) base
  val stop=cpu()
  val dec=CONV_RULE(RAND_CONV EVAL) raw
  val th=List.foldl(fn(a,z)=>PROVE_HYP(prove(a,SIMP_TAC(srw_ss())[])) z) dec (hyp dec)
  val (oracles,axs)=Tag.dest_tag(tag th)
  val _=if null(hyp th) andalso null axs andalso List.all(fn a=>a="DISK_THM") oracles andalso
    aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) expect then () else raise Fail name
  val _=save_thm("q10000_"^name,th)
in print("ACTUAL "^name^" "^n^" "^String.concatWith " " (map Real.toString[t-start,stop-t,cpu()-stop])^"\n") end;
val _=List.app stage ["pre","forward","pointwise","inverse","post"];
val _=if Option.isSome(TextIO.inputLine input) then raise Fail "trailing input" else TextIO.closeIn input;
val _=export_theory();
val _=print "FFT_DONE\n";
