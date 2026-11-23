Theory EndpointExport
Ancestors CountReceipt
Libs meter cv_transLib
open meter;
Definition paced_steps_def:
 (paced_steps d upper pos 0 bits prev k w = (prev,k,w)) /\
 (paced_steps d upper pos (SUC n) bits prev k w =
    let s=1+bits MOD 2; flip=((prev<>0) /\ (prev<>s)) in
    paced_steps d upper (pos+d) n (bits DIV 2) s
      (if flip then k+1 else k) (if flip then w+(upper-pos) else w))
End
Definition paced_scan_def:
 (paced_scan d upper last prev k w [] = SOME(k:num,w:num)) /\
 (paced_scan d upper last prev k w ((pos,len,bits)::rest) =
   let lastpos=pos+d*(len-1) in
   if 0<len /\ len<=60 /\ last<pos /\ lastpos<upper /\ bits<2**len then
     case paced_steps d upper pos len bits prev k w of (s,k1,w1) =>
       paced_scan d upper lastpos s k1 w1 rest
   else NONE)
End
Definition scan_at_def:
 scan_at d lower upper runs = paced_scan d upper lower 0 0 0 runs
End
val _=cv_auto_trans scan_at_def;
Definition pair_at_def:
 pair_at d h phase allowance shift (ma:(num#num) option) (aa:(num#num) option)
          (mb:(num#num) option) (ab:(num#num) option) =
 case (ma,aa,mb,ab) of (SOME(k1,w1),SOME(j1,v1),SOME(k2,w2),SOME(j2,v2)) =>
   64*d*(phase+2*allowance*4294967296) <
   5*4294967296*((v1-shift*j1)+(v2-shift*j2)+h*d*(k1+k2+1))
 | _ => F
End
val file = TextIO.openIn "selected-packets.txt";
fun line () = String.tokens Char.isSpace (valOf(TextIO.inputLine file));
fun insist true _ = () | insist false s = raise Fail s;
fun blocks (a::b::w::rest) = pairSyntax.mk_pair(nat a,pairSyntax.mk_pair(nat b,nat w))::blocks rest
  | blocks [] = [] | blocks _ = raise Fail "truncated run";
fun save name th = (insist (closed th) "unexpected oracle or assumptions";save_thm(name,th));
fun scan tag lab region d =
  let val [lo,hi,k,w,count] = line()
      val bs = blocks(line())
      val _ = insist (length bs=valOf(Int.fromString count)) "wrong block count"
      val xs = listSyntax.mk_list(bs,``:num#num#num``)
      val name = tag^"_c"^lab^"_"^region
      val defth = new_definition(name^"_def",mk_eq(mk_var(name,type_of xs),xs))
      val th = evaluate name ``scan_at`` [nat d,nat lo,nat hi,xs]
      val _ = insist (aconv (optionSyntax.dest_some(rhs(concl th)))
                (pairSyntax.mk_pair(nat k,nat w))) "wrong scan result"
      val fnterm = list_mk_comb(``scan_at``,[nat d,nat lo,nat hi])
  in save (name^"_scan") (TRANS (AP_TERM fnterm defth) th) end;
fun check () =
  let val [q,a,b,policy,d,h,phase,allow,shift,expected]=line()
      val name="q"^q^"_c"^a^"_c"^b^"_"^policy
      val readings=map (fn (l,r)=>scan name l r d)
        [(a,"main"),(a,"aux"),(b,"main"),(b,"aux")]
      val app=list_mk_comb(``pair_at``,map nat [d,h,phase,allow,shift])
      val result=EVAL(list_mk_comb(app,map (rhs o concl) readings))
      val link=List.foldl(fn(eq,f)=>MK_COMB(f,eq))(REFL app) readings
      val th=save (name^"_decision") (TRANS link result)
      val _=insist (aconv(rhs(concl th))(if expected="1" then boolSyntax.T else boolSyntax.F)) "wrong pair decision"
  in print ("ENDPOINT_DECISION "^name^" "^expected^"\n") end;
val [numRows]=line();
val _=List.tabulate(valOf(Int.fromString numRows),fn _=>check());
val _=insist(not(isSome(TextIO.inputLine file))) "extra records";
val _=TextIO.closeIn file;
val _=print "ENDPOINT_EXPORT_DONE\n";
