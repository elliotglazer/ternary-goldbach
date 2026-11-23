Theory KronTree
Ancestors KronFull Kron integer list cv_std
Libs intLib cv_transLib
val _=intLib.ARITH_TAC;

Definition kt_pairs_def:
  (kt_pairs (s:int) [] = []) /\
  (kt_pairs s [z:int # int] = [z]) /\
  (kt_pairs s (z::w::zs) =
    (FST z+s*FST w,SND z+s*SND w)::kt_pairs s zs)
End
Definition kt_pack_def:
  (kt_pack 0 (s:int) zs = case zs of []=>(0:int,0:int) | z::rest=>z) /\
  (kt_pack (SUC n) s zs = kt_pack n (s*s) (kt_pairs s zs))
End
Definition kt_powers_def:
  (kt_powers 0 (s:int) acc = acc) /\
  (kt_powers (SUC n) s acc = kt_powers n (s*s) ((s,kdiv s 2)::acc))
End
Definition kt_unpack_def:
  (kt_unpack [] (z:int # int) = [z]) /\
  (kt_unpack (sw::ss) z =
    let s=FST sw; h=SND sw; x=FST z; y=SND z; u=kdiv (x+h) s; v=kdiv (y+h) s in
    kt_unpack ss (x-u*s,y-v*s) ++ kt_unpack ss (u,v))
End
Definition kt_post_def:
  (kt_post [] cs = []) /\
  (kt_post (z::zs) cs = case cs of []=>[] | w::ws =>
    kr_rot (&(2**614)) z w :: kt_post zs ws)
End
Definition kt_full_def:
  kt_full xs ws =
    let s=(&(2**632):int);
        aa=kt_pack 9 s (kr_pre xs ws); bb=kt_pack 9 s (kr_conj ws);
        x=FST aa; y=SND aa; u=FST bb; v=SND bb;
        p=x*u; q=y*v; t=(x+y)*(u+v); m=(&(2**316000):int)-1;
        pairs=kt_unpack (kt_powers 9 s []) (kr_center (p-q) m,kr_center (t-p-q) m)
    in kt_post pairs ws
End
val _=cv_auto_trans kt_pairs_def;
val _=cv_auto_trans kt_pack_def;
val _=cv_auto_trans kt_powers_def;
val _=cv_auto_trans kt_unpack_def;
val _=cv_auto_trans kt_post_def;
val _=cv_auto_trans kt_full_def;

val tstart=Timer.startCPUTimer();
fun cpu c=let val {usr,sys}=Timer.checkCPUTimer c in Time.toReal(Time.+(usr,sys)) end;
fun rows name =
 let val f=TextIO.openIn(name ^ ".tsv")
     fun cv s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x) s))
     fun loop acc=case TextIO.inputLine f of NONE=>rev acc
       | SOME l=>(case String.tokens Char.isSpace l of [a,b]=>loop(pairSyntax.mk_pair(cv a,cv b)::acc)|_=>raise Fail "row")
     val xs=loop []
 in TextIO.closeIn f; listSyntax.mk_list(xs,``:int # int``) end;
val [a,b,c]=map rows ["../c10000-bluestein-hol/inputs","../c10000-bluestein-hol/chirps","output"];
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
val full=run "tree_cold" ``kt_full`` [a,b] c;
val _=save_thm("kt_actual_full_500",full);
val _=run "tree_warm" ``kt_full`` [a,b] c;



