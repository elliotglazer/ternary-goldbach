Theory ShortBench
Ancestors ShortAxis
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
fun readRow id k = let
  val [mode,n,q,rep] = map (valOf o Int.fromString) (line())
  val xs = pairs(line())
  val ys = pairs(line())
  val _ = if mode=id andalso rep=k andalso length xs=n andalso
       length ys=(if q=0 then n else n-n div q) then () else raise Fail "bad fixture"
  in (n,vector xs,vector ys) end;

val encoded = ref ([]:(term * thm) list);
fun encode tm = case List.find(fn (key,_) => aconv key tm) (!encoded) of
    SOME(_,h) => h
  | NONE => let val h0 = EVAL tm
                val h = CONV_RULE(RAND_CONV(REWRITE_CONV[cv_primTheory.cv_rep_T,cv_primTheory.cv_rep_F])) h0
            in encoded := (tm,h)::(!encoded); h end;

fun stage id label args answer = let
  val start = cpu()
  val f = ``ShortAxis$loop``
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

fun one id = let
  val (n,x,y) = readRow id 0
  val (_,u,v) = readRow id 1
  val (_,h,e) = readRow id 2
  val _ = encoded := []
  val _ = stage id "high" [nu 1,nu id,T,h,e,h,e] T 0
  val _ = if id<>0 then () else let
    val (l,_) = listSyntax.dest_list y
    val bad = vector(hd l::l)
    in stage id "bad" [nu 1,nu id,T,x,bad,u,v] F 0 end
  val reps = if n<=2 then 8192 else if n<=4 then 4096 else if n<=10 then 1024 else 256
  val realRun = stage id "full" [nu reps,nu id,T,x,y,u,v] T
  val control = stage id "control" [nu reps,nu id,F,x,y,u,v] T
  in List.app (fn j=>if j mod 2=0 then (control j;realRun j) else (realRun j;control j))
      [0,1,2,3,4,5,6] end;
val _ = List.app one (List.tabulate(17,fn j=>j));
val _ = if Option.isSome(TextIO.inputLine input) then raise Fail "trailing input" else TextIO.closeIn input;
val actual = TextIO.openIn "real.txt";
fun nextReal () = case TextIO.inputLine actual of
    SOME s => String.tokens Char.isSpace s | NONE => raise Fail "missing actual vector";
fun realOne i = let
  val [band,pair] = nextReal()
  val x = vector(pairs(nextReal()))
  val y = vector(pairs(nextReal()))
  val _ = encoded := []
  val label = "real_"^band^"_"^pair
  in stage 1 label [nu 1,nu 1,T,x,y,x,y] T i end;
val _ = List.app realOne (List.tabulate(16,fn i=>i));
val _ = if Option.isSome(TextIO.inputLine actual) then raise Fail "trailing actual inputs" else TextIO.closeIn actual;
val _ = print "SHORT_DONE\n";
