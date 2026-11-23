Theory SinkBench
Ancestors ShortSink
Libs cv_transLib intLib

val clock = Timer.startCPUTimer();
fun cpu () = let val {usr,sys} = Timer.checkCPUTimer clock
             in Time.toReal(Time.+(usr,sys)) end;
val input = TextIO.openIn "rows.txt";
fun line () = case TextIO.inputLine input of
    SOME s => String.tokens Char.isSpace s | NONE => raise Fail "missing input";
fun integer s = intSyntax.term_of_int
    (Arbint.fromString(String.translate(fn #"-" => "~" | c => String.str c) s));
fun pairs (a::b::rest) = pairSyntax.mk_pair(integer a,integer b)::pairs rest
  | pairs [] = [] | pairs _ = raise Fail "odd input";
fun vector ps = listSyntax.mk_list(ps,``:int # int``);
fun nu i = numSyntax.mk_numeral(Arbnum.fromInt i);
val encoded = ref ([]:(term * thm) list);
fun encode tm = case List.find(fn (key,_) => aconv key tm) (!encoded) of
    SOME(_,h) => h
  | NONE => let val h0 = EVAL tm
                val h = CONV_RULE(RAND_CONV(REWRITE_CONV[cv_primTheory.cv_rep_T,cv_primTheory.cv_rep_F])) h0
            in encoded := (tm,h)::(!encoded); h end;

fun stage id label args answer = let
  val start = cpu()
  val f = ``ShortSink$ss_loop``
  val tm = list_mk_comb(f,args)
  fun vars aa = ListPair.map(fn (a,j) => mk_var("argument"^Int.toString j,type_of a))
    (aa,List.tabulate(length aa,fn j=>j))
  val variables = vars args
  val rep = cv_repLib.cv_rep_for [] (list_mk_comb(f,variables))
  val ft = cv_typeLib.from_to_thm_for(type_of tm)
  val ctx = UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
  val inst = INST(ListPair.map (fn (v,a)=> v |-> a) (variables,args)) ctx
  fun goargs 0 = ALL_CONV
    | goargs n = RATOR_CONV(goargs(n-1)) THENC RAND_CONV encode
  val base = CONV_RULE(RAND_CONV(RAND_CONV(goargs(length args)))) inst
  val (cf,ars) = strip_comb(rand(rhs(concl base)))
  val conv = cv_computeLib.cv_compute(cv_eqs_for(list_mk_comb(cf,vars ars)))
  val _ = print ("SETUP "^Int.toString id^" "^label^" "^Real.toString(cpu()-start)^"\n")
  fun run trial = let val t = cpu()
    val raw = CONV_RULE(RAND_CONV(RAND_CONV conv)) base
    val stop = cpu()
    val dec = CONV_RULE(RAND_CONV EVAL) raw
    val th = List.foldl(fn(h,z) => PROVE_HYP(prove(h,SIMP_TAC(srw_ss()) [])) z) dec (hyp dec)
    val (oracles,axs) = Tag.dest_tag(tag th)
    val _ = if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM") oracles
      andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) answer then ()
      else raise Fail("kernel result mismatch "^Int.toString id^" "^label)
    in print("SHORT "^Int.toString id^" "^label^" "^term_to_string(hd args)^" "^
         Int.toString trial^" "^Real.toString(stop-t)^"\n") end
  in run end;


val fIn=TextIO.openIn "factors.txt";
fun getf ()=vector(pairs(String.tokens Char.isSpace(valOf(TextIO.inputLine fIn))));
val fs=getf(); val gs=getf();
fun nat v=numSyntax.mk_numeral(Arbnum.fromString v);
fun br [x,y,p,q,a,e]=pairSyntax.list_mk_pair [integer x,integer y,integer p,integer q,nat a,integer e]
  | br _=raise Fail "row";
fun panel id=let val [n,q,m,good,bad]=line()
 val out=pairSyntax.mk_pair(nat good,nat bad)
 val rows=listSyntax.mk_list(List.tabulate(valOf(Int.fromString m),fn _=>br(line())),``:int # int # int # int # num # int``)
 val _=encoded:=[]
 val reps=if valOf(Int.fromString m)<12 then 128 else 32
 fun trial mode ans=stage id ("s"^Int.toString mode) [nu reps,nu mode,fs,gs,rows,ans] T
 val ctr=trial 0 out; val quick=trial 1 out; val full=trial 2 out
 val _=stage id "damage" [nu 1,nu 1,fs,gs,rows,pairSyntax.mk_pair(nat good,nat "1")] F 0
 in List.app(fn j=>if j mod 2=0 then (ctr j;quick j;full j) else (full j;quick j;ctr j)) [0,1,2,3,4] end;
val _=List.app panel (List.tabulate(13,fn j=>j));
val _=print "SINK_DONE\n";
