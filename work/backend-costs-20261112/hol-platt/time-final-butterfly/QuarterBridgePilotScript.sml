Theory QuarterBridgePilot
Ancestors QuarterBridge
Libs cv_transLib

open HolKernel Parse boolLib bossLib cv_transLib;
fun require b m=if b then () else raise Fail m;
fun cpu()=let val {usr,sys}=Timer.checkCPUTimer(Timer.totalCPUTimer()) in Time.toReal(Time.+(usr,sys)) end;
fun audit th=let val(o1,a)=Tag.dest_tag(tag th)
 in require(null(hyp th) andalso null a andalso List.all(fn x=>x="DISK_THM")o1)"theorem tags" end;
val allowed=["bool.ETA_AX","bool.INFINITY_AX","bool.SELECT_AX","bool.BOOL_CASES_AX"];
val axs=List.concat(map(fn thy=>map(fn(k,_)=>thy^"."^k)(DB.axioms thy))("QuarterBridge"::Theory.ancestry"QuarterBridge"));
val _=require(List.all(fn a=>List.exists(fn b=>b=a)allowed)axs)"unexpected ancestry axiom";
val start=cpu();
fun nat i=numSyntax.term_of_int i;
fun list xs=listSyntax.mk_list(xs,numSyntax.num);
fun hex s=numSyntax.mk_numeral(Arbnum.fromHexString s);
fun dec s=numSyntax.mk_numeral(Arbnum.fromString s);
fun small s=valOf(Int.fromString s);
val vs=List.tabulate(9,fn j=>mk_var("n"^Int.toString j,numSyntax.num))@[mk_var("prev",``:num list``),mk_var("next",``:num list``)];
val fnTm=``QuarterBridge$qb_tile``;
val rep=cv_repLib.cv_rep_for [] (list_mk_comb(fnTm,vs));
val ft=cv_typeLib.from_to_thm_for bool;
val templ=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep)ft);
val raw=rand(rhs(concl templ));
val (cf,cas)=strip_comb raw;
val bare=list_mk_comb(cf,List.tabulate(length cas,fn i=>mk_var("cvv"^Int.toString i,cvSyntax.cv)));
val conv=cv_computeLib.cv_compute(cv_eqs_for bare);
val xn=mk_var("rawnat",numSyntax.num);
val nrep=EVAL(mk_comb(cv_typeLib.from_term_for numSyntax.num,xn));
fun natEnc tm=INST[xn |-> rand tm]nrep;
val listF=cv_typeLib.from_term_for ``:num list``;
val encs=ref ([]:(int*(term list*thm))list);
fun listEnc tm =
 let val rs= #1(listSyntax.dest_list(rand tm))
     val n=length rs
     val (vars,schema)=case List.find(fn(k,_)=>k=n)(!encs) of SOME(_,e)=>e
        | NONE=>let val vars=List.tabulate(n,fn j=>mk_var("x"^Int.toString j,numSyntax.num))
                     val th=EVAL(mk_comb(listF,list vars))
                     val _=encs:=(n,(vars,th))::(!encs)
                 in (vars,th) end
 in INST(ListPair.map(fn(v,r)=>v |-> r)(vars,rs))schema end;
fun encArgs []=ALL_CONV | encArgs(c::cs)=RATOR_CONV(encArgs cs) THENC RAND_CONV c;
val schemaTime=cpu()-start;
val ins=TextIO.openIn "quarter.hex";
fun run i =
 let val t0=cpu()
     val path="b06_proofs_"^Int.toString(256*(i div 256))^"/ending-"^Int.toString(8*(i div 8)+7)^".thms"
     val group=DiskThms.read_file path
     val (_,old)=valOf(List.find(fn(k,_)=>k="tile_"^Int.toString i)group)
     val _=audit old
     val (f,oa)=strip_comb(concl old)
     val _=require(aconv f ``FullButterfly$fr_tile`` andalso length oa=12 andalso aconv(hd oa)(nat i))"old tile input"
     val t1=cpu()
     val fields=String.tokens Char.isSpace(valOf(TextIO.inputLine ins))
     val (t,v,words)=case fields of id::t::v::n::rs=>
       (require(small id=i andalso small n=length rs)"quarter tile";(small t,small v,rs))
                      | _=>raise Fail "quarter header"
     val args=List.take(oa,3)@[nat t,nat v]@List.take(List.drop(oa,3),4)@[List.last oa,list(map hex words)]
     val tm=list_mk_comb(fnTm,args)
     val t2=cpu()
     val inst=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args))templ
     val pre=CONV_RULE(RAND_CONV(RAND_CONV(encArgs(listEnc::listEnc::List.tabulate(9,fn _=>natEnc)))))inst
     val t3=cpu()
     val done=CONV_RULE(RAND_CONV(RAND_CONV conv))pre
     val t4=cpu()
     val eq=CONV_RULE(RAND_CONV EVAL)done
     fun discharge(h,th)=PROVE_HYP(prove(h,SIMP_TAC(srw_ss())[]))th
     val res=List.foldl discharge eq (hyp eq)
     val quarter=if aconv(concl res)tm then res else EQT_ELIM res
     val _=require(aconv(concl quarter)tm)"wrong bridge"
     val merged=CONJ quarter old
     val _=audit merged
     val _=save_thm("linked_tile_"^Int.toString i,merged)
 in print("QUARTER_CPU,"^Int.toString i^","^String.concatWith "," (map Real.toString
       [t1-t0,t2-t1,t3-t2,t4-t3,cpu()-t4])^"\n") end;
val _=print("QUARTER_SCHEMA,"^Real.toString schemaTime^"\n");
val _=List.app run [2,512,1026,1318];
val _=require(not(isSome(TextIO.inputLine ins)))"trailing quarter tiles";
val _=TextIO.closeIn ins;
val _=print "QUARTER_PILOT_DONE\n";
