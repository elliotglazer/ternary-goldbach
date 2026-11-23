open HolKernel Parse boolLib bossLib cv_transLib BlueTheory;
fun require b s = if b then () else raise Fail s;
val _ = new_theory "BlueResident";
fun readPairs path =
  let val stream = TextIO.openIn path
      fun number s = intSyntax.term_of_int (Arbint.fromString
        (String.translate (fn #"-" => "~" | c => String.str c) s))
      fun loop acc = case TextIO.inputLine stream of NONE => rev acc
        | SOME line => (case String.tokens Char.isSpace line of
            [r,i] => loop (pairSyntax.mk_pair(number r,number i)::acc)
          | _ => raise Fail path)
      val pairs = loop []
  in TextIO.closeIn stream; pairs end;
val pairty = ``:int # int``;
fun pairList pairs = listSyntax.mk_list(pairs,pairty);
fun cpu timer = let val {usr,sys} = Timer.checkCPUTimer timer
  in Time.+ (usr,sys) end;
fun seconds t = Real.toString (Time.toReal t);
fun timed f = let val clock = Timer.startCPUTimer ()
                 val value = f ()
             in (value,cpu clock) end;


val _ = intLib.ARITH_TAC;
val paths = ["roots","chirps","kernel","inputs"];
val data = map (fn p => pairList (readPairs ("../c10000-bluestein-hol/" ^ p ^ ".tsv"))) paths;
val expected = pairList (readPairs "../c10000-bluestein-hol/expected.tsv");
val tm = list_mk_comb (``blue_run``,data);
val vs = map (fn n => mk_var(n,type_of expected)) paths;
val (template,tTemplate)=timed (fn()=>
  let val rep=cv_repLib.cv_rep_for [] (list_mk_comb(``blue_run``,vs))
      val ft=cv_typeLib.from_to_thm_for (type_of tm)
  in UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft) end);
fun enc 0 = ALL_CONV
  | enc n = (RATOR_CONV(enc(n-1))) THENC (RAND_CONV EVAL);
val (shared,tShared)=timed (fn()=>
  let val three=INST(ListPair.map(fn(v,a)=> v |-> a)(List.take(vs,3),List.take(data,3))) template
  in CONV_RULE ((RAND_CONV o RAND_CONV o RATOR_CONV) (enc 3)) three end);
val (ready,tInput)=timed (fn()=>
  let val filled=INST [List.last vs |-> List.last data] shared
  in CONV_RULE ((RAND_CONV o RAND_CONV o RAND_CONV) EVAL) filled end);
val (conv,tConv)=timed(fn()=>cv_computeLib.cv_compute(cv_eqs_for(rand(rhs(concl ready)))));
val _=print("ADMISSION_CPU,"^String.concatWith "," (map seconds [tTemplate,tShared,tInput,tConv])^"\n");
fun once i =
  let val (raw,tRun)=timed(fn()=>CONV_RULE (RAND_CONV(RAND_CONV conv)) ready)
      val (decoded,tDecode)=timed(fn()=>CONV_RULE (RAND_CONV EVAL) raw)
      fun discharge(h,th)=PROVE_HYP(prove(h,SIMP_TAC std_ss [blue_mul_pre_ok])) th
      val (closed,tConsume)=timed(fn()=>
        let val th=List.foldl discharge decoded (hyp decoded)
            val (ors,axs)=Tag.dest_tag(tag th)
            val _=require(null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM") ors) "bad tags"
            val _=require(aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) expected) "mismatch"
        in th end)
      val _=print("RESIDENT_CPU,"^Int.toString i^","^String.concatWith ","(map seconds[tRun,tDecode,tConsume])^"\n")
  in closed end;
val last=List.foldl(fn(i,_)=>SOME(once i)) NONE [1,2,3,4,5];
val (_,tSave)=timed(fn()=>save_thm("blue_actual_resident_500",valOf last));
val (_,tExport)=timed(fn()=>export_theory());
val _=print("EXPORT_CPU,"^seconds tSave^","^seconds tExport^"\nRESIDENT_DONE\n");
