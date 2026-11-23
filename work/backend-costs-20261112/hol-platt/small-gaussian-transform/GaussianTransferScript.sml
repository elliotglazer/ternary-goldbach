Theory GaussianTransfer
Ancestors Gauss
Libs intLib encoding

open meter;
val _=intLib.ARITH_TAC;
val ins=TextIO.openIn "matched.txt";
val [pp,_,mm,qr,qi]=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
val _=TextIO.closeIn ins;
val args=[nat "10000",nat mm,nat pp,pair qr qi];
val th=encoding.produce "buckets" ``Gauss$produce`` args (map (K EVAL) args);
val _=save_thm("c10000_bucket_encoding",th);
val _=print "SOURCE_RECEIPT_DONE\n";
