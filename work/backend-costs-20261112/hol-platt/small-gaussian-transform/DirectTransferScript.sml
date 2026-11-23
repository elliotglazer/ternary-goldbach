Theory DirectTransfer
Ancestors ConductorTables
Libs intLib encoding

open meter;
val _=intLib.ARITH_TAC;
val ins=TextIO.openIn "matched.txt";
val [pp,ee,mm,qr,qi]=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
val _=List.app (fn _=>ignore(valOf(TextIO.inputLine ins))) [1,2,3];
val expected=vector(pairs(String.tokens Char.isSpace(valOf(TextIO.inputLine ins))));
val _=TextIO.closeIn ins;
val prefix=[nat pp,nat ee,nat mm,pair qr qi];
val roots=[ConductorTablesTheory.c10000_roots_encoding,
           ConductorTablesTheory.c10000_chirps_encoding,
           ConductorTablesTheory.c10000_kernel_encoding];
val _=if List.all closed roots then () else raise Fail "table tags";
val args=prefix @ map (rand o lhs o concl) roots;
val fused=encoding.produce "direct" ``Matched$matched`` args
  (map (K EVAL) prefix @ map REWR_CONV roots);
val _=save_thm("c10000_primitive_encoding",fused);
val t=cpu();
val independent=EVAL(mk_comb(rator(lhs(concl fused)),expected));
val _=if aconv(rhs(concl independent))(rhs(concl fused)) then () else raise Fail "independent integer output";
val _=print("DIAGNOSTIC "^Real.toString(cpu()-t)^"\n");
val _=print "DIRECT_RECEIPT_DONE\n";
