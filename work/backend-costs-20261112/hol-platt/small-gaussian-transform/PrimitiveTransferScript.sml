Theory PrimitiveTransfer
Ancestors GaussianTransfer Matched
Libs intLib encoding

open meter;
val _=intLib.ARITH_TAC;
val ins=TextIO.openIn "matched.txt";
fun next()=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
val [pp,ee,mm,qr,qi]=next();
val p=nat pp and extra=nat ee and m=nat mm and q=pair qr qi;
fun readvec count=let val xs=pairs(next()) in
  if length xs=count then vector xs else raise Fail "length" end;
val roots=readvec 512 and chirps=readvec 500 and kernel=readvec 1024 and expected=readvec 1600;
val _=if Option.isSome(TextIO.inputLine ins) then raise Fail "trailing data" else TextIO.closeIn ins;
val source=GaussianTransferTheory.c10000_bucket_encoding;
val _=if closed source then () else raise Fail "imported source tag";
val outer=[p,extra,roots,chirps,kernel];
val bucketTerm=list_mk_comb(``Gauss$produce``,[nat "10000",m,p,q]);
val result=encoding.produce "primitive" ``Matched$matched_after``
  (outer@[bucketTerm]) (map (K EVAL) outer@[REWR_CONV source]);
val full=list_mk_comb(``Matched$matched``,[p,extra,m,q,roots,chirps,kernel]);
val enc=rator(lhs(concl result));
val th=TRANS (AP_TERM enc (REWR_CONV MatchedTheory.matched_def full)) result;
val _=if closed th then () else raise Fail "combined tag";
val _=save_thm("c10000_primitive_encoding",th);
val t=cpu();
val check=EVAL(mk_comb(enc,expected));
val _=if aconv(rhs(concl check))(rhs(concl th)) then () else raise Fail "independent vector mismatch";
val _=print("DIAGNOSTIC "^Real.toString(cpu()-t)^"\n");
val _=print "CONSUMER_RECEIPT_DONE\n";
