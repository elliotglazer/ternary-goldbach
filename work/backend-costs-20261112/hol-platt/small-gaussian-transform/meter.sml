structure meter = struct
open HolKernel Parse boolLib bossLib cv_transLib;
val clock = Timer.startCPUTimer();
fun cpu() = let val {usr,sys}=Timer.checkCPUTimer clock in Time.toReal(Time.+(usr,sys)) end;
fun nat s = numSyntax.mk_numeral(Arbnum.fromString s);
fun integer s = intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~" | c=>String.str c) s));
fun pair a b = pairSyntax.mk_pair(integer a,integer b);
fun pairs (a::b::rest) = pair a b :: pairs rest
  | pairs [] = [] | pairs _ = raise Fail "incomplete complex point";
fun vector xs = listSyntax.mk_list(xs,``:int # int``);
fun vars args=ListPair.map(fn(a,i)=>mk_var("arg"^Int.toString i,type_of a))(args,List.tabulate(length args,fn i=>i));
fun closed th = let val (oracles,axs)=Tag.dest_tag(tag th)
  in null(hyp th) andalso null axs andalso List.all(fn x=>x="DISK_THM") oracles end;
fun evaluate label f args = let
  val tm=list_mk_comb(f,args)
  val vs=vars args
  val t=cpu()
  val rep=cv_repLib.cv_rep_for [] (list_mk_comb(f,vs))
  val ft=cv_typeLib.from_to_thm_for(type_of tm)
  val ctx=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
  val inst=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args)) ctx
  fun encs 0=ALL_CONV | encs n=RATOR_CONV(encs(n-1)) THENC RAND_CONV EVAL
  val base=CONV_RULE(RAND_CONV(RAND_CONV(encs(length args)))) inst
  val (cf,aa)=strip_comb(rand(rhs(concl base)))
  val conv=cv_computeLib.cv_compute(cv_eqs_for(list_mk_comb(cf,vars aa)))
  val tp=cpu()
  val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) base
  val ts=cpu()
  val dec=CONV_RULE(RAND_CONV EVAL) raw
  val th=List.foldl(fn(a,z)=>PROVE_HYP(prove(a,SIMP_TAC(srw_ss())[])) z) dec (hyp dec)
  val stop=cpu()
  val _=if closed th andalso aconv(lhs(concl th)) tm then () else raise Fail label
  val _=print("TIMED "^label^" "^String.concatWith " " (map Real.toString[tp-t,ts-tp,stop-ts])^"\n")
in th end;


end;
