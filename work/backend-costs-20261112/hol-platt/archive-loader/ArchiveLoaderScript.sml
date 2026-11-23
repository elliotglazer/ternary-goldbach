Theory ArchiveLoader
Ancestors CountReceipt

fun demand true = () | demand false = raise Fail "archive mismatch";
fun timed tag f =
  let val t = Timer.startCPUTimer()
      val out = f()
      val {usr,sys} = Timer.checkCPUTimer t
  in print ("ARCHIVE_TIME "^tag^" "^Time.toString(Time.+(usr,sys))^"\n"); out end;
fun textread () =
  let val f = TextIO.openIn "../full-height-count/packets.txt"
      fun line () = map (valOf o IntInf.fromString) (String.tokens Char.isSpace
                    (valOf(TextIO.inputLine f)))
      fun runs (a::b::w::rest) = (a,b,w)::runs rest
        | runs [] = [] | runs _ = raise Fail "truncated text"
      fun group () = let val rows=List.tabulate(4,fn _ =>
                         let val h=line() in (h,runs(line())) end)
                     in (rows,line()) end
      val out=List.tabulate(2,fn _ => group())
  in demand(not(isSome(TextIO.inputLine f)));TextIO.closeIn f;out end;
fun binread () =
  let val f=BinIO.openIn "../grid-sign-join/packets-q10000.bin"
      val b=BinIO.inputAll f
      val _=BinIO.closeIn f
      val pos=ref 8
      val _=demand(Byte.bytesToString(Word8VectorSlice.vector
            (Word8VectorSlice.slice(b,0,SOME 8)))="SGNRUN01")
      fun num n =
        let val start= !pos
            fun loop i v = if i=0 then v else loop (i-1)
             (v*256 + IntInf.fromInt(Word8.toInt(Word8Vector.sub(b,start+i-1))))
        in pos:=start+n; loop n (0:IntInf.int) end
      fun row () = let val h=List.tabulate(9,fn _=>num 8)
        in (h,List.tabulate(IntInf.toInt(List.last h),fn _ =>
             let val a=num 4 val n=num 1 in (a,n,num 8) end)) end
      fun group () = let val rows=List.tabulate(4,fn _=>row())
                     in (rows,List.tabulate(3,fn _=>num 8)) end
      val out=List.tabulate(2,fn _=>group())
  in demand(!pos=Word8Vector.length b);out end;
fun nat n=numSyntax.mk_numeral(Arbnum.fromString(IntInf.toString n));
fun terms groups = List.concat(map (fn (rows,_) => map (fn (_,runs) =>
    listSyntax.mk_list(map (fn (a,b,w)=>pairSyntax.mk_pair(nat a,
      pairSyntax.mk_pair(nat b,nat w))) runs,``:num#num#num``)) rows) groups);
val names=["000","001","010","011","100","101","110","111"];
fun check xs = ListPair.appEq (fn (x,name) => demand(aconv x
     (rhs(concl(DB.fetch "CountReceipt" ("runs_"^name^"_def")))))) (xs,names);
fun bench binaryFirst =
  let fun run tag load = let val data=timed (tag^"_decode") load
             val ts=timed (tag^"_terms") (fn()=>terms data)
             val _=timed (tag^"_check") (fn()=>check ts)
           in data end
      val (a,b)=if binaryFirst then
                  let val b=run "bin" binread in (run "text" textread,b) end
                else let val a=run "text" textread in (a,run "bin" binread) end
  in demand(a=b) end;
val _=List.app bench [true,false,true,false];
val _=print "ARCHIVE_LOADERS_CHECKED\n";
