open HolKernel Parse boolLib bossLib cv_transLib BlueTheory;
fun require b s = if b then () else raise Fail s;
val _ = new_theory "BlueActual";
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
val data = map (fn p => pairList (readPairs (p ^ ".tsv"))) paths;
val expected = pairList (readPairs "expected.tsv");
val tm = list_mk_comb (``blue_run``,data);
val vs = map (fn n => mk_var(n,type_of expected)) paths;
fun evaluate () =
 let val ((conv,ctx),prep) = timed (fn () =>
        let val rep = cv_repLib.cv_rep_for [] (list_mk_comb(``blue_run``,vs))
            val ft = cv_typeLib.from_to_thm_for (type_of tm)
            val template = UNDISCH_ALL (MATCH_MP (MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
            val concrete = INST (ListPair.map (fn(v,a)=> v |-> a) (vs,data)) template
            fun enc 0 = ALL_CONV
              | enc n = (RATOR_CONV (enc (n-1))) THENC (RAND_CONV EVAL)
            val ctx = CONV_RULE ((RAND_CONV o RAND_CONV) (enc 4)) concrete
            val cvtm=rand(rhs(concl ctx))
            val _ = print ("CV_HEAD," ^ term_to_string(fst(strip_comb cvtm)) ^ "\n")
    val anomalies = find_terms (fn t => is_const t andalso #Name(dest_thy_const t)="numeric_negate") cvtm
    val _ = print ("ANOMALIES," ^ Int.toString(length anomalies) ^ "\n")
        in (cv_computeLib.cv_compute(cv_eqs_for cvtm),ctx) end)
     val (raw,exec) = timed (fn()=>CONV_RULE (RAND_CONV(RAND_CONV conv)) ctx)
     val (decoded,decode) = timed (fn()=>CONV_RULE (RAND_CONV EVAL) raw)
     fun discharge (h,th) = PROVE_HYP (prove(h,SIMP_TAC std_ss [blue_mul_pre_ok])) th
     val decoded = List.foldl discharge decoded (hyp decoded)
     val _ = require (null(hyp decoded)) "open theorem"
     val _ = require (aconv(lhs(concl decoded)) tm andalso aconv(rhs(concl decoded)) expected) "mismatch"
     val (oracles,axs) = Tag.dest_tag(tag decoded)
     val _ = require (null axs andalso List.all (fn s=>s="DISK_THM") oracles) "bad tags"
     val _ = print ("BLUE_CPU," ^ String.concatWith "," (map seconds [prep,exec,decode]) ^ "\n")
 in decoded end;
val cold=evaluate();
val warm=evaluate();
val _=save_thm("blue_actual_500",cold);
val _=export_theory();
val _=print "BLUE_REPLAY_DONE\n";


