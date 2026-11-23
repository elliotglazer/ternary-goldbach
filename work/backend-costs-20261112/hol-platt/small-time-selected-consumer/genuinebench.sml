open HolKernel Parse boolLib bossLib cv_transLib GenuineHeadTheory;
fun nat s = Arbnum.fromHexString s;
fun natural s = numSyntax.mk_numeral(nat s);
fun integer s = let val negative=String.isPrefix "-" s
    val n=Arbint.fromNat(nat(if negative then String.extract(s,1,NONE) else s))
    in intSyntax.term_of_int(if negative then Arbint.~ n else n) end;
fun readf f=let val inp=TextIO.openIn f val ws=String.tokens Char.isSpace(TextIO.inputAll inp) val _=TextIO.closeIn inp in ws end;
fun run l row=
 let val [w,e,m,a,b,c,ah,bh,ch,x,y,want,n]= readf("g-"^l^"-"^row^".hex")
     val args=map natural [w,e,m]@map integer[a,b,c,ah,bh,ch]@map natural[x,y]@[integer want,natural n]
     fun evalmode mode=let val tm=list_mk_comb(``genuinerow``,numSyntax.term_of_int mode::args)
       val wall=Time.now() val timer=Timer.startCPUTimer() val th=cv_eval tm val {usr,sys}=Timer.checkCPUTimer timer val (o1,axs)=Tag.dest_tag(tag th)
       val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM")o1 andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) boolSyntax.T then () else raise Fail "incorrect genuine head"
       in print(String.concatWith "," [l,row,Int.toString mode,Time.toString(Time.+(usr,sys)),Time.toString(Time.-(Time.now(),wall))]^"\n");TextIO.flushOut TextIO.stdOut end
 in List.app evalmode (if row="128" orelse row="1024" then [2,1,1,2] else [1,2,2,1]) end;
val _=List.app(fn l=>List.app(run l)["0","128","512","1024"])["3","6667","11","9091"];
val _=print "SELECT_DONE\n";
