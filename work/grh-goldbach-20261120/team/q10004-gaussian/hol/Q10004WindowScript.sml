Theory Q10004Window
Ancestors Q10004Receipt integer list arithmetic
Libs meter cv_transLib intLib

open meter;
Definition signs_def:
  (signs (r:int) word ([]:int list) <=> word=0) /\
  (signs r word (x::xs) <=>
     (if word MOD 2 = 1 then r<x else x < -r) /\ signs r (word DIV 2) xs)
End
Definition inner_def:
  (inner ([]:int list) (ys:int list) = 0:int) /\
  (inner (x::xs) ys = case ys of [] => 0 | y::ts => x*y + inner xs ts)
End
Definition triple_def:
  triple a b c = 1 + 4*a + 2*b + c:num
End
Definition window_def:
  window (first:num) (tick:num) (off:num) (r:int) (e:int) (word:num) (xs:int list) ws =
   if LENGTH xs=192 /\ LENGTH ws=192 /\ 0<off /\ off<20480 /\
      tick=20480*(first+95)+off /\ 0<=r /\ 0<=e /\ signs r word xs
   then let z=inner xs ws in
     if e<z \/ z < -e then
       triple ((word DIV 2**95) MOD 2) (if e<z then 1 else 0) ((word DIV 2**96) MOD 2)
     else 0
   else 0
End
Definition selected_def:
  (selected ([]:(num#num#num) list) (b:num) (i:num) (t:num) = NONE) /\
  (selected ((p,n,w)::rest) b i t =
    if b=0 then
      (if i<n /\ t=p+20480*i then SOME ((w DIV 2**i) MOD 2) else NONE)
    else selected rest (b-1) i t)
End
Definition at_three_def:
  at_three runs j t b i c k d m =
    case (selected runs b i (20480*j),selected runs c k t,selected runs d m (20480*(j+1))) of
      (SOME x,SOME y,SOME z) => triple x y z | _ => 0
End
val _=cv_auto_trans window_def;
val _=cv_auto_trans at_three_def;
val ins=TextIO.openIn "windows.txt";
fun line()=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
fun ints s=listSyntax.mk_list(map integer s,``:int``);
fun named n x=new_definition(n^"_def",mk_eq(mk_var(n,type_of x),x));
fun check (packet,n) =
 let val [label,first,tick,off,r,e,bits,mid]=line()
     val xs=ints(line()) and ws=ints(line())
     val ids=map nat(line())
     val xdef=named ("raw_"^label) xs and wdef=named ("weights_"^label) ws
     val args=[nat first,nat tick,nat off,integer r,integer e,nat bits]
     val wf=list_mk_comb(``Q10004Window$window``,args)
     val wth=evaluate ("window_"^label) ``Q10004Window$window`` (args@[xs,ws])
     val namedw=TRANS(MK_COMB(MK_COMB(REFL wf,xdef),wdef))wth
     val pdef=DB.fetch "Q10004Receipt" (packet^"_def")
     val j=nat(Int.toString(valOf(Int.fromString first)+95))
     val f=``Q10004Window$at_three``
     val tail=[j,nat tick]@ids
     val pth=evaluate ("count_packet_"^label) f (rhs(concl pdef)::tail)
     val lifted=List.foldl(fn(x,th)=>MK_COMB(th,REFL x))(AP_TERM f pdef)tail
     val namedp=TRANS lifted pth
     val joined=TRANS namedw (SYM namedp)
     val _=if closed joined andalso aconv(rhs(concl namedw))(nat (if mid="1" then "3" else "6"))
            then () else raise Fail ("hidden pair "^label)
     val _=save_thm("raw_to_count_packet_"^label,CONJ joined namedw)
 in print ("CLOSED_RAW_WINDOW "^label^" "^term_to_string(rhs(concl namedw))^"\n") end;
val _=app check [("runs_100",0),("runs_110",1),("runs_300",2),("runs_310",3)];
val _=if Option.isSome(TextIO.inputLine ins) then raise Fail "extra packet" else TextIO.closeIn ins;
