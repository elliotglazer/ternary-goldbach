Theory FinalButterflyPilot
Ancestors FinalButterfly
Libs cv_transLib

open HolKernel Parse boolLib bossLib cv_transLib;
fun require b s = if b then () else raise Fail s;
fun cpu () = let val {usr,sys} = Timer.checkCPUTimer(Timer.totalCPUTimer()) in Time.toReal(Time.+(usr,sys)) end;
val start=cpu();
val vs=List.tabulate(8,fn i=>mk_var("fb_arg"^Int.toString i,``:num``));
val fnTm=``FinalButterfly$fb_project``;
val generic=list_mk_comb(fnTm,vs);
val rep=cv_repLib.cv_rep_for [] generic;
val schema=UNDISCH_ALL(REWRITE_RULE[cv_repTheory.cv_rep_def]rep);
val base=List.foldl(fn(p,th)=>PROVE_HYP(prove(p,SIMP_TAC(srw_ss())[]))th) schema (hyp schema);
val conv=cv_computeLib.cv_compute(cv_eqs_for(rhs(concl base)));
val inv=REWRITE_RULE[cv_typeTheory.from_to_def] cv_typeTheory.from_to_bool;
val from_to=PURE_REWRITE_RULE[inv] o AP_TERM ``cv$c2b``;
val allowed=["bool.ETA_AX","bool.INFINITY_AX","bool.SELECT_AX","bool.BOOL_CASES_AX"];
val axs=List.concat(map(fn n=>map(fn(k,_)=>n^"."^k)(DB.axioms n))("FinalButterfly"::Theory.ancestry "FinalButterfly"));
val _=require(List.all(fn a=>List.exists(fn b=>b=a) allowed) axs)"ancestor axiom";
fun audit th=let val (os,ax)=Tag.dest_tag(tag th)
 in require(null(hyp th) andalso null ax andalso List.all(fn s=>s="DISK_THM") os)"theorem tags" end;
val schemaTime=cpu()-start;
val stream=TextIO.openIn "packed.hex";
fun loop acc=case TextIO.inputLine stream of NONE=>rev acc | SOME s=>loop(String.tokens Char.isSpace s::acc);
val lines=loop [];
val _=TextIO.closeIn stream;
val _=require(length lines=256)"sample count";
fun check args good =
 let val input=INST(ListPair.map(fn(v,n)=>v |-> n)(vs,args))base
     val done=CONV_RULE(RAND_CONV conv)input
     val answer=if good then cv_primTheory.cv_rep_T else cv_primTheory.cv_rep_F
     val eq=from_to(TRANS done(SYM answer))
     val th=if good then EQT_ELIM eq else EQF_ELIM eq
     val expected=list_mk_comb(fnTm,args)
     val _=require(aconv(concl th)(if good then expected else mk_neg expected))"exact sample claim"
     val _=audit th
 in th end;
fun hex s=numSyntax.mk_numeral(Arbnum.fromHexString s);
fun run count =
 let val t=cpu()
     val selected=List.tabulate(count,fn i=>List.nth(lines,i*256 div count))
     val args=map (map hex) selected
     val t1=cpu()
     val ths=map (fn a=>check a true) args
     val t2=cpu()
     val _=if count=256 then ignore(save_thm("all_256_actual_samples",LIST_CONJ ths)) else ()
     val _=print("BUTTERFLY_CPU,"^Int.toString count^","^Real.toString(t1-t)^","^Real.toString(t2-t1)^","^Real.toString(cpu()-t2)^"\n")
 in () end;
val _=print("BUTTERFLY_SCHEMA,"^Real.toString schemaTime^"\n");
val _=List.app run [1,16,64,256];
val args=map hex(hd lines);
val n=List.last args;
val flip=if aconv n (numSyntax.term_of_int 1) then 2 else 1;
val _=save_thm("reject_wrong_sign",check(List.take(args,7)@[numSyntax.term_of_int flip])false);
val _=print "BUTTERFLY_PILOT_DONE\n";
