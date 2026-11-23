Theory LeafPrice
Ancestors integer list cv_std
Libs cv_transLib
Definition leafrot_def:
  leafrot (wr:int) wi (z:int # int) =
    let x=FST z; y=SND z; t=wr*(x+y) in (t-y*(wr+wi), t+x*(wi-wr))
End
Definition leafscale_def:
  leafscale (z:int # int) = (2417851639229258349412352*FST z,2417851639229258349412352*SND z)
End
Definition leafadd_def:
  leafadd (z:int # int) (w:int # int) = (FST z+FST w,SND z+SND w)
End
Definition leaf5_def:
  leaf5 (a:int # int) b c d e =
    let a0=leafscale a; b0=leafscale b; c0=leafscale c; d0=leafscale d; e0=leafscale e
      ; b1=leafrot (747157246399165135975325) (2299513556923904919222126) b
      ; c1=leafrot (~1956083066013794310681501) (1421177535770139339473510) c
      ; d1=leafrot (~1956083066013794310681501) (~1421177535770139339473510) d
      ; e1=leafrot (747157246399165135975325) (~2299513556923904919222126) e
      ; b2=leafrot (~1956083066013794310681501) (1421177535770139339473510) b
      ; c2=leafrot (747157246399165135975325) (~2299513556923904919222126) c
      ; d2=leafrot (747157246399165135975325) (2299513556923904919222126) d
      ; e2=leafrot (~1956083066013794310681501) (~1421177535770139339473510) e
      ; b3=leafrot (~1956083066013794310681501) (~1421177535770139339473510) b
      ; c3=leafrot (747157246399165135975325) (2299513556923904919222126) c
      ; d3=leafrot (747157246399165135975325) (~2299513556923904919222126) d
      ; e3=leafrot (~1956083066013794310681501) (1421177535770139339473510) e
      ; b4=leafrot (747157246399165135975325) (~2299513556923904919222126) b
      ; c4=leafrot (~1956083066013794310681501) (~1421177535770139339473510) c
      ; d4=leafrot (~1956083066013794310681501) (1421177535770139339473510) d
      ; e4=leafrot (747157246399165135975325) (2299513556923904919222126) e
    in [leafadd (leafadd (leafadd (leafadd a0 b0) c0) d0) e0;leafadd (leafadd (leafadd (leafadd a0 b1) c1) d1) e1;leafadd (leafadd (leafadd (leafadd a0 b2) c2) d2) e2;leafadd (leafadd (leafadd (leafadd a0 b3) c3) d3) e3;leafadd (leafadd (leafadd (leafadd a0 b4) c4) d4) e4]
End
val _=cv_auto_trans leafadd_def;
val _=cv_auto_trans leafscale_def;
val _=cv_auto_trans leafrot_def;
val _=cv_auto_trans leaf5_def;
val stream = TextIO.openIn "terms.txt";
fun go () = case TextIO.inputLine stream of NONE=>() | SOME s =>
  let val tokens=ref(String.tokens Char.isSpace s)
      fun take()=case !tokens of x::xs=>(tokens:=xs;x) | _=>raise Fail "short"
      val labels=[take(),take(),take()]
      val c=Timer.startCPUTimer()
      fun cpu()=let val {usr,sys}=Timer.checkCPUTimer c in Time.toReal(Time.+(usr,sys)) end
      fun integer()=intSyntax.term_of_int(Arbint.fromString(take()))
      fun pair()=pairSyntax.mk_pair(integer(),integer())
      val args=List.tabulate(5,fn _=>pair())
      val tm=list_mk_comb(``leaf5``,args)
      val expected=listSyntax.mk_list(List.tabulate(5,fn _=>pair()),type_of(hd args))
      val t0=cpu()
      val rep=cv_repLib.cv_rep_for [] tm
      val ft=cv_typeLib.from_to_thm_for(type_of tm)
      val cvtm=cv_miscLib.cv_rep_cv_tm(concl rep)
      val conv=cv_computeLib.cv_compute(cv_eqs_for cvtm)
      val ctx=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
      val t1=cpu()
      val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) ctx
      val t2=cpu()
      val dec=CONV_RULE(RAND_CONV EVAL) raw
      val th=List.foldl (fn (h,t)=>PROVE_HYP (prove(h,SIMP_TAC (srw_ss()) [])) t) dec (hyp dec)
      val t3=cpu()
      val _=if null(!tokens) andalso null(hyp th) andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) expected then () else (print("DIAG " ^ Bool.toString(aconv(lhs(concl th)) tm) ^ " " ^ Bool.toString(aconv(rhs(concl th)) expected) ^ " " ^ term_to_string(rhs(concl th)) ^ " vs " ^ term_to_string expected ^ "\n"); raise Fail "incorrect")
      val t4=cpu()
      val _=print("LEAF " ^ String.concatWith " " labels ^ " " ^ String.concatWith " " (map Real.toString [t0,t1-t0,t2-t1,t3-t2,t4-t3]) ^ "\n")
  in go() end;
val _=go();
val _=TextIO.closeIn stream;

