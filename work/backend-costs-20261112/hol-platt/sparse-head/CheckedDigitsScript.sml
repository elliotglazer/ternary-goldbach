Theory CheckedDigits
Ancestors ProducedRange GenuineHead
Libs cv_transLib intLib
Definition checked_def:
 (checked 0 w e m a b x y = (m=0:num,0:int,1:int)) /\
 (checked (SUC n) w e m a b x y =
 if m=0 then (T,0,1) else
 let j=SelectedBias$tz 64 m; sa=2**(544*j); sr=2**(243*j);d=SelectedBias$nd m (2**j);
     (a0,an)=SelectedBias$dq (SelectedBias$nd a sa) (2**544);
     (b0,bn)=SelectedBias$dq (SelectedBias$nd b sa) (2**544);
     (x0,xn)=SelectedBias$dq (SelectedBias$nd x sr) (2**243);
     (y0,yn)=SelectedBias$dq (SelectedBias$nd y sr) (2**243);
     (ok,v,mul)=checked n w e (d DIV 2) an bn xn yn;
     digit=TwoHead$twoval w e (&a0- &(2**543)) (&b0- &(2**543)) (&x0- &(2**242)) (&y0- &(2**242))
 in (ok /\ 0<=digit /\ digit < &(2**w),digit+ &(2**w)*v, &(2**w)*mul))
End
val _=cv_auto_trans checked_def;
Theorem value_agrees:
 !n w e m a b x y. SND(checked n w e m a b x y)=TwoHead$twosweep n w e m a b x y
Proof
 Induct >> rpt gen_tac >> simp[checked_def,TwoHeadTheory.twosweep_def,LET_THM,pairTheory.UNCURRY] >>
 Cases_on `m=0` >> simp[] >> fs[pairTheory.PAIR_EQ]
QED
Definition checkedrow_def:
 checkedrow w e m (a:int) b c ah bh ch x y want count =
 let H= &(2**(544*64)); za=a+H*ah;zb=b+H*bh;zc=c+H*ch;
     B=repblk 6 544 1 (&(2**543));
     (pl,ph)=TwoHead$subfused H B (za-zb);(ql,qh)=TwoHead$subfused H B (zc-za-zb)
 in ph=ah-bh /\ qh=ch-ah-bh /\
    checked 64 w e m pl ql x y=(T,want,&(2**(w*count)))
End
val _=cv_auto_trans checkedrow_def;

open HolKernel Parse boolLib bossLib cv_transLib GenuineHeadTheory;
fun nat s = Arbnum.fromHexString s;
fun natural s = numSyntax.mk_numeral(nat s);
fun integer s = let val negative=String.isPrefix "-" s
    val n=Arbint.fromNat(nat(if negative then String.extract(s,1,NONE) else s))
    in intSyntax.term_of_int(if negative then Arbint.~ n else n) end;
fun readf f=let val inp=TextIO.openIn f val ws=String.tokens Char.isSpace(TextIO.inputAll inp) val _=TextIO.closeIn inp in ws end;
fun run l row=
 let val [w,e,m,a,b,c,ah,bh,ch,x,y,want,n]= readf("../small-time-selected-consumer/g-"^l^"-"^row^".hex")
     val args=map natural [w,e,m]@map integer[a,b,c,ah,bh,ch]@map natural[x,y]@[integer want,natural n]
     fun evalmode mode=let val tm=if mode=3 then list_mk_comb(``checkedrow``,args) else list_mk_comb(``genuinerow``,numSyntax.term_of_int mode::args)
       val wall=Time.now() val timer=Timer.startCPUTimer() val th=cv_eval tm val {usr,sys}=Timer.checkCPUTimer timer val (o1,axs)=Tag.dest_tag(tag th)
       val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM")o1 andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) boolSyntax.T then () else raise Fail "incorrect genuine head"
       in print(String.concatWith "," [l,row,Int.toString mode,Time.toString(Time.+(usr,sys)),Time.toString(Time.-(Time.now(),wall))]^"\n");TextIO.flushOut TextIO.stdOut end
 in List.app evalmode (if row="128" orelse row="1024" then [2,3,3,2] else [3,2,2,3]) end;
val _=List.app(fn l=>List.app(run l)["0","128","512","1024"])["3","6667","11","9091"];
val _=print "SELECT_DONE\n";

