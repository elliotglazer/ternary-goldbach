open HolKernel Parse boolLib bossLib cv_transLib SelectedHeadTheory SelectedMasksTheory;
fun integer s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x)s));
fun natural s=numSyntax.mk_numeral(Arbnum.fromString s);
fun readf f=let val inp=TextIO.openIn f val ws=String.tokens Char.isSpace(TextIO.inputAll inp) val _=TextIO.closeIn inp in ws end;
fun run l d modes =
 let val [w,e,_,a,b,c,x,y,_,_]=readf("term-"^l^".txt")
     val [mask,h,count]=readf("mask-"^l^"-"^d^".txt")
     val inp=[natural w,natural e,numSyntax.mk_numeral(Arbnum.fromHexString mask),
       integer a,integer b,integer c,integer x,integer y,intSyntax.term_of_int(Arbint.fromNat(Arbnum.fromHexString h)),natural count]
 fun measure mode=let val tm=list_mk_comb(``test_mask``,[numSyntax.term_of_int mode,numSyntax.term_of_int 10]@inp)
   val wall=Time.now() val timer=Timer.startCPUTimer() val th=cv_eval tm val {usr,sys}=Timer.checkCPUTimer timer val (o1,axs)=Tag.dest_tag(tag th)
   val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM")o1 andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) boolSyntax.T then () else raise Fail "bad packed heads"
 in print(String.concatWith "," [l,d,Int.toString mode,Time.toString(Time.+(usr,sys)),Time.toString(Time.-(Time.now(),wall))]^"\n");TextIO.flushOut TextIO.stdOut end
 in List.app measure modes end;
val _=List.app(fn l=>List.app(fn d=>run l d (if d="2" then [0,1,2] else [0,2,1]))["2","3"])["3","6667","11","9091"];
val _=print "SELECT_DONE\n";
