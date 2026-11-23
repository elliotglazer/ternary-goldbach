Theory DynamicPrice
Ancestors DynamicPhase
Libs intLib cv_transLib
fun nat s=numSyntax.mk_numeral(Arbnum.fromString s);
fun integer s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x) s));
fun pair a b=pairSyntax.mk_pair(a,b);
fun cpu()=let val t=Timer.checkCPUTimer(Timer.totalCPUTimer()) in Time.toReal(#usr t)+Time.toReal(#sys t) end;
val input=TextIO.openIn "strips.txt";
fun readrows()=case TextIO.inputLine input of NONE=>[] | SOME s=>String.tokens Char.isSpace s ::readrows();
val rows=readrows();
val _=TextIO.closeIn input;
fun verify [q,start,n,u,v,r,i,er,ei,x,y,a,b,m]=
 let val t0=cpu()
     val w=pair(integer u)(integer v)
     val z=pair(integer r)(integer i)
     val tgt=pair(integer er)(integer ei)
     val tm=list_mk_comb(``strip``,[nat n,w,z,nat x,nat y,nat a,nat b,nat m,tgt])
     val t1=cpu()
     val th=EQT_ELIM(cv_transLib.cv_eval tm)
     val t2=cpu()
     val _=save_thm("strip_"^q^"_"^start,th)
 in print("DYNAMIC_ROW "^String.concatWith " " [q,start,n,Real.toString(t1-t0),Real.toString(t2-t1),Real.toString(cpu()-t2)]^"\n") end
 | verify _=raise Fail "row";
val _=List.app verify rows;

