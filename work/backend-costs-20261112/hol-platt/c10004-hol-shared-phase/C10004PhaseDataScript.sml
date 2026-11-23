Theory C10004PhaseData
Ancestors C10004Shared
Libs intLib intReduce cv_transLib

val clock = Timer.startCPUTimer ();
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

val phaseRows = readPairs "phases.tsv";
val _ = if length phaseRows = 2301 then () else raise Fail "phase count";
val phaseTm = pairList phaseRows;
val phaseDef = new_definition ("actual_phase_def",
  mk_eq(mk_var("actual_phase",type_of phaseTm),phaseTm));
val enc = cv_typeLib.from_term_for (type_of phaseTm);
val rep = TRANS (AP_TERM enc phaseDef) (EVAL (mk_comb(enc,phaseTm)));
val _ = cv_transLib.cv_eqs_for (rhs (concl rep));
val _ = save_thm("actual_phase_encoding",rep);
val {usr,sys} = Timer.checkCPUTimer clock;
val _ = print ("PHASE_CACHE_CPU," ^ Real.toString(Time.toReal(Time.+(usr,sys))) ^ "\n");
