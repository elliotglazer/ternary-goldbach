Theory Series
Ancestors arithmetic integer list cv_std
Libs cv_transLib intLib
Definition poly_def:
(poly (r:int) ([]:int list) = 0) /\ (poly r (x::xs) = x+r*poly r xs)
End
Definition vals_def:
(vals 0 (r:int) cs = []) /\ (vals (SUC n) r cs = poly r cs :: vals n (r+1024) cs)
End
Definition diff_def:
(diff (z:int) ([]:int list) = []) /\ (diff z (x::xs) = x-z :: diff x xs)
End
Definition repeatdiff_def:
(repeatdiff 0 xs = xs) /\ (repeatdiff (SUC n) xs = repeatdiff n (diff 0 xs))
End
Definition roundq_def:
roundq (v:int) x = if v=0 then 0 else (x+v / 2) / v
End
val rd_p_def=cv_trans_pre "rd_p" roundq_def;
Theorem rd_ok[cv_pre]:
 !v x. rd_p v x
Proof
 simp [rd_p_def]
QED
Definition rounded_def:
(rounded v ([]:int list) = []) /\ (rounded v (x::xs) = roundq v x :: rounded v xs)
End
Definition get_def:
(get 0 (z:num) (b:num) = []:int list) /\ (get (SUC n) z b = if b=0 then [] else (&(z MOD b) - &(b DIV 2)) :: get n (z DIV b) b)
End
Definition geom_def:
(geom 0 (b:num) = 0:num) /\ (geom (SUC n) b = 1+b*geom n b)
End
Definition boundok_def:
boundok (R:int) (b:num) (cs:int list) <=> 2*poly R (MAP ABS cs) < &b
End
Definition boundpoly_def:
(boundpoly (r:int) ([]:int list) = 0) /\ (boundpoly r (x::xs) = ABS x+r*boundpoly r xs)
End
Definition divides0_def:
divides0 (j:int) (x:int) <=> if j = 0 then F else x % j = 0
End
val _ = cv_auto_trans divides0_def;
Definition cert_def:
cert (n:num) (k:num) (r:int) (R:int) (b:num) (cs:int list) (z:int) <=> b <> 0 /\ LENGTH cs=k /\ 2*boundpoly R cs < &b /\ ABS r <= R /\ ABS (r+1024* &(n-1)) <= R /\ 0 <= z + &((b DIV 2)*geom n b) /\ z + &((b DIV 2)*geom n b) < &(b ** n) /\ divides0 (&(b ** n)) ((1 - &b) ** k * z - poly (&b) (repeatdiff k (vals k r cs)))
End
Definition sink_def:
sink n b (v:int) (z:int) = rounded v (get n (Num (z + &((b DIV 2)*geom n b))) b)
End
Definition direct_def:
direct n r cs v = rounded v (vals n r cs)
End
val _=cv_auto_trans cert_def;
val _=cv_auto_trans sink_def;
val _=cv_auto_trans direct_def;
val clk=Timer.startCPUTimer();
fun cpu()=let val {usr,sys}=Timer.checkCPUTimer clk in Time.toReal(Time.+(usr,sys)) end;
val io=TextIO.openIn "terms.txt";
fun tokens()=case TextIO.inputLine io of SOME line=>String.tokens Char.isSpace line | NONE=>raise Fail "end";
fun ii x=intSyntax.term_of_int(Arbint.fromString x);
fun nn x=numSyntax.mk_numeral(Arbnum.fromString x);
fun il xs=listSyntax.mk_list(map ii xs,type_of ``0:int``);
fun app f xs=list_mk_comb(f,xs);
fun stage label tm=let val t0=cpu()
  val rep=cv_repLib.cv_rep_for [] tm
  val ft=cv_typeLib.from_to_thm_for(type_of tm)
  val cvtm=cv_miscLib.cv_rep_cv_tm(concl rep)
  val conv=cv_computeLib.cv_compute(cv_eqs_for cvtm)
  val ctx=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
  val t1=cpu() val _=print("ADMIT "^label^" "^Real.toString(t1-t0)^"\n")
  fun go i=let val t=cpu() val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) ctx val t2=cpu()
    val dec=CONV_RULE(RAND_CONV EVAL) raw
    val th=List.foldl(fn(h,t)=>PROVE_HYP (prove(h,SIMP_TAC(srw_ss()) [])) t) dec (hyp dec)
    val t3=cpu()
    val _=if null(hyp th) andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) T then () else raise Fail label
    val _=print("SERIES "^label^" "^Int.toString i^" "^String.concatWith " " (map Real.toString [t2-t,t3-t2,cpu()-t3])^"\n")
    in () end
  in go end;
fun run()=let val t0=cpu()
  val [name,n,d,r,rr,b,v]=tokens()
  val k=nn(Int.toString(valOf(Int.fromString d)+1))
  val n=nn n val r=ii r val rr=ii rr val b=nn b val v=ii v
  fun coords()=let val xs=il(tokens()) val z=ii(hd(tokens())) val ys=il(tokens())
      val c=app ``cert`` [n,k,r,rr,b,xs,z]
      val s=boolSyntax.mk_eq(app ``sink`` [n,b,v,z],ys)
      val h=boolSyntax.mk_eq(app ``direct`` [n,r,xs,v],ys)
    in (c,s,h) end
  val (c0,s0,h0)=coords() val (c1,s1,h1)=coords()
  fun both x y=boolSyntax.mk_conj(x,y)
  val cert=both c0 c1 val sink=both s0 s1 val full=both cert sink val direct=both h0 h1
  val _=print("TERMS "^name^" "^Real.toString(cpu()-t0)^"\n")
  val funcs=map (fn (id,tm)=>stage (name^"_"^id) tm) [("cert",cert),("sink",sink),("full",full),("direct",direct)]
  in List.app(fn i=>List.app(fn f=>f i)funcs)[1,2,3,4,5] end;
val _=run();
val _=run();


