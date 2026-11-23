open HolKernel Parse boolLib bossLib cv_transLib FusedTheory GaussTheory;
val _ = intLib.ARITH_TAC;
val _ = new_theory "FusedActual";
val clock = Timer.startCPUTimer();
fun cpu() = let val {usr,sys}=Timer.checkCPUTimer clock in Time.toReal(Time.+(usr,sys)) end;
fun nat s = numSyntax.mk_numeral(Arbnum.fromString s);
fun integer s = intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~" | c=>String.str c) s));
fun pair a b = pairSyntax.mk_pair(integer a,integer b);
fun pairs (a::b::rest) = pair a b :: pairs rest
  | pairs [] = [] | pairs _ = raise Fail "incomplete complex point";
fun vector xs = listSyntax.mk_list(xs,``:int # int``);
val input = TextIO.openIn "actual.txt";
fun line() = String.tokens Char.isSpace(valOf(TextIO.inputLine input));
val [pp,mm,qr,qi] = line();
val p = nat pp and m = nat mm and q = pair qr qi;
fun readvec count =
  let val xs=pairs(line()) in if length xs=count then vector xs else raise Fail "vector length" end;
val roots=readvec 512 and chirps=readvec 500 and kernel=readvec 1024 and expected=readvec 1600;
val _=if Option.isSome(TextIO.inputLine input) then raise Fail "trailing data" else TextIO.closeIn input;

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

val args=[p,m,q,roots,chirps,kernel];
val direct=evaluate "fused" ``Fused$fused`` args;
val _=if aconv(rhs(concl direct)) expected then () else raise Fail "fused outputs";
val _=save_thm("gaussian_to_primitive_characters",direct);

val buckets=evaluate "buckets" ``Gauss$produce`` [nat "10000",m,p,q];
val tab=rhs(concl buckets);
val _=if length(#1(listSyntax.dest_list tab))=5303 then () else raise Fail "bucket count";
val rest=[p,roots,chirps,kernel];
val finish=evaluate "after" ``Fused$after_table`` (rest@[tab]);
val start=cpu();
val lifted=AP_TERM (list_mk_comb(``Fused$after_table``,rest)) buckets;
val unfold=REWR_CONV fused_def (lhs(concl direct));
val composed=TRANS unfold (TRANS lifted finish);
val _=if closed composed andalso aconv(concl composed)(concl direct) then () else raise Fail "two paths disagree";
val _=save_thm("gaussian_to_primitive_characters_split",composed);
val _=print("COMPOSE "^Real.toString(cpu()-start)^"\n");
val _=export_theory();
val _=print "FUSED_DONE\n";
