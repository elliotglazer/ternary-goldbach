open HolKernel Parse boolLib bossLib cv_transLib GenuineBatchTheory;
val leaf=Array.array(65536,NONE:term option);
fun literal s=let val n=Arbnum.fromHexString s val k=Arbnum.toInt n in case Array.sub(leaf,k) of
  SOME v=>v | NONE=>let val v=cvSyntax.mk_cv_num(numSyntax.mk_numeral n) in Array.update(leaf,k,SOME v);v end end;
val levels=Vector.tabulate(24,fn k=>mk_comb(prim_mk_const{Name="cv_treeword",Thy="GenuineBatch"},cvSyntax.mk_cv_num(numSyntax.term_of_int k)));
fun packed s=let val n=String.size s val size=(n+3) div 4
  fun width w=if w>=size then w else width(2*w)
  fun get j=if j>=size then literal "0" else
      let val z=n-4*j val i=Int.max(0,z-4) in literal(String.substring(s,i,z-i)) end
  fun join n k j=if j>=size then literal "0" else if n=1 then get j else
      list_mk_comb(Vector.sub(levels,k-1),[join(n div 2)(k-1)j,join(n div 2)(k-1)(j+n div 2)])
  fun lg n=if n=1 then 0 else 1+lg(n div 2)
  val w=width 1 in join w (lg w) 0 end;

val zero=literal "0";
fun integer s=if String.isPrefix "-" s then cvSyntax.mk_cv_pair(packed(String.extract(s,1,NONE)),zero) else packed s;
fun tuples [x]=x | tuples(x::xs)=cvSyntax.mk_cv_pair(x,tuples xs) | tuples []=raise Fail "empty tuple";
val cvbatch=prim_mk_const{Name="cv_batchhead",Thy="GenuineBatch"};
val seed=list_mk_comb(cvbatch,list_mk_comb(Vector.sub(levels,0),[zero,zero])::List.tabulate(8,fn _=>zero));
val solve=cv_computeLib.cv_compute(cv_eqs_for seed);
fun run l k=
 let val inp=TextIO.openIn("b-"^l^"-"^Int.toString k^".hex")
     fun lines ()=case TextIO.inputLine inp of NONE => [] | SOME s=>String.tokens Char.isSpace s::lines()
     val cols::rows=lines() val _=TextIO.closeIn inp
     val args=map integer cols
     val spec=List.foldr cvSyntax.mk_cv_pair zero (map (tuples o map packed) rows)
     fun evalmode mode=let val tm=list_mk_comb(cvbatch,[literal(Int.toString mode),literal(Int.toString k),spec]@args)
       val wall=Time.now() val timer=Timer.startCPUTimer() val th=solve tm val {usr,sys}=Timer.checkCPUTimer timer
       val (o1,axs)=Tag.dest_tag(tag th)
       val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM")o1 andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) (literal "1") then () else raise Fail "incorrect genuine batch"
       in print(String.concatWith "," [l,Int.toString k,Int.toString mode,Time.toString(Time.+(usr,sys)),Time.toString(Time.-(Time.now(),wall))]^"\n");TextIO.flushOut TextIO.stdOut end
 in List.app evalmode (if l="3" orelse l="11" then [1,2,2,1] else [2,1,1,2]) end;
val _=List.app(fn k=>List.app(fn l=>run l k)["3","6667","11","9091"])[0,2,4];
val _=print "SELECT_DONE\n";
