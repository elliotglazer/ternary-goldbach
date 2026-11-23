Theory Kron
Ancestors integer list cv_std
Libs intLib cv_transLib
val _=intLib.ARITH_TAC;

Definition kr_pack_def:
  (kr_pack ([]:(int # int) list) = (0:int,0:int)) /\
  (kr_pack (h::t) =
    let tail = kr_pack t in
    (FST h + (&(2**632))*FST tail,SND h + (&(2**632))*SND tail))
End
Definition kr_mod_def:
  kr_mod (z:int) (m:int) = if m=0 then 0 else z % m
End
Definition kr_probe_def:
  kr_probe (mode:num) a b =
    let aa=kr_pack a; bb=kr_pack b; x=FST aa; y=SND aa;
        u=FST bb; v=SND bb
    in if mode=0 then kr_mod (kr_mod x 65521 + kr_mod y 65521 +
        kr_mod u 65521 + kr_mod v 65521) 65521
    else let p=x*u; q=y*v; t=(x+y)*(u+v) in
      kr_mod (kr_mod p 65521 + kr_mod q 65521 + kr_mod t 65521) 65521
End
Definition kr_exact_def:
  kr_exact a b c <=>
    let aa=kr_pack a; bb=kr_pack b; cc=kr_pack c;
        x=FST aa; y=SND aa; u=FST bb; v=SND bb;
        p=x*u; q=y*v; t=(x+y)*(u+v); m= (&(2**316000):int)-1 in
    kr_mod (p-q-FST cc) m=0 /\ kr_mod (t-p-q-SND cc) m=0
End
val _=cv_auto_trans kr_pack_def;
val _=cv_trans kr_mod_def;
val _=cv_auto_trans kr_probe_def;
val _=cv_auto_trans kr_exact_def;

val tstart=Timer.startCPUTimer();
fun cpu c=let val {usr,sys}=Timer.checkCPUTimer c in Time.toReal(Time.+(usr,sys)) end;
fun rows name =
 let val f=TextIO.openIn(name ^ ".tsv")
     fun cv s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x) s))
     fun loop acc=case TextIO.inputLine f of NONE=>rev acc
       | SOME l=>(case String.tokens Char.isSpace l of [a,b]=>loop(pairSyntax.mk_pair(cv a,cv b)::acc)|_=>raise Fail "row")
     val xs=loop []
 in TextIO.closeIn f; listSyntax.mk_list(xs,``:int # int``) end;
val [a,b,c]=map rows ["a","b","c"];
val _=print("KR_LOAD " ^ Real.toString(cpu tstart) ^ "\n");
fun run label head args expected =
 let val clock=Timer.startCPUTimer()
     val tm=list_mk_comb(head,args)
     val vs=List.tabulate(length args,fn i=>mk_var("v" ^ Int.toString i,type_of(List.nth(args,i))))
     val rep=cv_repLib.cv_rep_for [] (list_mk_comb(head,vs))
     val ft=cv_typeLib.from_to_thm_for(type_of tm)
     val abstract=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
     val concrete=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args)) abstract
     fun enc 0=ALL_CONV | enc n=(RATOR_CONV(enc(n-1))) THENC (RAND_CONV EVAL)
     val ctx=CONV_RULE ((RAND_CONV o RAND_CONV) (enc(length args))) concrete
     val cvtm=rand(rhs(concl ctx))
     val conv=cv_computeLib.cv_compute(cv_eqs_for cvtm)
     val t1=cpu clock
     val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) ctx
     val t2=cpu clock
     val dec=CONV_RULE(RAND_CONV EVAL) raw
     val th=List.foldl(fn(h,t)=>PROVE_HYP(prove(h,SIMP_TAC (srw_ss()) [])) t) dec (hyp dec)
     val t3=cpu clock
     val (os,axs)=Tag.dest_tag(tag th)
     val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM") os andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) expected then () else raise Fail label
     val _=print("KR_RUN " ^ label ^ " " ^ String.concatWith " " (map Real.toString [t1,t2-t1,t3-t2,cpu clock-t3]) ^ "\n")
 in th end;
val _=run "control" ``kr_probe`` [``0:num``,a,b] ``33370:int``;
val _=run "products" ``kr_probe`` [``1:num``,a,b] ``13193:int``;
val exact=run "exact" ``kr_exact`` [a,b,c] T;
val _=save_thm("kr_actual_cyclic_outputs",EQT_ELIM exact);


