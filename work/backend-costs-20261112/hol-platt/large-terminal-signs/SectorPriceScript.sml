Theory SectorPrice
Ancestors Sector JoinTables
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

fun measure p =
 let val rows=replay.lines(map integer)("data"^p^".txt")
     val masks=map replay.tuple(replay.lines(map nat)("sector"^p^".txt"))
     val [f,g,h,i,e,j,k,l,m,v]=hd(replay.lines(map integer)("cfg"^p^".txt"))
     val _=()
     val cfg=replay.tuple[f,g,e,h,i,j,k,l,m,v]
     val [[sum]]=replay.lines(map integer)("sum"^p^".txt")
     val tuples=map replay.tuple rows
     fun chunks []=[] | chunks xs=let val n=Int.min(64,length xs) in listSyntax.mk_list(List.take(xs,n),type_of(hd xs))::chunks(List.drop(xs,n)) end
     fun list xs=listSyntax.mk_list(xs,type_of(hd xs))
     val t0=cpu()
     val data=replay.literal(replay.named("inputs_"^p)(list(chunks tuples)))
     val expected=replay.literal(replay.named("expected_"^p)(list masks))
     val c=enc cfg and sumcode=enc sum
     val _=print("ADMIT "^p^" "^Real.toString(cpu()-t0)^"\n")
     fun run n mode=let val _=print("TERMINAL "^p^" "^Int.toString n^" "^Bool.toString mode^"\n")
            val proof=joined ``Sector$sector_trial`` [data,expected,c,sumcode,enc(nat(if mode then "1" else "0")),enc(nat(Int.toString n))]
         in if n=1 then ignore(save_thm("run_"^p^"_"^Bool.toString mode,proof)) else () end
 in List.app(fn(n,m)=>run n m)[(1,false),(1,true),(32,true),(32,false),(32,false),(32,true),(32,true),(32,false)] end;
val _=List.app measure ["24","28","81"];


