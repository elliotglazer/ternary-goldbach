Theory KDot
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

Definition mom_def:
mom (q:num) z k = if z < q then (q ** k - z ** k) DIV (q-z) else 0
End
Definition ap_def:
(ap ([]:int list) (e:int) b t alter = 0:num) /\ (ap (x::xs) e b t alter = Num (e+(if alter /\ t then -x else x)) + b*ap xs e b (~t) alter)
End
Definition ac_def:
ac xs ys e b shift alt = ap xs e b F alt + shift*ap ys e b F alt
End
Definition pairout_def:
pairout prod (h:num) (b:num) (cut:num) (cut2:num) v = if cut=0 \/ cut2=0 \/ b=0 then (0:int,0:int) else (rnd v (&((prod DIV cut) MOD b) - &h), rnd v (&((prod DIV cut2) MOD b) - &h))
End
Definition provided_def:
(provided ([]:num list) hs (r:int) pos neg b x y v = []:int list) /\ (provided (a::ws) [] r pos neg b x y v = []) /\ (provided (a::ws) (h::hs) r pos neg b x y v = let (l,m)=pairout ((if r<0 then neg else pos)*a) h b x y v in l::m::provided ws hs (r+1024) pos neg b x y v)
End
Definition makeq_def:
(makeq 0 (r:int) q k e = []:num list) /\ (makeq (SUC n) r q k e = e*mom q (Num(ABS r)) k :: makeq n (r+1024) q k e)
End
Definition cold_def:
cold n r q k xs ys e b x y shift v = provided (makeq n r (q*b) k 1) (makeq n r q k (Num e)) r (ac xs ys e b shift F) (ac xs ys e b shift T) b x y v
End
val _=cv_auto_trans signed_def;
val _=cv_auto_trans cold_def;
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
 val [name,n,r,k,q,v,e,b,x,y,shift]=tokens()
 val n=nn n val r=ii r val k=nn k val q=nn q val v=ii v val e=ii e val b=nn b val x=nn x val y=nn y val shift=nn shift
 val dx=il(tokens()) val dy=il(tokens()) val xs=il(tokens()) val ys=il(tokens()) val [pos,neg]=map nn(tokens()) val ws=nl(tokens()) val hs=nl(tokens()) val ex=il(tokens())
 val direct=app ``signed`` [n,r,dx,dy,v]
 val cold=app ``cold`` [n,r,q,k,xs,ys,e,b,x,y,shift,v]
 val warm=app ``provided`` [ws,hs,r,pos,neg,b,x,y,v]
 val _=print("TERMS "^name^" "^Real.toString(cpu()-t0)^"\n")
 val jobs=if String.isSuffix "full" name then [("direct",direct),("cold",cold)] else [("direct",direct),("warm",warm)]
 val funcs=map(fn(id,tm)=>stage(name^"_"^id)(boolSyntax.mk_eq(tm,ex))) jobs
 in List.app(fn i=>List.app(fn f=>f i)funcs)[1,2,3,4,5] end;
val _=List.app (fn _=>run()) [1,2,3,4,5,6];

