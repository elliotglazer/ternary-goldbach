Theory NatPair
Ancestors arithmetic integer list cv_std
Libs cv_transLib intLib
Definition np_def:
(np (z:num) ([]:num list) = 0) /\ (np z (a::xs) = a+z*np z xs)
End
Definition ip_def:
(ip (z:int) ([]:int list) = 0) /\ (ip z (a::xs) = a+z*ip z xs)
End
Definition rnd_def:
rnd (v:int) x = if v=0 then 0 else (x+v / 2) / v
End
val pre_def = cv_trans_pre "rnd_pre" rnd_def;
Theorem pre_ok[cv_pre]:
 !v x. rnd_pre v x
Proof
 simp [pre_def]
QED
Definition signed_def:
(signed 0 r xs ys v = []:int list) /\ (signed (SUC n) r xs ys v = rnd v (ip r xs) :: rnd v (ip r ys) :: signed n (r+1024) xs ys v)
End
Definition bits_def:
bits (r:int) pos neg = np (Num (ABS r)) (if r<0 then neg else pos)
End
Definition unpk_def:
unpk (b:num) h v (x:num) = if b=0 then (0:int,0:int) else (rnd v (&(x MOD b) - &h),rnd v (&(x DIV b) - &h))
End
Definition paired_def:
(paired ([]:num list) r pos neg b v = []:int list) /\ (paired (h::hs) r pos neg b v = let (x,y)=unpk b h v (bits r pos neg) in x::y::paired hs (r+1024) pos neg b v)
End
Definition hs_def:
(hs 0 r bias = []:num list) /\ (hs (SUC n) (r:int) bias = np (Num (ABS r)) bias :: hs n (r+1024) bias)
End
Definition col_def:
(col ([]:int list) ys (fs:num list) (e:int) b (t:bool) = []:num list) /\ (col (x::xs) [] fs e b t = []) /\ (col (x::xs) (y::ys) [] e b t = []) /\ (col (x::xs) (y::ys) (f::fs) e b t = (Num(e+(if t then -x else x))+b*Num(e+(if t then -y else y)))*f :: col xs ys fs e b (~t))
End
Definition poscol_def:
(poscol ([]:int list) ys (fs:num list) (e:int) b = []:num list) /\ (poscol (x::xs) [] fs e b = []) /\ (poscol (x::xs) (y::ys) [] e b = []) /\ (poscol (x::xs) (y::ys) (f::fs) e b = (Num(e+x)+b*Num(e+y))*f :: poscol xs ys fs e b)
End
Definition cold_def:
cold n r xs ys fs e b v bias = paired (hs n r bias) r (poscol xs ys fs e b) (col xs ys fs e b F) b v
End
val _=cv_auto_trans cold_def;
val _=cv_auto_trans signed_def;
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
fun nl xs=listSyntax.mk_list(map nn xs,type_of ``0:num``);
fun run()=let val t0=cpu()
 val [name,n,r,e,b,v]=tokens()
 val n=nn n val r=ii r val e=ii e val b=nn b val v=ii v
 val dx=il(tokens()) val dy=il(tokens()) val xs=il(tokens()) val ys=il(tokens())
 val fs=nl(tokens()) val bias=nl(tokens()) val p=nl(tokens()) val m=nl(tokens()) val hh=nl(tokens())
 val expected=il(tokens())
 val direct=app ``signed`` [n,r,dx,dy,v]
 val warm=app ``paired`` [hh,r,p,m,b,v]
 val pc=app ``poscol`` [xs,ys,fs,e,b] val mc=app ``col`` [xs,ys,fs,e,b,F]
 val shared=app ``paired`` [hh,r,pc,mc,b,v]
 val cold=app ``cold`` [n,r,xs,ys,fs,e,b,v,bias]
 val _=print("TERMS "^name^" "^Real.toString(cpu()-t0)^"\n")
 val funcs=map(fn(id,tm)=>stage(name^"_"^id)(boolSyntax.mk_eq(tm,expected))) [("direct",direct),("warm",warm),("shared",shared),("cold",cold)]
 in List.app(fn i=>List.app(fn f=>f i)funcs)[1,2,3,4,5] end;
val _=run();
val _=run();

