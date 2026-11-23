Theory ReadTransfer
Ancestors DirectTransfer
Libs intLib encoding

open meter;
val _=intLib.ARITH_TAC;
Definition interleave_def:
  (interleave ([]:(int#int) list) bs cs ds = []) /\
  (interleave (a::xs) bs cs ds = case bs of [] => [] | b::ys =>
     case cs of [] => [] | c::zs => case ds of [] => [] | d::ws =>
     a::b::c::d::interleave xs ys zs ws)
End
Definition by_frequency_label_def:
  by_frequency_label xs =
    let b=DROP 400 xs; c=DROP 400 b; d=DROP 400 c in
      interleave (TAKE 400 xs) (TAKE 400 b) (TAKE 400 c) d
End
val _=cv_auto_trans by_frequency_label_def;

val source=DirectTransferTheory.c10000_primitive_encoding;
val _=if closed source then () else raise Fail "imported primitive tag";
val input=rand(lhs(concl source));
val reordered=encoding.produce "reorder" ``ReadTransfer$by_frequency_label`` [input] [REWR_CONV source];
val _=save_thm("all_primitive_coefficients_reordered",reordered);
val ins=TextIO.openIn "matched.txt";
val _=List.app (fn _=>ignore(valOf(TextIO.inputLine ins))) [1,2,3,4];
val expected=Vector.fromList(pairs(String.tokens Char.isSpace(valOf(TextIO.inputLine ins))));
val _=TextIO.closeIn ins;
val _=if Vector.length expected=1600 then () else raise Fail "reference size";
val check=vector(List.tabulate(1600,fn i=>Vector.sub(expected,400*(i mod 4)+i div 4)));
val t=cpu();
val independent=EVAL(mk_comb(rator(lhs(concl reordered)),check));
val _=if aconv(rhs(concl independent))(rhs(concl reordered)) then () else raise Fail "reordered coordinates";
val _=print("DIAGNOSTIC "^Real.toString(cpu()-t)^"\n");
val _=print "READBACK_RECEIPT_DONE\n";
