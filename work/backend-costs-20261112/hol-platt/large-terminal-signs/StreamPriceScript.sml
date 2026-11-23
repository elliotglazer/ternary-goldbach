Theory StreamPrice
Ancestors StreamCost JoinTables
Libs replay meter cv_transLib intLib
open meter;
fun enc term=EVAL(mk_comb(replay.enc_for(type_of term),term));
open replay cv_transLib;
fun joined constant encodings =
  let val args=map(rand o lhs o concl) encodings
      val vs=vars args
      val start=cpu()
      val schema=UNDISCH_ALL(REWRITE_RULE[cv_repTheory.cv_rep_def]
                             (cv_repLib.cv_rep_for [] (list_mk_comb(constant,vs))))
      fun inspect label tm=if cvSyntax.is_cv_num tm andalso can numSyntax.dest_numeral(rand tm) then ()
 else if cvSyntax.is_cv_pair tm then List.app(inspect label)(#2(strip_comb tm))
 else raise Fail ("not concrete "^label^" "^term_to_string tm)
      val _=List.app(fn(i,h)=>inspect(Int.toString i)(rhs(concl h)))(ListPair.zip(List.tabulate(length encodings,fn i=>i),encodings))
      val cvargs=List.tabulate(length args,fn j=>mk_var("input"^Int.toString j,``:cv``))
      val hyps=ListPair.map(fn(v,x)=>ASSUME(mk_eq(mk_comb(enc_for(type_of v),v),x)))(vs,cvargs)
      val skeleton=CONV_RULE(RAND_CONV(PURE_REWRITE_CONV hyps))schema
      val _=print("SCHEMA "^term_to_string(rhs(concl skeleton))^"\n")
      val cvdo=cv_computeLib.cv_compute(cv_eqs_for(rhs(concl skeleton)))
      val concrete=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args)@
            ListPair.map(fn(v,h)=>v |-> rhs(concl h))(cvargs,encodings))skeleton
      val ready=List.foldl(fn(h,eq)=>PROVE_HYP h eq)concrete encodings
      val t=cpu()
      val _=print "EVAL_ENTER\n"
      val raw=CONV_RULE(RAND_CONV cvdo)ready
      val u=cpu()
      val th=List.foldl(fn(a,z)=>PROVE_HYP(prove(a,SIMP_TAC(srw_ss())[])) z)raw(hyp raw)
      val truth=cv_primTheory.cv_rep_T
      val eq=TRANS th (SYM truth)
      val ft=cv_typeLib.from_to_thm_for ``:bool``
      val [_,dec]= #2(strip_comb(concl ft))
      val final=EQT_ELIM(PURE_REWRITE_RULE[REWRITE_RULE[cv_typeTheory.from_to_def]ft](AP_TERM dec eq))
      val _=req(closed final)"channel tag"
      val _=print("JOIN_EVAL "^String.concatWith " " (map Real.toString[t-start,u-t,cpu()-u])^"\n")
  in final end;


fun do_stream (name,bas,up,len)=
 let val rs=map replay.tuple(replay.lines(map nat)(name^"count.txt"))
     val data=replay.literal(replay.named(name^"_rows")(listSyntax.mk_list(rs,type_of(hd rs))))
     fun cv n=enc(nat(Int.toString n))
     fun run n=let val _=print("STREAM "^name^" "^Int.toString n^"\n")
        val th=joined ``StreamCost$streamrun`` [cv n,cv (4096*bas),cv (4096*up),cv len,data]
       in if n=1 then ignore(save_thm(name^"_counts",th)) else () end
 in List.app run [1,0,8,8,0] end;
val _=List.app do_stream [("low",1,33,32),("high",84184,84200,16)];
