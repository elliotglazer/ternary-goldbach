Theory ShortGuard
Ancestors CountReceipt FullCount arithmetic
Libs meter cv_transLib

open meter;

Theorem exact_pair_count:
  !m1 m2 k1 k2 off n:num.
    (EVEN m1 <=> EVEN k1) /\ (EVEN m2 <=> EVEN k2) /\
    n=m1+m2+2*off /\ k1+k2 <= n /\ n<k1+k2+2 ==>
    n=k1+k2
Proof
  rpt strip_tac >>
  `EVEN n <=> EVEN (k1+k2)` by
     (asm_simp_tac (srw_ss())[EVEN_ADD,EVEN_MULT] >> metis_tac[]) >>
  metis_tac[FullCountTheory.exact_count_of_parity]
QED

Definition parity_test_def:
  parity_test h a b pos1 end1 pos2 end2 (ma:(num#num) option) (aa:(num#num) option)
                                       (mb:(num#num) option) (ab:(num#num) option) =
    case (ma,aa,mb,ab) of
      (SOME (k1,wm1), SOME (ka1,w1), SOME (k2,wm2), SOME (ka2,w2)) =>
        ((EVEN k1) = (pos1 = (end1:bool))) /\ ((EVEN k2) = (pos2 = (end2:bool))) /\
        saturates h a b (k1+k2+1) (w1+w2)
    | _ => F
End
val _=cv_auto_trans parity_test_def;
val ins=TextIO.openIn "short.txt";
fun line()=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
fun block (a::n::w::rest)=pairSyntax.mk_pair(nat a,pairSyntax.mk_pair(nat n,nat w))::block rest
  | block []=[] | block _=raise Fail "block";
fun asbool "1"=boolSyntax.T | asbool "0"=boolSyntax.F | asbool _=raise Fail "sign";
fun channel main =
  let val [label,z,t,lower,upper,flips,w,len]=line()
      val bs=block(line())
      val _=if Int.toString(length bs)=len then () else raise Fail "length"
      val xs=listSyntax.mk_list(bs,``:num#num#num``)
      val name="aux25_"^label
      val def=new_definition(name^"_def",mk_eq(mk_var(name,type_of xs),xs))
      val th=evaluate name ``FullCount$scan_between`` [nat lower,nat upper,xs]
      val inp=list_mk_comb(``FullCount$scan_between``,[nat lower,nat upper])
      val aux=TRANS(AP_TERM inp def) th
      val _=if closed main andalso closed aux andalso aconv (optionSyntax.dest_some(rhs(concl aux)))
                    (pairSyntax.mk_pair(nat flips,nat w)) then () else raise Fail name
  in ([asbool z,asbool t],[main,aux]) end;
fun verify (p,mainA,mainB) =
  let val args = map nat(line())
      val (s1,a)=channel mainA
      val (s2,b)=channel mainB
      val xs=a@b
      val pre=args@s1@s2
      val res=EVAL(list_mk_comb(``parity_test``,pre@map(rhs o concl) xs))
      val lift=List.foldl(fn(eq,acc)=>MK_COMB(acc,eq))
         (REFL(list_mk_comb(``parity_test``,pre))) xs
      val th=TRANS lift res
      val _=if closed th andalso aconv(rhs(concl th)) boolSyntax.T then () else raise Fail p
  in save_thm("parity_width25_"^p,th) end;
val _=verify ("even",CountReceiptTheory.runs_000_checked,CountReceiptTheory.runs_010_checked);
val _=verify ("odd",CountReceiptTheory.runs_100_checked,CountReceiptTheory.runs_110_checked);
val _=if Option.isSome(TextIO.inputLine ins) then raise Fail "extra rows" else TextIO.closeIn ins;
val _=print "PARITY_WIDTH25_DONE\n";
