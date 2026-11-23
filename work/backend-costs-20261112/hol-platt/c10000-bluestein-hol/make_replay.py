from pathlib import Path
import re
here=Path(__file__).resolve().parent
p=here/'BlueScript.sml'
s=p.read_text()
zipdef=s[s.index('Definition blue_zip_def:'):s.index('Definition blue_fft_def:')]
s=s.replace(zipdef,''.join(zipdef.replace('blue_zip_def','blue_zip_'+name+'_def').replace('blue_zip f','blue_zip_'+name).replace('f x y', 'blue_'+name+' x y') for name in ('mul','add','sub')))
for name in ('mul','add','sub'):
    s=s.replace('blue_zip blue_'+name,'blue_zip_'+name)
s=s.replace('MAP blue_conj roots','blue_conjs roots')
s=s.replace('Definition blue_run_def:',"""Definition blue_conjs_def:
  (blue_conjs [] = []) /\
  (blue_conjs (x::xs) = blue_conj x::blue_conjs xs)
End
Definition blue_run_def:""".replace('/  ','/\\\n  '))
p.write_text(s)
legacy=(here.parent/'c10004-hol-replay/replay_inst.sml').read_text()
read=legacy[legacy.index('fun readPairs'):legacy.index('fun rootRows')]
time=legacy[legacy.index('fun cpu'):legacy.index('(* Every call')]
sml="""open HolKernel Parse boolLib bossLib cv_transLib BlueTheory;
fun require b s = if b then () else raise Fail s;
val _ = new_theory "BlueActual";
"""+read+time+"""
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
        in (cv_computeLib.cv_compute(cv_eqs_for cvtm),ctx) end)
     val (raw,exec) = timed (fn()=>CONV_RULE (RAND_CONV(RAND_CONV conv)) ctx)
     val (decoded,decode) = timed (fn()=>CONV_RULE (RAND_CONV EVAL) raw)
     val _ = require (null(hyp decoded)) "open theorem"
     val _ = require (aconv(lhs(concl decoded)) tm andalso aconv(rhs(concl decoded)) expected) "mismatch"
     val (oracles,axs) = Tag.dest_tag(tag decoded)
     val _ = require (null axs andalso List.all (fn s=>s="DISK_THM") oracles) "bad tags"
     val _ = print ("BLUE_CPU," ^ String.concatWith "," (map seconds [prep,exec,decode]) ^ "\\n")
 in decoded end;
val cold=evaluate();
val warm=evaluate();
val _=save_thm("blue_actual_500",cold);
val _=export_theory();
val _=print "BLUE_REPLAY_DONE\\n";
"""
(here/'replay.sml').write_text(sml)
