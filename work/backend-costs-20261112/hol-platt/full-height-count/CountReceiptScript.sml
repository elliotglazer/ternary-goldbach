Theory CountReceipt
Ancestors FullCount
Libs meter cv_transLib

open meter;

Definition pair_test_def:
  pair_test guards phase allowance (ma:(num#num) option) (aa:(num#num) option)
                                   (mb:(num#num) option) (ab:(num#num) option) =
    case (ma,aa,mb,ab) of
      (SOME (k1,wm1), SOME (ka1,w1), SOME (k2,wm2), SOME (ka2,w2)) =>
        saturates guards phase allowance (k1+k2) (w1+w2)
    | _ => F
End
val _=cv_auto_trans pair_test_def;

val input=TextIO.openIn "packets.txt";
fun line()=String.tokens Char.isSpace(valOf(TextIO.inputLine input));
fun block (a::b::w::rest)=pairSyntax.mk_pair(nat a,pairSyntax.mk_pair(nat b,nat w))::block rest
  | block []=[] | block _=raise Fail "incomplete sign block";
fun require cond msg=if cond then () else raise Fail msg;
fun store name th= (require (closed th) ("proof tag for "^name); save_thm(name,th));
fun scan pair label region =
  let val fields=line()
      val (l,u,k,w,total) = case fields of
          [p,j,r,l,u,entries,k,w,total] =>
            (require ([p,j,r]=map Int.toString [pair,label,region]) "packet order"; (l,u,k,w,total))
        | _ => raise Fail "packet header"
      val bs=block(line())
      val _=require (length bs=valOf(Int.fromString total)) "packet size"
      val xs=listSyntax.mk_list(bs,``:num#num#num``)
      val name="runs_"^String.concat(map Int.toString [pair,label,region])
      val def=new_definition(name^"_def",mk_eq(mk_var(name,type_of xs),xs))
      val th=evaluate name ``FullCount$scan_between`` [nat l,nat u,xs]
      val result=optionSyntax.dest_some(rhs(concl th))
      val _=require (aconv result (pairSyntax.mk_pair(nat k,nat w))) "brackets or weights"
      val prefix=list_mk_comb(``FullCount$scan_between``,[nat l,nat u])
      val moved=TRANS (AP_TERM prefix def) th
  in store (name^"_checked") moved end;
fun verify p =
  let val readings=map (fn (j,r)=>scan p j r) [(0,0),(0,1),(1,0),(1,1)]
      val operands=map nat (line())
      val _=require (length operands=3) "phase/guard data"
      val concrete=EVAL(list_mk_comb(``CountReceipt$pair_test``,
                     operands @ map (rhs o concl) readings))
      val lifted=List.foldl (fn (eq,fnEq)=>MK_COMB(fnEq,eq))
                     (REFL(list_mk_comb(``CountReceipt$pair_test``,operands))) readings
      val result=store ("pair"^Int.toString p^"_full_count_test") (TRANS lifted concrete)
      val _=print ("PAIR_RESULT "^Int.toString p^" "^term_to_string(rhs(concl result))^"\n")
  in result end;
val both=map verify [0,1];
val _=require (not(Option.isSome(TextIO.inputLine input))) "unexpected packet";
val _=TextIO.closeIn input;
val _=print "FULL_COUNT_RECEIPT_DONE\n";
