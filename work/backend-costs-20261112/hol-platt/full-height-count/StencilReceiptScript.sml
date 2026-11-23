Theory StencilReceipt
Ancestors integer list
Libs encoding intLib

open meter;

Definition dot_def:
  (dot ([]:int list) ys = (0:int)) /\
  (dot (w::ws) ys =
    case ys of [] => 0 | x::xs => w*x + dot ws xs)
End
val _=cv_auto_trans dot_def;
fun store name th = if closed th then save_thm(name,th) else raise Fail name;
val ins=TextIO.openIn "stencils.txt";
fun line()=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
fun scalar()=valOf(Int.fromString(hd(line())));
fun ints ls=listSyntax.mk_list(map integer ls,``:int``);
fun named name tm = new_definition(name^"_def",mk_eq(mk_var(name,type_of tm),tm));
(* Keep named coefficient encodings for all later uses. *)
fun table k =
  let val (r,d,t) = case line() of [i,r,offset,d,t] =>
            if valOf(Int.fromString i)=k then (r,d,t) else raise Fail "order"
          | _ => raise Fail "header"
      val ss=line()
      val _=if Int.toString(length ss)=r then () else raise Fail "stencil length"
      val xs=ints ss
      val n="kernel_"^Int.toString k
      val def=named n xs
      val [encoder,_]= #2(strip_comb(concl(cv_typeLib.from_to_thm_for(type_of xs))))
      val enc=store (n^"_encoding") (TRANS(AP_TERM encoder def)(EVAL(mk_comb(encoder,xs))))
      val threshold=rhs(concl(EVAL(mk_comb(mk_comb(``($*):int->int->int``,integer d),integer t))))
  in (lhs(concl def),enc,threshold,r) end;
val tables=Vector.tabulate(scalar(),table);
val inverse=cv_typeLib.from_to_thm_for ``:int``;
val [_,decoder]= #2(strip_comb(concl inverse));
val decode_recode=REWRITE_RULE[cv_typeTheory.from_to_def]inverse;
fun job ix =
  let val (label,at,k,pos) = case line() of [label,at,k,sg] =>
            (label,at,valOf(Int.fromString k),sg="1")
          | _ => raise Fail "job"
      val (ws,old,threshold,order)=Vector.sub(tables,k)
      val ss=line()
      val _=if Int.toString(length ss)=order then () else raise Fail "sample count"
      val xs=ints ss
      val n="y_"^label^"_"^at
      val def=named n xs
      val raw=encoding.produce n ``StencilReceipt$dot`` [ws,xs] [REWR_CONV old,EVAL]
      val dotval=TRANS(SYM(SPEC(rand(lhs(concl raw)))decode_recode))
                    (CONV_RULE(RAND_CONV EVAL)(AP_TERM decoder raw))
      val eq=TRANS(AP_TERM(mk_comb(``StencilReceipt$dot``,ws)) def) dotval
      val cmp=``($<):int->int->bool``
      val inequality=if pos then AP_TERM (mk_comb(cmp,threshold)) eq
           else MK_COMB(AP_TERM cmp eq,REFL(intSyntax.mk_negated threshold))
      val compact=CONV_RULE(RAND_CONV EVAL) inequality
      val _=if aconv(rhs(concl compact)) boolSyntax.T then () else raise Fail "strict margin"
  in store (n^"_checked") (EQT_ELIM compact) end;
val jobs=List.tabulate(scalar(),job);
val _=if Option.isSome(TextIO.inputLine ins) then raise Fail "unused rows" else TextIO.closeIn ins;
val _=print ("STRICT_STENCIL_JOBS "^Int.toString(length jobs)^"\n");
