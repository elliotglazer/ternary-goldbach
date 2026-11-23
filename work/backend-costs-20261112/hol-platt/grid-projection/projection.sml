structure projection = struct
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

fun run full =
  let val t0=cpu()
      val four=stream_template 16 and one=stream_template 1
      val setup=cpu()-t0
      val input=TextIO.openIn "source.hex"
      val reading=ref 0.0 and checking=ref 0.0 and storeTime=ref 0.0
      val records=ref 0 and samples=ref 0 and admitted=ref 0 and total=ref 0
      fun words s = String.tokens Char.isSpace s
      fun line()=valOf(TextIO.inputLine input)
      fun hex s=numSyntax.mk_numeral(Arbnum.fromHexString s)
      fun asint s=valOf(Int.fromString s)
      fun block i =
        case TextIO.inputLine input of NONE => () | SOME row =>
        let val [label,k,w,e,n]=words row
            val raw=line() and short=line()
            val id=asint k and size=asint n
            val _=require(label=List.nth(["3","6667","11","9091"],i div 1331) andalso
                          id=i mod 1331 andalso size=(if id=1330 then 1 else 64))"tile identity"
            val _=total:= !total+1
            val selected=full orelse id mod 83=0 orelse id=1330
        in if not selected then block(i+1) else
          let val start=cpu()
              val xs=map hex (words raw) and hs=map nat (words short)
              val bounds=map nat [w,e,n]
              val vals=bounds@xs@hs
              val eval=if size=1 then one else four
              val t1=cpu()
              val proved=eval vals true
              val t2=cpu()
              val requested=list_mk_comb(``Project$project_ok``,bounds@[natlist xs,natlist hs])
              val _=require(aconv requested (concl proved)) "concrete tile identity"
              val _=if id=0 orelse id=1330 then
                let val key=label^"_"^k
                    val bad= numSyntax.mk_numeral(Arbnum.+(numSyntax.dest_numeral(hd hs),Arbnum.one))
                    val corrupt=eval(bounds@xs@(bad::tl hs))false
                    val _=save_thm("project_"^key,proved)
                    val _=save_thm("reject_"^key,corrupt)
                in admitted:= !admitted+1 end else ()
              val _=reading:= !reading+t1-start
              val _=checking:= !checking+t2-t1
              val _=storeTime:= !storeTime+cpu()-t2
              val _=samples:= !samples+size
              val _=records:= !records+1
              val _=if full andalso id mod 300=0 then
                      print("PROJECTION_AT "^label^" "^k^" "^Real.toString(cpu()-t0)^"\n") else ()
          in block(i+1) end
        end
      val _=block 0
      val _=TextIO.closeIn input
      val _=require(!total=5324 andalso !admitted=8 andalso
              (if full then !samples=340484 andalso !records=5324
               else !records=72 andalso !samples=4356)) "projection coverage"
      val _=print("PROJECTION_COUNTS "^String.concatWith " " (map Int.toString[!records,!samples,!admitted])^"\n")
      val _=print("PROJECTION_CPU "^String.concatWith " " (map Real.toString[setup,!reading,!checking,!storeTime,cpu()-t0])^"\n")
  in () end;
end;
