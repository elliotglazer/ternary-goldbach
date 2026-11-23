Theory MassPrice
Ancestors MassSink JoinTables
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

fun localrun t =
 let fun rs name=replay.lines(map integer)(t^name^".txt")
     fun il name=let val vs=map replay.tuple(rs name) in replay.literal(replay.named(t^name)(listSyntax.mk_list(vs,type_of(hd vs)))) end
     val [sc,mass,chk]=hd(replay.lines(fn x=>x)(t^"cfg.txt"))
     val xs=il "xs" and ws=il "ws"
     val size=if String.isSuffix "1024" t then 1024 else if String.isSuffix "256" t then 256 else 64
     fun trial (q,m)= let val n=if q=1024 then 131072 div size else q val _=print("FUSED "^t^" "^Int.toString n^" "^Bool.toString m^"\n")
     val res=joined ``MassSink$massloop`` [enc(nat(Int.toString n)),(if m then cv_primTheory.cv_rep_T else cv_primTheory.cv_rep_F),enc(integer sc),xs,ws,enc(integer mass),enc(integer chk)]
     in if n=1 then ignore(save_thm(t^Bool.toString m,res)) else () end
 in List.app trial [(1,false),(1,true),(64,true),(64,false),(1024,false),(1024,true),(1024,true),(1024,false),(1024,false),(1024,true)] end;
val _=List.app localrun ["mass24n64","mass28n64","mass24n256","mass28n256","mass24n1024","mass28n1024"];
