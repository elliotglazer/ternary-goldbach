Theory MaskedButterflyPilot
Ancestors MaskedButterfly
Libs cv_transLib

open HolKernel Parse boolLib bossLib cv_transLib;
fun require b s=if b then () else raise Fail s;
fun cpu()=let val {usr,sys}=Timer.checkCPUTimer(Timer.totalCPUTimer()) in Time.toReal(Time.+(usr,sys)) end;
fun audit th=
 let val (os,ax)=Tag.dest_tag(tag th)
 in require(null(hyp th) andalso null ax andalso List.all(fn s=>s="DISK_THM") os)"failed audit" end;
val allowed=["bool.ETA_AX","bool.INFINITY_AX","bool.SELECT_AX","bool.BOOL_CASES_AX"];
val axs=List.concat(map(fn thy=>map(fn(k,_)=>thy^"."^k)(DB.axioms thy))("MaskedButterfly"::Theory.ancestry"MaskedButterfly"));
val _=require(List.all(fn a=>List.exists(fn b=>b=a)allowed)axs)"ancestry axiom";
val start=cpu();
val fnTm=``MaskedButterfly$mb_all``;
val vars=[mk_var("n",numSyntax.num),mk_var("rs",``:num list``)];
val rep=cv_repLib.cv_rep_for [] (list_mk_comb(fnTm,vars));
val typ=cv_typeLib.from_to_thm_for bool;
val template=UNDISCH_ALL(MATCH_MP (MATCH_MP cv_repTheory.cv_rep_eval rep)typ);
val rawPattern=rand(rhs(concl template));
val (cvfn,cvargs)=strip_comb rawPattern;
val bare=list_mk_comb(cvfn,List.tabulate(length cvargs,fn i=>mk_var("c"^Int.toString i,cvSyntax.cv)));
val conv=cv_computeLib.cv_compute(cv_eqs_for bare);
val setup=cpu()-start;
val ins=TextIO.openIn "masked.hex";
fun lines acc=case TextIO.inputLine ins of NONE=>rev acc | SOME s=>lines(hd(String.tokens Char.isSpace s)::acc);
val texts=Vector.fromList(lines []);
val _=TextIO.closeIn ins;
val _=require(Vector.length texts>4)"empty masked payload";
fun nlist xs=listSyntax.mk_list(xs,numSyntax.num);
fun hex s=numSyntax.mk_numeral(Arbnum.fromHexString s);
fun encoding enc count =
 let val vs=List.tabulate(count,fn i=>mk_var("p"^Int.toString i,numSyntax.num))
     val schema=EVAL(mk_comb(enc,nlist vs))
 in fn tm=>let val xs = #1(listSyntax.dest_list(rand tm))
               val r = INST(ListPair.map(fn(v,n)=>v |-> n)(vs,xs))schema
            in require(aconv(lhs(concl r))tm)"bad encoding";r end end;
val baseEnc=cv_typeLib.from_term_for ``:num list``;
fun run store =
 let val n=Vector.length texts
     val t=cpu()
     val enc=encoding baseEnc n
     val t1=cpu()
     val args=[numSyntax.term_of_int 4,nlist(Vector.foldr (fn(s,acc)=>hex s::acc)[]texts)]
     val t2=cpu()
     val tm=list_mk_comb(fnTm,args)
     val inst=INST(ListPair.map(fn(v,a)=>v |-> a)(vars,args))template
     val encoded=CONV_RULE(RAND_CONV(RAND_CONV(
       RATOR_CONV(RAND_CONV EVAL) THENC RAND_CONV enc)))inst
     val t3=cpu()
     val raw=CONV_RULE(RAND_CONV(RAND_CONV conv))encoded
     val t4=cpu()
     val eq=CONV_RULE(RAND_CONV EVAL)raw
     fun discharge(p,th)=PROVE_HYP(prove(p,SIMP_TAC(srw_ss())[]))th
     val th=List.foldl discharge eq (hyp eq)
     val good=if aconv(concl th)tm then th else EQT_ELIM th
     val _=require(aconv(concl good)tm)"masked result"
     val _=audit good
     val t5=cpu()
     val _=if store then ignore(save_thm("selected_actual_samples",good)) else ()
 in print("MASKED_CPU,"^Bool.toString store^","^String.concatWith "," (map Real.toString
     [t1-t,t2-t1,t3-t2,t4-t3,t5-t4,cpu()-t5])^"\n") end;
val _=print("MASKED_SCHEMA,"^Real.toString setup^"\n");
val _=List.app run [false,false,true];
val _=print "MASKED_PILOT_DONE\n";
