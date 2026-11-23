Theory KronFull
Ancestors Kron integer list cv_std
Libs intLib cv_transLib
val _=intLib.ARITH_TAC;

Definition kdiv_def:
  kdiv (z:int) d = if d=0 then 0 else z / d
End
Definition kr_center_def:
  kr_center z d =
    let r=kr_mod z d in if 2*r >= d then r-d else r
End
Definition kr_rot_def:
  kr_rot (scale:int) (z:int # int) (w:int # int) =
    let x=FST z; y=SND z; u=FST w; v=SND w; p=x*u; q=y*v; t=(x+y)*(u+v);
        real=p-q; imag=t-p-q in
    (kdiv (real+kdiv scale 2) scale,kdiv (imag+kdiv scale 2) scale)
End
Definition kr_pre_def:
  (kr_pre [] cs = []) /\
  (kr_pre (z::zs) cs =
    case cs of [] => [] | w::ws => kr_rot (&(2**307)) z w :: kr_pre zs ws)
End
Definition kr_conj_def:
  (kr_conj ([]:(int # int) list) = []) /\
  (kr_conj (z::zs) = (FST z,-SND z) :: kr_conj zs)
End
Definition kr_unpack_def:
  (kr_unpack x y ([]:(int # int) list) = []) /\
  (kr_unpack x y (w::ws) =
    let d=(&(2**632):int); u=kr_center x d; v=kr_center y d in
      kr_rot (&(2**614)) (u,v) w ::
        kr_unpack (kdiv (x-u) d) (kdiv (y-v) d) ws)
End
Definition kr_full_def:
  kr_full xs ws =
    let aa=kr_pack (kr_pre xs ws); bb=kr_pack (kr_conj ws);
        x=FST aa; y=SND aa; u=FST bb; v=SND bb;
        p=x*u; q=y*v; t=(x+y)*(u+v); m=(&(2**316000):int)-1 in
      kr_unpack (kr_center (p-q) m) (kr_center (t-p-q) m) ws
End
val _=cv_auto_trans kdiv_def;
val _=cv_auto_trans kr_center_def;
val _=cv_auto_trans kr_rot_def;
val _=cv_auto_trans kr_pre_def;
val _=cv_auto_trans kr_conj_def;
val _=cv_auto_trans kr_unpack_def;
val _=cv_auto_trans kr_full_def;
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
val full=run "full" ``kr_full`` [a,b] c;
val _=save_thm("kr_actual_full_500",full);


