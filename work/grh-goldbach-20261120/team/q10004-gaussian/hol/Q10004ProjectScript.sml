
Theory Q10004Project
Ancestors Q10004Compressed
Libs meter encoding cv_transLib intLib
open meter;
Definition within_def:
  (within (u:int) ([]:int list) qs <=> qs=[]) /\
  (within u (x::xs) qs <=> case qs of []=>F | q::rest =>
     ABS(x-q*u)<=u /\ within u xs rest)
End
Definition projects_def:
  (projects ([]:(num#int list) list) compact <=> compact=[]) /\
  (projects ((a,xs)::rs) compact <=> case compact of [] => F | h::tail =>
    (case h of b::ex::width::n::ws =>
      a=b /\ LENGTH xs=n /\ within (&(2**ex)) xs (words (2**width) n ws) | _=>F)
     /\ projects rs tail)
End
val _=cv_auto_trans projects_def;
fun encode label def=
 let val t=cpu()
     val [enc,_]= #2(strip_comb(concl(cv_typeLib.from_to_thm_for(type_of(lhs(concl def))))))
     val th=TRANS(AP_TERM enc def)(EVAL(mk_comb(enc,rhs(concl def))))
     val _=if closed th then () else raise Fail label
     val _=print("INPUT_CONVERT "^label^" "^Real.toString(cpu()-t)^"\n")
 in (lhs(concl def),REWR_CONV th) end;

fun check label =
 let val sf=encode ("original_"^label)(DB.fetch "Q10004All" ("grid_spans_"^label^"_def"))
     val cf=encode ("compact_"^label)(DB.fetch "Q10004Compressed" ("compressed_spans_"^label^"_def"))
     val f=``Q10004Project$projects``
     val args=map #1 [sf,cf]
     val th=encoding.produce ("project_"^label) f args (map #2 [sf,cf])
     val inv=cv_typeLib.from_to_thm_for ``:bool``
     val [_,decoder]= #2(strip_comb(concl inv))
     val decoded=TRANS(SYM(SPEC(list_mk_comb(f,args))(REWRITE_RULE[cv_typeTheory.from_to_def]inv)))
                    (CONV_RULE(RAND_CONV EVAL)(AP_TERM decoder th))
     val _=if closed decoded andalso aconv(rhs(concl decoded))boolSyntax.T then () else raise Fail label
     val _=save_thm("raw_projection_"^label,EQT_ELIM decoded)
 in print("PROJECTED "^label^"\n") end;
val _=app check ["6559","7707","5499","7659"];
