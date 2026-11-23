Theory KronProducts
Ancestors KronTree KronFull Kron integer list cv_std
Libs intLib cv_transLib
val _=intLib.ARITH_TAC;
Definition kp_repeat_def:
  (kp_repeat 0 (x:int) y u v acc = acc) /\
  (kp_repeat (SUC n) x y u v acc =
     let p=x*u; q=y*v; t=(x+y)*(u+v);
         checksum=kr_mod(p+q+t) 65521 in
       kp_repeat n x y u v (acc+checksum))
End
Definition kp_full_def:
  kp_full n a b =
    let aa=kt_pack 9 (&(2**632)) a; bb=kt_pack 9 (&(2**632)) b in
    kp_repeat n (FST aa) (SND aa) (FST bb) (SND bb) 0
End
val _=cv_auto_trans kp_repeat_def;
val _=cv_auto_trans kp_full_def;
val tstart=Timer.startCPUTimer();
fun cpu c=let val {usr,sys}=Timer.checkCPUTimer c in Time.toReal(Time.+(usr,sys)) end;
fun rows name =
 let val f=TextIO.openIn(name ^ ".tsv")
     fun cv s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x) s))
     fun loop acc=case TextIO.inputLine f of NONE=>rev acc
       | SOME l=>(case String.tokens Char.isSpace l of [a,b]=>loop(pairSyntax.mk_pair(cv a,cv b)::acc)|_=>raise Fail "row")
     val xs=loop []
 in TextIO.closeIn f; listSyntax.mk_list(xs,``:int # int``) end;
val [a,b]=map rows ["a","b"];
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
val _ = List.app (fn n =>
 let val nn=numSyntax.mk_numeral(Arbnum.fromInt n)
     val result=intSyntax.term_of_int(Arbint.fromInt(13193*n))
     val _=run ("rep" ^ Int.toString n) ``kp_full`` [nn,a,b] result
 in () end) [0,1,8,24];
