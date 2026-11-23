Theory GammaPhaseReceipt
Ancestors arithmetic list pair real
Libs cv_transLib realLib

Definition bin_ok_def:
  bin_ok (lo:num,hi:num,m:num) <=>
    lo <= hi /\ 0 < m /\ (2*m-1)*35184372088832 < 2*lo /\
    2*hi < (2*m+1)*35184372088832
End
Definition bins_ok_def:
  (bins_ok [] = T) /\ (bins_ok (h::t) = (bin_ok h /\ bins_ok t))
End
val _ = cv_transLib.cv_trans bin_ok_def;
val _ = cv_transLib.cv_trans bins_ok_def;
val stream=TextIO.openIn "gamma-rectangles.txt";
fun readall acc = case TextIO.inputLine stream of NONE => rev acc | SOME s =>
  let val fields=String.tokens Char.isSpace s
      fun n s = numSyntax.mk_numeral (Arbnum.fromString s)
  in readall(pairSyntax.list_mk_pair(map n fields)::acc) end;
val data=readall [];
val _=TextIO.closeIn stream;
fun cpu()=let val t=Timer.checkCPUTimer(Timer.totalCPUTimer()) in Time.toReal(#usr t)+Time.toReal(#sys t) end;
fun check i []=() | check i rows=
  let val (chunk,rest)=(List.take(rows,64),List.drop(rows,64))
      val tm=mk_comb(``bins_ok``,listSyntax.mk_list(chunk,type_of(hd chunk)))
      val th=EQT_ELIM(cv_transLib.cv_eval tm)
      val _=save_thm("gamma_bins_"^Int.toString i,th)
  in check (i+1) rest end;
val _=if length data=4096 then () else raise Fail "record count";
val t0=cpu();
val _=check 0 (List.take(data,2048));
val t1=cpu();
val _=check 32 (List.drop(data,2048));
val _=print ("GAMMA_BINS_LOW_HIGH_CPU "^Real.toString(t1-t0)^" "^Real.toString(cpu()-t1)^"\n");

