structure keptprojection = struct
open HolKernel Parse boolLib bossLib cv_transLib meter;

fun require p s = if p then () else raise Fail s;
fun nvar s = mk_var(s,``:num``);
fun natlist xs = listSyntax.mk_list(xs,``:num``);
fun stream_template count =
  let val w=nvar "width" and e=nvar "exponent" and n=nvar "count"
      fun vector prefix = List.tabulate(count,fn i => nvar(prefix^Int.toString i))
      val xs=vector "raw" and ys=vector "short"
      val generic=list_mk_comb(``Project$project_ok``,[w,e,n,natlist xs,natlist ys])
      val rep=cv_repLib.cv_rep_for [] generic
      val schema=UNDISCH_ALL(REWRITE_RULE[cv_repTheory.cv_rep_def]rep)
      val base=List.foldl(fn(p,th)=>PROVE_HYP(prove(p,SIMP_TAC(srw_ss())[]))th) schema (hyp schema)
      val cvdo=cv_computeLib.cv_compute(cv_eqs_for(rhs(concl base)))
      val variables=[w,e,n]@xs@ys
      val inv=REWRITE_RULE[cv_typeTheory.from_to_def] cv_typeTheory.from_to_bool
      val from_to=PURE_REWRITE_RULE[inv] o AP_TERM ``cv$c2b``
  in fn args => fn expected =>
    let val f=INST(ListPair.map(fn(v,a)=>v |-> a)(variables,args)) base
        val result=CONV_RULE(RAND_CONV cvdo) f
        val answer=if expected then cv_primTheory.cv_rep_T else cv_primTheory.cv_rep_F
        val eq=from_to (TRANS result (SYM answer))
        val th=if expected then EQT_ELIM eq else EQF_ELIM eq
        val _=require(closed th)"projection tag"
    in th end
  end;


fun run () =
 let val t0=cpu() val schema=Vector.tabulate(16,fn i=>stream_template(i+1))
     val start=cpu() val inp=TextIO.openIn "retained.hex"
     val numtime=ref 0.0 and evaltime=ref 0.0
     fun words s=String.tokens Char.isSpace s
     fun next()=words(valOf(TextIO.inputLine inp))
     fun go tiles fields bad =
       case TextIO.inputLine inp of NONE => (tiles,fields,bad) | SOME s =>
       let val t=cpu()
           val [lab,ix,mask,w,e,n]=words s
           val count=valOf(Int.fromString n)
           val a=map (numSyntax.mk_numeral o Arbnum.fromHexString) (next())
           val b=map nat (next())
           val params=map nat [w,e,n]
           val _=require(length a=(count+3) div 4 andalso length b=length a) "word count"
           val check=Vector.sub(schema,length a-1)
           val t1=cpu()
           val th=check(params@a@b)true
           val t2=cpu()
           val wanted=list_mk_comb(``Project$project_ok``,params@[natlist a,natlist b])
           val _=require(aconv wanted(concl th)) "projection conclusion"
           val control=tiles mod 1100=0
           val _=if control then
             let val b0=numSyntax.mk_numeral(Arbnum.+(numSyntax.dest_numeral(hd b),Arbnum.one))
                 val wrong=check(params@a@(b0::tl b))false
             in ignore(save_thm("admit_"^lab^"_"^ix,th)); ignore(save_thm("reject_"^lab^"_"^ix,wrong)) end else ()
           val _=numtime:= !numtime+t1-t
           val _=evaltime:= !evaltime+t2-t1
       in go (tiles+1) (fields+count) (if control then bad+1 else bad) end
     val (tiles,fields,bad)=go 0 0 0
     val _=TextIO.closeIn inp
     val _=require(tiles=5312 andalso fields=71325 andalso bad=(tiles+1099) div 1100) "projection total"
     val _=print("RETAINED_PROJECTION "^Int.toString tiles^" "^Int.toString fields^" "^Int.toString bad^" "^
       String.concatWith " " (map Real.toString [start-t0,!numtime,!evaltime,cpu()-t0])^"\n")
 in () end;
end;
