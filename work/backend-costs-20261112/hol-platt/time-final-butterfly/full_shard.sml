open HolKernel Parse boolLib bossLib cv_transLib FullButterflyTheory;
fun bound n=valOf(Int.fromString(valOf(OS.Process.getEnv n)));
val lo=bound "FB_FIRST" and hi=bound "FB_LAST";
val _=new_theory("FullButterflyPart" ^ Int.toString lo);
fun require b m=if b then () else raise Fail m;
fun cpu()=let val {usr,sys}=Timer.checkCPUTimer(Timer.totalCPUTimer()) in Time.toReal(Time.+(usr,sys)) end;
fun audit th=let val(o1,a)=Tag.dest_tag(tag th)
 in require(null(hyp th) andalso null a andalso List.all(fn x=>x="DISK_THM")o1)"theorem tags" end;
val allowed=["bool.ETA_AX","bool.INFINITY_AX","bool.SELECT_AX","bool.BOOL_CASES_AX"];
val axs=List.concat(map(fn thy=>map(fn(k,_)=>thy^"."^k)(DB.axioms thy))("FullButterfly"::Theory.ancestry"FullButterfly"));
val _=require(List.all(fn a=>List.exists(fn b=>b=a)allowed)axs)"unexpected ancestry axiom";
val start=cpu();
fun nat i=numSyntax.term_of_int i;
fun list xs=listSyntax.mk_list(xs,numSyntax.num);
fun hex s=numSyntax.mk_numeral(Arbnum.fromHexString s);
fun dec s=numSyntax.mk_numeral(Arbnum.fromString s);
fun small s=valOf(Int.fromString s);
val vs=List.tabulate(11,fn j=>mk_var("n"^Int.toString j,numSyntax.num))@[mk_var("rs",``:num list``)];
val fnTm=``FullButterfly$fr_tile``;
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
val streams=map TextIO.openIn (map(fn l=>"../sparse-count/raw-"^l^".txt")["3","6667","11","9091"]);
val source=TextIO.openIn "full-operands.hex";
val folder=valOf(OS.Process.getEnv "REPLAY_LABEL") ^ "_proofs_" ^ Int.toString lo;
val _=OS.FileSys.mkDir folder;
fun tokens s=String.tokens Char.isSpace s;
fun line ins=valOf(TextIO.inputLine ins);
val names=ref ([]:(string*thm)list);
val parseT=ref 0.0 and encT=ref 0.0 and evalT=ref 0.0 and auditT=ref 0.0 and writeT=ref 0.0 and readT=ref 0.0;
val nums=ref 0 and ticknum=ref 0;
fun mergeRaw []=nat 0 | mergeRaw fields=
 let fun pad s=let val n=64-size s
                   val _=require(n>=0)"oversize raw220"
               in String.implode(List.tabulate(n,fn _=> #"0"))^s end
 in hex(String.concat(map pad (rev fields))) end;
fun input ins=case tokens(line ins) of mask::fields=>(dec mask,mergeRaw fields,length fields)
                  | _=>raise Fail "missing raw mask";
fun writeBatch tile =
 let val ts=cpu()
     val group=map(fn(name,th)=>(name,save_thm(name,th)))(rev(!names))
     val path=folder^"/ending-"^Int.toString tile^".thms"
     val _=DiskThms.write_file path group
     val tr=cpu()
     val read=DiskThms.read_file path
     val _=require(length read=length group)"persisted count"
     val _=ListPair.appEq(fn((n,th),(m,r))=>
          (require(n=m andalso aconv(concl th)(concl r))"persisted identity";audit r)) (group,read)
 in List.app(fn(name,_)=>Theory.delete_binding name) group; names:=[]; writeT:= !writeT+tr-ts;readT:= !readT+cpu()-tr end;
fun tile i=
 let val t=cpu()
     val fields=tokens(line source)
     val (id,p,w,num,words)=case fields of a::b::c::d::rs=>(small a,small b,small c,small d,rs)
                                 | _=>raise Fail "invalid operand tile"
     val _=require(id=i andalso length words=num)"tile identity"
     val inputs=map input streams
     val args=[nat i,nat p,nat w]@map #1 inputs@map #2 inputs@[list(map hex words)]
     val t1=cpu()
     val tm=list_mk_comb(fnTm,args)
     val inst=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args))templ
     val cs=listEnc::List.tabulate(11,fn _=>natEnc)
     val pre=CONV_RULE(RAND_CONV(RAND_CONV(encArgs cs)))inst
     val t2=cpu()
     val finished=CONV_RULE(RAND_CONV(RAND_CONV conv))pre
     val t3=cpu()
     val eq=CONV_RULE(RAND_CONV EVAL)finished
     fun discharge(h,th)=PROVE_HYP(prove(h,SIMP_TAC(srw_ss())[]))th
     val th=List.foldl discharge eq (hyp eq)
     val result=if aconv(concl th)tm then th else EQT_ELIM th
     val _=require(aconv(concl result)tm)"wrong projection result"
     val _=audit result
     val _=names:=("tile_"^Int.toString i,result)::(!names)
     val _=nums:= !nums+List.foldl(fn((_,_,n),a)=>a+n)0 inputs
     val _=ticknum:= !ticknum+num
     val t4=cpu()
     val _=parseT:= !parseT+t1-t
     val _=encT:= !encT+t2-t1
     val _=evalT:= !evalT+t3-t2
     val _=auditT:= !auditT+t4-t3
     val _=if i mod 8=7 orelse i=hi then writeBatch i else ()
     val _=if i mod 64=63 orelse i=hi then print("FULL_BUTTERFLY_AT,"^Int.toString i^","^Int.toString(!nums)^","^Real.toString(cpu()-start)^"\n")else()
 in () end;
val _=List.app(fn stream=>List.app(fn _=>ignore(line stream))(List.tabulate(lo,fn i=>i)))(source::streams);
val _=List.app tile (List.tabulate(hi-lo+1,fn i=>lo+i));
val _=List.app(fn ins=>(if hi=1330 then require(not(isSome(TextIO.inputLine ins)))"trailing input" else ();TextIO.closeIn ins))(source::streams);
val _=require(null(!names))"unfinished save";
val _=print("FULL_BUTTERFLY_COVERAGE,"^Int.toString lo^","^Int.toString hi^","^Int.toString(!nums)^","^Int.toString(!ticknum)^"\n");
val _=print("FULL_BUTTERFLY_CPU,"^String.concatWith ","(map Real.toString
 [schemaTime,!parseT,!encT,!evalT,!auditT,!writeT,!readT,cpu()-start])^"\n");
val _=print "FULL_BUTTERFLY_DONE\n";

val _=export_theory();
