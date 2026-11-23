Theory Throughput
Ancestors arithmetic integer list cv_std
Libs cv_transLib intLib
Definition rm_def:
rm (x:int) = (x + 10004) / 20008
End
val rm_p_def = cv_trans_pre "rm_p" rm_def;
Theorem rm_ok[cv_pre]:
 !x. rm_p x
Proof
 simp [rm_p_def]
QED
Definition rd_def:
rd (x:int) = (x + 256923075937082083989535485004416548864) / 513846151874164167979070970008833097728
End
val rd_p_def = cv_trans_pre "rd_p" rd_def;
Theorem rd_ok[cv_pre]:
 !x. rd_p x
Proof
 simp [rd_p_def]
QED
Definition loop_delayed_def:
(loop_delayed (r:int) (fs:int list) ([]:int list) (z:int) = z) /\ (loop_delayed r [] (x::xs) z = z) /\ (loop_delayed r (g::gs) (x::xs) z = loop_delayed r gs xs (r*z+x*g))
End
Definition row_delayed_def:
row_delayed r fs xs = rd (loop_delayed r fs xs 0)
End
Definition many_delayed_def:
(many_delayed r fs ([]:int list list) = []) /\ (many_delayed r fs (x::xs) = row_delayed r fs x :: many_delayed r fs xs)
End
Definition test_delayed_def:
(test_delayed (rs:int list) ([]:int list list) fs xs <=> rs = []) /\ (test_delayed [] (y::ys) fs xs <=> F) /\ (test_delayed (r::rs) (y::ys) fs xs <=> many_delayed r fs xs = y /\ test_delayed rs ys fs xs)
End
val _ = cv_auto_trans test_delayed_def;
Definition loop_mixed_def:
(loop_mixed (r:int) (fs:int list) ([]:int list) (z:int) = z) /\ (loop_mixed r [] (x::xs) z = z) /\ (loop_mixed r (g::gs) (x::xs) z = loop_mixed r gs xs (rm (r*z*g)+x))
End
Definition row_mixed_def:
row_mixed r fs xs = loop_mixed r fs xs 0
End
Definition many_mixed_def:
(many_mixed r fs ([]:int list list) = []) /\ (many_mixed r fs (x::xs) = row_mixed r fs x :: many_mixed r fs xs)
End
Definition test_mixed_def:
(test_mixed (rs:int list) ([]:int list list) fs xs <=> rs = []) /\ (test_mixed [] (y::ys) fs xs <=> F) /\ (test_mixed (r::rs) (y::ys) fs xs <=> many_mixed r fs xs = y /\ test_mixed rs ys fs xs)
End
val _ = cv_auto_trans test_mixed_def;
val timer=Timer.startCPUTimer();
fun cpu()=let val {usr,sys}=Timer.checkCPUTimer timer in Time.toReal(Time.+(usr,sys)) end;
val io=TextIO.openIn "terms.txt";
fun tokens()=case TextIO.inputLine io of SOME line=>String.tokens Char.isSpace line | NONE=>raise Fail "eof";
fun toint x=intSyntax.term_of_int(Arbint.fromString x);
val intty=type_of ``0:int``;
val listty=type_of ``[]:int list``;
fun ints ts=listSyntax.mk_list(map toint ts,intty);
fun one()=ints(tl(tokens()));
fun many()=case tokens() of rows::cols::ts=>
  let val n=valOf(Int.fromString rows) val m=valOf(Int.fromString cols)
      fun split 0 []=[] | split k data=ints(List.take(data,m))::split(k-1)(List.drop(data,m))
  in listSyntax.mk_list(split n ts,listty) end | _=>raise Fail "matrix";
val build0=cpu();
fun getcell()=let val rows=many() val rs=one() val df=one() val mf=one() val dy=many() val my=many()
  in (list_mk_comb(``test_delayed``,[rs,dy,df,rows]),list_mk_comb(``test_mixed``,[rs,my,mf,rows])) end;
val (d0,m0)=getcell();
val (d1,m1)=getcell();
val d=boolSyntax.mk_conj(d0,d1) and m=boolSyntax.mk_conj(m0,m1);
val _=print("ADMIT_TERM "^Real.toString(cpu()-build0)^"\n");
fun setup tm=let
  val rep=cv_repLib.cv_rep_for [] tm
  val ft=cv_typeLib.from_to_thm_for(type_of tm)
  val cvtm=cv_miscLib.cv_rep_cv_tm(concl rep)
  val conv=cv_computeLib.cv_compute(cv_eqs_for cvtm)
  val ctx=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
  in (conv,ctx) end;
fun stage (label,tm)=let val start=cpu() val (conv,ctx)=setup tm val endt=cpu()
  val _=print("ADMIT_CV "^label^" "^Real.toString(endt-start)^"\n")
  fun go i=let val t=cpu() val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) ctx val t2=cpu()
    val dec=CONV_RULE(RAND_CONV EVAL) raw
    val th=List.foldl (fn (h,t)=>PROVE_HYP(prove(h,SIMP_TAC(srw_ss()) [])) t) dec (hyp dec)
    val t3=cpu()
    val _=if null(hyp th) andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) T then () else raise Fail label
    val fin=cpu()
    val _=print("SLAB "^label^" "^Int.toString i^" "^String.concatWith " " (map Real.toString [t2-t,t3-t2,fin-t3])^"\n")
    in () end
  in go end;
val a=stage("delayed",d);
val b=stage("mixed",m);
val _=List.app (fn i=>(a i;b i)) [1,2,3,4,5];

