Theory DynamicStatic
Ancestors DynamicPhase
Libs intLib cv_transLib
Definition dig_def:
 dig (z:num) = &(z MOD (2**83)) - (2:int)**81
End
Definition sg4_def:
 sg4 (v:int) = if v < ~4 then 1:num else if 4<v then 2 else 0
End
Definition merge_def:
 (merge 0 x y u v m = (m=0)) /\
 (merge (SUC n) x y u v m =
  ((let (r,i)=times ((2:int)**81) (dig x,dig y) (dig u,dig v)
   in m MOD 16=sg4 r+4*sg4 i) /\
  merge n (x DIV 2**83) (y DIV 2**83) (u DIV 2**83) (v DIV 2**83) (m DIV 16)))
End
val _=cv_auto_trans merge_def;
fun nat s=numSyntax.mk_numeral(Arbnum.fromString s);
fun cpu()=let val t=Timer.checkCPUTimer(Timer.totalCPUTimer()) in Time.toReal(#usr t)+Time.toReal(#sys t) end;
val f=TextIO.openIn "static.txt";
fun test j=case TextIO.inputLine f of NONE=>() | SOME line=>
 let val vs=String.tokens Char.isSpace line
     val t0=cpu()
     val args=map nat vs
     val th=EQT_ELIM(cv_transLib.cv_eval(list_mk_comb(``merge``,args)))
     val _=save_thm("static_"^Int.toString j,th)
 in print ("STATIC "^Int.toString j^" "^hd vs^" "^Real.toString(cpu()-t0)^"\n");test(j+1) end;
val _=test 0;
val _=TextIO.closeIn f;

