open HolKernel Parse boolLib bossLib cv_transLib ChirpPacketsTheory;
fun integer s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x)s));
fun natural s=numSyntax.mk_numeral(Arbnum.fromString s);
fun readf f=let val h=TextIO.openIn f val ws=String.tokens Char.isSpace(TextIO.inputAll h) val _=TextIO.closeIn h in ws end;
fun one n p sites =
 let val rows::ws=readf("case-"^n^"-"^p^"-"^sites^".txt")
     val input=List.take(ws,length ws-1) val checksum=List.last ws
     fun measure mode=let val args=[natural rows,natural(Int.toString mode)]@map integer(input@[if mode=1 then "0" else checksum])
       val tm=list_mk_comb(``accept``,args) val timer=Timer.startCPUTimer() val th=cv_eval tm val {usr,sys}=Timer.checkCPUTimer timer
       val (o1,axs)=Tag.dest_tag(tag th)
       val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM")o1 andalso aconv(lhs(concl th))tm andalso aconv(rhs(concl th)) boolSyntax.T then () else raise Fail "packet"
       in print(String.concatWith ","[n,p,sites,Int.toString mode,Time.toString(Time.+(usr,sys))]^"\n");TextIO.flushOut TextIO.stdOut end
 in List.app measure [1,2,2,1] end;
val _=List.app(fn (n,p)=> List.app(one n p)["64","1024","4096"])[("524288","240"),("262144","238"),("524288","128")];
val _=print "SELECT_DONE\n";
