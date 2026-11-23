Theory DynamicCarry
Ancestors DynamicPhase
Libs intLib cv_transLib
fun nat s=numSyntax.mk_numeral(Arbnum.fromString s);
fun integer s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x) s));
fun pair a b=pairSyntax.mk_pair(integer a,integer b);
fun cpu()=let val t=Timer.checkCPUTimer(Timer.totalCPUTimer()) in Time.toReal(#usr t)+Time.toReal(#sys t) end;
val f=TextIO.openIn "strips.txt";
fun readall()=case TextIO.inputLine f of NONE=>[] | SOME l=>String.tokens Char.isSpace l::readall();
val rows=readall();
val _=TextIO.closeIn f;
fun link q0 j0 prev []=() | link q0 j0 prev (r::rs)=
 case r of q::start::span::u::v::a::b::er::ei::_=>
 let val j=valOf(Int.fromString start)
     val n=valOf(Int.fromString span)
     val seed=if q=q0 then prev else pair "85070591730234615865843651857942052864" "0"
     val gap=if q=q0 then j-j0 else j
     val expected=pair a b
     val _=if gap=0 then (if aconv seed expected then () else raise Fail "carry chain mismatch") else
       let val tm=mk_eq(list_mk_comb(``advance``,[nat(Int.toString gap),pair u v,seed]),expected)
           val t0=cpu()
           val th=EQT_ELIM(cv_transLib.cv_eval tm)
           val _=save_thm("carry_"^q^"_"^start,th)
       in print("CARRY "^q^" "^Int.toString gap^" "^Real.toString(cpu()-t0)^"\n") end
 in link q (j+n) (pair er ei) rs end | _=>raise Fail "fields";
val _=link "" 0 (pair "0" "0") rows;
