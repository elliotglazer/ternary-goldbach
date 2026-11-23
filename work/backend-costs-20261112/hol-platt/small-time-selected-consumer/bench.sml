open HolKernel Parse boolLib bossLib cv_transLib SelectedHeadTheory;
fun integer s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x)s));
fun natural s=numSyntax.mk_numeral(Arbnum.fromString s);
fun getrow l=let val f=TextIO.openIn("term-"^l^".txt") val fields=String.tokens Char.isSpace(TextIO.inputAll f) val _=TextIO.closeIn f
 in case fields of [w,e,m,a,b,c,x,y,h,n]=>[natural w,natural e,natural m,integer a,integer b,integer c,integer x,integer y,integer h,natural n] | _=>raise Fail "row" end;
fun run label codes rows =
 let val inp=getrow label
 fun measure k mode = let val tm=list_mk_comb(``repeat_test``,[numSyntax.term_of_int mode,numSyntax.term_of_int k]@inp)
  val wall=Time.now() val timer=Timer.startCPUTimer() val th=cv_eval tm val {usr,sys}=Timer.checkCPUTimer timer
  val (o1,axs)=Tag.dest_tag(tag th)
  val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM")o1 andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) boolSyntax.T then () else raise Fail "head equality"
 in print(String.concatWith "," [label,Int.toString k,Int.toString mode,Time.toString(Time.+(usr,sys)),Time.toString(Time.-(Time.now(),wall))]^"\n");TextIO.flushOut TextIO.stdOut end
 in List.app(fn k=>List.app(measure k)codes) rows end;
val _=List.app(fn label=>run label [1,2] [0]) ["3","6667","11","9091"];
val _=run "3" [0,1,2] [4,6,10];
val _=print "SELECT_DONE\n";
