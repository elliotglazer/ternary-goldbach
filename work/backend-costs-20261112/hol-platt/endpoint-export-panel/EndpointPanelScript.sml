Theory EndpointPanel
Ancestors EndpointExport
Libs meter
open meter;
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
