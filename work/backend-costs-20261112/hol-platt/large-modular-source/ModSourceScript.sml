Theory ModSource
Ancestors arithmetic integer list cv_std
Libs cv_transLib intLib

Definition hor_def:
  (hor (r:int) ([]:int list) = 0) /\
  (hor r (x::xs) = x+r*hor r xs)
End
Definition rd_def:
  rd (v:int) x = if v=0 then 0 else (x+v / 2) / v
End
Definition digit_def:
  digit (v:int) bias m x =
    if v=0 \/ m<=0 then 0 else (x % m) / v - bias
End
Definition mods_def:
  (mods ([]:int list) v bias t x y = []:int list) /\
  (mods (r::rs) v bias t x y =
    let m=t-r in digit v bias m x :: digit v bias m y :: mods rs v bias t x y)
End
Definition refs_def:
  (refs ([]:int list) v xs ys = []:int list) /\
  (refs (r::rs) v xs ys =
    rd v (hor r xs) :: rd v (hor r ys) :: refs rs v xs ys)
End
Definition cold_def:
  cold rs v bias t base shift xs ys =
    mods rs v bias t (v*hor base xs+shift) (v*hor base ys+shift)
End
val rd_pre_def = cv_trans_pre "rd_pre" rd_def;
Theorem rd_ok[cv_pre]:
  !v x. rd_pre v x
Proof
  simp[rd_pre_def]
QED
val digit_pre_def = cv_trans_pre "digit_pre" digit_def;
Theorem digit_ok[cv_pre]:
  !v bias m x. digit_pre v bias m x
Proof
  simp[digit_pre_def] >> intLib.ARITH_TAC
QED
val _ = cv_auto_trans cold_def;
val _ = cv_auto_trans refs_def;

val clk = Timer.startCPUTimer();
fun cpu() = let val {usr,sys} = Timer.checkCPUTimer clk in Time.toReal(Time.+(usr,sys)) end;
val io = TextIO.openIn "terms.txt";
fun tokens() = case TextIO.inputLine io of SOME line => String.tokens Char.isSpace line | NONE => raise Fail "end";
fun ii x = intSyntax.term_of_int(Arbint.fromString x);
fun il xs = listSyntax.mk_list(map ii xs,type_of ``0:int``);
fun stage label tm = let
  val t0=cpu()
  val rep=cv_repLib.cv_rep_for [] tm
  val ft=cv_typeLib.from_to_thm_for(type_of tm)
  val cvtm=cv_miscLib.cv_rep_cv_tm(concl rep)
  val conv=cv_computeLib.cv_compute(cv_eqs_for cvtm)
  val ctx=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
  val _=print("ADMIT "^label^" "^Real.toString(cpu()-t0)^"\n")
  fun go i = let val t=cpu()
    val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) ctx
    val t2=cpu()
    val dec=CONV_RULE(RAND_CONV EVAL) raw
    val th=List.foldl(fn(h,t)=>PROVE_HYP (prove(h,SIMP_TAC(srw_ss()) [])) t) dec (hyp dec)
    val t3=cpu()
    val _=if null(hyp th) andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) T then () else raise Fail label
    in print("MODCHECK "^label^" "^Int.toString i^" "^Real.toString(t2-t)^" "^Real.toString(t3-t2)^"\n") end
  in go end;
fun runCell() = let
  val name::fields=tokens()
  val [den,bias,center,base,shift]=map ii fields
  val rs=il(tokens())
  val [x,y]=map ii(tokens())
  val dx=il(tokens()) val dy=il(tokens())
  val xs=il(tokens()) val ys=il(tokens())
  val outputs=il(tokens())
  fun setup(id,f,args)=stage (name^"_"^id) (boolSyntax.mk_eq(list_mk_comb(f,args),outputs))
  val workers=map setup [("reference",``refs``,[rs,den,dx,dy]),
                         ("warm",``mods``,[rs,den,bias,center,x,y]),
                         ("cold",``cold``,[rs,den,bias,center,base,shift,xs,ys])]
  in List.app(fn i=>List.app(fn w=>w i)(if i mod 2=1 then workers else rev workers)) [1,2,3,4,5,6,7] end;
val _ = List.app (fn _=>runCell()) [1,2,3,4,5,6];
val _ = TextIO.closeIn io;
val _ = print("MODULAR_SOURCE_DONE\n");
