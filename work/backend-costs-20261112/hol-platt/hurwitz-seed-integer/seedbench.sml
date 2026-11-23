structure seedbench = struct
open HolKernel Parse boolLib bossLib cv_transLib
val timer=Timer.startCPUTimer()
fun cpu()=let val {usr,sys}=Timer.checkCPUTimer timer in Time.toReal(Time.+(usr,sys)) end
fun nat s=numSyntax.mk_numeral(Arbnum.fromString s)
fun vars ts=ListPair.map(fn(t,i)=>mk_var("a"^Int.toString i,type_of t))(ts,List.tabulate(length ts,fn i=>i))
fun enc_for ty=hd(#2(strip_comb(concl(cv_typeLib.from_to_thm_for ty))))
fun literal def=let val(a,v)=dest_eq(concl def) val e=enc_for(type_of a)
  in TRANS(AP_TERM e def)(EVAL(mk_comb(e,v))) end
fun named name a=new_definition(name^"_def",mk_eq(mk_var(name,type_of a),a))
(* This is the input-staging conversion used by grid-sign-join/replay.sml,
   with a check of the exact proposition and no project-specific ancestors. *)
fun joined constant encodings=let
  val args=map(rand o lhs o concl) encodings
  val vs=vars args
  val start=cpu()
  val schema=UNDISCH_ALL(REWRITE_RULE[cv_repTheory.cv_rep_def]
             (cv_repLib.cv_rep_for [] (list_mk_comb(constant,vs))))
  val cvargs=List.tabulate(length args,fn j=>mk_var("input"^Int.toString j,``:cv``))
  val hyps=ListPair.map(fn(v,x)=>ASSUME(mk_eq(mk_comb(enc_for(type_of v),v),x)))(vs,cvargs)
  val skeleton=CONV_RULE(RAND_CONV(PURE_REWRITE_CONV hyps))schema
  val cvdo=cv_computeLib.cv_compute(cv_eqs_for(rhs(concl skeleton)))
  val concrete=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args)@
      ListPair.map(fn(v,h)=>v |-> rhs(concl h))(cvargs,encodings))skeleton
  val ready=List.foldl(fn(h,eq)=>PROVE_HYP h eq)concrete encodings
  val t=cpu()
  val raw=CONV_RULE(RAND_CONV cvdo)ready
  val u=cpu()
  val th=List.foldl(fn(a,z)=>PROVE_HYP(prove(a,SIMP_TAC(srw_ss())[])) z)raw(hyp raw)
  val eq=TRANS th (SYM cv_primTheory.cv_rep_T)
  val ft=cv_typeLib.from_to_thm_for ``:bool``
  val [_,dec]= #2(strip_comb(concl ft))
  val final=EQT_ELIM(PURE_REWRITE_RULE[REWRITE_RULE[cv_typeTheory.from_to_def]ft](AP_TERM dec eq))
  val (os,axs)=Tag.dest_tag(tag final)
  val _=if null(hyp final) andalso null axs andalso List.all(fn s=>s="DISK_THM") os
           andalso aconv(concl final)(list_mk_comb(constant,args)) then () else raise Fail "checked conclusion"
  val _=print("JOIN_EVAL "^String.concatWith " " (map Real.toString[t-start,u-t,cpu()-u])^"\n")
  in final end
end
