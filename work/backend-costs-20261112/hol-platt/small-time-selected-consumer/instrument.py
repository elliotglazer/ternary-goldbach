from pathlib import Path
p=Path(__file__).parent/'batchbench.sml'
s=p.read_text()
helper="""fun truthimp th = MP th TRUTH handle HOL_ERR _ => th;
fun timed_cv tm =
 let val rep=cv_repLib.cv_rep_for [] tm
     val cvtm=cv_miscLib.cv_rep_cv_tm(concl rep)
     val solve=cv_computeLib.cv_compute(cv_eqs_for cvtm)
     val raw=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep)(cv_typeLib.from_to_thm_for(type_of tm)))
     val timer=Timer.startCPUTimer()
     val out=CONV_RULE(RAND_CONV(RAND_CONV solve))raw
     val {usr,sys}=Timer.checkCPUTimer timer
     val fin=truthimp(DISCH_ALL(CONV_RULE(RAND_CONV EVAL)(UNDISCH_ALL(truthimp(DISCH_ALL out)))))
 in (fin,Time.toString(Time.+(usr,sys))) end;
"""
s=s.replace('fun run l k=',helper+'fun run l k=').replace('val th=cv_eval tm','val (th,kern)=timed_cv tm').replace('Int.toString mode,Time.toString','Int.toString mode,kern,Time.toString')
p.write_text(s)
